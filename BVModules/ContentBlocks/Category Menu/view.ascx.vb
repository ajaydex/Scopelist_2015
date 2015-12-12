Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_ContentBlocks_Category_Menu_view
    Inherits Content.BVModule

    Private _showProductCounts As Boolean = False
    Private _showCategoryCounts As Boolean = False

    Dim currentId As String = "0"


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadMenu()
    End Sub

    Private Function LocateCurrentCategory() As String
        Dim result As String = String.Empty


        If Request.QueryString("categoryId") IsNot Nothing Then
            result = Request.QueryString("categoryId")
        Else
            If TypeOf Me.Page Is BaseStoreProductPage Then
                Dim p As Catalog.Product = CType(Me.Page, BaseStoreProductPage).LocalProduct
                If p IsNot Nothing Then

                    Dim bvin As String = p.Bvin
                    If Not String.IsNullOrEmpty(p.ParentId) Then
                        bvin = p.ParentId
                    End If

                    Dim categories As Collection(Of Catalog.Category) = Catalog.InternalProduct.GetCategories(bvin)
                    If categories IsNot Nothing Then
                        If categories.Count > 0 Then

                            Dim found As Boolean = False

                            ' scan category list to see if the last visited is in the collection
                            For Each c As Catalog.Category In categories
                                If c.Bvin = SessionManager.CategoryLastId Then
                                    result = c.Bvin
                                    found = True
                                    Exit For
                                End If
                            Next

                            If found = False Then
                                result = categories(0).Bvin
                            End If

                        End If
                    End If
                End If
            Else
                result = SessionManager.CategoryLastId
            End If
        End If

        ' Always reset to zero if we can't find anything
        If result = String.Empty Then
            result = "0"
        End If

        Return result
    End Function

    Private Sub LoadMenu()
        currentId = LocateCurrentCategory()


        Me.TitlePlaceHolder.Controls.Clear()
        Dim title As String = SettingsManager.GetSetting("Title")
        If title.Trim.Length > 0 Then
            Me.TitlePlaceHolder.Controls.Add(New LiteralControl("<h4>" & title & "</h4>"))
        End If

        Me.MenuControl.Controls.Clear()
        MenuControl.EnableViewState = False

        _showProductCounts = SettingsManager.GetBooleanSetting("ShowProductCount")
        _showCategoryCounts = SettingsManager.GetBooleanSetting("ShowCategoryCount")
        Me.MenuControl.Controls.Add(New LiteralControl("<ul>"))

        If SettingsManager.GetBooleanSetting("HomeLink") = True Then
            AddHomeLink()
        End If


        Dim mode As String = SettingsManager.GetSetting("CategoryMenuMode")
        Select Case mode
            Case "0"
                ' Root Categories Only
                LoadRoots()
            Case "1"
                ' All Categories
                LoadAllCategories()
            Case "2"
                ' Peers, Children and Parents
                LoadPeersAndChildren()
            Case "3"
                ' Show root and expanded children
                LoadRootPlusExpandedChildren()
            Case Else
                ' All Categories
                LoadRoots()
        End Select

        Me.MenuControl.Controls.Add(New LiteralControl("</ul>"))
    End Sub

    Private Sub LoadRoots()
        Dim cats As Collection(Of Catalog.Category) = Catalog.Category.FindVisibleChildren("0")
        AddCategoryCollection(cats, cats, 1, 1)
    End Sub

    Private Sub AddHomeLink()
        Me.MenuControl.Controls.Add(New LiteralControl("<li>"))
        Dim m As New HyperLink
        m.ToolTip = "Home"
        m.Text = "Home"
        m.NavigateUrl = "~/default.aspx"
        m.EnableViewState = False
        Me.MenuControl.Controls.Add(m)
        Me.MenuControl.Controls.Add(New LiteralControl("</li>"))
    End Sub

    Private Sub AddSingleLink(ByVal c As Catalog.Category, ByVal allCats As Collection(Of Catalog.Category), Optional ByVal MenuColor As String = "")
        AddSingleLink(c, currentId, allCats, MenuColor)
    End Sub

    Private Sub AddSingleLink(ByVal c As Catalog.Category, ByVal currentCategoryId As String, ByVal allCats As Collection(Of Catalog.Category), Optional ByVal MenuColor As String = "")
        'If c.Bvin = currentCategoryId Then
        '    If TypeOf Me.Page Is BaseStoreCategoryPage Then
        '        Me.MenuControl.Controls.Add(New LiteralControl("<li class=""current"">"))
        '    Else
        '        Me.MenuControl.Controls.Add(New LiteralControl("<li class=""current"">"))
        '    End If
        'Else
        '    Me.MenuControl.Controls.Add(New LiteralControl("<li>"))
        'End If

        'Dim m As New HyperLink
        'm.ToolTip = c.MetaTitle
        'm.Text = c.Name

        'Dim childCount As Integer = 0
        'If Me._showProductCounts Then
        '    'childCount += Catalog.InternalProduct.FindCountByCategoryId(c.Bvin)
        '    childCount += c.LatestProductCount
        'End If

        'If Me._showCategoryCounts Then
        '    childCount += Catalog.Category.FindChildrenInCollection(allCats, c.Bvin, False).Count
        'End If

        'If childCount > 0 Then
        '    m.Text = m.Text + " (" + childCount.ToString() + ")"
        'End If

        'm.NavigateUrl = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, allCats)
        'If c.SourceType = Catalog.CategorySourceType.CustomLink Then
        '    If c.CustomPageOpenInNewWindow = True Then
        '        m.Target = "_blank"
        '    End If
        'End If

        'm.EnableViewState = False
        'Me.MenuControl.Controls.Add(m)
        'commented by developer
        'If c.Bvin = currentCategoryId Then
        '    If TypeOf Me.Page Is BaseStoreCategoryPage Then
        '        'added by developer
        '        'Me.MenuControl.Controls.Add(New LiteralControl("<li class='current'"))        '        
        '    Else
        '        'added by developer
        '        'Me.MenuControl.Controls.Add(New LiteralControl("<li class='current'"))
        '    End If
        'Else
        '    Me.MenuControl.Controls.Add(New LiteralControl("<li>"))
        'End If

        'added by developer
        If (Not c.ParentId Is Nothing) Then
            If (c.ParentId = 0.ToString()) Then
                Me.MenuControl.Controls.Add(New LiteralControl("<p>"))

                Dim m As New HyperLink
                m.ToolTip = c.MetaTitle

                Dim childCount As Integer = 0

                If Me._showProductCounts Then
                    childCount += Catalog.InternalProduct.FindCountByCategoryId(c.Bvin)
                End If

                If Me._showCategoryCounts Then
                    childCount += Catalog.Category.FindVisibleChildren(c.Bvin).Count
                End If

                If childCount > 0 Then
                    m.Text = m.Text + " (" + childCount.ToString() + ")"
                End If

                If c.SourceType = Catalog.CategorySourceType.CustomLink Then
                    If c.CustomPageOpenInNewWindow = True Then
                        m.Target = "_blank"
                    End If
                End If

                m.Text = c.Name
                m.EnableViewState = False
                m.NavigateUrl = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, allCats)

                Me.MenuControl.Controls.Add(m)

                Me.MenuControl.Controls.Add(New LiteralControl("</p>"))
            Else
                Me.MenuControl.Controls.Add(New LiteralControl("<li>"))


                Dim m As New HyperLink
                m.ToolTip = c.MetaTitle

                If MenuColor <> String.Empty Then
                    m.Style.Add("color", MenuColor)
                End If

                Dim childCount As Integer = 0

                If Me._showProductCounts Then
                    childCount += Catalog.InternalProduct.FindCountByCategoryId(c.Bvin)
                End If

                If Me._showCategoryCounts Then
                    childCount += Catalog.Category.FindVisibleChildren(c.Bvin).Count
                End If

                If childCount > 0 Then
                    m.Text = m.Text + " (" + childCount.ToString() + ")"
                End If


                If c.SourceType = Catalog.CategorySourceType.CustomLink Then
                    If c.CustomPageOpenInNewWindow = True Then
                        m.Target = "_blank"
                    End If
                End If
                m.Text = c.Name
                m.EnableViewState = False
                m.NavigateUrl = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, allCats)

                Me.MenuControl.Controls.Add(m)
                Me.MenuControl.Controls.Add(New LiteralControl("</li>"))
            End If
        End If

    End Sub

    Private Sub LoadRootPlusExpandedChildren()

        Dim allCats As Collection(Of Catalog.Category) = Catalog.Category.FindAllLight()

        ' Get Current Category
        Dim currentCategory As Catalog.Category = Catalog.Category.FindInCollection(allCats, currentId)
        If currentCategory IsNot Nothing Then
            If currentCategory.Bvin <> String.Empty Then
                currentId = currentCategory.Bvin
            End If

            ' Find the trail from this category back to the root of the site
            Dim trail As New Collection(Of Catalog.Category)
            BuildParentTrail(allCats, currentCategory.Bvin, trail)
            If trail Is Nothing Then
                trail = New Collection(Of Catalog.Category)
            End If

            If trail.Count < 1 Then
                ' Load Roots Only
                LoadRoots()
            Else

                Dim StartingRootCategoryId As String = currentCategory.Bvin
                StartingRootCategoryId = trail(trail.Count - 1).Bvin


                Dim roots As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(allCats, "0", False)
                If roots IsNot Nothing Then
                    Me.MenuControl.Controls.Add(New LiteralControl("<ul>" & System.Environment.NewLine))

                    For Each c As Catalog.Category In roots
                        If IsInTrail(c.Bvin, trail) Then
                            AddSingleLink(c, currentId, allCats)
                            Dim children As New Collection(Of Catalog.Category)
                            children = Catalog.Category.FindChildrenInCollection(allCats, StartingRootCategoryId, False)
                            If children IsNot Nothing Then
                                Me.MenuControl.Controls.Add(New LiteralControl("<ul>" & System.Environment.NewLine))
                                ExpandInTrail(allCats, children, trail)
                                Me.MenuControl.Controls.Add(New LiteralControl("</ul>" & System.Environment.NewLine))
                            End If
                            Me.MenuControl.Controls.Add(New LiteralControl("</li>"))

                            Exit For
                        End If
                    Next

                    Me.MenuControl.Controls.Add(New LiteralControl("</ul>" & System.Environment.NewLine))
                End If

            End If
        Else
            Me.MenuControl.Controls.Add(New LiteralControl("Invalid Category Id. Contact Administrator"))
        End If

    End Sub

    Private Function IsInTrail(ByVal testBvin As String, ByVal trail As Collection(Of Catalog.Category)) As Boolean
        Dim result As Boolean = False

        If trail IsNot Nothing Then
            For Each c As Catalog.Category In trail
                If c.Bvin = testBvin Then
                    result = True
                    Exit For
                End If
            Next
        End If

        Return result
    End Function

    Private Sub ExpandInTrail(ByVal allCats As Collection(Of Catalog.Category), ByVal cats As Collection(Of Catalog.Category), ByVal trail As Collection(Of Catalog.Category))
        If cats IsNot Nothing Then
            For Each c As Catalog.Category In cats

                If c.Hidden = False Then


                    AddSingleLink(c, allCats)

                    If IsInTrail(c.Bvin, trail) Then
                        Dim children As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(allCats, c.Bvin, False)
                        If children IsNot Nothing Then
                            If children.Count > 0 Then
                                Me.MenuControl.Controls.Add(New LiteralControl("<ul>" & System.Environment.NewLine))
                                ExpandInTrail(allCats, children, trail)
                                Me.MenuControl.Controls.Add(New LiteralControl("</ul>" & System.Environment.NewLine))
                            End If
                        End If
                    End If

                    Me.MenuControl.Controls.Add(New LiteralControl("</li>"))
                End If
            Next
        End If
    End Sub

    Private Sub LoadAllCategories()
        Dim allCategories As Collection(Of Catalog.Category) = Catalog.Category.FindAllLight()
        Dim maxDepth As Integer = SettingsManager.GetIntegerSetting("MaximumDepth")
        Dim children As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(allCategories, "0", False)
        AddCategoryCollection(allCategories, children, 0, maxDepth)
    End Sub

    Private Sub AddCategoryCollection(ByVal allCats As Collection(Of Catalog.Category), ByVal currentCats As Collection(Of Catalog.Category), ByVal currentDepth As Integer, ByVal maxDepth As Integer)
        If allCats IsNot Nothing Then

            For Each c As Catalog.Category In currentCats

                If c.Hidden = False Then

                    Dim info As CategoryInfo = CategoryInfo.FindByCategory(c.Bvin)

                    AddSingleLink(c, allCats, info.MenuColor)

                    If info.MenuMode <> CategoryInfo.EMenuMode.Collapsed Then
                        If (maxDepth = 0) Or (currentDepth + 1 < maxDepth) Or info.MenuMode = CategoryInfo.EMenuMode.Expanded Then
                            Dim children As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(allCats, c.Bvin, False)
                            If children IsNot Nothing Then
                                If children.Count > 0 Then
                                    Me.MenuControl.Controls.Add(New LiteralControl("<ul>" & System.Environment.NewLine))
                                    AddCategoryCollection(allCats, children, currentDepth + 1, maxDepth)
                                    Me.MenuControl.Controls.Add(New LiteralControl("</ul>" & System.Environment.NewLine))
                                End If
                            End If
                        End If
                    End If

                    'Me.MenuControl.Controls.Add(New LiteralControl("</li>"))
                End If
            Next
        End If
    End Sub

    Private Sub BuildParentTrail(ByVal allCats As Collection(Of Catalog.Category), ByVal currentId As String, ByRef trail As Collection(Of Catalog.Category))

        If currentId = "0" OrElse currentId = String.Empty Then
            Exit Sub
        End If

        Dim current As Catalog.Category = Catalog.Category.FindInCollection(allCats, currentId)

        If (current IsNot Nothing) Then
            trail.Add(current)
            If (current.ParentId = "0") Then
                Exit Sub
            End If
            If current.ParentId IsNot Nothing Then
                If current.ParentId <> String.Empty Then
                    BuildParentTrail(allCats, current.ParentId, trail)
                End If
            End If
        End If

    End Sub

    Private Function GetPeerSet(ByVal allCats As Collection(Of Catalog.Category), ByVal cat As Catalog.Category) As Catalog.CategoryPeerSet
        Dim result As New Catalog.CategoryPeerSet

        Dim parent As Catalog.Category = Catalog.Category.FindInCollection(allCats, cat.ParentId)
        If (parent IsNot Nothing) Then
            result.Parents = Catalog.Category.FindChildrenInCollection(allCats, parent.ParentId, False)
        End If
        result.Peers = Catalog.Category.FindChildrenInCollection(allCats, cat.ParentId, False)
        result.Children = Catalog.Category.FindChildrenInCollection(allCats, cat.Bvin, False)

        Return result
    End Function

    Private Sub LoadPeersAndChildren()

        Dim allCats As Collection(Of Catalog.Category) = Catalog.Category.FindAllLight()

        ' Get Current Category
        Dim currentCategory As Catalog.Category = Catalog.Category.FindInCollection(allCats, currentId)

        ' Trick system into accepting root category of zero which never exists in database
        If (currentId = "0") Then
            currentCategory = New Catalog.Category()
            currentCategory.Bvin = "0"
        End If

        If currentCategory IsNot Nothing Then
            If currentCategory.Bvin <> String.Empty Then
                currentId = currentCategory.Bvin
            End If

            ' Find the trail from this category back to the root of the site
            Dim trail As New Collection(Of Catalog.Category)
            BuildParentTrail(allCats, currentCategory.Bvin, trail)
            If trail Is Nothing Then
                trail = New Collection(Of Catalog.Category)
            End If

            If trail.Count < 1 Then
                ' Load Roots Only
                LoadRoots()
            Else

                Dim neighbors As Catalog.CategoryPeerSet = GetPeerSet(allCats, currentCategory)

                If trail.Count = 1 Then
                    ' special case where we want only peers and children
                    RenderPeersChildren(neighbors, currentCategory, allCats)
                Else
                    If trail.Count >= 3 Then
                        If neighbors.Children.Count < 1 Then
                            ' Special case where we are at the end of the tree and have
                            ' no children. Reset neighbors to parent's bvin
                            Dim parent As Catalog.Category = Catalog.Category.FindInCollection(allCats, currentCategory.ParentId)
                            If (parent Is Nothing) Then
                                parent = New Catalog.Category
                            End If
                            neighbors = GetPeerSet(allCats, parent)
                            RenderParentsPeersChildren(neighbors, trail(1), allCats)
                        Else
                            RenderParentsPeersChildren(neighbors, currentCategory, allCats)
                        End If
                    Else
                        ' normal load of peers
                        RenderParentsPeersChildren(neighbors, currentCategory, allCats)
                    End If
                End If
            End If

        Else
            Me.MenuControl.Controls.Add(New LiteralControl("&nbsp;"))
        End If

    End Sub

    Private Sub RenderPeersChildren(ByVal neighbors As Catalog.CategoryPeerSet, ByVal currentCategory As Catalog.Category, ByVal allCats As Collection(Of Catalog.Category))
        ' No Parents, start with peers
        For Each peer As Catalog.Category In neighbors.Peers
            If Not peer.Hidden Then
                AddSingleLink(peer, allCats)
                If peer.Bvin = currentCategory.Bvin Then

                    ' Load Children
                    If neighbors.Children.Count > 0 Then
                        Dim initialized As Boolean = False
                        For Each child As Catalog.Category In neighbors.Children
                            If Not child.Hidden Then
                                If Not initialized Then
                                    Me.MenuControl.Controls.Add(New LiteralControl("<ul>" & System.Environment.NewLine))
                                    initialized = True
                                End If

                                AddSingleLink(child, allCats)
                                Me.MenuControl.Controls.Add(New LiteralControl("</li>" & System.Environment.NewLine))
                            End If
                        Next
                        If initialized Then
                            Me.MenuControl.Controls.Add(New LiteralControl("</ul>" & System.Environment.NewLine))
                        End If
                    End If

                End If
                Me.MenuControl.Controls.Add(New LiteralControl("</li>" & System.Environment.NewLine))
            End If
        Next
    End Sub

    Private Sub RenderParentsPeersChildren(ByVal neighbors As Catalog.CategoryPeerSet, ByVal currentCategory As Catalog.Category, ByVal allCats As Collection(Of Catalog.Category))
        If neighbors.Parents.Count < 1 Then
            RenderPeersChildren(neighbors, currentCategory, allCats)
        Else

            ' Add Parents
            For Each parent As Catalog.Category In neighbors.Parents
                If Not parent.Hidden Then
                    AddSingleLink(parent, allCats)

                    ' Add Peers
                    If parent.Bvin = currentCategory.ParentId Then

                        Dim peerInitialized As Boolean = False

                        For Each peer As Catalog.Category In neighbors.Peers
                            If Not peer.Hidden Then
                                If Not peerInitialized Then
                                    Me.MenuControl.Controls.Add(New LiteralControl("<ul>"))
                                    peerInitialized = True
                                End If
                                AddSingleLink(peer, allCats)
                                If peer.Bvin = currentCategory.Bvin Then

                                    ' Load Children
                                    If neighbors.Children.Count > 0 Then
                                        Dim childInitialized As Boolean = False
                                        For Each child As Catalog.Category In neighbors.Children
                                            If Not child.Hidden Then
                                                If Not childInitialized Then
                                                    Me.MenuControl.Controls.Add(New LiteralControl("<ul>" & System.Environment.NewLine))
                                                    childInitialized = True
                                                End If
                                                AddSingleLink(child, allCats)
                                                Me.MenuControl.Controls.Add(New LiteralControl("</li>" & System.Environment.NewLine))
                                            End If
                                        Next
                                        If childInitialized Then
                                            Me.MenuControl.Controls.Add(New LiteralControl("</ul>" & System.Environment.NewLine))
                                        End If
                                    End If


                                End If
                                Me.MenuControl.Controls.Add(New LiteralControl("</li>" & System.Environment.NewLine))
                            End If
                        Next

                        If peerInitialized Then
                            Me.MenuControl.Controls.Add(New LiteralControl("</ul>" & System.Environment.NewLine))
                        End If

                    End If

                End If

                Me.MenuControl.Controls.Add(New LiteralControl("</li>" & System.Environment.NewLine))

            Next

        End If
    End Sub

End Class
