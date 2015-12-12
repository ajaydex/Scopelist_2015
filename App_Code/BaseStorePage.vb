Imports BVSoftware.Bvc5.Core
Imports System.Data
Imports System.Collections.ObjectModel

Public Class BaseStorePage
    Inherits System.Web.UI.Page

    Private _CanonicalUrl As String = String.Empty
    Private _useTabIndexes As Boolean = False
    Private _FbOpenGraph As New FacebookOpenGraph

    Public Property PageTitle() As String
        Get
            Return Me.Page.Title
        End Get
        Set(ByVal Value As String)
            Me.Page.Title = Value
        End Set
    End Property
    Public Property CanonicalUrl() As String
        Get
            If String.IsNullOrEmpty(Me._CanonicalUrl) Then
                Me.LoadCanonicalUrl()
            End If

            Return Me._CanonicalUrl
        End Get
        Set(value As String)
            Me._CanonicalUrl = value
        End Set
    End Property
    Public Property UseTabIndexes() As Boolean
        Get
            Return _useTabIndexes
        End Get
        Set(ByVal value As Boolean)
            _useTabIndexes = value
        End Set
    End Property
    Public Shadows Property MetaKeywords() As String
        Get
            Dim m As HtmlControls.HtmlMeta = Page.Header.FindControl("MetaKeywords")
            If m IsNot Nothing Then
                Return m.Content
            Else
                Return String.Empty
            End If
        End Get
        Set(ByVal value As String)
            Dim m As HtmlControls.HtmlMeta = Page.Header.FindControl("MetaKeywords")
            If m IsNot Nothing Then
                m.Content = value
            End If
        End Set
    End Property
    Public Shadows Property MetaDescription() As String
        Get
            Dim m As HtmlControls.HtmlMeta = Page.Header.FindControl("MetaDescription")
            If m IsNot Nothing Then
                Return m.Content
            Else
                Return String.Empty
            End If
        End Get
        Set(ByVal value As String)
            Dim m As HtmlControls.HtmlMeta = Page.Header.FindControl("MetaDescription")
            If m IsNot Nothing Then
                m.Content = value
            End If
        End Set
    End Property
    Public Overridable ReadOnly Property DisplaysActiveCategoryTab() As Boolean
        Get
            Return False
        End Get
    End Property
    Public Overridable ReadOnly Property IsClosedPage() As Boolean
        Get
            Return False
        End Get
    End Property
    Public Property FbOpenGraph As FacebookOpenGraph
        Get
            Return Me._FbOpenGraph
        End Get
        Set(value As FacebookOpenGraph)
            Me._FbOpenGraph = value
        End Set
    End Property

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        'log affiliate request
        If Not Request.Params(WebAppSettings.AffiliateQueryStringName) Is Nothing Then
            Dim affid As String = String.Empty
            Try
                affid = Request.Params(WebAppSettings.AffiliateQueryStringName)
                Contacts.Affiliate.RecordReferral(affid)
            Catch ex As Exception
                EventLog.LogEvent("BaseStorePage - Page_Init", "Error loading affiliate " & ex.Message, Metrics.EventLogSeverity.Warning)
            End Try
        End If

        ' add coupon from query string
        Dim couponCode As String = Request.QueryString("code")
        If Not String.IsNullOrEmpty(couponCode) Then
            Dim cart As Orders.Order = SessionManager.CurrentShoppingCart()
            Dim opResult As BVOperationResult = cart.AddCouponCode(couponCode, True)
            If opResult.Success Then
                SessionManager.InvalidateCachedCart()
            Else
                AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Marketing, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Warning, "BaseStorePage - Page_Init", opResult.Message)
            End If
        End If

        Anthem.Manager.Register(Me)
        'If this is a private store, force login before showing anything.
        If WebAppSettings.IsPrivateStore = True Then
            If SessionManager.IsUserAuthenticated = False Then
                Dim nameOfPage As String = Request.AppRelativeCurrentExecutionFilePath
                ' Check to make sure we're not going to end up in an endless loop of redirects
                If (Not nameOfPage.ToLower.StartsWith("~/login.aspx")) AndAlso _
                    (Not nameOfPage.ToLower.StartsWith("~/forgotpassword.aspx")) AndAlso _
                    (Not nameOfPage.ToLower.StartsWith("~/contactus.aspx")) Then
                    Response.Redirect("~/Login.aspx?ReturnUrl=" & HttpUtility.UrlEncode(Me.Request.RawUrl))
                End If
            End If
        End If
    End Sub

    Public Overridable ReadOnly Property RequiresSSL() As Boolean
        Get
            Return False
        End Get
    End Property

    Protected Overridable Sub StoreClosedCheck()
        If WebAppSettings.StoreClosed = True Then
            If SessionManager.IsAdminUser = False Then
                Response.Redirect("Closed.aspx")
            End If
        End If
    End Sub

    Private Sub Page_LoadComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LoadComplete
        If Not Page.IsPostBack Then
            If WebAppSettings.MetaTitleAppendStoreName Then
                Me.Page.Title = Me.PageTitle + " - " + WebAppSettings.SiteName
            Else
                Me.Page.Title = Me.PageTitle
            End If
        End If
    End Sub

    Protected Sub BasePage_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not Page.IsPostBack Then

            Me.MetaKeywords = WebAppSettings.MetaKeywords
            Me.MetaDescription = WebAppSettings.MetaDescription
        End If

        StoreClosedCheck()

        If RequiresSSL Then
            If WebAppSettings.UseSsl Then
                ' Assure that both URL's are not the same so the system doesn't try to redirect to the same URL and loop.
                If WebAppSettings.SiteSecureRoot.ToLower <> WebAppSettings.SiteStandardRoot.ToLower Then
                    If Not Request.IsSecureConnection Then
                        Utilities.SSL.SSLRedirect(Me, Utilities.SSL.SSLRedirectTo.SSL)
                    End If
                End If
            End If
        Else
            If WebAppSettings.UseSsl Then
                If Request.IsSecureConnection Then
                    Utilities.SSL.SSLRedirect(Me, Utilities.SSL.SSLRedirectTo.NonSSL)
                End If
            End If
        End If

        If WebAppSettings.CanonicalUrlEnabled Then
            RenderCanonicalUrl()
        End If

        If WebAppSettings.FacebookOpenGraphEnabled Then
            Me.LoadFacebookOpenGraph()
            Me.FbOpenGraph.AddMetaTags()
        End If

        ' Add CurrentPage to Context for Core Access
        ' HttpContext.Current.Items.Add("CurrentPage", Me)

    End Sub

    Public Sub ValidateCurrentUserHasPermission(ByVal p As String)
        Dim l As New Collection(Of String)
        l.Add(p)
        ValidateCurrentUserHasPermissions(l)
    End Sub

    Public Sub ValidateCurrentUserHasPermissions(ByVal p As Collection(Of String))
        If SessionManager.IsUserAuthenticated = False Then
            ' Send to Login Page
            Response.Redirect("~/login.aspx?ReturnUrl=" & HttpUtility.UrlEncode(Me.Request.RawUrl))
        Else
            If Membership.UserAccount.DoesUserHaveAllPermissions(SessionManager.GetCurrentUserId, p) = False Then
                ' Send to no permissions page
                Response.Redirect("~/nopermissions.aspx")
            End If
        End If
    End Sub

    Protected Overrides Sub Render(ByVal writer As System.Web.UI.HtmlTextWriter)
        'If WebAppSettings.MoveViewstateToBottomOfPage Then
        '    Dim stringWriter As New System.IO.StringWriter()
        '    Dim htmlWriter As New HtmlTextWriter(stringWriter)
        '    MyBase.Render(htmlWriter)
        '    Dim html As String = stringWriter.ToString()
        '    Dim startPoint As Integer = html.IndexOf("<input type=""hidden"" name=""__VIEWSTATE""")
        '    If (startPoint >= 0) Then
        '        Dim endPoint As Integer = html.IndexOf("/>", startPoint) + 2
        '        Dim viewStateInput As String = html.Substring(startPoint, endPoint - startPoint)
        '        html = html.Remove(startPoint, endPoint - startPoint)
        '        Dim FormEndStart As Integer = html.IndexOf("</form>")
        '        If (FormEndStart >= 0) Then
        '            html = html.Insert(FormEndStart, viewStateInput)
        '        End If
        '    End If
        '    writer.Write(html)
        'Else
        MyBase.Render(writer)
        'End If
    End Sub

    Protected Overridable Sub LoadCanonicalUrl()
        Dim requestedUrl As String = Utilities.UrlRewriter.CreateFullyQualifiedUrl(Request.RawUrl)

        If String.Compare(requestedUrl, WebAppSettings.SiteStandardRoot) = 0 OrElse String.Compare(requestedUrl, WebAppSettings.SiteStandardRoot.Trim("/"c) + "/default.aspx", True) = 0 Then
            ' homepage
            Me.CanonicalUrl = WebAppSettings.SiteStandardRoot
        Else
            ' everything else (with query string excluded)
            Dim pos As Integer = requestedUrl.IndexOf("?"c)
            If pos > 0 Then
                Me.CanonicalUrl = requestedUrl.Substring(0, pos)
            Else
                Me.CanonicalUrl = requestedUrl
            End If
        End If
    End Sub

    Protected Overridable Sub RenderCanonicalUrl()
        If Not String.IsNullOrEmpty(Me.CanonicalUrl) Then
            If Me.Header IsNot Nothing Then
                Dim link As New HtmlLink()
                link.EnableViewState = False
                link.Href = Me.CanonicalUrl
                link.Attributes.Add("rel", "canonical")

                Try
                    Me.Header.Controls.Add(link)
                Catch ex As Exception
                    ' do nothing
                End Try
            End If
        End If
    End Sub

    Protected Overridable Sub LoadFacebookOpenGraph()
        ' SiteName
        If String.IsNullOrEmpty(Me.FbOpenGraph.SiteName) Then
            Me.FbOpenGraph.SiteName = WebAppSettings.SiteName
        End If

        ' Url
        If String.IsNullOrEmpty(Me.FbOpenGraph.Url) Then
            Me.FbOpenGraph.Url = Me.CanonicalUrl
        End If

        ' Title
        If String.IsNullOrEmpty(Me.FbOpenGraph.Title) Then
            Me.FbOpenGraph.Title = Me.PageTitle
        End If
    End Sub

End Class