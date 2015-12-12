Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Bvc5_Footer
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lnkHome.Text = Content.SiteTerms.GetTerm("Home")
        lnkHome.ToolTip = Content.SiteTerms.GetTerm("Home")

        lnkSearch.Text = Content.SiteTerms.GetTerm("Search")
        lnkSearch.ToolTip = Content.SiteTerms.GetTerm("Search")

        lnkSiteMap.Text = Content.SiteTerms.GetTerm("SiteMap")
        lnkSiteMap.ToolTip = Content.SiteTerms.GetTerm("SiteMap")

        If TypeOf Me.Page Is BaseStorePage Then
            If DirectCast(Me.Page, BaseStorePage).UseTabIndexes Then
                lnkHome.TabIndex = 10000
                lnkSearch.TabIndex = 10001
                lnkSiteMap.TabIndex = 10002
            End If
        End If
    End Sub
End Class
