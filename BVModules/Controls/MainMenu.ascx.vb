Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_MainMenu
    Inherits System.Web.UI.UserControl

    Private _LinksPerRow As Integer = 7
    Private _MaximumLinks As Integer = 0
    Private _tabIndex As Integer = -1

    Private _allCats As Collection(Of Catalog.Category) = Nothing

    Private _tempTabIndex As Integer = 0
    Public Property TabIndex() As Integer
        Get
            Return _tabIndex
        End Get
        Set(ByVal value As Integer)
            _tabIndex = value
        End Set
    End Property

    Public Property LinksPerRow() As Integer
        Get
            Return _LinksPerRow
        End Get
        Set(ByVal value As Integer)
            _LinksPerRow = value
        End Set
    End Property
    Public Property MaximumLinks() As Integer
        Get
            Return _MaximumLinks
        End Get
        Set(ByVal value As Integer)
            _MaximumLinks = value
        End Set
    End Property

    Private _DisplayActiveTab As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '_DisplayActiveTab = DirectCast(Me.Page, BaseStorePage).DisplaysActiveCategoryTab

        _allCats = Catalog.Category.FindAllLight()
        LoadMenu()

    End Sub

    Private Sub LoadMenu()

        '' Find Categories to Display in Menu
        'Dim categories As Collection(Of Catalog.Category) = Catalog.Category.FindMenuCategories()

        '' Limit number of links
        'Dim stopCount As Integer = categories.Count - 1
        'If (_MaximumLinks > 0) AndAlso ((_MaximumLinks - 1) < stopCount) Then
        '    stopCount = (_MaximumLinks - 1)
        'End If

        'Dim sb As New StringBuilder

        '' Open List
        'If categories.Count > 0 Then
        '    sb.Append("<ul>")
        'End If

        '_tempTabIndex = Me.TabIndex
        '' Build each Row
        'For i As Integer = 0 To (stopCount)
        '    sb.Append(BuildLink(categories(i)))
        '    ' Move to Next Row if Not Last Item
        '    If (((i + 1) Mod _LinksPerRow) = 0) AndAlso ((i) < stopCount) Then
        '        sb.Append("</ul><ul>")
        '    End If
        'Next

        '' Close List
        'If categories.Count > 0 Then
        '    sb.Append("</ul>")
        'End If

        'Me.litMain.Text = sb.ToString

        ' Find Categories to Display in Menu
        Dim categories As Collection(Of Catalog.Category) = Catalog.Category.FindMenuCategories()

        ' Limit number of links
        'commented by developer
        'Dim stopCount As Integer = categories.Count - 1
        Dim stopCount As Integer = categories.Count - 1
        'If (_MaximumLinks > 0) AndAlso ((_MaximumLinks - 1) < stopCount) Then
        '    stopCount = (_MaximumLinks - 1)
        'End If

        Dim sb As New StringBuilder

        ' Open List
        If categories.Count > 0 Then
            sb.Append("<ul>")
        End If

        _tempTabIndex = Me.TabIndex
        ' Build each Row
        For i As Integer = 0 To (stopCount)
            If categories(i).Name.ToLower() = "firearms" Then
                'handle the url if sku exists in it and redirect with custom url of the product to display it
                Dim url As String = Request.Url.ToString()
                If url.Contains("=") And url.Contains("affid") And url.Contains("ppc") Then
                    'nothing to do here
                Else
                    sb.Append(BuildLink(categories(i)))
                End If
            Else
                sb.Append(BuildLink(categories(i)))
            End If

            ' Move to Next Row if Not Last Item
            If (((i + 1) Mod _LinksPerRow) = 0) AndAlso ((i) < stopCount) Then
                sb.Append("</ul><ul>")
            End If
        Next

        ' Close List
        If categories.Count > 0 Then
            sb.Append("</ul>")
        End If

        Me.litMain.Text = sb.ToString
    End Sub

    Private Function BuildLink(ByVal c As Catalog.Category) As String
        'Dim result As String = String.Empty

        'Dim sbLink As New StringBuilder

        'sbLink.Append("<li")
        'If (c.Bvin = SessionManager.CategoryLastId) AndAlso _DisplayActiveTab Then
        '    sbLink.Append(" class=""activemainmenuitem"" >")
        'Else
        '    sbLink.Append(">")
        'End If

        'sbLink.Append("<a href=""")
        'sbLink.Append(Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, _allCats))
        'If c.CustomPageOpenInNewWindow Then
        '    sbLink.Append(""" target=""_blank""")
        'Else
        '    sbLink.Append("""")
        'End If
        'If _tempTabIndex <> -1 Then
        '    sbLink.Append(" TabIndex=""" & _tempTabIndex.ToString() & """ ")
        '    _tempTabIndex += 1
        'End If
        'sbLink.Append(" class=""actuator"" title=""" & c.MetaTitle & """>")
        'If c.MenuOffImageUrl.Trim.Length() > 0 Then
        '    sbLink.Append("<img src=""")
        '    If (c.Bvin = SessionManager.CategoryLastId) AndAlso _DisplayActiveTab Then
        '        sbLink.Append(Page.ResolveUrl("~" & c.MenuOnImageUrl))
        '    Else
        '        sbLink.Append(Page.ResolveUrl("~" & c.MenuOffImageUrl))
        '    End If
        '    sbLink.Append(""" alt=""")
        '    sbLink.Append(c.Name)
        '    sbLink.Append(""">")
        'Else
        '    sbLink.Append(c.Name)
        'End If
        'sbLink.Append("</a></li>")

        'result = sbLink.ToString
        'Return result


        Dim result As String = String.Empty

        Dim sbLink As New StringBuilder
        sbLink.Append("<li>")
        sbLink.Append("<a href=""")
        sbLink.Append(Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, _allCats))

        If c.CustomPageOpenInNewWindow Then
            sbLink.Append(""" target=""_blank""")
        Else
            sbLink.Append(""" target=""_parent""")
        End If

        If (c.Bvin = SessionManager.CategoryLastId) AndAlso _DisplayActiveTab Then
            sbLink.Append("class='active'")
        End If

        If _tempTabIndex <> -1 Then
            sbLink.Append(" TabIndex=""" & _tempTabIndex.ToString() & """ ")
            _tempTabIndex += 1
        End If

        If c.Name.ToLower() = "rifle scopes" Then
            Dim url As String = Request.Url.ToString()
            If url.Contains("=") And url.Contains("affid") And url.Contains("ppc") Then
                c.Name = "Riflescopes"
            End If
        End If

        sbLink.Append("  title=""" & c.MetaTitle & """>")

        If c.MenuOffImageUrl.Trim.Length() > 0 Then
            sbLink.Append("<img src=""")
            sbLink.Append(Page.ResolveUrl("~" & c.MenuOffImageUrl))
            sbLink.Append(""">")
            sbLink.Append("<span>" & c.Name & "</span>")
        Else
            sbLink.Append(c.Name)
        End If

        sbLink.Append("</a></li>")
        result = sbLink.ToString
        Return result
    End Function
    Protected Sub BuildListItem(ByVal item As HtmlGenericControl, ByVal category As Catalog.Category)
        item.InnerText = category.Name

        If (category.Bvin = SessionManager.CategoryLastId) AndAlso _DisplayActiveTab Then
            item.Attributes("class") = "activemainmenuitem"
        Else
            'item.Attributes("class") = "menuitem"
        End If

        Dim sbLink As New StringBuilder
        sbLink.Append("<a href=""")
        sbLink.Append(Utilities.UrlRewriter.BuildUrlForCategory(category, Me.Page, _allCats))
        If category.CustomPageOpenInNewWindow Then
            sbLink.Append(""" target=""_blank")
        End If
        sbLink.Append(""" class=""actuator"">")
        If category.MenuOffImageUrl.Trim.Length() > 0 Then
            sbLink.Append("<img src=""")
            If (category.Bvin = SessionManager.CategoryLastId) AndAlso _DisplayActiveTab Then
                sbLink.Append(Page.ResolveUrl("~" & category.MenuOnImageUrl))
            Else
                sbLink.Append(Page.ResolveUrl("~" & category.MenuOffImageUrl))
            End If
            sbLink.Append(""" border=""0"" alt=""")
            sbLink.Append(category.Name)
            sbLink.Append(""">")
        Else
            sbLink.Append(category.Name)
        End If
        sbLink.Append("</a>")
        item.InnerHtml = sbLink.ToString
    End Sub

End Class
