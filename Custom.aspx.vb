Imports BVSoftware.Bvc5.Core

Partial Class Custom
    Inherits BaseStoreCustomPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.Page.Title = WebAppSettings.SiteName
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadCustomPage()
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Custom.master")
    End Sub

    Public Overrides Sub LoadCustomPage()
        If Not String.IsNullOrEmpty(LocalCustomPage.Bvin) Then
            ' redirect to custom URL if it exists
            If Request.RawUrl.StartsWith("/Custom.aspx", StringComparison.InvariantCultureIgnoreCase) Then
                Dim customUrl As Content.CustomUrl = Utilities.UrlRewriter.GetCustomUrlForCustomPage(LocalCustomPage)
                If customUrl IsNot Nothing Then
                    Dim redirectUrl As String = Utilities.UrlRewriter.CreateFullyQualifiedUrl(customUrl.RequestedUrl)
                    Utilities.UrlRedirector.Redirect(redirectUrl, 301)

                    Return
                End If
            End If

            Me.Page.Title = If(Not String.IsNullOrEmpty(LocalCustomPage.MetaTitle), LocalCustomPage.MetaTitle, LocalCustomPage.Name)
            Me.lblName.Text = Me.LocalCustomPage.Name
            Me.lblContent.Text = LocalCustomPage.Content
            Me.MetaDescription = LocalCustomPage.MetaDescription
            Me.MetaKeywords = LocalCustomPage.MetaKeywords
        Else
            Throw New HttpException(404, "Page Not Found")
        End If
    End Sub

End Class
