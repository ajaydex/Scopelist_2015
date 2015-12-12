Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVAdmin_People_MailingLists_Edit
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            Me.NameField.Focus()
            Me.SetSecurityModel()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadList()
            Else
                Me.BvinField.Value = String.Empty
            End If
        End If
    End Sub

    Private Sub SetSecurityModel()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = False Then
            Me.btnSaveChanges.Enabled = False
            Me.btnSaveChanges.Visible = False
            Me.btnImport.Enabled = False
            Me.btnImport.Visible = False
            Me.btnExport.Enabled = False
            Me.btnExport.Visible = False
            Me.btnNew.Enabled = False
            Me.btnNew.Visible = False
            Me.NameField.ReadOnly = True
            Me.IsPrivateField.Enabled = False
        End If
    End Sub

    Private Sub LoadList()
        Dim m As Contacts.MailingList
        m = Contacts.MailingList.FindByBvin(Me.BvinField.Value)
        If Not m Is Nothing Then
            If m.Bvin <> String.Empty Then
                Me.NameField.Text = m.Name
                Me.IsPrivateField.Checked = m.IsPrivate
                Me.GridView1.DataSource = m.Members
                Me.GridView1.DataBind()
            End If
        End If
    End Sub

    Private Sub LoadMembers()
        Me.GridView1.DataSource = Contacts.MailingListMember.FindByListID(Me.BvinField.Value)
        Me.GridView1.DataBind()
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Mailing List"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("MailingLists.aspx")
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Page.IsValid Then
            Me.lblError.Text = String.Empty

            If Save() = True Then
                Response.Redirect("MailingLists.aspx")
            End If
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim m As Contacts.MailingList
        m = Contacts.MailingList.FindByBvin(Me.BvinField.Value)

        If m IsNot Nothing Then
            m.Name = Me.NameField.Text.Trim
            m.IsPrivate = Me.IsPrivateField.Checked

            If Me.BvinField.Value = String.Empty Then
                result = Contacts.MailingList.Insert(m)
            Else
                result = Contacts.MailingList.Update(m)
            End If

            If result = False Then
                Me.lblError.Text = "Unable to save mailing list. Uknown error."
            Else
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = m.Bvin
            End If
        End If

        Return result
    End Function

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnExport.Click
        Dim m As Contacts.MailingList = Contacts.MailingList.FindByBvin(Me.BvinField.Value)
        Me.ImportField.Text = m.ExportToCommaDelimited(Me.chkOnlyEmail.Checked)
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        If Me.Save = True Then
            Response.Redirect("MailingLists_EditMember.aspx?listid=" & Me.BvinField.Value)
        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
            Contacts.MailingListMember.Delete(bvin)
        End If
        LoadMembers()
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        If Me.Save = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
            Response.Redirect("MailingLists_EditMember.aspx?&id=" & bvin)
        End If
    End Sub

    Protected Sub btnImport_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnImport.Click
        If Page.IsValid Then
            If Me.Save = True Then
                Dim m As Contacts.MailingList = Contacts.MailingList.FindByBvin(Me.BvinField.Value)
                If m.Bvin <> String.Empty Then
                    m.ImportFromCommaDelimited(Me.ImportField.Text)
                    LoadMembers()
                End If
            End If
        End If
    End Sub

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        args.IsValid = True
        Dim sw As New IO.StringReader(ImportField.Text)
        Dim splitCharacter As String = ","
        Dim lineToProcess As String = String.Empty
        lineToProcess = sw.ReadLine

        While lineToProcess IsNot Nothing
            Dim lineValues() As String = lineToProcess.Split(splitCharacter.ToCharArray)
            If lineValues.Length() > 0 Then                
                Dim EmailAddress As String = lineValues(0)
                Dim re As New Regex("\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*", RegexOptions.Compiled)
                If Not re.Match(EmailAddress).Value = EmailAddress Then
                    args.IsValid = False
                    Return
                End If
            End If
            lineToProcess = sw.ReadLine
        End While
        sw.Dispose()
    End Sub
End Class
