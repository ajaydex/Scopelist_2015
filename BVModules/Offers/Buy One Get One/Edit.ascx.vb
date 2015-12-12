Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Offers_Buy_One_Get_One_Edit
    Inherits OfferTemplate

    Private Const _purchasedProducts As String = "PurchasedProducts"
    Private Const _discountedProducts As String = "DiscountedProducts"

    Public Overrides Sub Cancel()

    End Sub

    Public Overloads Overrides Sub Initialize()        

        Dim settings As Collection(Of ComponentSettingListItem) = SettingsManager.GetSettingList(_purchasedProducts)
        Dim purchasedProducts As New Collection(Of String)
        For Each setting As ComponentSettingListItem In settings
            purchasedProducts.Add(setting.Setting1)
        Next
        settings = Nothing

        settings = SettingsManager.GetSettingList(_discountedProducts)
        Dim discountedProducts As New Collection(Of String)
        For Each setting As ComponentSettingListItem In settings
            discountedProducts.Add(setting.Setting1)
        Next
        settings = Nothing

        BindPurchasedProductsGrid(purchasedProducts)
        BindDiscountedProductsGrid(discountedProducts)
        ViewState(_purchasedProducts) = purchasedProducts
        ViewState(_discountedProducts) = discountedProducts

        PercentAmountSelection.Amount = SettingsManager.GetDecimalSetting("Amount")
        If (PercentAmountSelection.Amount = 0) AndAlso (Not SettingsManager.SettingExists("Amount")) Then
            PercentAmountSelection.Amount = "100"
        End If        
        PercentAmountSelection.AmountType = SettingsManager.GetIntegerSetting("AmountType")
        OrderQuantityTextBox.Text = SettingsManager.GetIntegerSetting("OrderQuantity")
        If CInt(OrderQuantityTextBox.Text) = 0 Then
            OrderQuantityTextBox.Text = "1"
        End If
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

        Me.chkAutomaticallyAdd.Checked = SettingsManager.GetBooleanSetting("AddItemsAutomatically")
    End Sub

    Protected Sub BindPurchasedProductsGrid(ByVal products As Collection(Of String))
        Dim actualProducts As New Collection(Of Catalog.Product)
        For Each productId As String In products
            Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(productId)
            If product IsNot Nothing Then
                actualProducts.Add(product)
            End If
        Next
        PurchasedProductsGridView.DataSource = actualProducts
        PurchasedProductsGridView.DataKeyNames = New String() {"bvin"}
        PurchasedProductsGridView.DataBind()
    End Sub

    Protected Sub BindDiscountedProductsGrid(ByVal products As Collection(Of String))
        Dim actualProducts As New Collection(Of Catalog.Product)
        For Each productId As String In products
            Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(productId)
            If product IsNot Nothing Then
                actualProducts.Add(Catalog.InternalProduct.FindByBvin(productId))
            End If
        Next
        DiscountedProductsGridView.DataSource = actualProducts
        DiscountedProductsGridView.DataKeyNames = New String() {"bvin"}
        DiscountedProductsGridView.DataBind()
    End Sub

    Protected Sub AddPurchasedProductsImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddPurchasedProductsImageButton.Click
        Dim products As Collection(Of String) = CType(ViewState(_purchasedProducts), Collection(Of String))
        If products Is Nothing Then
            products = New Collection(Of String)
        End If
        'If products.Count = 0 Then
        For Each product As String In PurchasedProductPicker.SelectedProducts
            If Not products.Contains(product) Then
                products.Add(product)
            End If
        Next
        'End If

        ViewState(_purchasedProducts) = products
        BindPurchasedProductsGrid(products)
    End Sub

    Protected Sub RemovePurchasedProductsImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemovePurchasedProductsImageButton.Click
        Dim products As Collection(Of String) = CType(ViewState(_purchasedProducts), Collection(Of String))
        If products IsNot Nothing Then
            For Each row As GridViewRow In PurchasedProductsGridView.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    Dim checkbox As CheckBox = DirectCast(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
                    If checkbox.Checked Then
                        If products.Contains(PurchasedProductsGridView.DataKeys(row.RowIndex).Value) Then
                            products.Remove(PurchasedProductsGridView.DataKeys(row.RowIndex).Value)
                        End If
                    End If
                End If
            Next
        End If
        ViewState(_purchasedProducts) = products
        BindPurchasedProductsGrid(products)
    End Sub

    Protected Sub AddDiscountedProductsImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddDiscountedProductsImageButton.Click
        Dim products As Collection(Of String) = CType(ViewState(_discountedProducts), Collection(Of String))
        If products Is Nothing Then
            products = New Collection(Of String)
        End If
        'If (products.Count = 0) Then
        For Each product As String In DiscountedProductPicker.SelectedProducts
            If Not products.Contains(product) Then
                products.Add(product)
            End If
        Next
        'End If
        ViewState(_discountedProducts) = products
        BindDiscountedProductsGrid(products)
    End Sub

    Protected Sub RemoveDiscountedProductsImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemoveDiscountedProductsImageButton.Click
        Dim products As Collection(Of String) = CType(ViewState(_discountedProducts), Collection(Of String))
        If products IsNot Nothing Then
            For Each row As GridViewRow In DiscountedProductsGridView.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    Dim checkbox As CheckBox = DirectCast(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
                    If checkbox.Checked Then
                        If products.Contains(DiscountedProductsGridView.DataKeys(row.RowIndex).Value) Then
                            products.Remove(DiscountedProductsGridView.DataKeys(row.RowIndex).Value)
                        End If
                    End If
                End If
            Next
        End If
        ViewState(_discountedProducts) = products
        BindDiscountedProductsGrid(products)
    End Sub

    Public Overrides Sub Save()
        'first clear out our product list
        Dim products As Collection(Of String) = ViewState(_purchasedProducts)
        If products IsNot Nothing Then
            SettingsManager.DeleteSettingList(_purchasedProducts)
            For Each product As String In products
                Dim item As New ComponentSettingListItem()
                item.Setting1 = product
                SettingsManager.InsertSettingListItem(_purchasedProducts, item, "bvsoftware", "Offer", "Buy One Get One")
            Next
        End If

        products = ViewState(_discountedProducts)
        If products IsNot Nothing Then
            SettingsManager.DeleteSettingList(_discountedProducts)
            For Each product As String In products
                Dim item As New ComponentSettingListItem()
                item.Setting1 = product
                SettingsManager.InsertSettingListItem(_discountedProducts, item, "bvsoftware", "Offer", "Buy One Get One")
            Next
        End If
        SettingsManager.SaveDecimalSetting("Amount", PercentAmountSelection.Amount, "bvsoftware", "Offer", "Buy One Get One")
        SettingsManager.SaveIntegerSetting("AmountType", PercentAmountSelection.AmountType, "bvsoftware", "Offer", "Buy One Get One")
        SettingsManager.SaveBooleanSetting("AddItemsAutomatically", chkAutomaticallyAdd.Checked, "bvsoftware", "Offer", "Buy One Get One")
        SettingsManager.SaveIntegerSetting("OrderQuantity", CInt(OrderQuantityTextBox.Text), "bvsoftware", "Offer", "Buy One Get One")
        SettingsManager.SaveDecimalSetting("OrderTotal", Decimal.Parse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency), "bvsoftware", "Offer", "Buy One Get One")

        Dim val As Decimal = 0
        If Decimal.TryParse(OrderTotalMaxTextBox.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            If val <= 0 Then
                val = Decimal.MaxValue
            End If
        Else
            val = Decimal.MaxValue
        End If
        SettingsManager.SaveDecimalSetting("OrderTotalMax", val, "bvsoftware", "Offer", "Buy One Get One")
    End Sub

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        'Dim purchasedProducts As Collection(Of String) = ViewState(_purchasedProducts)
        'Dim discountedProducts As Collection(Of String) = ViewState(_discountedProducts)
        'For Each purchasedProduct As String In purchasedProducts
        '    For Each discountedProduct As String In discountedProducts
        '        If purchasedProduct = discountedProduct Then
        '            args.IsValid = False
        '        End If
        '    Next
        'Next
    End Sub

    Protected Sub OrderTotalCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles OrderTotalCustomValidator.ServerValidate, OrderTotalMaxCustomValidator.ServerValidate
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, Nothing) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub OrderTotalMaxCustomValidator2_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles OrderTotalMaxCustomValidator2.ServerValidate
        Dim orderTotalMin As Decimal = 0
        Dim orderTotalMax As Decimal = 0

        If Decimal.TryParse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, orderTotalMin) Then
            If Decimal.TryParse(OrderTotalMaxTextBox.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, orderTotalMax) Then
                If orderTotalMax <= orderTotalMin Then
                    args.IsValid = False
                End If
            End If
        End If
    End Sub
End Class
