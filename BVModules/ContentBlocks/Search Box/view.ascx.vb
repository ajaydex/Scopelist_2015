Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_Search_Box_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load        
        SetDefaultControlValues()        
    End Sub

    Private Sub SetDefaultControlValues()
        lblTitle.Text = SettingsManager.GetSetting("Title")
        If lblTitle.Text = String.Empty Then
            lblTitle.Text = Content.SiteTerms.GetTerm("Search")
        End If
        btnSearch.ImageUrl = PersonalizationServices.GetThemedButton("GoSearch")
        btnSearch.AlternateText = "Submit Form"
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click
        Response.Redirect("~/search.aspx?keyword=" & Server.UrlEncode(Me.KeywordField.Text.Trim))
    End Sub

End Class
