Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ProductTasks_Overrider_Price_With_Text_Edit
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
        Me.MyTextField.Text = Me.SettingsManager.GetSetting("OverrideText")
        Me.chkAnonymous.Checked = Me.SettingsManager.GetBooleanSetting("OnlyForAnonymous")
    End Sub

    Private Sub SaveData()
        Me.SettingsManager.SaveSetting("StepName", Me.StepNameField.Text.Trim, "bvsoftware", "Product Tasks", "Override Price With Text")
        Me.SettingsManager.SaveSetting("OverrideText", Me.MyTextField.Text.Trim, "bvsoftware", "Product Tasks", "Override Price With Text")
        Me.SettingsManager.SaveBooleanSetting("OnlyForAnonymous", Me.chkAnonymous.Checked, "bvsoftware", "Product Tasks", "Override Price With Text")
    End Sub


End Class
