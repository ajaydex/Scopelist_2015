Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CreditCardGateways_Authorize_Net_Edit
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
        Me.UsernameTextBox.Text = WebAppSettings.PaypalUserName
        Me.PasswordTextBox.Text = WebAppSettings.PaypalPassword
        Me.SignatureTextBox.Text = WebAppSettings.PaypalSignature
        Me.ModeRadioButtonList.SelectedValue = WebAppSettings.PaypalMode        
    End Sub

    Private Sub SaveData()
        WebAppSettings.PaypalUserName = Me.UsernameTextBox.Text
        WebAppSettings.PaypalPassword = Me.PasswordTextBox.Text
        WebAppSettings.PaypalSignature = Me.SignatureTextBox.Text
        WebAppSettings.PaypalMode = Me.ModeRadioButtonList.SelectedValue        
    End Sub

End Class
