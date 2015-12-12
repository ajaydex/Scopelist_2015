Imports System.Collections.ObjectModel

Imports BVSoftware.BVC5.Core

Partial Class BVModules_Offers_Products_By_Category_Edit
    Inherits Content.OfferTemplate

    Private _IncludedCategories As String = "IncludedCategories"
    Private _OrderTotal As String = "OrderTotal"
    Private _OrderTotalItems As String = "OrderTotalItems"
    Private _DiscountPercent As String = "DiscountPercent"
    Private _DiscountAmount As String = "DiscountAmount"
    Private _ShippingMethodId As String = "ShippingMethodId"

    Public Overrides Sub Cancel()

    End Sub

    Public Overloads Overrides Sub Initialize()
        LoadCategories()
        BindCategories()

        PercentAmountSelection.Amount = SettingsManager.GetDecimalSetting("Amount")
        PercentAmountSelection.AmountType = SettingsManager.GetIntegerSetting("AmountType")
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
    End Sub

    Public Overrides Sub Save()
        SettingsManager.SaveDecimalSetting("Amount", PercentAmountSelection.Amount, "Develisys", "Offer", "Products")
        SettingsManager.SaveIntegerSetting("AmountType", PercentAmountSelection.AmountType, "Develisys", "Offer", "Products")
        'SettingsManager.SaveIntegerSetting("OrderQuantity", CInt(OrderQuantityTextBox.Text), "Develisys", "Offer", "Products")
        SettingsManager.SaveDecimalSetting("OrderTotal", Decimal.Parse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency), "Develisys", "Offer", "Products")

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

    Private Sub LoadCategories()
        Dim allcats As Collection(Of ListItem) = Catalog.Category.ListFullTreeWithIndents(True)

        Me.lstCategory.Items.Clear()
        For Each li As ListItem In allcats
            Me.lstCategory.Items.Add(li)
        Next
    End Sub

    Protected Sub AddCategory_Click(sender As Object, e As EventArgs)
        Dim c As BVSoftware.BVC5.Core.Content.ComponentSettingListItem = New Content.ComponentSettingListItem()
        c.Setting1 = Me.lstCategory.SelectedItem.Value
        c.Setting2 = Me.lstCategory.SelectedItem.Text
        SettingsManager.InsertSettingListItem(_IncludedCategories, c, "bvsoftware", "Category", "Included Category")
        BindCategories()
    End Sub

    Private Sub BindCategories()
        Dim categories As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList(_IncludedCategories)

        ' Do not show deleted categories
        Dim undeletedCategories As New Collection(Of Content.ComponentSettingListItem)
        For Each category As Content.ComponentSettingListItem In categories

            Dim cat As Catalog.Category = Catalog.Category.FindByBvin(category.Setting1)
            If (cat IsNot Nothing AndAlso cat.Bvin <> String.Empty) Then
                undeletedCategories.Add(category)
            Else
                SettingsManager.DeleteSettingListItem(category.Bvin)
            End If
        next

        Me.gvIncludedCategories.DataSource = undeletedCategories
        Me.gvIncludedCategories.DataBind()
    End Sub

    Protected Sub gvIncludedCategories_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        Dim bvin As String = Me.gvIncludedCategories.DataKeys(e.RowIndex).Value.ToString()
        SettingsManager.DeleteSettingListItem(bvin)
        BindCategories()
    End Sub

    Protected Sub OrderTotalCustomValidator_ServerValidate(source As Object, args As ServerValidateEventArgs)
        Dim result As Decimal = 0
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, result) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
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