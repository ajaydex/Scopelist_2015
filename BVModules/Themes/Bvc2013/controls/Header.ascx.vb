Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Bvc2013_Header
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.Page.ClientScript.RegisterClientScriptInclude("bvsoftwareclient", Me.Page.ResolveUrl(PersonalizationServices.GetPersonalizedThemeVirtualPath & "scripts/theme.js"))
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            ' disabling this code prevents a cart from being created needlessly for every site visitor (including bots like Googlebot)
            'Dim quantity As String = SessionManager.CurrentShoppingCart.TotalQuantity.ToString("0")
            'Dim subtotal As String = String.Format("{0:c}", SessionManager.CurrentShoppingCart.SubTotal)

            lnkStoreName.Text = WebAppSettings.SiteName
            lnkStoreName.ToolTip = WebAppSettings.SiteName & " Home Page"

            'lnkHome.Text = Content.SiteTerms.GetTerm("Home")
            'lnkHome.ToolTip = Content.SiteTerms.GetTerm("Home")

            lnkMyAccount.Text = Content.SiteTerms.GetTerm("MyAccount")
            lnkMyAccount.ToolTip = Content.SiteTerms.GetTerm("MyAccount")

            lnkContactUs.Text = Content.SiteTerms.GetTerm("CustomerService")
            lnkContactUs.ToolTip = Content.SiteTerms.GetTerm("CustomerService")

            'lnkSearch.Text = Content.SiteTerms.GetTerm("Search")
            'lnkSearch.ToolTip = Content.SiteTerms.GetTerm("Search")

            lnkCart.Text = Content.SiteTerms.GetTerm("ViewCart")
            'lnkCart.ToolTip = "Your Cart: " & quantity & " - " & subtotal

        End If
    End Sub

End Class