Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CreditCardGateways_BV_LinkPointAPI_edit
    Inherits Content.BVModule

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        'Load Test Values
        Me.ddlTestMode.Items.Add("Off")
        Me.ddlTestMode.Items.Add("Approved Response")
        Me.ddlTestMode.Items.Add("Declined Response")
        Me.ddlTestMode.Items.Add("Duplicate Response")
        'Fetch Values
        Me.txtMerchantLogin.Text = SettingsManager.GetSetting("MerchantLogin")
        Me.txtMerchantPemKey.Text = SettingsManager.GetSetting("MerchantPemKey")
        Me.txtLiveURL.Text = SettingsManager.GetSetting("LiveURL")
        Me.ddlTestMode.SelectedIndex = SettingsManager.GetIntegerSetting("TestModeIndex")
        Me.chkDebugMode.Checked = SettingsManager.GetBooleanSetting("DebugMode")
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("MerchantLogin", Me.txtMerchantLogin.Text.Trim, "bvtools", "Credit Card Gateway", "LinkPointAPI")
        SettingsManager.SaveSetting("MerchantPemKey", Me.txtMerchantPemKey.Text.Trim, "bvtools", "Credit Card Gateway", "LinkPointAPI")
        SettingsManager.SaveSetting("LiveURL", Me.txtLiveURL.Text.Trim, "bvtools", "Credit Card Gateway", "LinkPointAPI")
        SettingsManager.SaveIntegerSetting("TestModeIndex", Me.ddlTestMode.SelectedIndex, "bvtools", "Credit Card Gateway", "LinkPointAPI")
        SettingsManager.SaveBooleanSetting("DebugMode", Me.chkDebugMode.Checked, "bvtools", "Credit Card Gateway", "LinkPointAPI")
    End Sub

End Class
