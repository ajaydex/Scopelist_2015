Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CreditCardGateways_BV_PaymentechOrbital_edit
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
        Me.txtMerchantTimeZone.Text = SettingsManager.GetSetting("MerchantTimeZone")
        Me.txtMerchantPassword.Text = SettingsManager.GetSetting("MerchantPassword")
        Me.txtLiveURL.Text = SettingsManager.GetSetting("LiveURL")
        Me.txtTestURL.Text = SettingsManager.GetSetting("TestURL")
        Me.chkTestMode.Checked = SettingsManager.GetBooleanSetting("TestMode")
        Me.chkDebugMode.Checked = SettingsManager.GetBooleanSetting("DebugMode")
        Me.CurrencyCodeTextBox.Text = SettingsManager.GetSetting("CurrencyCode")
        Me.CommentCodeTextBox.Text = SettingsManager.GetSetting("CommentCode")
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("MerchantLogin", Me.txtMerchantLogin.Text.Trim, "bvtools", "Credit Card Gateway", "PaymentechOrbital")
        SettingsManager.SaveSetting("MerchantTimeZone", Me.txtMerchantTimeZone.Text.Trim, "bvtools", "Credit Card Gateway", "PaymentechOrbital")
        SettingsManager.SaveSetting("MerchantPassword", Me.txtMerchantPassword.Text.Trim, "bvtools", "Credit Card Gateway", "PaymentechOrbital")
        SettingsManager.SaveSetting("LiveURL", Me.txtLiveURL.Text.Trim, "bvtools", "Credit Card Gateway", "PaymentechOrbital")
        SettingsManager.SaveSetting("TestURL", Me.txtTestURL.Text.Trim, "bvtools", "Credit Card Gateway", "PaymentechOrbital")
        SettingsManager.SaveBooleanSetting("TestMode", Me.chkTestMode.Checked, "bvtools", "Credit Card Gateway", "PaymentechOrbital")
        SettingsManager.SaveBooleanSetting("DebugMode", Me.chkDebugMode.Checked, "bvtools", "Credit Card Gateway", "PaymentechOrbital")
        SettingsManager.SaveSetting("CurrencyCode", Me.CurrencyCodeTextBox.Text.Trim, "bvtools", "Credit Card Gateway", "PaymentechOrbital")
        SettingsManager.SaveSetting("CommentCode", Me.CommentCodeTextBox.Text.Trim(), "bvtools", "Creidt Card Gateway", "PaymentechOrbital")
    End Sub

End Class
