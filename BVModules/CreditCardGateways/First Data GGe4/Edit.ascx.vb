Imports BVSoftware.BVC5.Core

Partial Class BVModules_CreditCardGateways_First_Data_GGe4_Edit
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
        Me.UsernameField.Text = SettingsManager.GetSetting("Username")
        Me.PasswordField.Text = "**********"
        Me.chkDebugMode.Checked = SettingsManager.GetBooleanSetting("DebugMode")
        Me.chkTestMode.Checked = SettingsManager.GetBooleanSetting("TestMode")
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Username", Me.UsernameField.Text.Trim, "bvsoftware", "Credit Card Gateway", "First Data Global Gateway")
        If Me.PasswordField.Text <> "**********" Then
            SettingsManager.SaveSetting("Password", Me.PasswordField.Text.Trim, "bvsoftware", "Credit Card Gateway", "First Data Global Gateway")
        End If
        SettingsManager.SaveBooleanSetting("DebugMode", Me.chkDebugMode.Checked, "bvsoftware", "Credit Card Gateway", "First Data Global Gateway")
        SettingsManager.SaveBooleanSetting("TestMode", Me.chkTestMode.Checked, "bvsoftware", "Credit Card Gateway", "First Data Global Gateway")
    End Sub

End Class