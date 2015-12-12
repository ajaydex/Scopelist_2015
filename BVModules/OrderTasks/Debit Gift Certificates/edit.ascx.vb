Imports BVSoftware.Bvc5.Core

Partial Class BVModules_OrderTasks_Receive_Credit_Cards_edit
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
            PopulateLists()
            LoadData()
        End If
    End Sub

    Private Sub PopulateLists()
        Me.FailStatusField.DataSource = Orders.OrderStatusCode.FindAll
        Me.FailStatusField.DataTextField = "StatusName"
        Me.FailStatusField.DataValueField = "bvin"
        Me.FailStatusField.DataBind()
    End Sub

    Private Sub LoadData()
        Me.StepNameField.Text = Me.SettingsManager.GetSetting("StepName")
        Me.chkThrowErrors.Checked = Me.SettingsManager.GetBooleanSetting("ThrowErrors")

        Dim errorMessage As String = Me.SettingsManager.GetSetting("CustomerErrorMessage")
        If errorMessage = String.Empty Then
            errorMessage = "An error occured while attempting to process your credit card. Please check your payment information and try again."
        End If
        Me.CustomerErrorMessageField.Text = errorMessage

        Me.chkSetStatusOnFail.Checked = Me.SettingsManager.GetBooleanSetting("SetStatusOnFail")

        Dim failCode As String = Me.SettingsManager.GetSetting("FailStatusCode")
        If failCode = String.Empty Then
            failCode = WebAppSettings.OrderStatusCodeOnHold
        End If
        If Me.FailStatusField.Items.FindByValue(failCode) IsNot Nothing Then
            Me.FailStatusField.ClearSelection()
            Me.FailStatusField.Items.FindByValue(failCode).Selected = True
        End If
    End Sub

    Private Sub SaveData()
        Me.SettingsManager.SaveSetting("StepName", Me.StepNameField.Text.Trim, "bvsoftware", "Order Tasks", "Debit Credit Cards")
        Me.SettingsManager.SaveBooleanSetting("ThrowErrors", Me.chkThrowErrors.Checked, "bvsoftware", "Order Tasks", "Debit Credit Cards")
        Me.SettingsManager.SaveSetting("CustomerErrorMessage", Me.CustomerErrorMessageField.Text.Trim, "bvsoftware", "Order Tasks", "Debit Credit Cards")
        Me.SettingsManager.SaveBooleanSetting("SetStatusOnFail", Me.chkSetStatusOnFail.Checked, "bvsoftware", "Order Tasks", "Debit Credit Cards")
        Me.SettingsManager.SaveSetting("FailStatusCode", Me.FailStatusField.SelectedValue, "bvsoftware", "Order Tasks", "Debit Credit Cards")
    End Sub

End Class
