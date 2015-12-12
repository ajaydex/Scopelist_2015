Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CreditCardGateways_Qbms_Edit
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
        Me.LoginField.Text = SettingsManager.GetSetting("Login")
        Me.TypeDropDown.Text = SettingsManager.GetSetting("Type")
        Me.TicketField.Text = SettingsManager.GetSetting("Ticket")
        Me.TestModeCheckBox.Checked = SettingsManager.GetBooleanSetting("TestMode")
        Me.DebugModeCheckBox.Checked = SettingsManager.GetBooleanSetting("DebugMode")
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Login", Me.LoginField.Text.Trim, "Develisys", "Credit Card Gateway", "QBMS")
        SettingsManager.SaveSetting("Type", Me.TypeDropDown.Text.Trim, "Develisys", "Credit Card Gateway", "QBMS")
        SettingsManager.SaveSetting("Ticket", Me.TicketField.Text.Trim, "Develisys", "Credit Card Gateway", "QBMS")
        SettingsManager.SaveBooleanSetting("TestMode", Me.TestModeCheckBox.Checked, "Develisys", "Credit Card Gateway", "QBMS")
        SettingsManager.SaveBooleanSetting("DebugMode", Me.DebugModeCheckBox.Checked, "Develisys", "Credit Card Gateway", "QBMS")
    End Sub

End Class
