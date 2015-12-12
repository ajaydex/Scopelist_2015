Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CreditCardGateways_BV_Protx_edit
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
        Me.txtCurrencyCode.Text = SettingsManager.GetSetting("CurrencyCode")
        Me.txtLiveURL.Text = SettingsManager.GetSetting("LiveURL")
        Me.txtTestURL.Text = SettingsManager.GetSetting("TestURL")
        Me.chkTestMode.Checked = SettingsManager.GetBooleanSetting("TestMode")
        Me.chkDebugMode.Checked = SettingsManager.GetBooleanSetting("DebugMode")
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("MerchantLogin", Me.txtMerchantLogin.Text, "bvtools", "Credit Card Gateway", "Protx")
        SettingsManager.SaveSetting("CurrencyCode", Me.txtCurrencyCode.Text, "bvtools", "Credit Card Gateway", "Protx")
        SettingsManager.SaveSetting("LiveURL", Me.txtLiveURL.Text, "bvtools", "Credit Card Gateway", "Protx")
        SettingsManager.SaveSetting("TestURL", Me.txtTestURL.Text, "bvtools", "Credit Card Gateway", "Protx")
        SettingsManager.SaveBooleanSetting("TestMode", Me.chkTestMode.Checked, "bvtools", "Credit Card Gateway", "Protx")
        SettingsManager.SaveBooleanSetting("DebugMode", Me.chkDebugMode.Checked, "bvtools", "Credit Card Gateway", "Protx")
    End Sub

End Class
