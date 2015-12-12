Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_People_MailingLists
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Mailing Lists"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadMailingLists()
        End If
    End Sub

    Private Sub LoadMailingLists()
        Dim m As Collection(Of Contacts.MailingList)
        m = Contacts.MailingList.FindAll
        Me.GridView1.DataSource = m
        Me.GridView1.DataBind()
        If m.Count = 1 Then
            Me.lblResults.Text = "1 list found"
        Else
            Me.lblResults.Text = m.Count & " lists found"
        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
            Contacts.MailingList.Delete(bvin)
        End If

        LoadMailingLists()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Response.Redirect("MailingLists_edit.aspx")
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("MailingLists_edit.aspx?id=" & bvin)
    End Sub


End Class
