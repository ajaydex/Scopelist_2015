Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Offers_Product_s_Edit
    Inherits OfferTemplate

    Protected Sub BindSelectedProductsGrid(ByVal products As Collection(Of String))
        Dim actualProducts As New Collection(Of Catalog.Product)
        Dim deletedProducts As New Collection(Of String)

        For Each product As String In products
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(product)
            If p IsNot Nothing Then
                actualProducts.Add(p)
            Else
                deletedProducts.Add(product)
            End If
        Next

        If deletedProducts.Count > 0 Then
            For Each product As String In deletedProducts
                products.Remove(product)
            Next
            ViewState("products") = products
        End If

        SelectedProductsGridView.DataSource = actualProducts
        SelectedProductsGridView.DataKeyNames = New String() {"bvin"}
        SelectedProductsGridView.DataBind()
    End Sub

    Protected Sub AddProductsImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddProductsImageButton.Click
        Dim products As Collection(Of String) = CType(ViewState("products"), Collection(Of String))
        If products Is Nothing Then
            products = New Collection(Of String)
        End If
        For Each product As String In ProductPicker2.SelectedProducts
            If Not products.Contains(product) Then
                products.Add(product)
            End If
        Next
        ViewState("products") = products
        BindSelectedProductsGrid(products)
    End Sub

    Protected Sub RemoveProductsImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemoveProductsImageButton.Click
        Dim products As Collection(Of String) = CType(ViewState("products"), Collection(Of String))
        If products IsNot Nothing Then
            For Each row As GridViewRow In SelectedProductsGridView.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    Dim checkbox As CheckBox = DirectCast(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
                    If checkbox.Checked Then
                        If products.Contains(SelectedProductsGridView.DataKeys(row.RowIndex).Value) Then
                            products.Remove(SelectedProductsGridView.DataKeys(row.RowIndex).Value)
                        End If
                    End If
                End If
            Next
        End If
        ViewState("products") = products
        BindSelectedProductsGrid(products)
    End Sub

    Public Overloads Overrides Sub Initialize()        
        Dim settings As Collection(Of ComponentSettingListItem) = SettingsManager.GetSettingList("Products")
        Dim products As New Collection(Of String)

        For Each setting As ComponentSettingListItem In settings
            products.Add(setting.Setting1)
        Next

        BindSelectedProductsGrid(products)
        ViewState("products") = products

        PercentAmountSelection.Amount = SettingsManager.GetDecimalSetting("Amount")
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
    End Sub

    Public Overrides Sub Save()
        'first clear out our product list        
        Dim products As Collection(Of String) = ViewState("products")
        If products IsNot Nothing Then
            SettingsManager.DeleteSettingList("Products")
            For Each product As String In products
                Dim item As New ComponentSettingListItem()
                item.Setting1 = product
                SettingsManager.InsertSettingListItem("Products", item, "bvsoftware", "Offer", "Products")
            Next
        End If
        SettingsManager.SaveDecimalSetting("Amount", PercentAmountSelection.Amount, "bvsoftware", "Offer", "Products")
        SettingsManager.SaveIntegerSetting("AmountType", PercentAmountSelection.AmountType, "bvsoftware", "Offer", "Products")
        SettingsManager.SaveIntegerSetting("OrderQuantity", CInt(OrderQuantityTextBox.Text), "bvsoftware", "Offer", "Products")
        SettingsManager.SaveDecimalSetting("OrderTotal", Decimal.Parse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency), "bvsoftware", "Offer", "Products")

        Dim val As Decimal = 0
        If Decimal.TryParse(OrderTotalMaxTextBox.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            If val <= 0 Then
                val = Decimal.MaxValue
            End If
        Else
            val = Decimal.MaxValue
        End If
        SettingsManager.SaveDecimalSetting("OrderTotalMax", val, "bvsoftware", "Offer", "Products")
    End Sub

    Public Overrides Sub Cancel()

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
