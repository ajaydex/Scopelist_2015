Imports BVSoftware.Bvc5.Core

Partial Class BVModules_OrderTasks_Log_Message_edit
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
        Me.MessageField.Text = Me.SettingsManager.GetSetting("Message")
    End Sub

    Private Sub SaveData()
        Me.SettingsManager.SaveSetting("Message", Me.MessageField.Text, "bvsoftware", "Order Tasks", "Log Message")        
    End Sub
End Class
