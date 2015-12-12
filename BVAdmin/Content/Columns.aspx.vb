Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Content_Columns
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Content Columns"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadColumns()
        End If
    End Sub

    Private Sub LoadColumns()
        Dim cols As Collection(Of Content.ContentColumn)
        cols = Content.ContentColumn.FindAll
        Me.GridView1.DataSource = cols
        Me.GridView1.DataBind()
        Me.lblResults.Text = cols.Count & " columns found"
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        msg.ClearMessage()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
            If Content.ContentColumn.Delete(bvin) = False Then
                Me.msg.ShowWarning("Unable to delete this column. System columns can not be deleted.")
            End If
        End If
        LoadColumns()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        msg.ClearMessage()

        If Me.NewNameField.Text.Trim.Length < 1 Then
            msg.ShowWarning("Please enter a name for the new column.")
        Else
            Dim c As New Content.ContentColumn
            c.DisplayName = Me.NewNameField.Text.Trim
            c.SystemColumn = False
            If Content.ContentColumn.Insert(c) = True Then
                Response.Redirect("Columns_Edit.aspx?id=" & c.Bvin)
            Else
                msg.ShowError("Unable to create column. Please see event log for details")
                EventLog.LogEvent("Create Content Column Button", "Unable to create column", Metrics.EventLogSeverity.Error)
            End If
        End If
        
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("Columns_edit.aspx?id=" & bvin)
    End Sub


End Class
