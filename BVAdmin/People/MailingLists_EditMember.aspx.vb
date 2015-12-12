Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_People_MailingLists_EditMember
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.EmailAddressField.Focus()
            Me.SetSecurityModel()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadMember()
            Else
                Me.BvinField.Value = String.Empty
                If Request.QueryString("ListID") IsNot Nothing Then
                    Me.ListIDField.Value = Request.QueryString("ListID")
                End If
            End If

        End If
    End Sub

    Private Sub SetSecurityModel()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = False Then
            Me.btnSaveChanges.Enabled = False
            Me.btnSaveChanges.Visible = False
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Mailing List Member"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Private Sub LoadMember()
        Dim m As Contacts.MailingListMember
        m = Contacts.MailingListMember.FindByBvin(Me.BvinField.Value)

        If Not m Is Nothing Then
            If m.Bvin <> String.Empty Then
                Me.EmailAddressField.Text = m.EmailAddress
                Me.FirstNameField.Text = m.FirstName
                Me.LastNameField.Text = m.LastName
                Me.ListIDField.Value = m.ListId
            End If
        End If

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("MailingLists_Edit.aspx?id=" & Me.ListIDField.Value)
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Me.Save() = True Then
            Response.Redirect("MailingLists_Edit.aspx?id=" & Me.ListIDField.Value)
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim m As Contacts.MailingListMember
        m = Contacts.MailingListMember.FindByBvin(Me.BvinField.Value)

        If m IsNot Nothing Then
            Dim originalEmail As String = m.EmailAddress

            m.EmailAddress = Me.EmailAddressField.Text.Trim
            m.FirstName = Me.FirstNameField.Text.Trim
            m.LastName = Me.LastNameField.Text.Trim
            m.ListId = Me.ListIDField.Value

            If Me.BvinField.Value = String.Empty Then
                If Contacts.MailingList.CheckMembership(m.ListId, m.EmailAddress) = True Then
                    Me.lblError.Text = "That email address already belongs to this mailing list. Select another email address"
                Else
                    result = Contacts.MailingListMember.Insert(m)
                End If
            Else
                If m.EmailAddress <> originalEmail Then
                    If Contacts.MailingList.CheckMembership(m.ListId, m.EmailAddress) = True Then
                        Me.lblError.Text = "That email address already belongs to this mailing list. Select another email address"
                    Else
                        result = Contacts.MailingListMember.Update(m)
                    End If
                Else
                    result = Contacts.MailingListMember.Update(m)
                End If
            End If

            If result = True Then
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = m.Bvin
            End If

        End If

        Return result
    End Function

End Class
