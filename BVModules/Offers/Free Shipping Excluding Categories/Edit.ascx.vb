Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Offers_Free_Shipping_Excluding_Categories_Edit
    Inherits OfferTemplate

    Private Shared _CategoriesExcluded As String = "ExcludedCategories"
    Private Shared _OrderTotal As String = "OrderTotal"
    Private Shared _ShippingMethodId As String = "ShippingMethodId"

    Protected Sub Page_Load(sender As Object, e As EventArgs)
    End Sub

    Public Overrides Sub Initialize()
        LoadCategories()
        LoadMethods()
        BindCategories()

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

    Private Sub LoadCategories()
        Dim allcats As Collection(Of ListItem) = BVSoftware.BVC5.Core.Catalog.Category.ListFullTreeWithIndents()

        Me.lstCategory.Items.Clear()
        For Each li As ListItem In allcats
            Me.lstCategory.Items.Add(li)
        Next
    End Sub

    Private Sub LoadMethods()
        Me.lstMethods.DataSource = BVSoftware.BVC5.Core.Shipping.ShippingMethod.FindAll()
        Me.lstMethods.DataTextField = "Name"
        Me.lstMethods.DataValueField = "bvin"
        Me.lstMethods.DataBind()
    End Sub

    Public Overrides Sub Cancel()

    End Sub



    Public Overrides Sub Save()
        SettingsManager.SaveSetting(_ShippingMethodId, lstMethods.SelectedValue, "bvsoftware", "Offer", "FreeShippingByCategory")
        SettingsManager.SaveIntegerSetting("OrderQuantity", CInt(OrderQuantityTextBox.Text), "bvsoftware", "Offer", "FreeShippingByCategory")
        SettingsManager.SaveDecimalSetting("OrderTotal", Decimal.Parse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency), "bvsoftware", "Offer", "FreeShippingByCategory")

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

    Protected Sub AddCategory_Click(sender As Object, e As EventArgs)
        Dim c As BVSoftware.BVC5.Core.Content.ComponentSettingListItem = New ComponentSettingListItem()
        c.Setting1 = Me.lstCategory.SelectedItem.Value
        c.Setting2 = Me.lstCategory.SelectedItem.Text
        SettingsManager.InsertSettingListItem(_CategoriesExcluded, c, "bvsoftware", "Free Gift Wrap", "Excluded Category")
        BindCategories()
    End Sub

    Private Sub BindCategories()
        Dim categories As Collection(Of ComponentSettingListItem) = SettingsManager.GetSettingList(_CategoriesExcluded)

        ' do not show deleted categories
        Dim undeletedCategories As New Collection(Of ComponentSettingListItem)()
        For Each category As ComponentSettingListItem In categories
            Dim cat As BVSoftware.BVC5.Core.Catalog.Category = BVSoftware.BVC5.Core.Catalog.Category.FindByBvin(category.Setting1)
            If cat IsNot Nothing AndAlso cat.Bvin <> String.Empty Then
                undeletedCategories.Add(category)
            Else
                SettingsManager.DeleteSettingListItem(category.Bvin)
            End If
        Next

        Me.ExcludedCategories.DataSource = undeletedCategories
        Me.ExcludedCategories.DataBind()
    End Sub

    Protected Sub ExcludedCategories_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        Dim bvin As String = Me.ExcludedCategories.DataKeys(e.RowIndex).Value.ToString()
        SettingsManager.DeleteSettingListItem(bvin)
        BindCategories()
    End Sub

    Protected Sub OrderTotalCustomValidator_ServerValidate(source As Object, args As ServerValidateEventArgs)
        Dim result As [Decimal] = 0
        If [Decimal].TryParse(args.Value, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, result) Then
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