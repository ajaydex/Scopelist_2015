Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_Search_Box_editor
    Inherits Content.BVModule


    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
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
        Me.TitleField.Text = SettingsManager.GetSetting("Title")
        If Me.TitleField.Text = String.Empty Then
            Me.TitleField.Text = "Search"
        End If        
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Title", Me.TitleField.Text.Trim, "bvsoftware", "Content Block", "Search Box")
    End Sub

End Class
