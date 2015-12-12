Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_RSS_Feed_Viewer_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        Me.FeedField.Text = Me.SettingsManager.GetSetting("FeedUrl")
        Me.chkShowDescription.Checked = Me.SettingsManager.GetBooleanSetting("ShowDescription")
        Me.chkShowTitle.Checked = Me.SettingsManager.GetBooleanSetting("ShowTitle")
        Me.MaxItemsField.Text = Me.SettingsManager.GetIntegerSetting("MaxItems")
    End Sub

    Private Sub SaveData()
        Me.SettingsManager.SaveSetting("FeedUrl", Me.FeedField.Text.Trim, "bvsoftware", "Content Block", "RSS Feed Viewer")
        Me.SettingsManager.SaveBooleanSetting("ShowDescription", Me.chkShowDescription.Checked, "bvsoftware", "Content Block", "RSS Feed Viewer")
        Me.SettingsManager.SaveBooleanSetting("ShowTitle", Me.chkShowTitle.Checked, "bvsoftware", "Content Block", "RSS Feed Viewer")
        Me.SettingsManager.SaveIntegerSetting("MaxItems", Me.MaxItemsField.Text.Trim, "bvsoftware", "Content Block", "RSS Feed Viewer")
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing()
    End Sub

End Class
