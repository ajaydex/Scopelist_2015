Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_ProductCombinationsEdit
    Inherits BaseProductAdminPage

    Dim _product As Catalog.Product = Nothing
    Private ReadOnly Property Product() As Catalog.Product
        Get
            If _product Is Nothing Then
                _product = Catalog.InternalProduct.FindByBvin(ViewState("id"))
            End If
            Return _product
        End Get
    End Property

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.RegisterWindowScripts()
        If Not Page.IsPostBack Then
            If Request.QueryString("id") IsNot Nothing Then
                ViewState("id") = Request.QueryString("id")
                If Product IsNot Nothing AndAlso Not String.IsNullOrEmpty(Product.ParentId) Then
                    Response.Redirect(String.Format("{0}?id={1}", HttpContext.Current.Request.Url.AbsolutePath, Product.ParentId))
                End If
            Else
                Response.Redirect("~/BVAdmin/Catalog/Default.aspx")
            End If
            BindGrids()
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Combinations Edit"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub BindGrids()
        Dim products As Collection(Of Catalog.Product) = Me.Product.GlobalProduct.GetCombinationProducts()
        Dim sortedProducts As New Utilities.SortableCollection(Of Catalog.Product)

        For Each product As Catalog.Product In products
            sortedProducts.Add(product)
        Next

        sortedProducts.Sort("ProductName", Utilities.SortDirection.Ascending)

        CombinationsDataList.DataSource = sortedProducts
        CombinationsDataList.DataBind()
    End Sub

    Protected Sub CombinationsDataList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles CombinationsDataList.ItemDataBound        
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim product As Catalog.Product = DirectCast(e.Item.DataItem, Catalog.Product)

            Dim parentProduct As Catalog.Product = Catalog.InternalProduct.FindByBvin(product.ParentId)
            Dim productChoiceLabel As Label = DirectCast(e.Item.FindControl("ProductChoiceLabel"), Label)
            If productChoiceLabel IsNot Nothing Then
                Dim choiceString As String = String.Empty
                If parentProduct IsNot Nothing Then
                    For Each choiceCombo As Catalog.ProductChoiceCombination In parentProduct.ChoiceCombinations
                        If choiceCombo.Bvin = product.Bvin Then
                            For Each choiceOptionId As String In choiceCombo.ChoiceOptionIds
                                Dim choiceOption As Catalog.ProductChoiceOption = Catalog.ProductChoiceOption.FindByBvin(choiceOptionId)
                                If choiceOption IsNot Nothing Then
                                    choiceString &= """" & choiceOption.DisplayText & ""","
                                End If
                            Next
                            Exit For
                        End If
                    Next
                End If
                choiceString = choiceString.TrimEnd(","c)
                productChoiceLabel.Text = choiceString
            End If
            

            DirectCast(e.Item.FindControl("NameTextBox"), TextBox).Text = product.ProductName
            DirectCast(e.Item.FindControl("SkuTextBox"), TextBox).Text = product.Sku

            Dim htmlEditor As ASP.bvadmin_controls_htmleditor_ascx = DirectCast(e.Item.FindControl("LongDescriptionHtmlEditor"), ASP.bvadmin_controls_htmleditor_ascx)
            htmlEditor.Text = product.LongDescription
            If htmlEditor.SupportsTransform Then
                If product.PreTransformLongDescription.Length > 0 Then
                    htmlEditor.Text = product.PreTransformLongDescription
                End If
            End If

            DirectCast(e.Item.FindControl("ShortDescriptionTextBox"), TextBox).Text = product.ShortDescription

            Dim sitePrice As String = product.SitePrice.ToString("C", WebAppSettings.SiteCulture)
            sitePrice = sitePrice.TrimStart(WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol.ToCharArray)
            sitePrice = sitePrice.TrimEnd(WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol.ToCharArray)
            DirectCast(e.Item.FindControl("SitePriceTextBox"), TextBox).Text = sitePrice

            Dim sitePriceOverrideText As String = product.SitePriceOverrideText
            DirectCast(e.Item.FindControl("SitePriceOverrideTextBox"), TextBox).Text = sitePriceOverrideText

            Dim siteCost As String = product.SiteCost.ToString("C", WebAppSettings.SiteCulture)
            siteCost = siteCost.TrimStart(WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol.ToCharArray)
            siteCost = siteCost.TrimEnd(WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol.ToCharArray)
            DirectCast(e.Item.FindControl("SiteCostTextBox"), TextBox).Text = siteCost

            Dim listPrice As String = product.ListPrice.ToString("C", WebAppSettings.SiteCulture)
            listPrice = listPrice.TrimStart(WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol.ToCharArray)
            listPrice = listPrice.TrimEnd(WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol.ToCharArray)
            DirectCast(e.Item.FindControl("ListPriceTextBox"), TextBox).Text = listPrice

            Dim weight As String = product.ShippingWeight.ToString("N", WebAppSettings.SiteCulture)
            DirectCast(e.Item.FindControl("WeightTextBox"), TextBox).Text = weight

            Dim extraShipFee As String = product.ExtraShipFee.ToString("C", WebAppSettings.SiteCulture)
            DirectCast(e.Item.FindControl("ExtraShipFeeTextBox"), TextBox).Text = extraShipFee

            DirectCast(e.Item.FindControl("SmallImageTextBox"), TextBox).Text = product.ImageFileSmall
            DirectCast(e.Item.FindControl("MediumImageTextBox"), TextBox).Text = product.ImageFileMedium
            DirectCast(e.Item.FindControl("NonShippingCheckBox"), CheckBox).Checked = product.NonShipping

            DirectCast(e.Item.FindControl("MediumImageButton"), HtmlControls.HtmlAnchor).HRef = "javascript:popUpWindow('?returnScript=SetImage&WebMode=1&id=" & DirectCast(e.Item.FindControl("MediumImageTextBox"), TextBox).ClientID & "');"
            DirectCast(e.Item.FindControl("SmallImageButton"), HtmlControls.HtmlAnchor).HRef = "javascript:popUpWindow('?returnScript=SetImage&WebMode=1&id=" & DirectCast(e.Item.FindControl("SmallImageTextBox"), TextBox).ClientID & "');"


        End If
    End Sub

    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveImageButton.Click
        If Page.IsValid Then
            Save()
        End If
    End Sub

    Protected Overrides Function Save() As Boolean
        Dim allSucceeded As Boolean = True
        For Each row As DataListItem In CombinationsDataList.Items
            If row.ItemType = ListItemType.Item OrElse row.ItemType = ListItemType.AlternatingItem Then
                Dim key As String = CombinationsDataList.DataKeys(row.ItemIndex)
                Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(key)
                If product IsNot Nothing Then
                    product.ProductName = DirectCast(row.FindControl("NameTextBox"), TextBox).Text
                    product.Sku = DirectCast(row.FindControl("SkuTextBox"), TextBox).Text
                    product.LongDescription = DirectCast(row.FindControl("LongDescriptionHtmlEditor"), ASP.bvadmin_controls_htmleditor_ascx).Text
                    product.PreTransformLongDescription = DirectCast(row.FindControl("LongDescriptionHtmlEditor"), ASP.bvadmin_controls_htmleditor_ascx).PreTransformText
                    product.ShortDescription = DirectCast(row.FindControl("ShortDescriptionTextBox"), TextBox).Text
                    product.SitePrice = DirectCast(row.FindControl("SitePriceTextBox"), TextBox).Text
                    product.SitePriceOverrideText = DirectCast(row.FindControl("SitePriceOverrideTextBox"), TextBox).Text
                    product.SiteCost = DirectCast(row.FindControl("SiteCostTextBox"), TextBox).Text
                    product.ListPrice = DirectCast(row.FindControl("ListPriceTextBox"), TextBox).Text
                    product.ImageFileSmall = DirectCast(row.FindControl("SmallImageTextBox"), TextBox).Text
                    product.ImageFileMedium = DirectCast(row.FindControl("MediumImageTextBox"), TextBox).Text
                    product.NonShipping = DirectCast(row.FindControl("NonShippingCheckBox"), CheckBox).Checked
                    product.ShippingWeight = DirectCast(row.FindControl("WeightTextBox"), TextBox).Text
                    product.ExtraShipFee = DirectCast(row.FindControl("ExtraShipFeeTextBox"), TextBox).Text
                    If Not product.Commit() Then
                        allSucceeded = False
                    End If
                End If
            End If
        Next
        If Not allSucceeded Then
            MessageBox1.ShowError("An error occurred while saving the choice combinations.")
            Return False
        Else
            MessageBox1.ShowOk("Choice combinations updated successfully!")
            Return True
        End If
    End Function

    Private Sub RegisterWindowScripts()

        Dim sb As New StringBuilder

        sb.Append("var w;")
        sb.Append("function popUpWindow(parameters) {")
        sb.Append("w = window.open('../ImageBrowser.aspx' + parameters, 'imagebrowser', 'height=505, width=950');")
        sb.Append("}")

        sb.Append("function closePopup() {")
        sb.Append("w.close();")
        sb.Append("}")

        sb.Append("function SetImage(fileName, id) {")
        sb.Append("document.getElementById(id).value = fileName;")
        sb.Append("w.close();")
        sb.Append("}")

        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "WindowScripts", sb.ToString, True)
    End Sub

    Protected Sub UniqueSkuValidate_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)
        Dim key As String = CombinationsDataList.DataKeys(DirectCast(DirectCast(source, CustomValidator).NamingContainer, DataListItem).ItemIndex)
        If Catalog.InternalProduct.IsSkuUnique(key, args.Value) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub IsMonetary_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)
        Dim val As Decimal = 0D
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub IsNumeric_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)
        Dim val As Decimal = 0D
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Number, Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        Response.Redirect("~/BVAdmin/Catalog/default.aspx")
    End Sub
End Class
