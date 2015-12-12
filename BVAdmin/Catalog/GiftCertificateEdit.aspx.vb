Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_GiftCertificateEdit
    Inherits BaseAdminPage

    Protected WithEvents _ProductNavigator As New Content.NotifyClickControl

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Dim val As Decimal = 0D
        SitePriceField.Text = val.ToString("c")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.RegisterWindowScripts()

        If Not Page.IsPostBack Then            
            PopulateColumns()
            Me.SkuField.Focus()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadProduct()
            Else
                Me.BvinField.Value = String.Empty
            End If
        End If

        Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Request.QueryString("id"))
        If p IsNot Nothing Then
            lnkView.Visible = True
            lnkView.ImageUrl = "~/BVAdmin/Images/Buttons/ViewInStore.png"
            lnkView.NavigateUrl = p.ProductURL
        Else
            lnkView.Visible = False
        End If

        Me.ResolveSelectedImages()

        PopulateMenuControl()
    End Sub

    Private Sub PopulateMenuControl()
        Dim c As System.Web.UI.Control = Page.Master.FindControl("ProductNavigator")
        If c IsNot Nothing Then
            Me._ProductNavigator = CType(c, Content.NotifyClickControl)
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Product"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub PopulateColumns()
        Dim columns As Collection(Of Content.ContentColumn) = Content.ContentColumn.FindAll
        For Each col As Content.ContentColumn In columns
            Me.PreContentColumnIdField.Items.Add(New ListItem(col.DisplayName, col.Bvin))
            Me.PostContentColumnIdField.Items.Add(New ListItem(col.DisplayName, col.Bvin))
        Next
    End Sub

    Private Sub LoadProduct()
        Dim p As Catalog.Product
        p = Catalog.InternalProduct.FindByBvin(Me.BvinField.Value)
        If Not p Is Nothing Then
            If p.Bvin <> String.Empty Then
                If p.Status = Catalog.ProductStatus.Active Then
                    Me.chkActive.Checked = True
                Else
                    Me.chkActive.Checked = False
                End If
                Me.GiftCertificateTypeRadioButtonList.SelectedValue = p.SpecialProductType
                Me.SkuField.Text = p.Sku
                Me.ProductNameField.Text = p.ProductName

                Me.SitePriceField.Text = p.SitePrice.ToString("c")
                
                Me.LongDescriptionField.Text = p.LongDescription
                Me.ShortDescriptionField.Text = p.ShortDescription

                If p.ShortDescription.Length > 255 Then
                    Me.CountField.Text = "0"
                Else
                    Me.CountField.Text = CType(255 - p.ShortDescription.Length, String)
                End If

                Me.ImageFileMediumField.Text = p.ImageFileMedium
                Me.ImageFileSmallField.Text = p.ImageFileSmall

                If p.PreContentColumnId.Trim <> String.Empty Then
                    If Me.PreContentColumnIdField.Items.FindByValue(p.PreContentColumnId) IsNot Nothing Then
                        Me.PreContentColumnIdField.Items.FindByValue(p.PreContentColumnId).Selected = True
                    End If
                End If
                If p.PostContentColumnId.Trim <> String.Empty Then
                    If Me.PostContentColumnIdField.Items.FindByValue(p.PostContentColumnId) IsNot Nothing Then
                        Me.PostContentColumnIdField.Items.FindByValue(p.PostContentColumnId).Selected = True
                    End If
                End If

                Me.CertificateIdTextBox.Text = p.GiftCertificateCodePattern

                Me.RewriteUrlField.Text = p.RewriteUrl
                LoadCustomUrl(p.Bvin)
                CheckForValidFieldsBasedOnGiftCertificateType()
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

    Private Sub ResolveSelectedImages()
        Me.imgPreviewMedium.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(Me.ImageFileMediumField.Text.Trim, True))
        Me.imgPreviewSmall.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(Me.ImageFileSmallField.Text.Trim, True))
    End Sub

    Private Sub RegisterWindowScripts()

        Dim sb As New StringBuilder

        sb.Append("var w;")
        sb.Append("function popUpWindow(parameters) {")
        sb.Append("w = window.open('../ImageBrowser.aspx' + parameters, 'imagebrowser', 'height=505, width=950');")
        sb.Append("}")

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

    Private Sub CancelClick()
        Response.Redirect("~/BVAdmin/Catalog/GiftCertificates.aspx")
    End Sub

    Private Sub SaveClick()
        Me.lblError.Text = String.Empty

        If Me.Save() = True Then
            Response.Redirect("~/BVAdmin/Catalog/GiftCertificates.aspx")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        CancelClick()
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Page.IsValid() Then
            SaveClick()
        End If
    End Sub

    Protected Sub btnCancel2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel2.Click
        CancelClick()
    End Sub

    Protected Sub btnSave2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave2.Click
        SaveClick()
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim p As Catalog.Product
        p = Catalog.InternalProduct.FindByBvin(Me.BvinField.Value)
        If p Is Nothing Then
            'if it is nothing then create a new product
            p = New Catalog.Product()
        End If

        If Not p Is Nothing Then
            p.SpecialProductType = DirectCast(CInt(Me.GiftCertificateTypeRadioButtonList.SelectedValue), Catalog.SpecialProductTypes)
            If Me.chkActive.Checked = True Then
                p.Status = Catalog.ProductStatus.Active
            Else
                p.Status = Catalog.ProductStatus.Disabled
            End If
            p.Sku = Me.SkuField.Text.Trim
            p.ProductName = Me.ProductNameField.Text.Trim
            p.SitePrice = Decimal.Parse(Me.SitePriceField.Text, System.Globalization.NumberStyles.Currency)
            p.LongDescription = Me.LongDescriptionField.Text.Trim
            p.ShortDescription = Me.ShortDescriptionField.Text.Trim
            p.ImageFileSmall = Me.ImageFileSmallField.Text.Trim
            p.ImageFileMedium = Me.ImageFileMediumField.Text.Trim
            p.PreContentColumnId = Me.PreContentColumnIdField.SelectedValue
            p.PostContentColumnId = Me.PostContentColumnIdField.SelectedValue
            p.RewriteUrl = Me.RewriteUrlField.Text.Trim
            p.GiftCertificateCodePattern = Me.CertificateIdTextBox.Text
            p.NonShipping = True
            result = p.GlobalProduct.Commit()

            If result = False Then
                Me.lblError.Text = "Unable to save product. Unknown error."
            Else
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = p.Bvin
            End If

            ' Save Customized Url
            If Me.RewriteUrlField.Text.Trim.Length > 0 Then
                ' Create or update Custom Url
                Dim curl As Content.CustomUrl = Content.CustomUrl.FindBySystemData(p.Bvin)
                If curl IsNot Nothing Then
                    curl.SystemUrl = True
                    curl.SystemData = p.Bvin
                    curl.RequestedUrl = Me.RewriteUrlField.Text.Trim
                    curl.RedirectToUrl = Utilities.UrlRewriter.BuildPhysicalUrlForProduct(p, "")
                    If curl.Bvin <> String.Empty Then
                        Content.CustomUrl.Update(curl)
                    Else
                        Content.CustomUrl.Insert(curl)
                    End If
                End If
            Else
                ' Delete any system custom Urls
                Dim target As Content.CustomUrl = Content.CustomUrl.FindBySystemData(p.Bvin)
                If target IsNot Nothing Then
                    If target.Bvin <> String.Empty Then
                        Content.CustomUrl.Delete(target.Bvin)
                    End If
                End If
            End If
        End If

        Return result
    End Function

    Protected Sub _ProductNavigator_Clicked(ByVal sender As Object, ByVal e As BVSoftware.Bvc5.Core.Content.NotifyClickControl.ClickedEventArgs) Handles _ProductNavigator.Clicked
        Me.Save()
    End Sub

    Protected Sub GiftCertificateTypeRadioButtonList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GiftCertificateTypeRadioButtonList.SelectedIndexChanged
        CheckForValidFieldsBasedOnGiftCertificateType()
    End Sub

    Protected Sub CheckForValidFieldsBasedOnGiftCertificateType()
        If CInt(GiftCertificateTypeRadioButtonList.SelectedValue) = Catalog.SpecialProductTypes.GiftCertificate Then
            PriceRow.Visible = True
        ElseIf CInt(GiftCertificateTypeRadioButtonList.SelectedValue) = Catalog.SpecialProductTypes.ArbitrarilyPricedGiftCertificate Then
            PriceRow.Visible = False
        End If
    End Sub

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        If CertificateIdTextBox.Text <> String.Empty Then
            Dim count As Integer = 0
            For Each letter As Char In CertificateIdTextBox.Text
                If letter = "!" OrElse letter = "#" OrElse letter = "?" Then
                    count += 1
                End If
            Next

            If count < 6 Then
                args.IsValid = False
            Else
                args.IsValid = True
            End If
        End If
    End Sub

    Protected Sub CustomValidator2_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator2.ServerValidate
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, Nothing) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub
End Class
