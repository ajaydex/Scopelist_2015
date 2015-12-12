Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Content_Policies
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Policies"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadPolicies()
        End If
    End Sub

    Private Sub LoadPolicies()
        Dim p As Collection(Of Content.Policy)
        p = Content.Policy.FindAll
        Me.GridView1.DataSource = p
        Me.GridView1.DataBind()
        If p.Count = 1 Then
            Me.lblResults.Text = "1 policy found"
        Else
            Me.lblResults.Text = p.Count & " policies found"
        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
            If Content.Policy.Delete(bvin) = False Then
                Me.msg.ShowWarning("Unable to delete this policy. System policies can not be deleted.")
            End If
        End If

        LoadPolicies()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        msg.ClearMessage()

        If Me.NewNameField.Text.Trim.Length < 1 Then
            msg.ShowWarning("Please enter a name for the new policy.")
        Else
            Dim p As New Content.Policy
            p.Title = Me.NewNameField.Text.Trim
            p.SystemPolicy = False
            If Content.Policy.Insert(p) = True Then
                Response.Redirect("Policies_Edit.aspx?id=" & p.Bvin)
            Else
                msg.ShowError("Unable to create policy. Please see event log for details")
                EventLog.LogEvent("Create New Policy Button", "Unable to create policy", Metrics.EventLogSeverity.Error)
            End If
        End If
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("Policies_edit.aspx?id=" & bvin)
    End Sub

End Class
