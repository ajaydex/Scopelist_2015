Imports BVSoftware.BVC5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.Linq

Partial Class BVModules_Controls_CategoryBreadCrumbTrail
    Inherits System.Web.UI.UserControl

    Private allCats As Collection(Of Catalog.Category) = Nothing

    Private _Spacer As String = Content.SiteTerms.GetTerm("BreadcrumbTrailSeparator")
    Private _CurrentCategoryId As String = String.Empty
    Private _IncludeProductName As Boolean = False
    Private _IncludeHomepage As Boolean = False
    Private _HomepageText As String = "Home"

#Region " Properties "

    Public Property Spacer() As String
        Get
            Return _Spacer
        End Get
        Set(ByVal value As String)
            _Spacer = value
        End Set
    End Property

    Public Property CurrentCategoryId() As String
        Get
            If String.IsNullOrEmpty(Me._CurrentCategoryId) Then
                Me._CurrentCategoryId = SessionManager.CurrentCategoryId()
            End If

            Return Me._CurrentCategoryId
        End Get
        Set(ByVal value As String)
            Me._CurrentCategoryId = value
        End Set
    End Property

    Public Property IncludeProductName As Boolean
        Get
            Return Me._IncludeProductName
        End Get
        Set(value As Boolean)
            Me._IncludeProductName = value
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

    Public ReadOnly Property IsProductPage As Boolean
        Get
            Return (Me.Page IsNot Nothing AndAlso TypeOf Me.Page Is BaseStoreProductPage)
        End Get
    End Property

#End Region

    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)

        Me.EnableViewState = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' hide control if the current category is the homepage (or cannot be determined)
        If Me.CurrentCategoryId = "0" Then
            Me.Visible = False
            Return
        End If

        Me.allCats = Catalog.Category.FindAllLight()
    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        Dim sb As New StringBuilder()

        For Each c As Catalog.Category In GetBreadcrumbs()
            Dim breadcrumbTrail As List(Of Catalog.Category) = Catalog.Category.BuildParentTrail(c.Bvin).Reverse().ToList()

            If breadcrumbTrail.Count > 0 Then
                sb.AppendFormat("<div class=""breadcrumbs"">")
                If Me.IncludeHomepage Then
                    sb.AppendFormat("<a href=""{0}"" class=""home""><span>{1}</span></a>{2}", WebAppSettings.SiteStandardRoot, Me.HomepageText, Environment.NewLine)
                    RenderDelimiter(sb)
                End If

                RenderBreadcrumbTrail(breadcrumbTrail, 0, sb)

                If Me.IncludeProductName AndAlso Me.IsProductPage Then
                    RenderDelimiter(sb)
                    sb.AppendFormat("<span>{0}</span>{1}", CType(Me.Page, BaseStoreProductPage).LocalProduct.ProductName, Environment.NewLine)
                End If
                sb.AppendFormat("</div>")
            End If
        Next

        If sb.Length > 0 Then
            'writer.AddAttribute(HtmlTextWriterAttribute.Class, "breadcrumbs")
            writer.RenderBeginTag(HtmlTextWriterTag.Div)
            writer.Write(sb.ToString())
            writer.RenderEndTag()
        End If

        sb = Nothing
    End Sub

    Private Sub RenderBreadcrumbTrail(ByVal breadcrumbTrail As List(Of Catalog.Category), ByVal depthLevel As Integer, ByRef sb As StringBuilder)
        If depthLevel = 0 Then
            sb.AppendLine("<div itemscope itemtype=""http://data-vocabulary.org/Breadcrumb"">")
        Else
            sb.AppendLine("<div itemprop=""child"" itemscope itemtype=""http://data-vocabulary.org/Breadcrumb"">")
        End If

        sb.AppendFormat("<a href=""{0}"" itemprop=""url"">{1}", Utilities.UrlRewriter.BuildUrlForCategory(breadcrumbTrail(depthLevel), Me.Page, allCats), Environment.NewLine)
        sb.AppendFormat("<span itemprop=""title"">{0}</span>{1}", breadcrumbTrail(depthLevel).Name, Environment.NewLine)
        sb.AppendLine("</a>")

        If depthLevel < (breadcrumbTrail.Count - 1) Then
            RenderDelimiter(sb)
            RenderBreadcrumbTrail(breadcrumbTrail, depthLevel + 1, sb)
        End If

        sb.AppendLine("</div>")
    End Sub

    Private Sub RenderDelimiter(ByRef sb As StringBuilder)
        sb.AppendFormat(" <span class=""spacer"">{0}</span>{1}", Me.Spacer, Environment.NewLine)
    End Sub

    Private Function GetBreadcrumbs() As Collection(Of Catalog.Category)
        Dim result As New Collection(Of Catalog.Category)()
        result.Add(Catalog.Category.FindByBvin(Me.CurrentCategoryId))

        If Me.IsProductPage Then
            If WebAppSettings.BreadCrumbTrailMaxEntries = 0 OrElse WebAppSettings.BreadCrumbTrailMaxEntries > 1 Then
                Dim p As Catalog.Product = CType(Me.Page, BaseStoreProductPage).LocalProduct
                Dim bvin As String = If(String.IsNullOrEmpty(p.ParentId), p.Bvin, p.ParentId)
                
                Dim categories As Collection(Of Catalog.Category) = Catalog.InternalProduct.GetCategories(bvin)
                If categories.Count > 1 Then
                    For i As Integer = 0 To categories.Count - 1
                        If categories(i).Bvin <> result(0).Bvin Then
                            result.Add(categories(i))

                            If result.Count = WebAppSettings.BreadCrumbTrailMaxEntries Then
                                Exit For
                            End If
                        End If
                    Next
                End If
            End If
        End If

        Return result
    End Function

End Class