Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CreditCardGateways_BV_CyberSource_edit
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
        Me.txtMerchantLogin.Text = SettingsManager.GetSetting("MerchantLogin")
        Me.txtMerchantPassword.Text = SettingsManager.GetSetting("MerchantKey")
        Me.txtLiveURL.Text = SettingsManager.GetSetting("LiveURL")
        Me.txtTestURL.Text = SettingsManager.GetSetting("TestURL")
        Me.chkTestMode.Checked = SettingsManager.GetBooleanSetting("TestMode")
        Me.chkDebugMode.Checked = SettingsManager.GetBooleanSetting("DebugMode")
        Me.CurrencyCodeField.Text = SettingsManager.GetSetting("CurrencyCode")
        If (Me.CurrencyCodeField.Text = String.Empty) Then
            Me.CurrencyCodeField.Text = "USD"
        End If
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("MerchantLogin", Me.txtMerchantLogin.Text, "bvtools", "Credit Card Gateway", "CyberSource")
        SettingsManager.SaveSetting("MerchantKey", Me.txtMerchantPassword.Text, "bvtools", "Credit Card Gateway", "CyberSource")
        SettingsManager.SaveSetting("LiveURL", Me.txtLiveURL.Text, "bvtools", "Credit Card Gateway", "CyberSource")
        SettingsManager.SaveSetting("TestURL", Me.txtTestURL.Text, "bvtools", "Credit Card Gateway", "CyberSource")
        SettingsManager.SaveBooleanSetting("TestMode", Me.chkTestMode.Checked, "bvtools", "Credit Card Gateway", "CyberSource")
        SettingsManager.SaveBooleanSetting("DebugMode", Me.chkDebugMode.Checked, "bvtools", "Credit Card Gateway", "CyberSource")
        SettingsManager.SaveSetting("CurrencyCode", Me.CurrencyCodeField.Text.Trim(), "bvtools", "Credit Card Gateway", "CyberSource")
    End Sub

End Class
