Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Offers_Order_Total_Edit
    Inherits OfferTemplate

    Public Overloads Overrides Sub Initialize()
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
        SettingsManager.SaveDecimalSetting("Amount", PercentAmountSelection.Amount, "bvsoftware", "Offer", "Order Total")
        SettingsManager.SaveIntegerSetting("AmountType", PercentAmountSelection.AmountType, "bvsoftware", "Offer", "Order Total")
        SettingsManager.SaveIntegerSetting("OrderQuantity", CInt(OrderQuantityTextBox.Text), "bvsoftware", "Offer", "Order Total")
        SettingsManager.SaveDecimalSetting("OrderTotal", Decimal.Parse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency), "bvsoftware", "Offer", "Order Total")

        Dim val As Decimal = 0
        If Decimal.TryParse(OrderTotalMaxTextBox.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            If val <= 0 Then
                val = Decimal.MaxValue
            End If
        Else
            val = Decimal.MaxValue
        End If
        SettingsManager.SaveDecimalSetting("OrderTotalMax", val, "bvsoftware", "Offer", "Order Total")
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
