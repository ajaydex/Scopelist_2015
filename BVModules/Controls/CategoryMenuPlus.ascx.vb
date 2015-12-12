Imports System.Collections.ObjectModel
Imports System.Linq

Imports BVSoftware.Bvc5.Core


Partial Class BVModules_Controls_CategoryMenuPlus
    Inherits BVSoftware.Bvc5.Core.Controls.BVBaseUserControl

    Private allCats As Collection(Of Catalog.Category) = Nothing

#Region "Private"

    Private _CurrentCategoryId As String = String.Empty
    Private _DepthLevels As Integer = 9999
    Private _StartDepth As Integer = 1
    Private _DefaultExpandedDepth As Integer = 1
    Private _DisplayOnlyActiveBranch As Boolean = False
    Private _DisplayOnlyChildrenOfCurrentCategory As Boolean = False
    Private _ShowProductCount As Boolean = False
    Private _ShowSubCategoryCount As Boolean = False
    Private _UseShowInTopMenuSettings As Boolean = False
    Private _HtmlID As String = String.Empty
    Private _AssignUniqueCssClassNames As Boolean = False
    Private _DisplayTopLevelAsHeadings As Boolean = False
    Private _HeadingTag As String = "span"
    Private _ShowMoreLink As Boolean = False
    Private _MoreLinkText As String = "more"

#End Region
    
#Region "Properties"

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

    Public Property DepthLevels() As Integer
        Get
            Return Me._DepthLevels
        End Get
        Set(ByVal value As Integer)
            Me._DepthLevels = value
        End Set
    End Property

    Public Property StartDepth() As Integer
        Get
            Return Me._StartDepth
        End Get
        Set(ByVal value As Integer)
            Me._StartDepth = value
        End Set
    End Property

    Public Property DefaultExpandedDepth() As Integer
        Get
            Return Me._DefaultExpandedDepth
        End Get
        Set(ByVal value As Integer)
            Me._DefaultExpandedDepth = value
        End Set
    End Property

    Public Property DisplayOnlyActiveBranch() As Boolean
        Get
            Return Me._DisplayOnlyActiveBranch
        End Get
        Set(ByVal value As Boolean)
            Me._DisplayOnlyActiveBranch = value
        End Set
    End Property

    Public Property DisplayOnlyChildrenOfCurrentCategory() As Boolean
        Get
            Return Me._DisplayOnlyChildrenOfCurrentCategory
        End Get
        Set(ByVal value As Boolean)
            Me._DisplayOnlyChildrenOfCurrentCategory = value
        End Set
    End Property

    Public Property ShowProductCount() As Boolean
        Get
            Return Me._ShowProductCount
        End Get
        Set(ByVal value As Boolean)
            Me._ShowProductCount = value
        End Set
    End Property

    Public Property ShowSubCategoryCount() As Boolean
        Get
            Return Me._ShowSubCategoryCount
        End Get
        Set(ByVal value As Boolean)
            Me._ShowSubCategoryCount = value
        End Set
    End Property

    Public Property UseShowInTopMenuSettings() As Boolean
        Get
            Return Me._UseShowInTopMenuSettings
        End Get
        Set(ByVal value As Boolean)
            Me._UseShowInTopMenuSettings = value
        End Set
    End Property

    Public Property HtmlID() As String
        Get
            Return Me._HtmlID
        End Get
        Set(ByVal value As String)
            Me._HtmlID = value
        End Set
    End Property

    Public Property AssignUniqueCssClassNames() As Boolean
        Get
            Return Me._AssignUniqueCssClassNames
        End Get
        Set(ByVal value As Boolean)
            Me._AssignUniqueCssClassNames = value
        End Set
    End Property

    Public Property DisplayTopLevelAsHeadings() As Boolean
        Get
            Return Me._DisplayTopLevelAsHeadings
        End Get
        Set(ByVal value As Boolean)
            Me._DisplayTopLevelAsHeadings = value
        End Set
    End Property

    Public Property HeadingTag() As String
        Get
            Return Me._HeadingTag
        End Get
        Set(ByVal value As String)
            Me._HeadingTag = value
        End Set
    End Property

    Public Property ShowMoreLink() As Boolean
        Get
            Return Me._ShowMoreLink
        End Get
        Set(value As Boolean)
            Me._ShowMoreLink = value
        End Set
    End Property

    Public Property MoreLinkText() As String
        Get
            Return Me._MoreLinkText
        End Get
        Set(value As String)
            Me._MoreLinkText = value
        End Set
    End Property

