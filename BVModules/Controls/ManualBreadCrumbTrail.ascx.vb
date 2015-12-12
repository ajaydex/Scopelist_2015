Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_ManualBreadCrumbTrail
    Inherits System.Web.UI.UserControl

    Private _Spacer As String = Content.SiteTerms.GetTerm("BreadcrumbTrailSeparator")
    Private _IncludeHomepage As Boolean = False
    Private _HomepageText As String = "Home"
    Private _Trail As String = String.Empty

#Region " Properties "

    Public Property Spacer() As String
        Get
            Return _Spacer
        End Get
        Set(ByVal value As String)
            _Spacer = value
        End Set
    End Property

    Public Property IncludeHomepage As Boolean
        Get
            Return Me._IncludeHomepage
        End Get
        Set(value As Boolean)
            Me._IncludeHomepage = value
        End Set
    End Property

    Public Property HomepageText As String
        Get
            Return Me._HomepageText
        End Get
        Set(value As String)
            Me._HomepageText = value
        End Set
    End Property

    Public Property Trail() As String
        Get
            Return _Trail
        End Get
        Set(ByVal value As String)
            _Trail = value
        End Set
    End Property

#End Region

    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)

        Me.EnableViewState = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        Dim sb As New StringBuilder()

        Dim breadcrumbTrail As Collection(Of String()) = Me.GetBreadcrumbs()
        If breadcrumbTrail.Count > 0 Then
            If Me.IncludeHomepage Then
                sb.AppendFormat("<a href=""{0}"" class=""home"">{1}</a>{2}", WebAppSettings.SiteStandardRoot, Me.HomepageText, Environment.NewLine)
                RenderDelimiter(sb)
            End If

            RenderBreadcrumbTrail(breadcrumbTrail, 0, sb)
        End If

        If sb.Length > 0 Then
            writer.AddAttribute(HtmlTextWriterAttribute.Class, "breadcrumbs")
            writer.RenderBeginTag(HtmlTextWriterTag.Div)
            writer.Write(sb.ToString())
            writer.RenderEndTag()
        End If

        sb = Nothing
    End Sub

    Private Sub RenderBreadcrumbTrail(ByVal breadcrumbTrail As Collection(Of String()), ByVal depthLevel As Integer, ByRef sb As StringBuilder)
        If depthLevel = 0 Then
            sb.AppendLine("<div itemscope itemtype=""http://data-vocabulary.org/Breadcrumb"">")
        Else
            sb.AppendLine("<div itemprop=""child"" itemscope itemtype=""http://data-vocabulary.org/Breadcrumb"">")
        End If

        If Not String.IsNullOrEmpty(breadcrumbTrail(depthLevel)(1)) Then
            sb.AppendFormat("<a href=""{0}"" itemprop=""url"">{1}", Page.ResolveUrl(breadcrumbTrail(depthLevel)(1)), Environment.NewLine)
            sb.AppendFormat("<span itemprop=""title"">{0}</span>{1}", breadcrumbTrail(depthLevel)(0), Environment.NewLine)
            sb.AppendLine("</a>")
        Else
            sb.AppendFormat("<span itemprop=""title"">{0}</span>{1}", breadcrumbTrail(depthLevel)(0), Environment.NewLine)
        End If

        If depthLevel < (breadcrumbTrail.Count - 1) Then
            RenderDelimiter(sb)
            RenderBreadcrumbTrail(breadcrumbTrail, depthLevel + 1, sb)
        End If

        sb.AppendLine("</div>")
    End Sub

    Private Sub RenderDelimiter(ByRef sb As StringBuilder)
        sb.AppendFormat(" <span class=""spacer"">{0}</span>{1}", Me.Spacer, Environment.NewLine)
    End Sub

    Private Function GetBreadcrumbs() As Collection(Of String())
        Dim result As New Collection(Of String())()

        Dim breadcrumbs As String() = Me.Trail.Split(",")
        If breadcrumbs.Length > 0 Then
            For Each crumb As String In breadcrumbs
                Dim crumbParts As String() = crumb.Split("|")
                If crumbParts.Length = 2 Then
                    result.Add(New String() {crumbParts(0), crumbParts(1)})
                ElseIf crumbParts.Length = 1 Then
                    result.Add(New String() {crumbParts(0), String.Empty})
                End If
            Next
        End If

        Return result
    End Function

    Public Sub ClearTrail()
        _Trail = String.Empty
    End Sub

    Public Sub AddLink(ByVal name As String, ByVal navigateurl As String)
        If _Trail.Length > 0 Then
            _Trail += ","
        End If
        _Trail += name.Replace(",", "")
        _Trail += "|"
        _Trail += navigateurl.Replace(",", "")
    End Sub

    Public Sub AddNonLink(ByVal name As String)
        If _Trail.Length > 0 Then
            _Trail += ","
        End If
        _Trail += name.Replace(",", "")
    End Sub

End Class