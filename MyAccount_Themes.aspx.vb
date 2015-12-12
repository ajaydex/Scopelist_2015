Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.PersonalizationServices

Partial Class MyAccount_Themes
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("MyAccount.master")

        If SessionManager.IsUserAuthenticated = False Then
            Response.Redirect("login.aspx?ReturnURL=" & Server.UrlEncode("MyAccount_Themes.aspx"))
        End If

    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
        Me.ManualBreadCrumbTrail1.ClearTrail()
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("MyAccount"), "~/MyAccount_Orders.aspx")
        Me.ManualBreadCrumbTrail1.AddNonLink(Content.SiteTerms.GetTerm("Themes"))

        If WebAppSettings.AllowPersonalizedThemes = False Then
            Response.Redirect("MyAccount_Orders.aspx")
        End If

        If Not Page.IsPostBack Then
            Page.Title = "Themes"
        End If

    End Sub

    Private Sub StyleSheetSelector1_ThemeChanged(ByVal Sender As Object, ByVal e As System.EventArgs) Handles StyleSheetSelector1.ThemeChanged
        Response.Redirect("MyAccount_Themes.aspx")
    End Sub


End Class
