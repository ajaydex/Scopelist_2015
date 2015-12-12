Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CreditCardGateways_BV_PayFlowProNET_edit
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
        'Fetch Values
        Me.txtMerchantVendor.Text = SettingsManager.GetSetting("MerchantVendor")
        Me.txtMerchantLogin.Text = SettingsManager.GetSetting("MerchantLogin")
        Me.txtMerchantUser.Text = SettingsManager.GetSetting("MerchantUser")
        Me.txtMerchantPassword.Text = SettingsManager.GetSetting("MerchantPassword")
        'Me.txtCertLocation.Text = SettingsManager.GetSetting("CertLocation")
        Me.txtLiveURL.Text = SettingsManager.GetSetting("LiveURL")
        Me.txtTestURL.Text = SettingsManager.GetSetting("TestURL")
        Me.chkTestMode.Checked = SettingsManager.GetBooleanSetting("TestMode")
        Me.chkDebugMode.Checked = SettingsManager.GetBooleanSetting("DebugMode")
        Me.CurrencyCodeDropDownList.SelectedValue = SettingsManager.GetSetting("CurrencyCode")
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("MerchantVendor", Me.txtMerchantVendor.Text.Trim(), "bvtools", "Credit Card Gateway", "PayflowProNET")
        SettingsManager.SaveSetting("MerchantLogin", Me.txtMerchantLogin.Text.Trim(), "bvtools", "Credit Card Gateway", "PayflowProNET")
        SettingsManager.SaveSetting("MerchantUser", Me.txtMerchantUser.Text.Trim(), "bvtools", "Credit Card Gateway", "PayflowProNET")
        SettingsManager.SaveSetting("MerchantPassword", Me.txtMerchantPassword.Text.Trim(), "bvtools", "Credit Card Gateway", "PayflowProNET")
        'SettingsManager.SaveSetting("CertLocation", Me.txtCertLocation.Text.Trim(), "bvtools", "Credit Card Gateway", "PayflowProNET")
        SettingsManager.SaveSetting("LiveURL", Me.txtLiveURL.Text.Trim().Replace("http://", "").Replace("https://", ""), "bvtools", "Credit Card Gateway", "PayflowProNET")
        SettingsManager.SaveSetting("TestURL", Me.txtTestURL.Text.Trim().Replace("http://", "").Replace("https://", ""), "bvtools", "Credit Card Gateway", "PayflowProNET")
        SettingsManager.SaveBooleanSetting("TestMode", Me.chkTestMode.Checked, "bvtools", "Credit Card Gateway", "PayflowProNET")
        SettingsManager.SaveBooleanSetting("DebugMode", Me.chkDebugMode.Checked, "bvtools", "Credit Card Gateway", "PayflowProNET")
        SettingsManager.SaveSetting("CurrencyCode", Me.CurrencyCodeDropDownList.SelectedValue, "bvtools", "Credit Card Gateway", "PayflowProNET")
    End Sub

End Class