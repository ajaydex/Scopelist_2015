Imports BVSoftware.Bvc5.Core
'Imports System.Web.Security

Partial Class logout
    Inherits System.Web.UI.Page

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim prevUserId As String = SessionManager.GetCurrentUserId()

        SessionManager.SetCurrentUserId(String.Empty, False)

        SessionManager.PersonalThemeName = String.Empty

        If Request.Browser.Cookies = True Then
            Try
                Dim saveCookie As New System.Web.HttpCookie(WebAppSettings.UserIdCookieName, "")
                saveCookie.Expires = Now()
                Response.Cookies.Add(saveCookie)
            Catch Ex As Exception
                EventLog.LogEvent("Login Cookie Writer", "Logout Page - " & Ex.Message, Metrics.EventLogSeverity.Warning)
            End Try
        End If

        If WebAppSettings.UseSsl Then
            If prevUserId.Trim <> String.Empty Then                
                Dim url As String = String.Empty
                If Me.Request.IsSecureConnection Then
                    Dim CurrentURL As String = Page.Request.Url.AbsoluteUri.ToLower.Trim
                    Dim StandardURL As String = WebAppSettings.SiteStandardRoot.ToLower.Trim
                    Dim SecureURL As String = WebAppSettings.SiteSecureRoot.ToLower.Trim
                    Utilities.SSL.RemoveAllEncoding(CurrentURL)
                    Utilities.SSL.RemoveAllEncoding(StandardURL)
                    Utilities.SSL.RemoveAllEncoding(SecureURL)
                    url = Utilities.UrlRewriter.SwitchUrlToStandard(CurrentURL, StandardURL, SecureURL)                    
                Else
                    Dim CurrentURL As String = Page.Request.Url.AbsoluteUri.ToLower.Trim
                    Dim StandardURL As String = WebAppSettings.SiteStandardRoot.ToLower.Trim
                    Dim SecureURL As String = WebAppSettings.SiteSecureRoot.ToLower.Trim
                    Utilities.SSL.RemoveAllEncoding(CurrentURL)
                    Utilities.SSL.RemoveAllEncoding(StandardURL)
                    Utilities.SSL.RemoveAllEncoding(SecureURL)
                    url = Utilities.UrlRewriter.SwitchUrlToSecure(CurrentURL, StandardURL, SecureURL)
                End If
                Response.Redirect(url)
            End If
        End If

        Response.Clear()
        Response.Redirect(WebAppSettings.SiteStandardRoot)
    End Sub

End Class
