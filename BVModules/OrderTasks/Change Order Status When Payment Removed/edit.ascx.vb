Imports BVSoftware.Bvc5.Core

Partial Class BVModules_OrderTasks_Change_Order_Status_When_Payment_Removed_edit
    Inherits Content.BVModule

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        MyBase.NotifyFinishedEditing()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        Me.StepNameField.Text = Me.SettingsManager.GetSetting("StepName")

        Me.OrderStatusDropDownList.DataSource = Orders.OrderStatusCode.FindAll()
        Me.OrderStatusDropDownList.DataTextField = "StatusName"
        Me.OrderStatusDropDownList.DataValueField = "Bvin"
        Me.OrderStatusDropDownList.DataBind()

        Me.OrderStatusDropDownList.SelectedValue = Me.SettingsManager.GetSetting("OrderStatusCode")
    End Sub

    Private Sub SaveData()
        Me.SettingsManager.SaveSetting("StepName", Me.StepNameField.Text.Trim, "bvsoftware", "Order Tasks", "Change Order Status When Payment Removed")
        Me.SettingsManager.SaveSetting("OrderStatusCode", Me.OrderStatusDropDownList.SelectedValue, "bvsoftware", "Order Tasks", "Change Order Status When Payment Removed")
    End Sub
End Class
