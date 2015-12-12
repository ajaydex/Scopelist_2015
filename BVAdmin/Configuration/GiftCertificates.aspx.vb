Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_GiftCertificates
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            MaximumAmountTextBox.Text = WebAppSettings.GiftCertificateMaximumAmount.ToString("c")
            MinimumAmountTextBox.Text = WebAppSettings.GiftCertificateMinimumAmount.ToString("c")
            ValidDaysTextBox.Text = WebAppSettings.GiftCertificateValidDays
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Gift Certificate Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Page.IsValid Then
            WebAppSettings.GiftCertificateMaximumAmount = Decimal.Parse(MaximumAmountTextBox.Text, System.Globalization.NumberStyles.Currency)
            WebAppSettings.GiftCertificateMinimumAmount = Decimal.Parse(MinimumAmountTextBox.Text, System.Globalization.NumberStyles.Currency)
            Dim v As Integer = WebAppSettings.GiftCertificateValidDays
            Integer.TryParse(ValidDaysTextBox.Text, v)
            WebAppSettings.GiftCertificateValidDays = v            
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate, CustomValidator4.ServerValidate
        Dim val As Decimal = 0D
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub
End Class
