Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CreditCardGateways_BV_Moneris_edit
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
        Me.txtHost.Text = SettingsManager.GetSetting("Host")
        Me.txtStoreId.Text = SettingsManager.GetSetting("StoreId")
        Me.txtAPIToken.Text = SettingsManager.GetSetting("APIToken")
        Me.chkCVV.Checked = SettingsManager.GetBooleanSetting("CVVEnabled")
        Me.chkDebugMode.Checked = SettingsManager.GetBooleanSetting("DebugMode")
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Host", Me.txtHost.Text.Trim, "bvsoftware", "Credit Card Gateway", "WorldPay")
        SettingsManager.SaveSetting("StoreId", Me.txtStoreId.Text.Trim, "bvsoftware", "Credit Card Gateway", "WorldPay")
        SettingsManager.SaveSetting("APIToken", Me.txtAPIToken.Text, "bvsoftware", "Credit Card Gateway", "WorldPay")
        SettingsManager.SaveBooleanSetting("CVVEnabled", Me.chkCVV.Checked, "bvsoftware", "Credit Card Gateway", "WorldPay")
        SettingsManager.SaveBooleanSetting("DebugMode", Me.chkDebugMode.Checked, "bvsoftware", "Credit Card Gateway", "WorldPay")
    End Sub

End Class
