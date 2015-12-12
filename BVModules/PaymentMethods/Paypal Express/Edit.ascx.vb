Imports BVSoftware.Bvc5.Core

Partial Class BVModules_PaymentMethods_Paypal_Express_Edit
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
        Me.lstCaptureMode.ClearSelection()
        If WebAppSettings.PaypalExpressAuthorizeOnly Then
            Me.lstCaptureMode.SelectedValue = "1"
        Else
            Me.lstCaptureMode.SelectedValue = "0"
        End If

        Me.CheckoutPageTextBox.Text = WebAppSettings.PaypalExpressCheckoutPage
        Me.UnconfirmedAddressCheckBox.Checked = WebAppSettings.PaypalAllowUnconfirmedAddresses
        Me.PaypalMonetaryFormatRadioButtonList.SelectedValue = WebAppSettings.PaypalCurrency
    End Sub

    Private Sub SaveData()
        WebAppSettings.PaypalUserName = Me.UsernameTextBox.Text
        WebAppSettings.PaypalPassword = Me.PasswordTextBox.Text
        WebAppSettings.PaypalSignature = Me.SignatureTextBox.Text
        WebAppSettings.PaypalMode = Me.ModeRadioButtonList.SelectedValue
        WebAppSettings.PaypalExpressAuthorizeOnly = (Me.lstCaptureMode.SelectedValue = "1")
        WebAppSettings.PaypalExpressCheckoutPage = Me.CheckoutPageTextBox.Text
        WebAppSettings.PaypalAllowUnconfirmedAddresses = Me.UnconfirmedAddressCheckBox.Checked
        WebAppSettings.PaypalCurrency = Me.PaypalMonetaryFormatRadioButtonList.SelectedValue
    End Sub

End Class