#End Region

    Protected Overrides Sub Render(ByVal writer As System.Web.UI.HtmlTextWriter)
        Me.allCats = Catalog.Category.FindAllLight()

        Dim sb As New StringBuilder()

        sb.Append("<ul")

        If Not String.IsNullOrEmpty(Me.HtmlID) Then
            sb.Append(" id=""" & Me.HtmlID & """")
        End If

        If Not String.IsNullOrEmpty(Me.CssClass) Then
            sb.Append(" class=""" & Me.CssClass & """")
        End If

        sb.Append(">")
        RenderMenu(sb)
        sb.Append("</ul>")

        sb.Replace("<ul></ul>", String.Empty)   ' remove empty unordered list(s)

        writer.Write(sb.ToString())
        sb = Nothing
    End Sub

    Private Sub RenderMenu(ByVal sb As StringBuilder)
        'Load current page category tree
        Dim categoryTree As Collection(Of Catalog.Category)
        If Me.CurrentCategoryId <> "0" Then
            categoryTree = Catalog.Category.BuildParentTrail(Me.CurrentCategoryId)
        Else
            categoryTree = New Collection(Of Catalog.Category)
        End If

        If categoryTree.Count > 0 Then
            If Me.StartDepth > 1 AndAlso Me.StartDepth <= categoryTree.Count Then
                ' remove initial branch(es) of tree based on StartDepth value
                For i As Integer = 2 To Me.StartDepth
                    categoryTree.RemoveAt(categoryTree.Count - 1)
                Next
            End If
            RenderSubMenu(sb, categoryTree, categoryTree.Count - 1)
        Else
            ' current page is not found, so load top-level categories
            Dim topCats As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(allCats, "0", False)
            If topCats.Count > 0 Then
                For Each c As Catalog.Category In topCats
                    'If c.Hidden = False Then
                    If Not Me.UseShowInTopMenuSettings OrElse (Me.UseShowInTopMenuSettings AndAlso c.ShowInTopMenu) Then
                        RenderLI(sb)

                        If Not Me.DisplayTopLevelAsHeadings Then
                            RenderLink(sb, c)
                        Else
                            RenderHeading(sb, c)
                        End If

                        RenderExpandedMenu(sb, c, 1)    ' pass a value for depthLevel that is one less than it actually is
                        Render_LI(sb)
                    End If
                    'End If
                Next
            End If
        End If
    End Sub

    Private Sub RenderSubMenu(ByVal sb As StringBuilder, ByVal c As Collection(Of Catalog.Category), ByVal i As Integer)
        If GetDepthLevel(c, i) > Me.DepthLevels Then
            Return
        End If

        Dim parentCat As Catalog.Category = Nothing
        Dim parentID As String

        If i >= 0 AndAlso i < c.Count Then
            parentID = c.Item(i).ParentId.ToString()
        Else
            parentID = c.Item(0).Bvin.ToString()
            parentCat = c.Item(0)   ' cache the category for later use
        End If

        Dim childCats As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(allCats, parentID, False)
        If childCats.Count > 0 Then

            Dim isTopLevel As Boolean = (i = c.Count - 1)

            ' DisplayOnlyActiveBranch
            If isTopLevel AndAlso (Me.DisplayOnlyActiveBranch OrElse Me.DisplayOnlyChildrenOfCurrentCategory) Then
                For Each category As Catalog.Category In childCats
                    If category.Bvin = c(c.Count - 1).Bvin Then
                        If Me.DisplayOnlyChildrenOfCurrentCategory Then
                            ' BUG? Shouldn't this traverse down tree until it finds the current page, then grab its children?
                            childCats = Catalog.Category.FindChildrenInCollection(allCats, category.Bvin, False)

                            ' remove top-level category from trail
                            c.RemoveAt(c.Count - 1)
                            i = i - 1
                        Else
                            ' remove all non-active branches from the tree
                            childCats = New Collection(Of Catalog.Category)
                            childCats.Add(category)
                        End If

                        Exit For
                    End If
                Next
            End If

            ' skip this part for top-level categories since we handle it in Render()
            If isTopLevel = False Then
                sb.Append("<ul>")
            End If

            For Each category As Catalog.Category In childCats
                Dim isInCurrentBranch As Boolean = False

                If i >= 0 Then
                    If category.Hidden = False AndAlso category.Bvin = c(i).Bvin Then   ' Current Page is inside this category
                        isInCurrentBranch = True

                        If Not Me.UseShowInTopMenuSettings OrElse (Me.UseShowInTopMenuSettings AndAlso category.ShowInTopMenu) Then
                            RenderLI(sb, "activeChild")

                            'Is this the last item in the tree?  If so, this is the current page.
                            If i = 0 Then
                                If Me.DisplayTopLevelAsHeadings AndAlso isTopLevel Then
                                    RenderHeading(sb, category)
                                Else
                                    RenderLink(sb, category, "active")
                                End If

                            Else
                                If Me.DisplayTopLevelAsHeadings AndAlso isTopLevel Then
                                    RenderHeading(sb, category)
                                Else
                                    RenderLink(sb, category)
                                End If
                            End If

                            RenderSubMenu(sb, c, i - 1)
                            Render_LI(sb)
                        End If
                    End If
                End If

                If Not isInCurrentBranch OrElse i < 0 Then    ' Current Page is not inside this category OR i < 0 (i.e. DefaultExpandedDepth has exceeded current page depth)
                    If category.Hidden = False Then
                        If Not Me.UseShowInTopMenuSettings OrElse (Me.UseShowInTopMenuSettings AndAlso category.ShowInTopMenu) Then
                            RenderLI(sb)

                            If Me.DisplayTopLevelAsHeadings AndAlso isTopLevel Then
                                RenderHeading(sb, category)
                            Else
                                RenderLink(sb, category)
                            End If

                            If i >= 0 Then
                                If c(i).ParentId = "0" Then
                                    RenderExpandedMenu(sb, category, 1)
                                Else
                                    RenderExpandedMenu(sb, category, GetDepthLevel(c, i))
                                End If
                            Else
                                RenderExpandedMenu(sb, category, GetDepthLevel(c, i))
                            End If

                            Render_LI(sb)
                        End If
                    End If
                End If
            Next

            Dim showInTopCount As Integer = childCats.Where(Function(x) x.ShowInTopMenu).Count()
            If Me.ShowMoreLink AndAlso Me.UseShowInTopMenuSettings AndAlso Not isTopLevel AndAlso childCats.Count > showInTopCount Then
                ' if we weren't able to 'cache' the category above, load it from the database
                If parentCat Is Nothing Then
                    parentCat = Catalog.Category.FindInCollection(Me.allCats, parentID)
                End If

                RenderLI(sb)
                RenderLink(sb, Me.MoreLinkText, Utilities.UrlRewriter.BuildUrlForCategory(parentCat, Me.Page, Me.allCats), "more", childCats.Count - showInTopCount)
                Render_LI(sb)
            End If

            ' skip this part for top-level categories since we handle it in Render()
            If isTopLevel = False Then
                sb.Append("</ul>")
            End If

        End If
    End Sub

    Private Sub RenderExpandedMenu(ByVal sb As StringBuilder, ByVal category As Catalog.Category, ByVal depthLevel As Integer)
        If Me.DefaultExpandedDepth > depthLevel AndAlso Me.DepthLevels > depthLevel Then
            Dim c As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(allCats, category.Bvin, False)
            If c.Count > 0 Then
                sb.Append("<ul>")
                For Each child As Catalog.Category In c
                    If Not Me.UseShowInTopMenuSettings OrElse (Me.UseShowInTopMenuSettings AndAlso child.ShowInTopMenu) Then
                        RenderLI(sb)
                        RenderLink(sb, child)

                        RenderExpandedMenu(sb, child, depthLevel + 1)

                        Render_LI(sb)
                    End If
                Next

                Dim showInTopCount As Integer = c.Where(Function(x) x.ShowInTopMenu).Count()
                If Me.ShowMoreLink AndAlso Me.UseShowInTopMenuSettings AndAlso c.Count > showInTopCount Then
                    RenderLI(sb)
                    RenderLink(sb, Me.MoreLinkText, Utilities.UrlRewriter.BuildUrlForCategory(category, Me.Page, Me.allCats), "more", c.Count - showInTopCount)
                    Render_LI(sb)
                End If

                sb.Append("</ul>")
            End If
        End If
    End Sub

    Private Function GetDepthLevel(ByVal c As Collection(Of Catalog.Category), ByVal i As Integer) As Integer
        Dim result As Integer = 0
        If c IsNot Nothing Then
            result = c.Count - i
        End If

        Return result
    End Function

    Private Sub RenderLI(ByVal sb As StringBuilder)
        RenderLI(sb, Nothing)
    End Sub
    Private Sub RenderLI(ByVal sb As StringBuilder, ByVal className As String)
        If Not String.IsNullOrEmpty(className) Then
            sb.Append("<li class=""" & className & """>")
        Else
            sb.Append("<li>")
        End If
    End Sub

    Private Sub Render_LI(ByVal sb As StringBuilder)
        sb.Append("</li>")
    End Sub

    Private Sub RenderLink(ByVal sb As StringBuilder, ByVal c As Catalog.Category)
        RenderLink(sb, c, Nothing)
    End Sub
    Private Sub RenderLink(ByVal sb As StringBuilder, ByVal text As String, ByVal url As String, ByVal className As String, Optional ByVal childCount As Integer = 0)
        sb.Append("<a")

        If Not String.IsNullOrEmpty(className) Then
            sb.Append(" class=""" & className & """")
        End If

        sb.Append(" href=""" & url & """")
        sb.Append(">")

        sb.Append(text & " (" + childCount.ToString() & ")")

        sb.Append("</a>")
    End Sub
    Private Sub RenderLink(ByVal sb As StringBuilder, ByVal c As Catalog.Category, ByVal className As String)
        sb.Append("<a")

        ' CSS class(es)
        If Me.AssignUniqueCssClassNames = True Then
            If Not String.IsNullOrEmpty(className) Then
                sb.Append(" class=""a_" & c.Bvin & " " & className & """")
            Else
                sb.Append(" class=""a_" & c.Bvin & """")
            End If
        Else
            If Not String.IsNullOrEmpty(className) Then
                sb.Append(" class=""" & className & """")
            End If
        End If

        ' Title
        If Not String.IsNullOrEmpty(c.MetaTitle) Then
            sb.Append(" title=""" & c.MetaTitle & """")
        End If

        ' Href
        sb.Append(" href=""" & Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, Me.allCats) & """")

        ' Target
        If c.CustomPageOpenInNewWindow = True Then
            sb.Append(" target=""_blank""")
        End If

        sb.Append(">")

        ' product count
        Dim childCount As Integer = 0
        If Me.ShowProductCount Then
            'childCount += Catalog.InternalProduct.FindCountByCategoryId(c.Bvin)
            childCount += c.LatestProductCount
        End If

        ' sub-category count
        If Me.ShowSubCategoryCount Then
            childCount += Catalog.Category.FindChildrenInCollection(allCats, c.Bvin, False).Count
        End If

        ' Text
        If childCount > 0 Then
            sb.AppendFormat("{0} <span>({1})</span>", c.Name, childCount.ToString())
        Else
            sb.Append(c.Name)
        End If

        sb.Append("</a>")
    End Sub

    Private Sub RenderHeading(ByVal sb As StringBuilder, ByVal c As Catalog.Category)
        sb.Append("<" & Me.HeadingTag & ">")
        sb.Append(c.Name.Trim())
        sb.Append("</" & Me.HeadingTag & ">")
    End Sub

End Class