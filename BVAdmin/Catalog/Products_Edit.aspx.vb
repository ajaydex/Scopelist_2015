Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_Products_Edit
    Inherits BaseProductAdminPage

    Protected ProductTypeProperties As New Collection(Of String)()
    Property LastProductType() As String
        Get
            Dim obj As Object = ViewState("LastProductType")
            If obj IsNot Nothing Then
                Return ViewState("LastProductType")
            Else
                Return ""
            End If
        End Get
        Set(ByVal value As String)
            ViewState("LastProductType") = value
        End Set
    End Property

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        SetDefaultValues()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load        
        If Me.Master IsNot Nothing Then
            If TypeOf Me.Master Is ASP.bvadmin_bvadminproduct_master Then
                DirectCast(Me.Master, ASP.bvadmin_bvadminproduct_master).ShowProductDisplayPanel = False
            End If
        End If
        Me.PageMessageBox = MessageBox1
        Me.RegisterWindowScripts()

        Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Request.QueryString("id"))
        If p IsNot Nothing Then
            lnkView.Visible = True
            lnkView.ImageUrl = "~/BVAdmin/Images/Buttons/ViewInStore.png"
            lnkView.NavigateUrl = p.ProductURL
        Else
            lnkView.Visible = False
        End If

        If Not Page.IsPostBack Then
            PopulateTemplates()
            PopulateManufacturers()
            PopulateVendors()
            PopulateProductTypes()
            PopulateColumns()
            PopulateTaxes()
            Me.SkuField.Focus()

            If p IsNot Nothing Then
                Me.BvinField.Value = p.Bvin
                LoadProduct(p)
                If Request.QueryString("u") = 1 Then
                    Me.MessageBox1.ShowOk("Product Updated")
                End If
            Else
                Me.BvinField.Value = String.Empty

                ' set default template for new product
                Me.lstTemplateName.ClearSelection()
                Me.lstTemplateName.SelectedValue = WebAppSettings.DefaultProductTemplate
            End If
            Dim props As Collections.Generic.List(Of Catalog.ProductProperty) = Catalog.ProductType.FindPropertiesForType(lstProductType.SelectedValue)
            For Each prop As Catalog.ProductProperty In props
                ProductTypeProperties.Add(Catalog.InternalProduct.GetPropertyValue(Me.BvinField.Value, prop.Bvin))
            Next
            GenerateProductTypePropertyFields()
        Else
            'this is a postback
            Dim count As Integer = 1
            While Request("ProductTypeProperty" + count.ToString()) IsNot Nothing
                ProductTypeProperties.Add(Request("ProductTypeProperty" + count.ToString()))
                count += 1
            End While
            CheckIfProductTypePropertyChanged()
            GenerateProductTypePropertyFields()
        End If
        If Catalog.ProductChoice.GetChoiceCountForProduct(Me.BvinField.Value) > 0 Then
            ProductCombinationParagraph.Visible = True
        Else
            ProductCombinationParagraph.Visible = False
        End If
        Me.ResolveSelectedImages()        
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Product"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub SetDefaultValues()
        Dim val As Decimal = 0
        ListPriceField.Text = val.ToString("c")
        CostField.Text = val.ToString("c")
        SitePriceField.Text = val.ToString("c")
        WeightField.Text = val.ToString("N")
        LengthField.Text = val.ToString("N")
        WidthField.Text = val.ToString("N")
        HeightField.Text = val.ToString("N")
        ExtraShipFeeField.Text = val.ToString("c")
        Me.txtGiftWrapCharge.Text = val.ToString("c")
        LongDescriptionField.EditorHeight = WebAppSettings.ProductLongDescriptionEditorHeight
    End Sub

    Private Sub PopulateTemplates()
        Me.lstTemplateName.DataSource = Content.ModuleController.FindProductTemplates
        Me.lstTemplateName.DataBind()
        Me.TemplatePreviewImage.ImageUrl = Content.ModuleController.FindProductTemplatePreviewImage(Me.lstTemplateName.SelectedValue, Request.PhysicalApplicationPath)
    End Sub

    Private Sub PopulateManufacturers()
        Me.lstManufacturers.DataSource = Contacts.Manufacturer.FindAll
        Me.lstManufacturers.DataTextField = "DisplayName"
        Me.lstManufacturers.DataValueField = "Bvin"
        Me.lstManufacturers.DataBind()
        Me.lstManufacturers.Items.Insert(0, New ListItem("- No Manufacturer -", ""))
    End Sub

    Private Sub PopulateVendors()
        Me.lstVendors.DataSource = Contacts.Vendor.FindAll
        Me.lstVendors.DataTextField = "DisplayName"
        Me.lstVendors.DataValueField = "Bvin"
        Me.lstVendors.DataBind()
        Me.lstVendors.Items.Insert(0, New ListItem("- No Vendor -", ""))
    End Sub
    Private Sub PopulateTaxes()
        Me.TaxClassField.DataSource = Taxes.TaxClass.FindAll
        Me.TaxClassField.DataTextField = "DisplayName"
        Me.TaxClassField.DataValueField = "Bvin"
        Me.TaxClassField.DataBind()
        Dim item As New ListItem("-- No Tax Class --", "")
        Me.TaxClassField.Items.Insert(0, item)
    End Sub
    Private Sub PopulateProductTypes()
        Me.lstProductType.Items.Clear()
        Me.lstProductType.Items.Add(New ListItem("Generic", ""))
        Me.lstProductType.AppendDataBoundItems = True
        Me.lstProductType.DataSource = Catalog.ProductType.FindAll()
        Me.lstProductType.DataTextField = "ProductTypeName"
        Me.lstProductType.DataValueField = "bvin"
        Me.lstProductType.DataBind()
    End Sub

    Private Sub PopulateColumns()
        Dim columns As Collection(Of Content.ContentColumn) = Content.ContentColumn.FindAll
        For Each col As Content.ContentColumn In columns
            Me.PreContentColumnIdField.Items.Add(New ListItem(col.DisplayName, col.Bvin))
            Me.PostContentColumnIdField.Items.Add(New ListItem(col.DisplayName, col.Bvin))
        Next
    End Sub

    Private Sub LoadProduct(ByVal p As Catalog.Product)
        If Not String.IsNullOrEmpty(p.ParentId) Then
            Response.Redirect(String.Format("{0}?id={1}", HttpContext.Current.Request.Url.AbsolutePath, p.ParentId))
        End If
        If Not p Is Nothing Then
            If p.Bvin <> String.Empty Then
                PersonalizationServices.RecordProductViews(p.Bvin)

                If p.Status = Catalog.ProductStatus.Active Then
                    Me.chkActive.Checked = True
                Else
                    Me.chkActive.Checked = False
                End If

                Me.SkuField.Text = p.Sku
                Me.ProductNameField.Text = p.ProductName

                Me.ListPriceField.Text = p.ListPrice.ToString("C")
                Me.CostField.Text = p.SiteCost.ToString("C")
                Me.SitePriceField.Text = p.SitePrice.ToString("C")

                Me.LongDescriptionField.Text = p.LongDescription
                If LongDescriptionField.SupportsTransform = True Then
                    If p.PreTransformLongDescription.Trim.Length > 0 Then
                        Me.LongDescriptionField.Text = p.PreTransformLongDescription
                    End If
                End If
                Me.ShortDescriptionField.Text = p.ShortDescription

                If p.ShortDescription.Length > 512 Then
                    Me.CountField.Text = "0"
                Else
                    Me.CountField.Text = CType(512 - p.ShortDescription.Length, String)
                End If
                If p.TaxExempt = True Then
                    Me.TaxExemptField.Checked = True
                Else
                    Me.TaxExemptField.Checked = False
                End If
                If Me.TaxClassField.Items.FindByValue(p.TaxClass) IsNot Nothing Then
                    Me.TaxClassField.ClearSelection()
                    Me.TaxClassField.Items.FindByValue(p.TaxClass).Selected = True
                End If
                If Me.lstManufacturers.Items.FindByValue(p.ManufacturerId) IsNot Nothing Then
                    Me.lstManufacturers.ClearSelection()
                    Me.lstManufacturers.Items.FindByValue(p.ManufacturerId).Selected = True
                End If
                If Me.lstVendors.Items.FindByValue(p.VendorId) IsNot Nothing Then
                    Me.lstVendors.ClearSelection()
                    Me.lstVendors.Items.FindByValue(p.VendorId).Selected = True
                End If
                If Me.lstTemplateName.Items.FindByValue(p.TemplateName) IsNot Nothing Then
                    Me.lstTemplateName.ClearSelection()
                    Me.lstTemplateName.Items.FindByValue(p.TemplateName).Selected = True
                End If
                Me.TemplatePreviewImage.ImageUrl = Content.ModuleController.FindProductTemplatePreviewImage(Me.lstTemplateName.SelectedValue, Request.PhysicalApplicationPath)

                Me.ImageFileMediumField.Text = p.ImageFileMedium
                Me.ImageFileSmallField.Text = p.ImageFileSmall

                Me.MediumImageAlternateTextField.Text = p.ImageFileMediumAlternateText
                Me.SmallImageAlternateTextField.Text = p.ImageFileSmallAlternateText

                If Me.lstProductType.Items.FindByValue(p.ProductTypeId) IsNot Nothing Then
                    Me.lstProductType.ClearSelection()
                    Me.lstProductType.Items.FindByValue(p.ProductTypeId).Selected = True
                End If
                ' Added this line to stop errors on immediate load and save - Marcus
                Me.LastProductType = p.ProductTypeId

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

                Me.Keywords.Text = p.Keywords
                Me.MetaTitleField.Text = p.MetaTitle
                Me.MetaDescriptionField.Text = p.MetaDescription
                Me.MetaKeywordsField.Text = p.MetaKeywords

                Me.WeightField.Text = Math.Round(p.ShippingWeight, 3)
                Me.LengthField.Text = Math.Round(p.ShippingLength, 3)
                Me.WidthField.Text = Math.Round(p.ShippingWidth, 3)
                Me.HeightField.Text = Math.Round(p.ShippingHeight, 3)

                Me.ExtraShipFeeField.Text = p.ExtraShipFee.ToString("C")
                If Me.ShipTypeField.Items.FindByValue(p.ShippingMode) IsNot Nothing Then
                    Me.ShipTypeField.ClearSelection()
                    Me.ShipTypeField.Items.FindByValue(p.ShippingMode).Selected = True
                End If
                Me.chkNonShipping.Checked = p.NonShipping
                Me.chkShipSeparately.Checked = p.ShipSeparately

                Me.MinimumQtyField.Text = p.MinimumQty.ToString()

                Me.RewriteUrlField.Text = p.RewriteUrl
                Me.PriceOverrideTextBox.Text = p.SitePriceOverrideText

                Me.chkGiftWrapAllowed.Checked = p.GiftWrapAllowed
                Me.txtGiftWrapCharge.Text = p.GiftWrapPrice.ToString("C")

                LoadCustomUrl(p.Bvin)

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

        'Dim f As String = WebAppSettings.ImageBrowserDefaultDirectory
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
        sb.Append("maxlimit=512;")
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

    Protected Sub lstTemplateName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lstTemplateName.SelectedIndexChanged
        Me.TemplatePreviewImage.ImageUrl = Content.ModuleController.FindProductTemplatePreviewImage(Me.lstTemplateName.SelectedValue, Request.PhysicalApplicationPath)
    End Sub

    Private Sub CancelClick()
        Response.Redirect("~/BVAdmin/Catalog/Default.aspx")
    End Sub

    Private Sub SaveClick()
        Me.lblError.Text = String.Empty

        If Me.Save() = True Then
            Response.Redirect("~/BVAdmin/Catalog/Default.aspx")
        End If
    End Sub

    Private Sub SaveClickOnPage()
        Me.lblError.Text = String.Empty

        If Me.Save() = True Then
            Me.Response.Redirect("~/BVAdmin/Catalog/Products_Edit.aspx?id=" & BvinField.Value & "&u=1")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        CancelClick()
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        SaveClick()
    End Sub

    Protected Sub btnCancel2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel2.Click
        CancelClick()
    End Sub

    Protected Sub btnSave2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave2.Click
        SaveClick()
    End Sub

    Protected Overrides Function Save() As Boolean
        Dim result As Boolean = False
        If Page.IsValid Then
            Dim p As Catalog.Product
            p = Catalog.InternalProduct.FindByBvin(Me.BvinField.Value)
            If p Is Nothing Then
                'if it is nothing then create a new product
                p = New Catalog.Product()
            End If

            If Not p Is Nothing Then

                If Me.chkActive.Checked Then
                    p.Status = Catalog.ProductStatus.Active
                Else
                    p.Status = Catalog.ProductStatus.Disabled
                End If

                If String.Compare(p.Sku.Trim(), Me.SkuField.Text.Trim(), True) <> 0 Then
                    'sku changed, so do a sku check
                    Dim skuCheckProduct As Catalog.Product = Catalog.InternalProduct.FindBySku(Me.SkuField.Text.Trim())
                    If skuCheckProduct IsNot Nothing Then
                        MessageBox1.ShowError("Sku already exists on another product. Please pick another sku.")
                        Return False
                    End If
                End If

                ' make sure Rewrite Url is unique
                Dim rewriteUrl As String = Me.RewriteUrlField.Text.Trim()
                If Not String.IsNullOrEmpty(rewriteUrl) Then
                    Dim customUrl As Content.CustomUrl = Content.CustomUrl.FindByRequestedUrl(rewriteUrl)
                    If Not String.IsNullOrEmpty(customUrl.Bvin) AndAlso customUrl.SystemData <> p.Bvin Then
                        ' if we're not updating the product and there isn't a conflict between this new product and a Custom Url that isn't tied to a BV object
                        If customUrl.SystemData <> p.Bvin OrElse (String.IsNullOrEmpty(p.Bvin) AndAlso String.IsNullOrEmpty(customUrl.SystemData)) Then
                            MessageBox1.ShowError(String.Format("The Rewrite Url ""{0}"" is already in use. Please choose another Url.", Me.RewriteUrlField.Text.Trim()))
                            Return False
                        End If
                    End If
                End If

                p.Sku = Me.SkuField.Text.Trim


                p.ProductName = Me.ProductNameField.Text.Trim
                If Me.lstProductType.SelectedValue IsNot Nothing Then
                    p.ProductTypeId = Me.lstProductType.SelectedValue
                Else
                    p.ProductTypeId = String.Empty
                End If

                Decimal.TryParse(Me.ListPriceField.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, p.ListPrice)
                Decimal.TryParse(Me.CostField.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, p.SiteCost)
                Decimal.TryParse(Me.SitePriceField.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, p.SitePrice)
                p.LongDescription = Me.LongDescriptionField.Text.Trim
                p.PreTransformLongDescription = Me.LongDescriptionField.PreTransformText
                p.ShortDescription = Me.ShortDescriptionField.Text.Trim
                If Me.lstManufacturers.SelectedValue IsNot Nothing Then
                    p.ManufacturerId = Me.lstManufacturers.SelectedValue
                Else
                    p.ManufacturerId = String.Empty
                End If
                If Me.lstVendors.SelectedValue IsNot Nothing Then
                    p.VendorId = Me.lstVendors.SelectedValue
                Else
                    p.VendorId = String.Empty
                End If
                If Me.lstTemplateName.SelectedValue IsNot Nothing Then
                    p.TemplateName = Me.lstTemplateName.SelectedValue
                End If

                p.ImageFileSmall = Me.ImageFileSmallField.Text.Trim
                p.ImageFileMedium = Me.ImageFileMediumField.Text.Trim

                If String.IsNullOrEmpty(Me.SmallImageAlternateTextField.Text) Then
                    p.ImageFileSmallAlternateText = p.ProductName & " " & p.Sku
                Else
                    p.ImageFileSmallAlternateText = Me.SmallImageAlternateTextField.Text
                End If

                If String.IsNullOrEmpty(Me.MediumImageAlternateTextField.Text) Then
                    p.ImageFileMediumAlternateText = p.ProductName & " " & p.Sku
                Else
                    p.ImageFileMediumAlternateText = Me.MediumImageAlternateTextField.Text
                End If

                p.PreContentColumnId = Me.PreContentColumnIdField.SelectedValue
                p.PostContentColumnId = Me.PostContentColumnIdField.SelectedValue
                p.RewriteUrl = Me.RewriteUrlField.Text.Trim
                p.GlobalProduct.SitePriceOverrideText = Me.PriceOverrideTextBox.Text.Trim
                p.Keywords = Me.Keywords.Text.Trim
                p.ProductTypeId = Me.lstProductType.SelectedValue
                p.TaxClass = Me.TaxClassField.SelectedValue

                p.MetaTitle = Me.MetaTitleField.Text.Trim
                p.MetaDescription = Me.MetaDescriptionField.Text.Trim
                p.MetaKeywords = Me.MetaKeywordsField.Text.Trim

                p.ShippingWeight = Decimal.Parse(Me.WeightField.Text, System.Globalization.NumberStyles.Float, Threading.Thread.CurrentThread.CurrentUICulture)
                p.ShippingLength = Decimal.Parse(Me.LengthField.Text, System.Globalization.NumberStyles.Float, Threading.Thread.CurrentThread.CurrentUICulture)
                p.ShippingWidth = Decimal.Parse(Me.WidthField.Text, System.Globalization.NumberStyles.Float, Threading.Thread.CurrentThread.CurrentUICulture)
                p.ShippingHeight = Decimal.Parse(Me.HeightField.Text, System.Globalization.NumberStyles.Float, Threading.Thread.CurrentThread.CurrentUICulture)

                p.ExtraShipFee = Decimal.Parse(Me.ExtraShipFeeField.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture)
                p.ShippingMode = Me.ShipTypeField.SelectedValue
                p.NonShipping = Me.chkNonShipping.Checked
                p.ShipSeparately = Me.chkShipSeparately.Checked

                p.MinimumQty = Integer.Parse(Me.MinimumQtyField.Text, System.Globalization.NumberStyles.Integer, System.Threading.Thread.CurrentThread.CurrentUICulture)

                If Me.TaxExemptField.Checked = True Then
                    p.TaxExempt = True
                Else
                    p.TaxExempt = False
                End If

                p.GlobalProduct.GiftWrapAllowed = Me.chkGiftWrapAllowed.Checked
                p.GlobalProduct.SetGiftWrapPrice(Me.txtGiftWrapCharge.Text)

                result = p.Commit()

                If result Then
                    Dim props As Collections.Generic.List(Of Catalog.ProductProperty) = Catalog.ProductType.FindPropertiesForType(lstProductType.SelectedValue)
                    Catalog.InternalProduct.ClearPropertyValues(p.Bvin)
                    For i As Integer = 0 To (props.Count - 1)
                        Catalog.InternalProduct.SetPropertyValue(p.Bvin, props(i).Bvin, ProductTypeProperties(i))
                    Next
                End If


                If result = False Then
                    Me.MessageBox1.ShowError("Unable to save product. Unknown error. Please check event log.")
                Else
                    ' record view of newly added item
                    If String.IsNullOrEmpty(Me.BvinField.Value) AndAlso Not String.IsNullOrEmpty(p.Bvin) Then
                        PersonalizationServices.RecordProductViews(p.Bvin)
                    End If

                    ' Update bvin field so that next save will call updated instead of create
                    Me.BvinField.Value = p.Bvin
                End If

                p.UpdateOrRemoveCustomUrls(Me.RewriteUrlField.Text.Trim)

                ' FIX #124, added in version 5.8
                ' Update Active Status on Child Products
                Dim children As Collection(Of Catalog.Product) = Catalog.InternalProduct.FindChildren(p.Bvin)
                For Each child As Catalog.Product In children
                    child.Status = p.Status
                    Catalog.InternalProduct.Update(child)
                Next

                HttpContext.Current.Items("productid") = p.Bvin
            End If
        End If
        Return result
    End Function

    Protected Sub CheckIfProductTypePropertyChanged()
        If lstProductType.SelectedValue <> LastProductType Then
            ProductTypeProperties.Clear()
            LastProductType = lstProductType.SelectedValue
        End If
    End Sub

    Protected Sub GenerateProductTypePropertyFields()
        ProductTypePropertiesLiteral.Text = ""
        If lstProductType.SelectedValue.Trim() <> String.Empty Then
            Dim pt As Catalog.ProductType = Catalog.ProductType.FindByBvin(lstProductType.SelectedValue)
            Dim props As Collections.Generic.List(Of Catalog.ProductProperty) = Catalog.ProductType.FindPropertiesForType(pt.Bvin)
            Dim sb As New StringBuilder()
            Dim count As Integer = 0
            For Each item As Catalog.ProductProperty In props
                count += 1
                Dim sw As New IO.StringWriter()
                Dim writer As New HtmlTextWriter(sw)
                sb.Append("<tr><td class=""formlabel"">")
                sb.Append(item.DisplayName)
                sb.Append("</td><td class=""formfield"">")
                If item.TypeCode = Catalog.ProductPropertyType.CurrencyField Then
                    Dim input As New HtmlInputText()
                    input.ID = "ProductTypeProperty" + count.ToString()
                    If ProductTypeProperties.Count > (count - 1) Then
                        If ProductTypeProperties(count - 1) IsNot Nothing Then
                            input.Value = ProductTypeProperties(count - 1)
                        Else
                            input.Value = item.DefaultValue
                        End If
                    Else
                        input.Value = item.DefaultValue
                    End If
                    input.RenderControl(writer)
                    writer.Flush()
                    sb.Append(sw.ToString())
                ElseIf item.TypeCode = Catalog.ProductPropertyType.DateField Then
                    Dim input As New HtmlInputText()
                    input.ID = "ProductTypeProperty" + count.ToString()
                    If ProductTypeProperties.Count > (count - 1) Then
                        If ProductTypeProperties(count - 1) IsNot Nothing Then
                            input.Value = ProductTypeProperties(count - 1)
                        Else
                            input.Value = item.DefaultValue
                        End If
                    Else
                        input.Value = item.DefaultValue
                    End If
                    input.RenderControl(writer)
                    writer.Flush()
                    sb.Append(sw.ToString())
                ElseIf item.TypeCode = Catalog.ProductPropertyType.HyperLink Then
                    Dim input As New HtmlInputText()
                    input.ID = "ProductTypeProperty" + count.ToString()
                    If ProductTypeProperties.Count > (count - 1) Then
                        If ProductTypeProperties(count - 1) IsNot Nothing Then
                            input.Value = ProductTypeProperties(count - 1)
                        Else
                            input.Value = item.DefaultValue
                        End If
                    Else
                        input.Value = item.DefaultValue
                    End If
                    input.RenderControl(writer)
                    writer.Flush()
                    sb.Append(sw.ToString())
                ElseIf item.TypeCode = Catalog.ProductPropertyType.MultipleChoiceField Then
                    Dim input As New HtmlSelect()
                    input.ID = "ProductTypeProperty" + count.ToString()
                    'we must load the whole product type since we don't get choices when we do FindAll()
                    Dim setWidth As Boolean = False
                    Dim prodProp As Catalog.ProductProperty = Catalog.ProductProperty.FindByBvin(item.Bvin)
                    For Each choice As Catalog.ProductPropertyChoice In prodProp.Choices
                        If choice.ChoiceName.Length > 25 Then
                            setWidth = True
                        End If
                        Dim li As New ListItem(choice.ChoiceName, choice.Bvin)
                        input.Items.Add(li)
                    Next
                    If setWidth Then
                        input.Style.Add("width", "305px")
                    End If

                    If ProductTypeProperties.Count > (count - 1) Then
                        If ProductTypeProperties(count - 1) IsNot Nothing Then
                            input.Value = ProductTypeProperties(count - 1)
                        Else
                            input.Value = item.DefaultValue
                        End If
                    Else
                        input.Value = item.DefaultValue
                    End If
                    input.RenderControl(writer)
                    writer.Flush()
                    sb.Append(sw.ToString())
                ElseIf item.TypeCode = Catalog.ProductPropertyType.TextField Then
                    Dim input As New HtmlTextArea()
                    input.ID = "ProductTypeProperty" + count.ToString()
                    If ProductTypeProperties.Count > (count - 1) Then
                        If ProductTypeProperties(count - 1) IsNot Nothing Then
                            input.Value = ProductTypeProperties(count - 1)
                        Else
                            input.Value = item.DefaultValue
                        End If
                    Else
                        input.Value = item.DefaultValue
                    End If
                    input.Rows = 5
                    input.Cols = 40
                    input.RenderControl(writer)
                    writer.Flush()
                    sb.Append(sw.ToString())
                End If
                sb.Append("</td></tr>")
                ProductTypePropertiesLiteral.Text = sb.ToString()
            Next
        End If
    End Sub

    Protected Sub ProductTypeCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles ProductTypeCustomValidator.ServerValidate
        Dim props As Collections.Generic.List(Of Catalog.ProductProperty) = Catalog.ProductType.FindPropertiesForType(lstProductType.SelectedValue)
        For i As Integer = 0 To (ProductTypeProperties.Count - 1)
            Select Case props(i).TypeCode
                Case Catalog.ProductPropertyType.CurrencyField
                    If Not Decimal.TryParse(ProductTypeProperties(i), Nothing) Then
                        args.IsValid = False
                        ProductTypeCustomValidator.ErrorMessage = props(i).DisplayName + " must be a valid monetary type."
                        Exit For
                    End If
                Case Catalog.ProductPropertyType.DateField
                    If Not Date.TryParse(ProductTypeProperties(i), Nothing) Then
                        args.IsValid = False
                        ProductTypeCustomValidator.ErrorMessage = props(i).DisplayName + " must be a valid date."
                        Exit For
                    End If
                Case Catalog.ProductPropertyType.MultipleChoiceField

            End Select
        Next
    End Sub

    Protected Sub update1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles update1.Click
        SaveClickOnPage()
    End Sub

    Protected Sub update2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles update2.Click
        SaveClickOnPage()
    End Sub

    Protected Sub IsNumeric_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator4.ServerValidate, CustomValidator5.ServerValidate, CustomValidator7.ServerValidate, CustomValidator6.ServerValidate
        Dim val As Decimal = 0
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Float, Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub IsMonetary_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator8.ServerValidate, CustomValidator1.ServerValidate, CustomValidator2.ServerValidate, CustomValidator3.ServerValidate
        Dim val As Decimal = 0D
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub ProductPropertyCopier_Clicked(ByVal sender As Object, ByVal e As BVSoftware.BVC5.Core.Content.NotifyClickControl.ClickedEventArgs)
        If Not Me.Save() Then
            e.ErrorOccurred = True
        End If
    End Sub
End Class
