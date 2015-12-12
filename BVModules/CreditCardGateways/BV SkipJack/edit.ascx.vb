Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CreditCardGateways_BV_SkipJack_edit
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
        Me.txtLiveURL.Text = SettingsManager.GetSetting("LiveURL")
        Me.chkDebugMode.Checked = SettingsManager.GetBooleanSetting("DebugMode")
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("MerchantLogin", Me.txtMerchantLogin.Text.Trim, "bvtools", "Credit Card Gateway", "SkipJack")
        SettingsManager.SaveSetting("LiveURL", Me.txtLiveURL.Text.Trim, "bvtools", "Credit Card Gateway", "SkipJack")
        SettingsManager.SaveBooleanSetting("DebugMode", Me.chkDebugMode.Checked, "bvtools", "Credit Card Gateway", "SkipJack")
    End Sub

End Class
