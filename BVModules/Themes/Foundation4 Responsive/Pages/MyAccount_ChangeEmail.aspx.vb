Imports System.Collections.ObjectModel
Imports System.Collections.Generic
Imports BVSoftware.Bvc5.Core.Membership
Imports BVSoftware.Bvc5.Core
Imports bvsoftware.Bvc5.Core.PersonalizationServices

Partial Class BVModules_Themes_Foundation4_Responsive_Pages_MyAccount_ChangeEmail
    Inherits BaseStorePage

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("MyAccount.master")

        If SessionManager.IsUserAuthenticated = False Then
            Response.Redirect("login.aspx?ReturnURL=" & Server.UrlEncode("MyAccount_ChangeEmail.aspx"))
        End If



    End Sub

    Private Sub SetMinimumPasswordLength()
        Dim min As Integer = WebAppSettings.PasswordMinimumLength
        Me.val2Password.ValidationExpression = "^[a-zA-Z]([\w\d\-\.]{" + (min - 1).ToString() + ",19})$"
        Me.val2Password.ErrorMessage = "Password must be between " + min.ToString() + " and 20 characters starting with a letter and containing only letters and numbers"
    End Sub


    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property


    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
        bvinField.Value = SessionManager.GetCurrentUserId
        SetMinimumPasswordLength()

        If Not Page.IsPostBack Then

            btnCancel.ImageUrl = GetThemedButton("Cancel")
            btnSave.ImageUrl = GetThemedButton("SaveChanges")

            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("ChangeEmail")
            Page.Title = Content.SiteTerms.GetTerm("ChangeEmail")
            Me.lblNewUsername.Text = Content.SiteTerms.GetTerm("NewEmail")
            Me.lblConfirmNewUsername.Text = Content.SiteTerms.GetTerm("ConfirmEmail")
            Me.lblPassword.Text = Content.SiteTerms.GetTerm("Password")
        End If


        If Not Page.IsPostBack Then
            Try

                Dim thisUser As BVSoftware.BVC5.Core.Membership.UserAccount
                thisUser = BVSoftware.BVC5.Core.Membership.UserAccount.FindByBvin(Me.bvinField.Value)
                inNewEmail.Text = thisUser.Email
                Page.SetFocus(inNewEmail)
                'inNewEmail.Text = BVC2004Store.GetCurrentUser.UserName
            Catch Ex As Exception
                msg.ShowException(Ex)
            End Try
        End If

    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("myaccount_orders.aspx", True)
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click

        msg.ClearMessage()

        If Page.IsValid() Then

            Dim thisUser As UserAccount = UserAccount.FindByBvin(Me.bvinField.Value)
            Dim RequestedUser As UserAccount
            Dim oldEmail As String = thisUser.Email

            RequestedUser = Membership.UserAccount.FindByEmail(inNewEmail.Text)

            If UserAccount.DoPasswordsMatch(inPassword.Text, thisUser) Then
                Try
                    UserAccount.UpdateEmail(thisUser, inNewEmail.Text)

                    Dim lists As New Collection(Of Contacts.MailingList)
                    lists = Contacts.MailingList.FindAllPublic
                    For i As Integer = 0 To lists.Count - 1
                        If Contacts.MailingList.CheckMembership(lists(i).Bvin, oldEmail) = True Then
                            Dim mm As New Contacts.MailingListMember
                            mm.ListId = lists(i).Bvin
                            mm.EmailAddress = oldEmail
                            Contacts.MailingListMember.Delete(mm.Bvin)
                            mm.EmailAddress = inNewEmail.Text.Trim
                            Contacts.MailingListMember.Insert(mm)
                        End If
                    Next
                    lists = Nothing

                    msg.ShowOk("<i class='fa fa-check'></i> Email Address Changed")
                Catch CreateEx As BVMembershipUserException
                    Select Case CreateEx.Status
                        Case CreateUserStatus.DuplicateUsername
                            msg.ShowWarning("<i class='fa fa-exclamation-triangle'></i> A user account with that email address already exists. Please select another email address.")
                        Case CreateUserStatus.InvalidPassword
                            msg.ShowWarning("<i class='fa fa-exclamation-triangle'></i> Please check your password and try again.")
                        Case CreateUserStatus.UserNotFound
                            msg.ShowWarning("<i class='fa fa-exclamation-triangle'></i> User account couldn't be located.")
                        Case Else
                    End Select
                End Try

            Else
                msg.ShowWarning("<i class='fa fa-exclamation-triangle'></i> Couldn't update E-mail Address.  Please check your password.")
            End If

            RequestedUser = Nothing
            thisUser = Nothing

        End If

    End Sub
End Class