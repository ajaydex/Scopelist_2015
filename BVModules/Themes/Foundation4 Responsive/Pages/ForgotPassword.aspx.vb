Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.PersonalizationServices

Partial Class BVModules_Themes_Foundation4_Responsive_Pages_ForgotPassword
    Inherits BaseStorePage

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Checkout.master")
    End Sub


    Private Sub PageLoad(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then

            Page.Title = Content.SiteTerms.GetTerm("ForgotPassword")

            ImageButton1.ImageUrl = GetThemedButton("Cancel")
            btnSend.ImageUrl = GetThemedButton("ResetPassword")
            Me.lblUsername.Text = Content.SiteTerms.GetTerm("Username")
            val2Username.ErrorMessage = "Please enter a " & Content.SiteTerms.GetTerm("Username")
        End If
    End Sub

    Private Sub btnSend_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSend.Click

        msg.ClearMessage()

        If Page.IsValid Then

            Try
                Dim thisUser As Membership.UserAccount = Membership.UserAccount.FindByUserName(inUsername.Text)
                If (thisUser IsNot Nothing) AndAlso (thisUser.Bvin <> String.Empty) Then
                    Dim newPassword As String = Membership.UserAccount.GeneratePassword(10)
                    thisUser.Password = thisUser.EncryptPassword(newPassword)

                    If Membership.UserAccount.Update(thisUser) Then
                        Dim t As Content.EmailTemplate = Content.EmailTemplate.FindByBvin(WebAppSettings.EmailTemplateID_ForgotPassword)
                        If t IsNot Nothing Then
                            Dim m As System.Net.Mail.MailMessage = t.ConvertToMailMessage(t.From, thisUser.Email, thisUser, newPassword)
                            If Utilities.MailServices.SendMail(m) Then
                                msg.ShowOk("Your new password has been sent by email.")
                            Else
                                msg.ShowError("Error while sending mail!")
                            End If
                        Else
                            msg.ShowError("Unable to find password reset email template!")
                        End If
                    Else
                        msg.ShowError("An error occurred while trying to update password.")
                    End If
                Else
                    msg.ShowError(Content.SiteTerms.GetTerm("Username") & " not found.")
                End If


            Catch CreateEx As Membership.BVMembershipUserException
                Select Case CreateEx.Status
                    Case Membership.CreateUserStatus.UpdateFailed
                        msg.ShowError("Update to user account failed.")
                    Case Else
                        msg.ShowError(CreateEx.Message)
                End Select
            End Try
        Else
            msg.ShowWarning("Please check your " & Content.SiteTerms.GetTerm("Username") & ".  No account was found for " & HttpUtility.HtmlEncode(inUsername.Text))
        End If

    End Sub

    Private Sub ImageButton1_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Response.Redirect(Page.ResolveUrl("~/login.aspx"))
    End Sub

End Class
