Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_GettingStartedEmail
    Inherits BaseAdminPage

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not Page.IsPostBack Then

            Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)

            If u.UserName.Trim().ToLower() = "admin" OrElse u.UserName.Trim().ToLower() = "admin@bvcommerce.com" Then
                Me.pnlForm.Visible = True
                Me.pnlThanks.Visible = False
                Me.UserNameField.Focus()
            Else
                Me.pnlForm.Visible = False
                Me.pnlThanks.Visible = False
                lblError.Text = "This page will only work if you are logged in as the default user of 'admin'"
            End If
        End If
    End Sub

    Private Sub btnOK_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOK.Click

        If Me.UserNameField.Text.Trim().ToLower() = "admin" OrElse Me.UserNameField.Text.Trim().ToLower() = "admin@bvcommerce.com" Then
            Me.lblError.Text = "You must change the username from 'admin' to a unique name"
            Return
        End If

        Dim u As Membership.UserAccount
        u = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId.ToString)

        Dim s As Membership.CreateUserStatus = Membership.CreateUserStatus.None

        If u IsNot Nothing Then

            ' Check password length
            If Me.passwordField.Text.Trim.Length < WebAppSettings.PasswordMinimumLength Then
                Me.lblError.Text = "Password must be at least " & WebAppSettings.PasswordMinimumLength & " characters long."
                s = Membership.CreateUserStatus.InvalidPassword
            Else
                u.Email = Me.EmailField.Text.Trim
                u.UserName = Me.UserNameField.Text.Trim

                Dim oldPasswordFormat As Membership.UserPasswordFormat = u.PasswordFormat
                u.PasswordFormat = WebAppSettings.PasswordDefaultEncryption

                If oldPasswordFormat <> u.PasswordFormat Then
                    ' Password format has changed so always encrypt
                    u.Password = u.EncryptPassword(Me.passwordField.Text.Trim)
                Else
                    If u.PasswordFormat = Membership.UserPasswordFormat.Hashed Then
                        ' Only updated hashed password if the admin changed the password, otherwise leave it alone
                        If u.Password <> Me.passwordField.Text.Trim Then
                            u.Password = u.EncryptPassword(Me.passwordField.Text.Trim)
                        End If
                    Else
                        ' Clear text and encrypted passwords are always decrypted so we can view and encrypt them again.
                        u.Password = u.EncryptPassword(Me.passwordField.Text.Trim)
                    End If

                End If
                u.RecordPasswordChange("")
                Membership.UserAccount.Update(u, s)
            End If
        End If

        Select Case s
            Case Membership.CreateUserStatus.InvalidPassword
                Me.lblError.Text = "Password must be at least " & WebAppSettings.PasswordMinimumLength & " characters long."
            Case Membership.CreateUserStatus.DuplicateUsername
                Me.lblError.Text = "That username already exists. Select another username."
            Case Membership.CreateUserStatus.Success
                BuildFirstEncryptionKeys()
                Me.lblError.Text = "Successfully Updated Admin Account."
                Response.Redirect("~/bvadmin/")
            Case Else
                Me.lblError.Text = "Unable to save user. Unknown error."
        End Select

    End Sub

    Private Sub BuildFirstEncryptionKeys()
        Try

            Dim keyLocation As String = HttpContext.Current.Server.MapPath("~/bin")
            Dim masterKeyLocation As String = WebAppSettings.EncryptionKeyLocation

            Dim manager As New BVSoftware.Cryptography.KeyManager(keyLocation, masterKeyLocation, String.Empty)
            manager.LoadKeyJsonFromDisk()
            If (manager.ReplaceMasterKey()) Then
                Application("EncryptionKeys") = manager.LoadKeyJsonFromDisk()
                manager.LoadKeyJsonFromDisk()
                manager.GenerateNewKey()
            End If
        Catch ex As Exception

        End Try
    End Sub

End Class
