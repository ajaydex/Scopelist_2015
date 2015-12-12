Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Reports_Customers
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Sales By Customer"
        Me.CurrentTab = AdminTabType.Reports
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ReportsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnView_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnShow.Click
        LoadUsers()
    End Sub

    Private Sub LoadUsers()
        Dim t As Data.DataTable = Orders.Order.FindUserTotals(DateRangeField.StartDate, DateRangeField.EndDate)

        If t.Rows.Count = 0 Then
            Me.lblResults.Text = "No Users Found"
        ElseIf t.Rows.Count = 1 Then
            Me.lblResults.Text = t.Rows.Count & " user found"
        ElseIf t.Rows.Count > 1 Then
            Me.lblResults.Text = t.Rows.Count & " users found"
        End If

        Me.GridView1.DataSource = t
        Me.GridView1.DataBind()

    End Sub

    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        GridView1.PageIndex = e.NewPageIndex
        LoadUsers()
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("~/bvadmin/people/users_edit.aspx?id=" & bvin)
    End Sub


End Class
