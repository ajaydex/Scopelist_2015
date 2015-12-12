Imports BVSoftware.Bvc5.Core


Partial Class BVAdmin_PasswordExpired
    Inherits BaseAdminPage

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Me.CurrentPasswordField.Focus()
    End Sub

    Private Sub btnOK_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOK.Click
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId.ToString)
        Dim s As Membership.CreateUserStatus = Membership.CreateUserStatus.None

        If u IsNot Nothing Then
            If Membership.UserAccount.DoPasswordsMatch(Me.CurrentPasswordField.Text.Trim(), u) = False Then
                Me.ucMessageBox.ShowError("Your current password doesn't match the one on file.")
                Return
            End If

            If u.IsOldPassword(Me.passwordField.Text.Trim()) Then
                Me.ucMessageBox.ShowError("You can not use any of the last three passwords for your account. Please select a new unique password.")
                Return
            End If

            ' Check password length
            If Me.passwordField.Text.Trim().Length < WebAppSettings.PasswordMinimumLength Then
                s = Membership.CreateUserStatus.InvalidPassword
            Else
                Dim oldPasswordFormat As Membership.UserPasswordFormat = u.PasswordFormat
                u.PasswordFormat = WebAppSettings.PasswordDefaultEncryption

                If oldPasswordFormat <> u.PasswordFormat Then
                    ' Password format has changed so alway encrypt
                    u.Password = u.EncryptPassword(Me.passwordField.Text.Trim())
                Else
                    If u.PasswordFormat = Membership.UserPasswordFormat.Hashed Then
                        ' Only updated hashed password if the admin changed the password, otherwise leave it alone
                        If u.Password <> Me.passwordField.Text.Trim() Then
                            u.Password = u.EncryptPassword(Me.passwordField.Text.Trim())
                        End If
                    Else
                        ' Clear text and encrypted passwords are alway decrypted so we can view and encrypt them again.
                        u.Password = u.EncryptPassword(Me.passwordField.Text.Trim())
                    End If
                End If

                Membership.UserAccount.Update(u, s)
                If (s = Membership.CreateUserStatus.Success) Then
                    u = Membership.UserAccount.FindByBvin(u.Bvin)
                    u.RecordPasswordChange(Me.CurrentPasswordField.Text.Trim())
                    Membership.UserAccount.Update(u)
                End If
            End If
        End If

        Select Case s
            Case Membership.CreateUserStatus.InvalidPassword
                Me.ucMessageBox.ShowError(String.Format("Password must be at least {0} characters long.", WebAppSettings.PasswordMinimumLength.ToString()))
            Case Membership.CreateUserStatus.DuplicateUsername
                Me.ucMessageBox.ShowError("That username already exists. Select another username.")
            Case Membership.CreateUserStatus.Success
                Me.ucMessageBox.ShowError("Successfully Updated Admin Account.")
                Response.Redirect("~/BVAdmin/Default.aspx")
            Case Else
                Me.ucMessageBox.ShowError("Unable to save user. Unknown error.")
        End Select
    End Sub

End Class