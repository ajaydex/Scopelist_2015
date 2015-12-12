Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Configuration_Workflow
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Workflows"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadWorkflows()
        End If
    End Sub

    Private Sub LoadWorkflows()
        Dim flows As Collection(Of BusinessRules.Workflow)
        flows = BusinessRules.Workflow.FindAll()
        Me.GridView1.DataSource = flows
        Me.GridView1.DataBind()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim wf As BusinessRules.Workflow = CType(e.Row.DataItem, BusinessRules.Workflow)
            If wf IsNot Nothing Then
                Dim typeField As Label = e.Row.FindControl("TypeField")
                If typeField IsNot Nothing Then
                    Select Case wf.ContextType
                        Case BusinessRules.WorkFlowType.OrderWorkFlow
                            typeField.Text = "Order"
                        Case BusinessRules.WorkFlowType.ProductWorkFlow
                            typeField.Text = "Product"
                        Case BusinessRules.WorkFlowType.Uknown
                            typeField.Text = "Unknown"
                        Case BusinessRules.WorkFlowType.ShippingWorkFlow
                            typeField.Text = "Shipping"
                    End Select
                End If
            End If
        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        msg.ClearMessage()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
            If BusinessRules.Workflow.Delete(bvin) = False Then
                Me.msg.ShowWarning("Unable to delete this workflow. System workflows can not be deleted.")
            End If
        End If
        LoadWorkflows()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        msg.ClearMessage()

        If Me.NewNameField.Text.Trim.Length < 1 Then
            msg.ShowWarning("Please enter a name for the new workflow.")
        Else
            Dim w As New BusinessRules.Workflow
            w.Name = Me.NewNameField.Text.Trim
            Dim flowType As BusinessRules.WorkFlowType = CType(Me.WorkflowTypeField.SelectedValue, BusinessRules.WorkFlowType)
            w.ContextType = flowType
            w.SystemWorkFlow = False

            If BusinessRules.Workflow.Insert(w) = True Then
                Response.Redirect("Workflow_Edit.aspx?id=" & w.Bvin)
            Else
                msg.ShowError("Unable to create workflow. Please see event log for details")
                EventLog.LogEvent("Create Workflow Button", "Unable to create workflow", Metrics.EventLogSeverity.Error)
            End If
        End If

    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("Workflow_edit.aspx?id=" & bvin)
    End Sub

End Class
