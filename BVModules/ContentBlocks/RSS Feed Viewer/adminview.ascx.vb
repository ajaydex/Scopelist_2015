Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_RSS_Feed_Viewer_adminview
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadData()
    End Sub

    Private Sub LoadData()
        Dim feed As String = Me.SettingsManager.GetSetting("FeedUrl")
        If feed.Length > 80 Then
            feed = feed.Substring(0, 80) & "..."
        End If
        If feed.Trim.Length < 1 Then
            feed = "No Feed Selected"
        End If
        Me.lblFeed.Text = feed
    End Sub

End Class
