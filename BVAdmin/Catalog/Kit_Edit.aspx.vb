Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_Products_Kit_Edit
    Inherits BaseProductAdminPage

    Private _kit As Catalog.Product = Nothing

    Private Property Kit() As Catalog.Product
        Get
            If _kit Is Nothing Then
                If Not String.IsNullOrEmpty(Request.QueryString("ID")) Then
                    _kit = Catalog.InternalProduct.FindByBvin(Request.QueryString("ID"))
                End If
            End If
            Return _kit
        End Get
        Set(ByVal value As Catalog.Product)
            _kit = value
        End Set
    End Property

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.PageTitle = "Edit Kit/Bundle Items"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Me.RegisterScripts()
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Catalog
            PopulateColumns()
            PopulateTemplates()
            LoadKit()
            LoadKitGroups()
        End If

        ' Add handlers for events during postbacks
        If Page.IsPostBack Then
            If dl.Items IsNot Nothing Then
                For i As Integer = 0 To dl.Items.Count - 1
                    If dl.Items(i).ItemType = ListItemType.Item OrElse dl.Items(i).ItemType = ListItemType.AlternatingItem Then
                        Dim kv As BVAdmin_Controls_KitComponentViewer = dl.Items(i).FindControl("KitGroupViewer1")
                        If kv IsNot Nothing Then
                            AddHandler kv.PartsChanged, AddressOf KitComponentViewer_PartsChanged
                        End If
                    End If
                Next
            End If
        End If
        Me.ResolveSelectedImages()
    End Sub

    Private Sub LoadKit()
        Dim kit As Catalog.Product = Me.Kit
        If kit IsNot Nothing Then
            SkuField.Text = kit.Sku
            ProductNameField.Text = kit.ProductName
            chkActive.Checked = (kit.Status = Catalog.ProductStatus.Active)
            lstTemplateName.SelectedValue = kit.TemplateName

            HeightField.Text = Me.Kit.ShippingHeight.ToString("N")
            LengthField.Text = Me.Kit.ShippingLength.ToString("N")
            WidthField.Text = Me.Kit.ShippingWidth.ToString("N")            

            Me.ImageFileSmallField.Text = kit.ImageFileSmall
            Me.SmallImageAlternateTextField.Text = kit.ImageFileSmallAlternateText
            'Me.imgPreviewSmall.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(Me.SmallImagePicker.ImageUrl.Trim, True))

            Me.ImageFileMediumField.Text = kit.ImageFileMedium
            Me.MediumImageAlternateTextField.Text = kit.ImageFileMediumAlternateText
            'Me.imgPreviewMedium.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(Me.MediumImagePicker.ImageUrl.Trim, True))

            Me.LongDescriptionField.Text = kit.LongDescription
            If LongDescriptionField.SupportsTransform = True Then
                If kit.PreTransformLongDescription.Trim.Length > 0 Then
                    Me.LongDescriptionField.Text = kit.PreTransformLongDescription
                End If
            End If
            Me.ShortDescriptionField.Text = kit.ShortDescription

            If kit.ShortDescription.Length > 255 Then
                Me.CountField.Text = "0"
            Else
                Me.CountField.Text = CType(255 - kit.ShortDescription.Length, String)
            End If

            Me.Keywords.Text = Me.Kit.Keywords

            Me.MetaTitleField.Text = Me.Kit.MetaTitle
            Me.MetaDescriptionField.Text = Me.Kit.MetaDescription
            Me.MetaKeywordsField.Text = Me.Kit.MetaKeywords

            Me.MinimumQtyField.Text = Me.Kit.MinimumQty.ToString()
            Me.RewriteUrlField.Text = Me.Kit.RewriteUrl

            LoadCustomUrl(Me.Kit.Bvin)

            If Me.Kit.PreContentColumnId.Trim <> String.Empty Then
                If Me.PreContentColumnIdField.Items.FindByValue(Me.Kit.PreContentColumnId) IsNot Nothing Then
                    Me.PreContentColumnIdField.Items.FindByValue(Me.Kit.PreContentColumnId).Selected = True
                End If
            End If
            If Me.Kit.PostContentColumnId.Trim <> String.Empty Then
                If Me.PostContentColumnIdField.Items.FindByValue(Me.Kit.PostContentColumnId) IsNot Nothing Then
                    Me.PostContentColumnIdField.Items.FindByValue(Me.Kit.PostContentColumnId).Selected = True
                End If
            End If

            Dim m As New HyperLink
            m.ImageUrl = "~/BVAdmin/Images/Buttons/ViewInStore.png"
            m.NavigateUrl = Utilities.UrlRewriter.BuildUrlForProduct(kit, Me.Page.Request)
            m.EnableViewState = False
            Me.inStore.Controls.Add(m)
        End If
    End Sub

    Private Sub LoadKitGroups()
        Dim kit As Catalog.Product = Me.Kit
        If Me.Kit IsNot Nothing Then
            If kit.Groups.Count > 0 Then
                Dim kc As Collection(Of Catalog.KitComponent) = Catalog.KitComponent.FindByGroupId(kit.Groups(0).Bvin)
                If Not kc Is Nothing Then
                    PopulateRanges(kc)
                    Me.dl.DataSource = kc
                    Me.dl.DataBind()
                End If
            End If
        End If        
    End Sub

    Private Sub PopulateColumns()
        Dim columns As Collection(Of Content.ContentColumn) = Content.ContentColumn.FindAll
        For Each col As Content.ContentColumn In columns
            Me.PreContentColumnIdField.Items.Add(New ListItem(col.DisplayName, col.Bvin))
            Me.PostContentColumnIdField.Items.Add(New ListItem(col.DisplayName, col.Bvin))
        Next
    End Sub

    Private Sub dl_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dl.DeleteCommand
        Me.MessageBox1.ClearMessage()
        Dim ID As String = dl.DataKeys(e.Item.ItemIndex)
        If Not Services.KitService.DeleteKitComponent(ID) Then
            MessageBox1.ShowError("An error occurred while deleting the component")
        End If
        LoadKitGroups()
    End Sub

    Private Sub dl_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dl.EditCommand
        Me.MessageBox1.ClearMessage()
        Dim ID As String = dl.DataKeys(e.Item.ItemIndex)
        Response.Redirect("KitComponent_Edit.aspx?ID=" & ID & Request.QueryString("id"))
    End Sub

    Private Sub dl_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dl.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then

            Dim componentId As String = dl.DataKeys(e.Item.ItemIndex)

            Dim kg As Catalog.KitComponent = CType(e.Item.DataItem, Catalog.KitComponent)

            Dim lblType As Label = e.Item.FindControl("lblType")
            If lblType IsNot Nothing Then
                If kg IsNot Nothing Then
                    Select Case kg.ComponentType
                        Case Catalog.KitComponentType.CheckBoxSelection
                            lblType.Text = "(Checkboxes)"
                        Case Catalog.KitComponentType.DropDownListSelection
                            lblType.Text = "(Drop Down List)"
                        Case Catalog.KitComponentType.IncludedHidden
                            lblType.Text = "(Included - Hidden)"
                        Case Catalog.KitComponentType.IncludedShown
                            lblType.Text = "(Included - Shown)"
                        Case Catalog.KitComponentType.RadioSelection
                            lblType.Text = "(Radio Buttons)"
                    End Select
                End If
            End If

            Dim kv As BVAdmin_Controls_KitComponentViewer = e.Item.FindControl("KitComponentViewer1")
            If kv IsNot Nothing Then
                AddHandler kv.PartsChanged, AddressOf KitComponentViewer_PartsChanged
                kv.ComponentId = componentId
            End If

        End If
    End Sub

    Protected Function SaveKit() As Boolean
        Dim status As Catalog.ProductStatus = Catalog.ProductStatus.NotSet
        If Me.chkActive.Checked Then
            status = Catalog.ProductStatus.Active
        Else
            status = Catalog.ProductStatus.Disabled
        End If

        If Me.Kit Is Nothing Then
            Me.Kit = Services.KitService.CreateNewKit(Me.SkuField.Text, Me.ProductNameField.Text, status, lstTemplateName.SelectedValue)
        End If

        Me.Kit.Sku = Me.SkuField.Text.Trim()
        Me.Kit.ProductName = Me.ProductNameField.Text.Trim()
        Me.Kit.Status = status
        Me.Kit.TemplateName = lstTemplateName.SelectedValue
        Me.Kit.ImageFileSmall = ImageFileSmallField.Text
        Me.Kit.ImageFileSmallAlternateText = SmallImageAlternateTextField.Text
        Me.Kit.ImageFileMedium = ImageFileMediumField.Text
        Me.Kit.ImageFileMediumAlternateText = MediumImageAlternateTextField.Text

        Me.Kit.LongDescription = Me.LongDescriptionField.Text.Trim
        Me.Kit.PreTransformLongDescription = Me.LongDescriptionField.PreTransformText
        Me.Kit.ShortDescription = Me.ShortDescriptionField.Text.Trim

        Me.Kit.Keywords = Me.Keywords.Text.Trim

        Me.Kit.MetaTitle = Me.MetaTitleField.Text.Trim
        Me.Kit.MetaDescription = Me.MetaDescriptionField.Text.Trim
        Me.Kit.MetaKeywords = Me.MetaKeywordsField.Text.Trim

        Me.Kit.ShippingHeight = Decimal.Parse(HeightField.Text)
        Me.Kit.ShippingLength = Decimal.Parse(LengthField.Text)
        Me.Kit.ShippingWidth = Decimal.Parse(WidthField.Text)

        Me.Kit.MinimumQty = Integer.Parse(Me.MinimumQtyField.Text, System.Globalization.NumberStyles.Integer, System.Threading.Thread.CurrentThread.CurrentUICulture)
        Me.Kit.RewriteUrl = Me.RewriteUrlField.Text.Trim

        Me.Kit.PreContentColumnId = Me.PreContentColumnIdField.SelectedValue
        Me.Kit.PostContentColumnId = Me.PostContentColumnIdField.SelectedValue

        Dim result As Boolean = Catalog.InternalProduct.Update(Me.Kit)

        If result Then
            Me.Kit.UpdateOrRemoveCustomUrls(Me.RewriteUrlField.Text.Trim)
        End If

        Return result

        'If Me.Kit IsNot Nothing Then
        '    Return True
        'Else
        '    Return False
        'End If
    End Function

    Protected Overrides Function Save() As Boolean
        If SaveKit() Then
            Return True
        Else
            MessageBox1.ShowError("An error occurred while saving the kit. Please try again.")
            Return False
        End If        
    End Function


    Protected Sub dl_UpdateCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dl.UpdateCommand
        Me.MessageBox1.ClearMessage()
        Dim ID As String = dl.DataKeys(e.Item.ItemIndex)

        Select Case e.CommandArgument.ToString
            Case "Up"
                Catalog.KitComponent.MoveDown(ID)
            Case "Down"
                Catalog.KitComponent.MoveUp(ID)
            Case "Add"
                Dim k As Catalog.KitPart = Services.KitService.CreateNewKitPart(ID, "New Kit Part", 0.0, "", 1, 0.0)
                If k IsNot Nothing Then
                    Response.Redirect("KitPart_Edit.aspx?id=" & k.Bvin & "&DOC=1")
                Else
                    Me.MessageBox1.ShowError("Unable to save new part!")
                End If
        End Select
        LoadKitGroups()
    End Sub

    Private Sub PopulateRanges(ByVal kc As Collection(Of Catalog.KitComponent))
        Dim lowPrice As Decimal = 0
        Dim highPrice As Decimal = 0
        Dim lowWeight As Decimal = 0
        Dim highWeight As Decimal = 0
        Dim defPrice As Decimal = 0
        Dim defWeight As Decimal = 0

        Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Request.QueryString("id"))

        If kc IsNot Nothing Then
            For i As Integer = 0 To kc.Count - 1
                Dim rd As Catalog.KitComponentRangeData = kc(i).GetRangeData()

                lowPrice += rd.LowPrice
                highPrice += rd.HighPrice
                defPrice += rd.DefaultPrice

                lowWeight += rd.LowWeight
                highWeight += rd.HighWeight
                defWeight += rd.DefaultWeight

            Next
        End If

        Me.lblPriceRange.Text = lowPrice.ToString("c") & " - " & highPrice.ToString("c")
        Me.lblDefaultPrice.Text = defPrice.ToString("c")

        Me.lblWeightRange.Text = Math.Round(lowWeight, 3) & " - " & Math.Round(highWeight, 3)
        Me.lblDefaultWeight.Text = Math.Round(defWeight, 3)

    End Sub

    Protected Sub KitComponentViewer_PartsChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        LoadKitGroups()
    End Sub

    Private Sub PopulateTemplates()
        Me.lstTemplateName.DataSource = Content.ModuleController.FindKitTemplates
        Me.lstTemplateName.DataBind()
        Me.TemplatePreviewImage.ImageUrl = Content.ModuleController.FindKitTemplatePreviewImage(Me.lstTemplateName.SelectedValue, Request.PhysicalApplicationPath)
    End Sub

    Protected Sub CancelButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelButton.Click
        Response.Redirect("~/BVAdmin/Catalog/Kits.aspx")
    End Sub

    Protected Sub UpdateButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles UpdateButton.Click
        If Page.IsValid Then
            If Me.Save() Then
                Me.Response.Redirect("~/BVAdmin/Catalog/Kit_Edit.aspx?id=" & Me.Kit.Bvin)
            End If
        End If
    End Sub

    Protected Sub SaveButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveButton.Click
        If Page.IsValid Then
            If Me.Save() Then
                Response.Redirect("~/BVAdmin/Catalog/Kits.aspx")
            End If
        End If
    End Sub

    Protected Sub IsNumeric_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator5.ServerValidate, CustomValidator7.ServerValidate, CustomValidator6.ServerValidate
        Dim val As Decimal = 0
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Float, Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub btnAddComponent_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddComponent.Click
        If Page.IsValid Then
            If SaveKit() Then
                Dim kc As Catalog.KitComponent = Services.KitService.CreateNewKitComponent("New Kit Component", Catalog.KitComponentType.RadioSelection, Me.Kit.Groups(0).Bvin)
                If kc IsNot Nothing Then
                    Response.Redirect("KitComponent_Edit.aspx?ID=" & kc.Bvin & "&DOC=1")
                Else
                    Me.MessageBox1.ShowError("Unable to save kit component!")
                    LoadKitGroups()
                End If
            Else
                Me.MessageBox1.ShowError("Unable to load kit!")
                LoadKitGroups()
            End If
        End If
    End Sub

    Private Sub LoadCustomUrl(ByVal productId As String)
        If Me.RewriteUrlField.Text.Trim = String.Empty Then
            ' Attempt to find existing rewrite records
            Dim c As Content.CustomUrl = Content.CustomUrl.FindBySystemData(productId)
            If c IsNot Nothing Then
                Me.RewriteUrlField.Text = c.RequestedUrl
            End If
        End If
    End Sub

    Protected Sub CategoryEditLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CategoryEditLinkButton.Click
        Response.Redirect("Kit_Edit_Categories.aspx?id=" & Me.Kit.Bvin)
    End Sub

    Private Sub RegisterScripts()

        Dim sb As New StringBuilder

        sb.Append("var w;")
        sb.Append("function popUpWindow(parameters) {")
        sb.Append("w = window.open('../ImageBrowser.aspx' + parameters, 'imagebrowser', 'height=505, width=950');")
        sb.Append("}")

        'sb.Append("var w;")
        'sb.Append("function popUpWindow(parameters) {")
        'sb.Append("w = window.open('../ImageBrowser.aspx?startDir=" & f & " ' , null, 'height=480, width=640');")
        'sb.Append("}")

        sb.Append("function closePopup() {")
        sb.Append("w.close();")
        sb.Append("}")

        sb.Append("function SetSmallImage(fileName) {")
        sb.Append("document.getElementById('")
        sb.Append(Me.ImageFileSmallField.ClientID)
        sb.Append("').value = fileName;")
        sb.Append("document.getElementById('")
        sb.Append(Me.imgPreviewSmall.ClientID)
        sb.Append("').src = '../../'+fileName;")
        sb.Append("w.close();")
        sb.Append("}")

        sb.Append("function SetMediumImage(fileName) {")
        sb.Append("document.getElementById('")
        sb.Append(Me.ImageFileMediumField.ClientID)
        sb.Append("').value = fileName;")
        sb.Append("document.getElementById('")
        sb.Append(Me.imgPreviewMedium.ClientID)
        sb.Append("').src = '../../'+fileName;")
        sb.Append("w.close();")
        sb.Append("}")



        'Script for description counter
        sb.Append("function textCounter() {")
        sb.Append("var maxlimit;")
        sb.Append("maxlimit=255;")
        sb.Append("var field;")
        sb.Append("field = document.getElementById('")
        sb.Append(Me.ShortDescriptionField.ClientID)
        sb.Append("'); ")
        sb.Append("if (field.value.length > maxlimit) {")
        sb.Append(" field.value = field.value.substring(0, maxlimit); }")
        sb.Append("else")
        sb.Append("{ document.getElementById('")
        sb.Append(Me.CountField.ClientID)
        sb.Append("').value = maxlimit - field.value.length; }")
        sb.Append("}")

        Me.ShortDescriptionField.Attributes.Add("onkeyup", "textCounter();")
        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "WindowScripts", sb.ToString, True)
    End Sub

    Private Sub ResolveSelectedImages()
        Me.imgPreviewMedium.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(Me.ImageFileMediumField.Text.Trim, True))
        Me.imgPreviewSmall.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(Me.ImageFileSmallField.Text.Trim, True))
    End Sub

End Class
