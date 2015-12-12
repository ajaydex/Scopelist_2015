Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Configuration_Workflow_EditStep
    Inherits BaseAdminPage


    Private w As BusinessRules.WorkFlowStep
    '    Private t As BusinessRules.Task
    Private WithEvents editor As Content.BVModule

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Request.QueryString("id") IsNot Nothing Then
            Me.BlockIDField.Value = Request.QueryString("id")
        End If

        w = BusinessRules.WorkFlowStep.FindByBvin(Me.BlockIDField.Value)

        LoadEditor()
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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Workflow Step"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub


    Private Sub LoadEditor()
        Dim tempControl As System.Web.UI.Control = Nothing

        Dim t As BusinessRules.Task = FindAvailableTask(w.ControlName)

        If TypeOf t Is BusinessRules.OrderTask Then
            ' Order Task
            tempControl = Content.ModuleController.LoadOrderTaskEditor(t.TaskName, Me)
        Else
            ' Product Task
            tempControl = Content.ModuleController.LoadProductTaskEditor(t.TaskName, Me)
        End If

        If TypeOf tempControl Is Content.BVModule Then
            editor = CType(tempControl, Content.BVModule)
            If Not editor Is Nothing Then
                editor.BlockId = w.Bvin
                Me.TitleLabel.Text = "Edit Workflow Step - " & t.TaskName
                Me.phEditor.Controls.Add(editor)
            End If
        Else
            Me.phEditor.Controls.Add(New LiteralControl("Error, editor is not based on Content.BVModule class"))
        End If
    End Sub

    Protected Sub editor_EditingComplete(ByVal sender As Object, ByVal e As BVSoftware.Bvc5.Core.Content.BVModuleEventArgs) Handles editor.EditingComplete
        Dim setman As New Datalayer.ComponentSettingsManager(editor.BlockId)
        w.StepName = setman.GetSetting("StepName")
        BusinessRules.WorkFlowStep.Update(w)
        Response.Redirect("Workflow_Edit.aspx?id=" & w.WorkFlowBvin)
    End Sub

End Class
