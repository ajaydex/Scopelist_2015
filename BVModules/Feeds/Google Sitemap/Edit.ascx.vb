Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Feeds_Google_Sitemap_Edit
    Inherits FeedEngine.FeedTemplate

    Public Overloads Overrides Sub Initialize()
        Dim feed As FeedEngine.Sitemaps.GoogleSitemap = DirectCast(Me.Feed, FeedEngine.Sitemaps.GoogleSitemap)

        Me.lblAdditionalUrlsPath.Text = feed.FileFolderPath
        Me.txtAdditionalUrlsFilename.Text = feed.AdditionalUrlsFileName
        Me.ddlDefaultPriority.Items.FindByValue(feed.DefaultPriority).Selected = True
        Me.ddlDefaultChangeFrequency.Items.FindByValue(feed.DefaultChangeFreq).Selected = True
        Me.chkPingSearchEngines.Checked = feed.PingSearchEngines
        Me.chkIncludeProductImages.Checked = feed.IncludeProductImages
    End Sub

    Public Overrides Sub Save()
        Dim feed As FeedEngine.Sitemaps.GoogleSitemap = DirectCast(Me.Feed, FeedEngine.Sitemaps.GoogleSitemap)

        feed.AdditionalUrlsFileName = Me.txtAdditionalUrlsFilename.Text.Trim()
        feed.DefaultPriority = Me.ddlDefaultPriority.SelectedValue
        feed.DefaultChangeFreq = Me.ddlDefaultChangeFrequency.SelectedValue
        feed.PingSearchEngines = Me.chkPingSearchEngines.Checked
        feed.IncludeProductImages = Me.chkIncludeProductImages.Checked

        feed.SaveSettings()
    End Sub

    Public Overrides Sub Cancel()

    End Sub

End Class