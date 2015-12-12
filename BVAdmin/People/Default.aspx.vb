Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_People_Default
    Inherits BaseAdminPage

    Private criteriaSessionKey As String = "PeopleCriteria"

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Users"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then            
            GridView1.PageSize = WebAppSettings.RowsPerPage
            LoadUsers()
            Me.FilterField.Focus()
        End If
    End Sub

    Private Sub LoadUsers()
        'Dim users As Collection(Of Membership.UserAccount)
        'users = Membership.UserAccount.FindAllWithFilter(Me.FilterField.Text.Trim)
        'Me.GridView1.DataSource = users
        Me.GridView1.DataSourceID = "FilterObjectDataSource"
        Me.GridView1.DataBind()
        

    End Sub

    Protected Sub btnGo_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGo.Click
        LoadUsers()
        Me.FilterField.Focus()
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
            Membership.UserAccount.Delete(bvin)
        End If
        LoadUsers()
        e.Cancel = True
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("users_edit.aspx?id=" & bvin)
    End Sub

    Protected Sub ObjectDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles FilterObjectDataSource.Selecting, CriteriaObjectDataSource.Selecting
        If e.ExecutingSelectCount Then
            e.InputParameters("rowCount") = HttpContext.Current.Items("RowCount")
            Dim count As Integer = CInt(HttpContext.Current.Items("RowCount"))
            If count = 1 Then
                Me.lblResults.Text = count & " user found"
            Else
                Me.lblResults.Text = count & " users found"
            End If
            HttpContext.Current.Items("RowCount") = Nothing
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles FilterObjectDataSource.Selected, CriteriaObjectDataSource.Selected
        If e.OutputParameters("RowCount") IsNot Nothing Then
            HttpContext.Current.Items("RowCount") = e.OutputParameters("RowCount")
        End If
    End Sub

    Protected Sub FilterChanged(ByVal criteria As Membership.UserSearchCriteria) Handles UserFilter1.FilterChanged
        Me.Session(criteriaSessionKey) = criteria
        Me.GridView1.DataSourceID = "CriteriaObjectDataSource"
        Me.GridView1.DataBind()
    End Sub

    Protected Sub GoPressed(ByVal criteria As Membership.UserSearchCriteria) Handles UserFilter1.GoPressed
        Me.Session(criteriaSessionKey) = criteria
        Me.GridView1.DataSourceID = "CriteriaObjectDataSource"
        Me.GridView1.DataBind()
    End Sub
End Class
