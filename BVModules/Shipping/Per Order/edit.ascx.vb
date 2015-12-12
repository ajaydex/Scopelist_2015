Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Shipping_Per_Order_edit
    Inherits Content.BVShippingModule

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing("Canceled")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing(Me.NameField.Text.Trim)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        Me.NameField.Text = SettingsManager.GetSetting("Name")
        Me.AmountField.Text = SettingsManager.GetDecimalSetting("Amount")
        AdjustmentDropDownList.SelectedValue = ShippingMethod.AdjustmentType
        If ShippingMethod.AdjustmentType = Shipping.ShippingMethodAdjustmentType.Amount Then
            AdjustmentTextBox.Text = String.Format("{0:c}", ShippingMethod.Adjustment)
        Else
            AdjustmentTextBox.Text = String.Format("{0:f}", ShippingMethod.Adjustment)
        End If
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Name", Me.NameField.Text.Trim, "bvsoftware", "Shipping Method", "Per Order")
        SettingsManager.SaveDecimalSetting("Amount", Me.AmountField.Text.Trim, "bvsoftware", "Shipping Method", "Per Order")
        ShippingMethod.AdjustmentType = AdjustmentDropDownList.SelectedValue()
        ShippingMethod.Adjustment = Decimal.Parse(AdjustmentTextBox.Text, System.Globalization.NumberStyles.Currency)
    End Sub

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        Dim val As Decimal = 0D
        If Decimal.TryParse(AdjustmentTextBox.Text, System.Globalization.NumberStyles.Currency, System.Globalization.CultureInfo.CurrentCulture, val) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub
End Class
