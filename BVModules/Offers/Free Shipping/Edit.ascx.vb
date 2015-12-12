Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Offers_Free_Shipping_Edit
    Inherits OfferTemplate

    Private Const _freeShippingProducts As String = "FreeShippingProducts"
    Private Shared _ShippingMethodId As String = "ShippingMethodId"
    
    Public Overrides Sub Cancel()

    End Sub

    Public Overloads Overrides Sub Initialize()
        LoadMethods()
	Dim settings As Collection(Of ComponentSettingListItem) = SettingsManager.GetSettingList(_freeShippingProducts)
        Dim purchasedProducts As New Collection(Of String)
        For Each setting As ComponentSettingListItem In settings
            purchasedProducts.Add(setting.Setting1)
        Next
        settings = Nothing

        BindFreeShippingGrid(purchasedProducts)
        ViewState(_freeShippingProducts) = purchasedProducts

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
	
	Dim selectedId As String = SettingsManager.GetSetting(_ShippingMethodId)
        If Me.lstMethods.Items.FindByValue(selectedId) IsNot Nothing Then
            Me.lstMethods.ClearSelection()
            Me.lstMethods.Items.FindByValue(selectedId).Selected = True
        End If
    End Sub

    Private Sub LoadMethods()
        Me.lstMethods.DataSource = BVSoftware.Bvc5.Core.Shipping.ShippingMethod.FindAll()
        Me.lstMethods.DataTextField = "Name"
        Me.lstMethods.DataValueField = "bvin"
        Me.lstMethods.DataBind()
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
        FreeShippingGridView.DataSource = actualProducts
        FreeShippingGridView.DataKeyNames = New String() {"bvin"}
        FreeShippingGridView.DataBind()
    End Sub

    Protected Sub AddFreeShippingImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddFreeShippingImageButton.Click
        Dim products As Collection(Of String) = CType(ViewState(_freeShippingProducts), Collection(Of String))
        If products Is Nothing Then
            products = New Collection(Of String)
        End If
        For Each product As String In FreeShippingProductPicker.SelectedProducts
            If Not products.Contains(product) Then
                products.Add(product)
            End If
        Next
        ViewState(_freeShippingProducts) = products
        BindFreeShippingGrid(products)
    End Sub

    Protected Sub RemoveFreeShippingImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemoveFreeShippingImageButton.Click
        Dim products As Collection(Of String) = CType(ViewState(_freeShippingProducts), Collection(Of String))
        If products IsNot Nothing Then
            For Each row As GridViewRow In FreeShippingGridView.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    Dim checkbox As CheckBox = DirectCast(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
                    If checkbox.Checked Then
                        If products.Contains(FreeShippingGridView.DataKeys(row.RowIndex).Value) Then
                            products.Remove(FreeShippingGridView.DataKeys(row.RowIndex).Value)
                        End If
                    End If
                End If
            Next
        End If
        ViewState(_freeShippingProducts) = products
        BindFreeShippingGrid(products)
    End Sub

    Public Overrides Sub Save()
        SettingsManager.SaveSetting(_ShippingMethodId, lstMethods.SelectedValue, "bvsoftware", "Offer", "FreeShippingByCategory")
        'first clear out our product list
        Dim products As Collection(Of String) = ViewState(_freeShippingProducts)
        If products IsNot Nothing Then
            SettingsManager.DeleteSettingList(_freeShippingProducts)
            For Each product As String In products
                Dim item As New ComponentSettingListItem()
                item.Setting1 = product
                SettingsManager.InsertSettingListItem(_freeShippingProducts, item, "bvsoftware", "Offer", "Free Shipping")
            Next
        End If

        SettingsManager.SaveIntegerSetting("OrderQuantity", CInt(OrderQuantityTextBox.Text), "bvsoftware", "Offer", "Free Shipping")
        SettingsManager.SaveDecimalSetting("OrderTotal", Decimal.Parse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency), "bvsoftware", "Offer", "Free Shipping")

        Dim val As Decimal = 0
        If Decimal.TryParse(OrderTotalMaxTextBox.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            If val <= 0 Then
                val = Decimal.MaxValue
            End If
        Else
            val = Decimal.MaxValue
        End If
        SettingsManager.SaveDecimalSetting("OrderTotalMax", val, "bvsoftware", "Offer", "Free Shipping")
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
