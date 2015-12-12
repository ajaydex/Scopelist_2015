Imports System.Net.Mail
Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.PersonalizationServices


Partial Class BVModules_Controls_ForgotPassword
    Inherits System.Web.UI.UserControl

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not Page.IsPostBack Then
            ImageButton1.ImageUrl = GetThemedButton("Cancel")
            btnSend.ImageUrl = GetThemedButton("ResetPassword")
            Page.Title = Content.SiteTerms.GetTerm("ForgotPassword")
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("ForgotPassword")
            Me.lblUsername.Text = Content.SiteTerms.GetTerm("Username")
            Me.val2Username.Text = GetThemedButton("ErrorIcon")
            Me.valUsername.Text = GetThemedButton("ErrorIcon")
        End If
    End Sub

    Private Sub btnSend_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSend.Click

        msg.ClearMessage()

        If Page.IsValid Then

            Dim thisUser As Membership.UserAccount = Membership.UserAccount.FindByUserName(inUsername.Text)

            If Not thisUser Is Nothing Then

                Dim newPassword As String = Membership.UserAccount.GeneratePassword(10)

                Dim crypto As New Utilities.Cryptography.MD5Encryption
                thisUser.Password = Utilities.Cryptography.MD5Encryption.EncodeWithSalt(newPassword, thisUser.Salt)

                Try
                    Membership.UserAccount.Update(thisUser)
                    SendPasswordReminderEmail(thisUser, newPassword)
                    msg.ShowOk("Your new password has been sent by email")
                Catch CreateEx As Membership.BVMembershipUserException
                    Select Case CreateEx.Status
                        Case Membership.CreateUserStatus.UpdateFailed
                            msg.ShowError("Update to user account failed.")
                        Case Else
                            msg.ShowError(CreateEx.Message)
                    End Select
                End Try
            Else
                msg.ShowWarning("Please check your E-mail address.  No user account was found for " & HttpUtility.HtmlEncode(inUsername.Text))
            End If
        End If
    End Sub

    Private Sub SendPasswordReminderEmail(ByVal thisUser As Membership.UserAccount, ByVal newPassword As String)
        ''''''''''''''''''''''''''''''''''''''''''TODO''''''''''''''''''''''''''''''''''''''''''''''''
        ''''''''''''''''''''''''''''''''''''''''''Commented out until Send Mail function is created'''
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

        'Dim t As Content.EmailTemplate
        't = Datalayer.EmailTemplateMapper.FindByBvin(WebAppSettings.EmailTemplateID_ForgotPassword)

        'If t IsNot Nothing Then
        '    Dim sFrom As String = t.From
        '    Dim sSubject As String = t.Subject

        '    Dim sBody As String = t.HtmlBody
        '    sBody = sBody.Replace("[[username]]", thisUser.UserName)
        '    sBody = sBody.Replace("[[newpassword]]", newPassword)
        '    sBody = sBody.Replace("[[firstname]]", thisUser.FirstName)
        '    sBody = sBody.Replace("[[lastname]]", thisUser.LastName)
        '    sBody = sBody.Replace("[[loginpage]]", WebAppSettings.SiteStandardRoot & "login.aspx")
        '    sBody = sBody.Replace("[[homepage]]", WebAppSettings.SiteStandardRoot)
        '    sBody = sBody.Replace("[[timestamp]]", Now())

        '    Dim sLogo As String = WebAppSettings.SiteStandardRoot & Utilities.ImageHelper.GetLogoImageURL
        '    sBody = sBody.Replace("[[logo]]", sLogo)

        '    sSubject = sSubject.Replace("[[username]]", thisUser.UserName)
        '    sSubject = sSubject.Replace("[[newpassword]]", newPassword)
        '    sSubject = sSubject.Replace("[[firstname]]", thisUser.FirstName)
        '    sSubject = sSubject.Replace("[[lastname]]", thisUser.LastName)
        '    sSubject = sSubject.Replace("[[loginpage]]", WebAppSettings.SiteStandardRoot & "login.aspx")
        '    sSubject = sSubject.Replace("[[homepage]]", WebAppSettings.SiteStandardRoot)
        '    sSubject = sSubject.Replace("[[timestamp]]", Now())

        '    Dim MyMessage As New MailMessage(sFrom, thisUser.UserName)
        '    MyMessage.Subject = sSubject
        '    MyMessage.Body = sBody
        '    If t.SendInPlainText = True Then
        '        MyMessage.IsBodyHtml = False
        '    Else
        '        MyMessage.IsBodyHtml = True
        '        MyMessage.Body = MyMessage.Body.Replace("<br>", Chr(13))
        '    End If

        '    If Utilities.MailServices.SendMail(MyMessage) = False Then
        '        msg.ShowError("Error while sending mail!")
        '    End If

        '    MyMessage = Nothing
        'End If


    End Sub

    Private Sub ImageButton1_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Response.Redirect(Page.ResolveUrl("~/login.aspx"))
    End Sub


End Class
