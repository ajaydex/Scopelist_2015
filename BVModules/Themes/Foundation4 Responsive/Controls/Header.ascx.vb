Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_Header
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.Page.ClientScript.RegisterClientScriptInclude("bvsoftwareclient", Me.Page.ResolveUrl(PersonalizationServices.GetPersonalizedThemeVirtualPath & "scripts/theme.js"))
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        RenderLogo(lnkStoreName)
        RenderLogo(lnkStoreName2)
        lnkMyAccount.Text = "<i class=""fa fa-user""></i> " + Content.SiteTerms.GetTerm("MyAccount")
        lnkContactUs.Text = "<i class=""fa fa-question-circle""></i> " + Content.SiteTerms.GetTerm("CustomerService")
        lnkWishlist.Text = "<i class=""fa fa-heart""></i> " + Content.SiteTerms.GetTerm("Wishlist")
    End Sub

    Private Sub RenderLogo(ByVal logoLink As HyperLink)
        Dim logo As New Image()
        logo.ImageUrl = "~/" + WebAppSettings.SiteLogo
        logo.AlternateText = WebAppSettings.SiteShippingAddress.Company

        logoLink.NavigateUrl = WebAppSettings.SiteStandardRoot
        logoLink.Controls.Add(logo)
    End Sub

End Class