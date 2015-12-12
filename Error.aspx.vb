Imports BVSoftware.Bvc5.Core

Partial Class ErrorPage
    Inherits BaseStorePage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Error.master")
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.Page.Title = WebAppSettings.SiteName
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' check for redirect before processing error page
        If Not (WebAppSettings.RedirectorEnabled AndAlso Utilities.UrlRedirector.TryRedirect(HttpContext.Current)) Then
            HttpContext.Current.Response.StatusCode = 404
            Dim type As String = Request.QueryString("type")
            If String.Compare(type, "product", True) = 0 Then
                HeaderLiteral.Text = Content.SiteTerms.GetTerm("ErrorPageHeaderTextProduct")
                ErrorContentLiteral.Text = Content.SiteTerms.GetTerm("ErrorPageContentTextProduct")

                If HeaderLiteral.Text = String.Empty Then
                    HeaderLiteral.Text = "Error finding product"
                End If

                If ErrorContentLiteral.Text = String.Empty Then
                    ErrorContentLiteral.Text = "An error occurred while trying to find the specified product."
                End If
                HttpContext.Current.Response.StatusDescription = "Product Not Found"
            ElseIf String.Compare(type, "category", True) = 0 Then
                HeaderLiteral.Text = Content.SiteTerms.GetTerm("ErrorPageHeaderTextCategory")
                ErrorContentLiteral.Text = Content.SiteTerms.GetTerm("ErrorPageContentTextCategory")

                If HeaderLiteral.Text = String.Empty Then
                    HeaderLiteral.Text = "Error finding category"
                End If

                If ErrorContentLiteral.Text = String.Empty Then
                    ErrorContentLiteral.Text = "An error occurred while trying to find the specified category."
                End If
                HttpContext.Current.Response.StatusDescription = "Category Not Found"
            Else
                HeaderLiteral.Text = Content.SiteTerms.GetTerm("ErrorPageHeaderTextGeneric")
                ErrorContentLiteral.Text = Content.SiteTerms.GetTerm("ErrorPageContentTextGeneric")

                If HeaderLiteral.Text = String.Empty Then
                    HeaderLiteral.Text = "Error finding page"
                End If

                If ErrorContentLiteral.Text = String.Empty Then
                    ErrorContentLiteral.Text = "An error occurred while processing your request."
                End If
            End If
        End If
    End Sub

End Class