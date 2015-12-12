Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_CategoryTreeView
    Inherits System.Web.UI.UserControl

    Private _allCats As Collection(Of Catalog.Category) = Nothing

#Region " Properties "

    Public Property SelectedCategories() As Dictionary(Of String, String)
        Get
            ' make sure that we're getting the most up-to-date info
            If Me.CategoryTree.Nodes IsNot Nothing AndAlso Me.CategoryTree.Nodes.Count > 0 Then
                ViewState("SelectedCategories") = GetSelectedNodes()
            End If

            Dim obj As Object = ViewState("SelectedCategories")
            If obj IsNot Nothing Then
                Return CType(obj, Dictionary(Of String, String))
            Else
                Return New Dictionary(Of String, String)
            End If
        End Get
        Set(ByVal value As Dictionary(Of String, String))
            ViewState("SelectedCategories") = value
        End Set
    End Property

    Public Property HighlightSelectedCategories() As Boolean
        Get
            Dim obj As Object = ViewState("HighlightSelectedCategories")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return True
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("HighlightSelectedCategories") = value
        End Set
    End Property

    Public Property ExpandSelectedCategories() As Boolean
        Get
            Dim obj As Object = ViewState("ExpandSelectedCategories")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("ExpandSelectedCategories") = value
        End Set
    End Property

    Public Property IncludeHiddenCategories() As Boolean
        Get
            Dim obj As Object = ViewState("IncludeHiddenCategories")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("IncludeHiddenCategories") = value
        End Set
    End Property

    Private ReadOnly Property allCats As Collection(Of Catalog.Category)
        Get
            If Me._allCats Is Nothing Then
                Me._allCats = Catalog.Category.FindAllLight()
            End If

            Return Me._allCats
        End Get
    End Property

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            LoadTreeView()
        End If
    End Sub

    Public Sub LoadSelectedCategories(ByVal categories As Collection(Of Catalog.Category))
        Me.SelectedCategories = Me.ConvertCollectionToDictionary(categories)
    End Sub

    Public Sub LoadTreeView()
        Me.CategoryTree.Nodes.Clear()

        Dim topLevelCats As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(allCats, "0", Me.IncludeHiddenCategories)
        Dim checkedCats As Dictionary(Of String, String) = Me.SelectedCategories

        For Each c As Catalog.Category In topLevelCats
            'If c.SourceType = Catalog.CategorySourceType.ByRules OrElse c.SourceType = Catalog.CategorySourceType.Manual Then  ' exclude CustomLink and CustomPage categories
            Dim node As New TreeNode(c.Name, c.Bvin)
            node.SelectAction = TreeNodeSelectAction.None   ' prevents node from being a link
            node.Checked = checkedCats.ContainsKey(c.Bvin)

            Me.CategoryTree.Nodes.Add(node)

            If AddChildNodes(node, 1, checkedCats) Then
                If Me.HighlightSelectedCategories Then
                    node.Text = "<b>" + node.Text + "</b>"
                End If
                If Me.ExpandSelectedCategories Then
                    node.Expanded = True
                End If
            End If
            'End If
        Next
    End Sub

    Private Function AddChildNodes(ByVal node As TreeNode, ByVal currentDepth As Integer, ByVal checkedCats As Dictionary(Of String, String)) As Boolean
        Dim result As Boolean = False

        Dim childCats As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(allCats, node.Value, Me.IncludeHiddenCategories)

        For Each c As Catalog.Category In childCats
            'If c.SourceType = Catalog.CategorySourceType.ByRules OrElse c.SourceType = Catalog.CategorySourceType.Manual Then  ' exclude CustomLink and CustomPage categories
            Dim childNode As New TreeNode(c.Name, c.Bvin)
            childNode.SelectAction = TreeNodeSelectAction.None   ' prevents node from being a link
            childNode.Checked = checkedCats.ContainsKey(c.Bvin)

            node.ChildNodes.Add(childNode)

            If childNode.Checked Then
                result = True
            End If

            If AddChildNodes(childNode, currentDepth + 1, checkedCats) Then
                If Me.HighlightSelectedCategories Then
                    childNode.Text = "<b>" + node.Text + "</b>"
                End If
                If Me.ExpandSelectedCategories Then
                    childNode.Expanded = True
                End If

                result = True
            End If
            'End If
        Next

        Return result
    End Function

    Private Function GetSelectedNodes() As Dictionary(Of String, String)
        Dim result As New Dictionary(Of String, String)

        For Each node As TreeNode In Me.CategoryTree.CheckedNodes
            If node.Checked Then
                result.Add(node.Value, node.Text)
            End If
        Next

        Return result
    End Function

#Region " Utilities "

    Public Function ConvertDictionaryToCollection(ByVal categories As Dictionary(Of String, String)) As Collection(Of Catalog.Category)
        Dim result As New Collection(Of Catalog.Category)

        If categories IsNot Nothing Then
            For Each item As KeyValuePair(Of String, String) In categories
                Dim c As Catalog.Category = Catalog.Category.FindInCollection(allCats, item.Key)
                If Not String.IsNullOrEmpty(c.Bvin) Then
                    result.Add(c)
                End If
            Next
        End If

        Return result
    End Function

    Public Function ConvertCollectionToDictionary(ByVal categories As Collection(Of Catalog.Category)) As Dictionary(Of String, String)
        Dim result As New Dictionary(Of String, String)

        If categories IsNot Nothing Then
            For Each c As Catalog.Category In categories
                result.Add(c.Bvin, c.Name)
            Next
        End If

        Return result
    End Function

#End Region

End Class