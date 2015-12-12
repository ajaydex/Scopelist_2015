Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.PersonalizationServices


Partial Class MyAccount_ChangePassword
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("MyAccount.master")

        If SessionManager.IsUserAuthenticated = False Then
            Response.Redirect("login.aspx?ReturnURL=" & Server.UrlEncode("MyAccount_ChangePassword.aspx"))
        End If



    End Sub


    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        Utilities.WebForms.MakePageNonCacheable(Me)

        Dim ManualBreadCrumbTrial As BVModules_Controls_ManualBreadCrumbTrail = DirectCast(Me.Master.FindControl("ManualBreadCrumbTrail1"), BVModules_Controls_ManualBreadCrumbTrail)

        ManualBreadCrumbTrial.ClearTrail()
        ManualBreadCrumbTrial.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        ManualBreadCrumbTrial.AddLink(Content.SiteTerms.GetTerm("MyAccount"), "~/MyAccount_Orders.aspx")
        ManualBreadCrumbTrial.AddNonLink(Content.SiteTerms.GetTerm("ChangePassword"))

        If Not Page.IsPostBack Then
            'btnCancel.ImageUrl = GetThemedButton("Cancel")
            btnCancel.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-cancel.png")
            'btnSave.ImageUrl = GetThemedButton("SaveChanges")
            btnSave.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-save-change.png")
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("ChangePassword")
            Page.Title = Content.SiteTerms.GetTerm("ChangePassword")
            Me.lblPassword.Text = Content.SiteTerms.GetTerm("Password")
            Me.lblNewPassword.Text = Content.SiteTerms.GetTerm("NewPassword")
            Me.lblConfirmNewPassword.Text = Content.SiteTerms.GetTerm("ConfirmNewPassword")
            Page.SetFocus(inCurrentPassword)
        End If

        bvinField.Value = SessionManager.GetCurrentUserId

    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        msg.ClearMessage()

        If Page.IsValid() Then

            Dim thisUser As Membership.UserAccount
            thisUser = Membership.UserAccount.FindByBvin(Me.bvinField.Value)

            If Not thisUser Is Nothing Then
                If Membership.UserAccount.DoPasswordsMatch(inCurrentPassword.Text, thisUser) = True Then
                    Try
                        If Me.inNewPassword.Text.Trim.Length < WebAppSettings.PasswordMinimumLength Then
                            Me.msg.ShowError("Password must be at least " & WebAppSettings.PasswordMinimumLength & " characters long.")
                        ElseIf (Membership.UserAccount.IsPasswordStrong(Me.inNewPassword.Text) = False) Then    ' PCI Validation
                            msg.ShowError("Password must contain at least one letter and one number")
                        ElseIf thisUser.IsOldPassword(Me.inNewPassword.Text.Trim()) Then
                            msg.ShowError("You can not use any of your last three passwords.")
                        Else
                            If Membership.UserAccount.ChangePassword(thisUser.UserName, inCurrentPassword.Text, Me.inNewPassword.Text.Trim()) Then
                                msg.ShowOk("Password Updated.")
                            Else
                                msg.ShowError("Password could not be updated.")
                            End If
                        End If
                    Catch cex As Membership.BVMembershipUserException
                        Select Case cex.Status
                            Case Membership.CreateUserStatus.UpdateFailed
                                msg.ShowError("Couldn't Save Changes. " & cex.Message)
                            Case Membership.CreateUserStatus.InvalidPassword
                                msg.ShowError("Couldn't Save Changes. Check your password and try again.")
                            Case Else
                                msg.ShowError(cex.Message)
                        End Select
                    End Try

                Else
                    msg.ShowError("Your current password didn't match.")
                End If
            End If

            thisUser = Nothing
        End If
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("MyAccount_Orders.aspx", True)
    End Sub

End Class