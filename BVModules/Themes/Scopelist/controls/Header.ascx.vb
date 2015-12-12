Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_OpticAuthority_Header
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.Page.ClientScript.RegisterClientScriptInclude("bvsoftwareclient", Me.Page.ResolveUrl(PersonalizationServices.GetPersonalizedThemeVirtualPath & "scripts/theme.js"))
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

	   If Request.Url.ToString().Contains(WebAppSettings.AffiliateQueryStringName) Then
                Dim cookDict As HttpCookie = New HttpCookie("affiliateReference")
                cookDict.Value = Request.Params(WebAppSettings.AffiliateQueryStringName)
                cookDict.Path = Request.ApplicationPath
                Response.Cookies.Add(cookDict)
            End If

            lnkStoreName.Text = WebAppSettings.SiteName
            lnkStoreName.ToolTip = WebAppSettings.SiteName & " Home Page"

            lnkHome.Text = Content.SiteTerms.GetTerm("Home")
            lnkHome.ToolTip = Content.SiteTerms.GetTerm("Home")

            lnkStoreName.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/logo.jpg")

            lnkMyAccount.Text = Content.SiteTerms.GetTerm("MyAccount")
            lnkMyAccount.ToolTip = Content.SiteTerms.GetTerm("MyAccount")

            lnkContactUs.Text = Content.SiteTerms.GetTerm("CustomerService")
            lnkContactUs.ToolTip = Content.SiteTerms.GetTerm("CustomerService")

            'lnkCart.Text = Content.SiteTerms.GetTerm("ViewCart")
            'lnkCart.ToolTip = Content.SiteTerms.GetTerm("ViewCart")


            Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)

            Dim str As String = ""
            str = u.FirstName & " " & u.LastName
            If str.Length > 20 Then
                str = str.Substring(0, 20) & ".."
            End If
            lnkUsername.Text = str
            If Not String.IsNullOrEmpty(str.Trim()) Then
                ltlWelcome.Visible = True
                'lnkUsername.Text = "Mr." & lnkUsername.Text.Trim()
                lnkUsername.Text = lnkUsername.Text.Trim()
            End If

        End If
    End Sub

End Class
