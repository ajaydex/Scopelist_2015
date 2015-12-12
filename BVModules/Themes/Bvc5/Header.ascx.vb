Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Bvc5_Header
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init        
        Me.Page.ClientScript.RegisterClientScriptInclude("bvsoftwareclient", Me.Page.ResolveUrl(PersonalizationServices.GetPersonalizedThemeVirtualPath & "theme.js"))
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            lnkHome.Text = Content.SiteTerms.GetTerm("Home")
            lnkHome.ToolTip = Content.SiteTerms.GetTerm("Home")

            lnkMyAccount.Text = Content.SiteTerms.GetTerm("MyAccount")
            lnkMyAccount.ToolTip = Content.SiteTerms.GetTerm("MyAccount")

            lnkContactUs.Text = Content.SiteTerms.GetTerm("CustomerService")
            lnkContactUs.ToolTip = Content.SiteTerms.GetTerm("CustomerService")

            lnkSearch.Text = Content.SiteTerms.GetTerm("Search")
            lnkSearch.ToolTip = Content.SiteTerms.GetTerm("Search")

            lnkCart.Text = Content.SiteTerms.GetTerm("ViewCart")
            lnkCart.ToolTip = Content.SiteTerms.GetTerm("ViewCart")

        End If
    End Sub
End Class
