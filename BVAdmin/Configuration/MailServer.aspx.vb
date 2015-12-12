Imports System.Collections.ObjectModel
Imports System.Collections.Generic
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_MailServer
    Inherits BaseAdminPage



    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Mail Server Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadEmailTemplates()
            LoadData()
        End If
    End Sub

    Private Sub LoadEmailTemplates()

        ddlForgotPassword.DataSource = Content.EmailTemplate.FindAll
        ddlForgotPassword.DataTextField = "DisplayName"
        ddlForgotPassword.DataValueField = "bvin"        
        ddlForgotPassword.DataBind()
        ddlForgotPassword.SelectedValue = WebAppSettings.EmailTemplateID_ForgotPassword

        ddlContactUs.DataSource = Content.EmailTemplate.FindAll
        ddlContactUs.DataTextField = "DisplayName"
        ddlContactUs.DataValueField = "bvin"        
        ddlContactUs.DataBind()
        ddlContactUs.SelectedValue = WebAppSettings.EmailTemplateID_ContactUs

        ddlEmailFriend.DataSource = Content.EmailTemplate.FindAll
        ddlEmailFriend.DataTextField = "DisplayName"
        ddlEmailFriend.DataValueField = "bvin"        
        ddlEmailFriend.DataBind()
        ddlEmailFriend.SelectedValue = WebAppSettings.EmailTemplateID_EmailFriend

    End Sub

    Private Sub LoadData()
        MailServerField.Text = WebAppSettings.MailServer
        Me.chkMailServerAuthentication.Checked = WebAppSettings.MailServerUseAuthentication
        Me.UsernameField.Text = WebAppSettings.MailServerUsername
        Me.PasswordField.Text = "****************"
        Me.txtContactUsEmailRecipient.Text = WebAppSettings.ContactUsEmailRecipient

        Me.chkSSL.Checked = WebAppSettings.MailServerUseSsl
        Me.SmtpPortField.Text = WebAppSettings.MailServerPort

    End Sub


    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.msg.ShowOk("Settings saved successfully.")
    End Sub

    Private Sub SaveData()
        WebAppSettings.EmailTemplateID_ForgotPassword = Me.ddlForgotPassword.SelectedValue
        WebAppSettings.EmailTemplateID_ContactUs = Me.ddlContactUs.SelectedValue
        WebAppSettings.EmailTemplateID_EmailFriend = Me.ddlEmailFriend.SelectedValue

        WebAppSettings.MailServer = MailServerField.Text.Trim
        WebAppSettings.MailServerUseAuthentication = Me.chkMailServerAuthentication.Checked
        WebAppSettings.MailServerUsername = Me.UsernameField.Text.Trim
        WebAppSettings.ContactUsEmailRecipient = Me.txtContactUsEmailRecipient.Text.Trim
        If Me.PasswordField.Text.Trim.Length > 0 Then
            If Me.PasswordField.Text <> "****************" Then
                WebAppSettings.MailServerPassword = Me.PasswordField.Text.Trim
                Me.PasswordField.Text = "****************"
            End If
        End If

        WebAppSettings.MailServerUseSsl = Me.chkSSL.Checked
        WebAppSettings.MailServerPort = Me.SmtpPortField.Text.Trim()

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("Default.aspx")
    End Sub

    Protected Sub btnSendTest_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSendTest.Click
        SaveData()

        msg.ClearMessage()

        Dim m As New System.Net.Mail.MailMessage("testemail@bvcommerce.com", Me.TestToField.Text.Trim)
        m.Subject = "Mail Server Test Message"
        m.Body = "Your mail server appears to be correctly configured!"
        m.IsBodyHtml = False

        If Utilities.MailServices.SendMail(m) = True Then
            msg.ShowOK("Test Message Sent")
        Else
            msg.ShowError("Test Failed. Please check your settings and try again.")
        End If

        m = Nothing        
    End Sub
End Class
