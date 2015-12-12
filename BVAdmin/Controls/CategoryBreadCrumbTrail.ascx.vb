Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Controls_CategoryBreadCrumbTrail
    Inherits System.Web.UI.UserControl

    Private _Spacer As String = "&nbsp;::&nbsp;"
    Private _DisplayLinks As Boolean = False

    Public Property Spacer() As String
        Get
            Return _Spacer
        End Get
        Set(ByVal value As String)
            _Spacer = value
        End Set
    End Property

    Public Property DisplayLinks() As Boolean
        Get
            Return _DisplayLinks
        End Get
        Set(ByVal value As Boolean)
            _DisplayLinks = value
        End Set
    End Property

    Public Sub LoadTrail(ByVal categoryId As String)

        Me.TrailPlaceholder.Controls.Clear()

        Dim allCats As Collection(Of Catalog.Category) = Catalog.Category.FindAllLight()
        Dim trail As New Collection(Of Catalog.Category)
        Dim c As Catalog.Category = Catalog.Category.FindInCollection(allCats, categoryId)
        If c IsNot Nothing Then
            Catalog.Category.BuildParentTrail(allCats, c.Bvin, trail)            
        End If

        If _DisplayLinks Then
            Dim m As New HyperLink
            m.CssClass = "root"
            m.ToolTip = Content.SiteTerms.GetTerm("Root")
            m.Text = Content.SiteTerms.GetTerm("Root")
            m.NavigateUrl = Me.Page.ResolveUrl("~/Default.aspx")
            m.EnableViewState = False
            Me.TrailPlaceholder.Controls.Add(m)
        Else
            Me.TrailPlaceholder.Controls.Add(New LiteralControl("<span class=""current"">Root</span>"))
        End If

        Me.TrailPlaceholder.Controls.Add(New LiteralControl("<span class=""spacer"">" & _Spacer & "</span>"))
        If trail IsNot Nothing Then
            ' Walk list backwards
            For i As Integer = trail.Count - 1 To 0 Step -1
                If i <> trail.Count - 1 Then
                    Me.TrailPlaceholder.Controls.Add(New LiteralControl("<span class=""spacer"">" & _Spacer & "</span>"))
                End If
                If i <> 0 Then
                    If _DisplayLinks Then
                        AddCategoryLink(trail(i), allCats)
                    Else
                        AddCategoryName(trail(i))
                    End If

                Else
                    AddCategoryName(trail(i))
                End If
            Next
        End If

    End Sub

    Private Sub AddCategoryLink(ByVal c As Catalog.Category, ByVal allCats As Collection(Of Catalog.Category))
        Dim m As New HyperLink
        m.ToolTip = c.MetaTitle
        m.Text = c.Name

        m.NavigateUrl = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, allCats)
        If c.SourceType = Catalog.CategorySourceType.CustomLink Then
            If c.CustomPageOpenInNewWindow = True Then
                m.Target = "_blank"
            End If
        End If

        m.EnableViewState = False
        Me.TrailPlaceholder.Controls.Add(m)
    End Sub

    Private Sub AddCategoryName(ByVal c As Catalog.Category)
        Me.TrailPlaceholder.Controls.Add(New LiteralControl("<span class=""current"">" & c.Name & "</span>"))
    End Sub
End Class
