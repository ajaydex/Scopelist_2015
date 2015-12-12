Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_People_Manufacturers
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Manufacturers"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            GridView1.PageSize = WebAppSettings.RowsPerPage
            LoadManufacturers()
            Me.FilterField.Focus()
        End If
    End Sub

    Private Sub LoadManufacturers()
        Me.GridView1.DataBind()        
    End Sub

    Protected Sub btnGo_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGo.Click
        LoadManufacturers()
        Me.FilterField.Focus()
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
            Contacts.Manufacturer.Delete(bvin)
        End If
        LoadManufacturers()
        e.Cancel = True
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("Manufacturers_edit.aspx?id=" & bvin)
    End Sub

    Protected Sub ObjectDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource1.Selecting
        If e.ExecutingSelectCount Then
            e.InputParameters("rowCount") = HttpContext.Current.Items("RowCount")
            Dim count As Integer = CInt(HttpContext.Current.Items("RowCount"))
            If count = 1 Then
                Me.lblResults.Text = count & " manufacturer found"
            Else
                Me.lblResults.Text = count & " manufacturers found"
            End If
            HttpContext.Current.Items("RowCount") = Nothing
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If e.OutputParameters("RowCount") IsNot Nothing Then
            HttpContext.Current.Items("RowCount") = e.OutputParameters("RowCount")
        End If
    End Sub
End Class
