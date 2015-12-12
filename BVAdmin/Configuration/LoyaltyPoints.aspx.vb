Imports System.Collections.ObjectModel
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_LoyaltyPoints
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.ucDateRangeField.RangeType = BVSoftware.Bvc5.Core.Utilities.DateRangeType.ThisMonth
            LoadSettings()
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Loyalty Points"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsEdit)
    End Sub

    Private Sub LoadSettings()
        Me.chkLoyaltyPointsEnabled.Checked = WebAppSettings.LoyaltyPointsEnabled
        Me.txtLoyaltyPointsEarnedPerCurrencyUnit.Text = WebAppSettings.LoyaltyPointsEarnedPerCurrencyUnit.ToString()
        Me.txtLoyaltyPointsToCurrencyUnitExchangeRate.Text = WebAppSettings.LoyaltyPointsToCurrencyUnitExchangeRate.ToString()
        Me.txtMinimumOrderAmountToEarnPoints.Text = WebAppSettings.LoyaltyPointsMinimumOrderAmountToEarnPoints.ToString()
        Me.txtMinimumOrderAmountToUsePoints.Text = WebAppSettings.LoyaltyPointsMinimumOrderAmountToUsePoints.ToString()
        Me.txtMinimumPointsCurrencyBalanceToUse.Text = WebAppSettings.LoyaltyPointsMinimumPointsCurrencyBalanceToUse.ToString()
        Me.chkLoyaltyPointsExpire.Checked = WebAppSettings.LoyaltyPointsExpire
        Me.txtLoyaltyPointsExpireDays.Text = WebAppSettings.LoyaltyPointsExpireDays.ToString()
    End Sub

    Private Sub SaveSettings()
        WebAppSettings.LoyaltyPointsEnabled = Me.chkLoyaltyPointsEnabled.Checked
        WebAppSettings.LoyaltyPointsEarnedPerCurrencyUnit = Convert.ToDecimal(Me.txtLoyaltyPointsEarnedPerCurrencyUnit.Text)
        WebAppSettings.LoyaltyPointsToCurrencyUnitExchangeRate = Convert.ToDecimal(Me.txtLoyaltyPointsToCurrencyUnitExchangeRate.Text)
        WebAppSettings.LoyaltyPointsMinimumOrderAmountToEarnPoints = Convert.ToDecimal(Me.txtMinimumOrderAmountToEarnPoints.Text)
        WebAppSettings.LoyaltyPointsMinimumOrderAmountToUsePoints = Convert.ToDecimal(Me.txtMinimumOrderAmountToUsePoints.Text)
        WebAppSettings.LoyaltyPointsMinimumPointsCurrencyBalanceToUse = Convert.ToDecimal(Me.txtMinimumPointsCurrencyBalanceToUse.Text)
        WebAppSettings.LoyaltyPointsExpire = Me.chkLoyaltyPointsExpire.Checked
        WebAppSettings.LoyaltyPointsExpireDays = Convert.ToInt32(Me.txtLoyaltyPointsExpireDays.Text)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        Page.Validate()
        If Page.IsValid Then
            SaveSettings()
            Me.ucMessageBox.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Protected Sub btnCreditPastOrders_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCreditPastOrders.Click
        Dim criteria As New Orders.OrderSearchCriteria()
        criteria.IsPlaced = 1
        criteria.StartDate = Me.ucDateRangeField.StartDate
        criteria.EndDate = Me.ucDateRangeField.EndDate

        Dim ordersCredited As Integer = 0
        Dim pastOrders As Collection(Of Orders.Order) = Orders.Order.FindByCriteria(criteria)
        For Each o As Orders.Order In pastOrders
            ' tag order to receive loyalty points
            o.CustomPropertySet("Develisys", "ValidForLoyaltyPoints", Boolean.TrueString)

            If Not String.IsNullOrEmpty(Membership.LoyaltyPoints.CreditPoints(o).Bvin) Then
                Orders.Order.Update(o)
                ordersCredited += 1
            End If
        Next

        If pastOrders.Count > 0 Then
            Me.ucMessageBox.ShowOk(String.Format("{0} orders found in the chosen date range and {1} orders were credited loyalty points", pastOrders.Count.ToString(), ordersCredited.ToString()))
        Else
            Me.ucMessageBox.ShowWarning("No ordrers found in the chosen date range")
        End If
    End Sub

End Class