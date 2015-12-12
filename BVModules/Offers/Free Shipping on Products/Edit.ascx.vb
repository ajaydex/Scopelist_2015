Imports System.Collections.ObjectModel
Imports System.Collections.Generic
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Offers_Free_Shipping_on_Products_Edit
    Inherits Content.OfferTemplate

    Private _IncludedProducts As String = "IncludedProducts"
    Private _OrderTotal As String = "OrderTotal"
    Private _OrderTotalItems As String = "OrderTotalItems"
    Private _DiscountPercent As String = "DiscountPercent"
    Private _DiscountAmount As String = "DiscountAmount"
    Private _ShippingMethodId As String = "ShippingMethodId"

    Public Overrides Sub Cancel()

    End Sub

    Public Overloads Overrides Sub Initialize()
        InitBindProducts()
        LoadMethods()

        'OrderQuantityTextBox.Text = SettingsManager.GetIntegerSetting("OrderQuantity")
        'If CInt(OrderQuantityTextBox.Text) = 0 Then
        '    OrderQuantityTextBox.Text = "1"
        'End If

        OrderTotalTextBox.Text = SettingsManager.GetDecimalSetting("OrderTotal").ToString("c")
        If Decimal.Parse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency) = 0 Then
            Dim val As Decimal = 0.01D
            OrderTotalTextBox.Text = val.ToString("c")
        End If

        Dim orderTotalMax As Decimal = SettingsManager.GetDecimalSetting("OrderTotalMax")
        If orderTotalMax = Decimal.MaxValue OrElse orderTotalMax = 0 Then
            OrderTotalMaxTextBox.Text = String.Empty
        Else
            OrderTotalMaxTextBox.Text = orderTotalMax.ToString("c")
        End If

        Dim selectedId As String = SettingsManager.GetSetting(_ShippingMethodId)
        If Me.lstMethods.Items.FindByValue(selectedId) IsNot Nothing Then
            Me.lstMethods.ClearSelection()
            Me.lstMethods.Items.FindByValue(selectedId).Selected = True
        End If
    End Sub

    Public Overrides Sub Save()

        'first clear out our product list
        Dim products As Collection(Of String) = ViewState(_IncludedProducts)
        If products IsNot Nothing Then
            SettingsManager.DeleteSettingList(_IncludedProducts)
            For Each product As String In products
                Dim item As New Content.ComponentSettingListItem()
                item.Setting1 = product
                SettingsManager.InsertSettingListItem(_IncludedProducts, item, "bvsoftware", "Offer", "Free Shipping")
            Next
        End If

        SettingsManager.SaveDecimalSetting("OrderTotal", Decimal.Parse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency), "Develisys", "Offer", "Products")
        SettingsManager.SaveSetting(_ShippingMethodId, lstMethods.SelectedValue, "bvsoftware", "Offer", "FreeShippingByCategory")

        Dim val As Decimal = 0
        If Decimal.TryParse(OrderTotalMaxTextBox.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            If val <= 0 Then
                val = Decimal.MaxValue
            End If
        Else
            val = Decimal.MaxValue
        End If
        SettingsManager.SaveDecimalSetting("OrderTotalMax", val, "Develisys", "Offer", "Products")
    End Sub

    Private Sub LoadMethods()
        Me.lstMethods.DataSource = BVSoftware.BVC5.Core.Shipping.ShippingMethod.FindAll()
        Me.lstMethods.DataTextField = "Name"
        Me.lstMethods.DataValueField = "bvin"
        Me.lstMethods.DataBind()
    End Sub

    Private Sub InitBindProducts()
        Dim products As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList(_IncludedProducts)
        Dim prodStrings As New Collection(Of String)
        For Each product As Content.ComponentSettingListItem In products
            prodStrings.Add(product.Setting1)
        Next

        'get initial list on first load
        BindFreeShippingGrid(prodStrings)
        If Not IsPostBack Then
            ViewState(_IncludedProducts) = prodStrings
        End If
    End Sub

    Protected Sub gvIncludedProducts_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        Dim bvin As String = Me.gvIncludedProducts.DataKeys(e.RowIndex).Value.ToString()

        'get product
        Dim listItem As Content.ComponentSettingListItem = Content.ComponentSettingListItem.FindByBvin(bvin)
        Dim prod As Catalog.Product = Catalog.InternalProduct.FindByBvin(listItem.Setting1)

        SettingsManager.DeleteSettingListItem(bvin)

        If (DirectCast(ViewState(_IncludedProducts), Collection(Of String)).Contains(bvin)) Then
            DirectCast(ViewState(_IncludedProducts), Collection(Of String)).Remove(bvin)
        End If

        InitBindProducts()

        'remove custom property from product (used for caching)
        If prod IsNot Nothing AndAlso prod.CustomPropertyExists("Develisys", "FreeShipping") Then
            prod.CustomPropertyRemove("Develisys", "FreeShipping")
            Catalog.InternalProduct.Update(prod)
        End If
    End Sub

    Protected Sub OrderTotalCustomValidator_ServerValidate(source As Object, args As ServerValidateEventArgs)
        Dim result As Decimal = 0
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, result) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub AddFreeShippingImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddFreeShippingImageButton.Click
        Dim products As Collection(Of String) = CType(ViewState(_IncludedProducts), Collection(Of String))
        If products Is Nothing Then
            products = New Collection(Of String)
        End If

        For Each product As String In FreeShippingProductPicker.SelectedProducts
            If Not products.Contains(product) Then
                products.Add(product)
            End If
        Next

        ViewState(_IncludedProducts) = products
        BindFreeShippingGrid(products)
    End Sub

    Protected Sub RemoveFreeShippingImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemoveFreeShippingImageButton.Click
        Dim products As Collection(Of String) = CType(ViewState(_IncludedProducts), Collection(Of String))
        If products IsNot Nothing Then
            For Each row As GridViewRow In gvIncludedProducts.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    Dim checkbox As CheckBox = DirectCast(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
                    If checkbox.Checked Then
                        If products.Contains(gvIncludedProducts.DataKeys(row.RowIndex).Value) Then
                            products.Remove(gvIncludedProducts.DataKeys(row.RowIndex).Value)
                        End If
                    End If
                End If
            Next
        End If

        ViewState(_IncludedProducts) = products
        BindFreeShippingGrid(products)
    End Sub

    Protected Sub BindFreeShippingGrid(ByRef products As Collection(Of String))
        Dim actualProducts As New Collection(Of Catalog.Product)
        Dim undeletedProducts As New Collection(Of String)      ' If product was deleted, it must be removed from the offer
        For Each product As String In products
            Dim actualProduct As Catalog.Product = Catalog.InternalProduct.FindByBvin(product)
            If actualProduct IsNot Nothing Then
                actualProducts.Add(Catalog.InternalProduct.FindByBvin(product))
                undeletedProducts.Add(product)
            End If
        Next
        products = undeletedProducts
        gvIncludedProducts.DataSource = actualProducts
        gvIncludedProducts.DataKeyNames = New String() {"bvin"}
        gvIncludedProducts.DataBind()
    End Sub

    Protected Sub OrderTotalItemsCustomValidator_ServerValidate(source As Object, args As ServerValidateEventArgs)
        Dim result As Int16 = 0
        If Int16.TryParse(args.Value, System.Globalization.NumberStyles.Integer, System.Threading.Thread.CurrentThread.CurrentUICulture, result) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub DiscountPercentCustomValidator_ServerValidate(source As Object, args As ServerValidateEventArgs)
        Dim result As Decimal = 0
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Float, System.Threading.Thread.CurrentThread.CurrentUICulture, result) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub DiscountAmountCustomValidator_ServerValidate(source As Object, args As ServerValidateEventArgs)
        Dim result As Decimal = 0
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, result) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

End Class