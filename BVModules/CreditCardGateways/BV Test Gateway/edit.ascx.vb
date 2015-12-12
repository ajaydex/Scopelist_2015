Imports BVSoftware.BVC5.Core

Partial Class BVModules_CreditCardGateways_BV_Test_Gateway_edit
    Inherits Content.BVModule

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        Me.chkAuthorizeFails.Checked = SettingsManager.GetBooleanSetting("AuthorizeFails")
        Me.chkCaptureFails.Checked = SettingsManager.GetBooleanSetting("CaptureFails")
        Me.chkChargeFails.Checked = SettingsManager.GetBooleanSetting("ChargeFails")
        Me.chkRefundFails.Checked = SettingsManager.GetBooleanSetting("RefundFails")
        Me.chkVoidFails.Checked = SettingsManager.GetBooleanSetting("VoidFails")
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveBooleanSetting("AuthorizeFails", Me.chkAuthorizeFails.Checked, "bvsoftware", "Credit Card Gateway", "BV Test Gateway")
        SettingsManager.SaveBooleanSetting("CaptureFails", Me.chkCaptureFails.Checked, "bvsoftware", "Credit Card Gateway", "BV Test Gateway")
        SettingsManager.SaveBooleanSetting("ChargeFails", Me.chkChargeFails.Checked, "bvsoftware", "Credit Card Gateway", "BV Test Gateway")
        SettingsManager.SaveBooleanSetting("RefundFails", Me.chkRefundFails.Checked, "bvsoftware", "Credit Card Gateway", "BV Test Gateway")
        SettingsManager.SaveBooleanSetting("VoidFails", Me.chkVoidFails.Checked, "bvsoftware", "Credit Card Gateway", "BV Test Gateway")
    End Sub

End Class
