Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CreditCardGateways_BV_PayFuseXML_edit
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
        Me.ddlTestMode.Items.Add("TestMode")
        Me.ddlTestMode.Items.Add("Reject Transactions")
        Me.ddlTestMode.Items.Add("Accept Transactions")
        Me.ddlTestMode.Items.Add("Random Transactions")
        'Fetch Values
        Me.txtMerchantLogin.Text = SettingsManager.GetSetting("MerchantLogin")
        Me.txtMerchantAlias.Text = SettingsManager.GetSetting("MerchantAlias")
        Me.txtMerchantPassword.Text = SettingsManager.GetSetting("MerchantPassword")
        Me.txtLiveURL.Text = SettingsManager.GetSetting("LiveURL")
        Me.txtTestURL.Text = SettingsManager.GetSetting("TestURL")
        Me.ddlTestMode.SelectedIndex = SettingsManager.GetIntegerSetting("TestModeIndex")
        Me.chkDebugMode.Checked = SettingsManager.GetBooleanSetting("DebugMode")
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("MerchantLogin", Me.txtMerchantLogin.Text.Trim, "bvtools", "Credit Card Gateway", "PayFuseXML")
        SettingsManager.SaveSetting("MerchantAlias", Me.txtMerchantAlias.Text.Trim, "bvtools", "Credit Card Gateway", "PayFuseXML")
        SettingsManager.SaveSetting("MerchantPassword", Me.txtMerchantPassword.Text.Trim, "bvtools", "Credit Card Gateway", "PayFuseXML")
        SettingsManager.SaveSetting("LiveURL", Me.txtLiveURL.Text.Trim, "bvtools", "Credit Card Gateway", "PayFuseXML")
        SettingsManager.SaveSetting("TestURL", Me.txtTestURL.Text.Trim, "bvtools", "Credit Card Gateway", "PayFuseXML")
        SettingsManager.SaveIntegerSetting("TestModeIndex", Me.ddlTestMode.SelectedIndex, "bvtools", "Credit Card Gateway", "PayFuseXML")
        SettingsManager.SaveBooleanSetting("DebugMode", Me.chkDebugMode.Checked, "bvtools", "Credit Card Gateway", "PayFuseXML")
    End Sub

End Class
