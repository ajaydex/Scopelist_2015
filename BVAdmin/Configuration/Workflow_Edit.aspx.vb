Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Configuration_Workflow_Edit
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Workflow"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
            End If
            LoadWorkflow()
        End If
    End Sub

    Private Sub LoadStepList(ByVal flowType As BusinessRules.WorkFlowType)

        Me.lstSteps.Items.Clear()

        Select Case flowType
            Case BusinessRules.WorkFlowType.OrderWorkFlow
                For i As Integer = 0 To BusinessRules.AvailableTasks.OrderTasks.Count - 1
                    lstSteps.Items.Add(New ListItem(BusinessRules.AvailableTasks.OrderTasks(i).TaskName, BusinessRules.AvailableTasks.OrderTasks(i).TaskId))
                Next
            Case BusinessRules.WorkFlowType.ProductWorkFlow
                For i As Integer = 0 To BusinessRules.AvailableTasks.ProductTasks.Count - 1
                    lstSteps.Items.Add(New ListItem(BusinessRules.AvailableTasks.ProductTasks(i).TaskName, BusinessRules.AvailableTasks.ProductTasks(i).TaskId))
                Next
            Case BusinessRules.WorkFlowType.ShippingWorkFlow
                For i As Integer = 0 To BusinessRules.AvailableTasks.ShippingTasks.Count - 1
                    lstSteps.Items.Add(New ListItem(BusinessRules.AvailableTasks.ShippingTasks(i).TaskName, BusinessRules.AvailableTasks.ShippingTasks(i).TaskId))
                Next
            Case BusinessRules.WorkFlowType.Uknown
                ' Do Nothing
        End Select

        If Me.lstSteps.Items.Count < 1 Then
            Me.lstSteps.Items.Add("- No Tasks Found -")
        End If
    End Sub

    Private Sub LoadWorkflow()
        Dim w As BusinessRules.Workflow = BusinessRules.Workflow.FindByBvin(Me.BvinField.Value)
        LoadStepList(w.ContextType)
        Me.lblTitle.Text = w.Name
        Me.GridView1.DataSource = w.Steps
        Me.GridView1.DataBind()
        Me.GridView1.UpdateAfterCallBack = True
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Me.msg.ClearMessage()
        Dim s As New BusinessRules.WorkFlowStep
        s.ControlName = Me.lstSteps.SelectedValue
        s.DisplayName = Me.lstSteps.SelectedItem.Text
        s.WorkFlowBvin = Me.BvinField.Value
        BusinessRules.WorkFlowStep.Insert(s)
        LoadWorkflow()
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        Me.msg.ClearMessage()
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        BusinessRules.WorkFlowStep.MoveDown(bvin, Me.BvinField.Value)
        LoadWorkflow()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim ws As BusinessRules.WorkFlowStep = CType(e.Row.DataItem, BusinessRules.WorkFlowStep)

            Dim controlFound As Boolean = False

            Dim editControl As System.Web.UI.UserControl

            Dim t As BusinessRules.Task = FindAvailableTask(ws.ControlName)

            If TypeOf t Is BusinessRules.OrderTask Then
                ' Order Task
                editControl = Content.ModuleController.LoadOrderTaskEditor(t.TaskName, Me)
            Else
                ' Product Task
                editControl = Content.ModuleController.LoadProductTaskEditor(t.TaskName, Me)                
            End If

            If TypeOf editControl Is Content.BVModule Then
                CType(editControl, Content.BVModule).BlockId = ws.Bvin
                controlFound = True
            End If

            ' Check for Editor
            Dim lnkEdit As HyperLink = e.Row.FindControl("lnkEdit")
            If lnkEdit IsNot Nothing Then
                lnkEdit.Visible = controlFound
            End If

        End If
    End Sub

    Private Function FindAvailableTask(ByVal bvin As String) As BusinessRules.Task
        Dim result As BusinessRules.Task = New BusinessRules.NullTask

        Dim found As Boolean = False

        For i As Integer = 0 To BusinessRules.AvailableTasks.OrderTasks.Count - 1
            If BusinessRules.AvailableTasks.OrderTasks(i).TaskId = bvin Then
                result = BusinessRules.AvailableTasks.OrderTasks(i)
                found = True
                Exit For
            End If
        Next

        For i As Integer = 0 To BusinessRules.AvailableTasks.ProductTasks.Count - 1
            If BusinessRules.AvailableTasks.ProductTasks(i).TaskId = bvin Then
                result = BusinessRules.AvailableTasks.ProductTasks(i)
                found = True
                Exit For
            End If
        Next

        For i As Integer = 0 To BusinessRules.AvailableTasks.ShippingTasks.Count - 1
            If BusinessRules.AvailableTasks.ShippingTasks(i).TaskId = bvin Then
                result = BusinessRules.AvailableTasks.ShippingTasks(i)
                found = True
                Exit For
            End If
        Next

        Return result
    End Function

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Me.msg.ClearMessage()

        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        BusinessRules.WorkFlowStep.Delete(bvin)
        LoadWorkflow()
    End Sub

    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOk.Click
        Response.Redirect("Workflow.aspx")
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Me.msg.ClearMessage()
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        BusinessRules.WorkFlowStep.MoveUp(bvin, Me.BvinField.Value)
        LoadWorkflow()
    End Sub

End Class
