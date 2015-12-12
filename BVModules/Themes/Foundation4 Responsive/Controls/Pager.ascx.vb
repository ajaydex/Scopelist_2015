Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_Pager
    Inherits System.Web.UI.UserControl

    Public Event PageChange(ByVal source As Object, ByVal e As Controls.PageChangingEventArgs)

    Private _pages As Integer = 0
    Private _rowCount As Integer = 0
    Private _itemsPerPage As Integer = 10

    Private _page As Integer = Integer.MinValue

    Private _AllCats As Collection(Of Catalog.Category) = Catalog.Category.FindAllLight()

    Public ReadOnly Property CurrentRow() As Integer
        Get
            Dim val As Integer = ((CurrentPage - 1) * ItemsPerPage)
            Return val
        End Get
    End Property

    Public Property CurrentPage() As Integer
        Get
            If _page <> Integer.MinValue Then
                Return _page
            Else
                Dim page As String = Request.QueryString("page")
                If page IsNot Nothing Then
                    Dim currPage As Integer = CInt(page)
                    Return CInt(page)
                Else
                    Return 1
                End If
            End If
        End Get
        Set(ByVal value As Integer)
            _page = value
        End Set
    End Property

    Public Property RowCount() As Integer
        Get
            Return _rowCount
        End Get
        Set(ByVal value As Integer)
            _rowCount = value
            Me.InitializeButtons()
        End Set
    End Property

    Public Property ItemsPerPage() As Integer
        Get
            Return _itemsPerPage
        End Get
        Set(ByVal value As Integer)
            _itemsPerPage = value
        End Set
    End Property

    Public ReadOnly Property GetPageCount() As Integer
        Get
            Try
                If _pages = 0 Then
                    _pages = Me.RowCount \ Me.ItemsPerPage
                    If Me.RowCount Mod Me.ItemsPerPage > 0 Then
                        _pages += 1
                    End If
                End If
                Return _pages
            Catch
                Return 0
            End Try
        End Get
    End Property

    Public Sub InitializeButtons()
        If Me.GetPageCount <= 1 Then
            Me.Visible = False
        Else
            Me.Visible = True
        End If

        Dim currentUrl As String = String.Empty
        Dim nextUrl As String = String.Empty
        Dim prevUrl As String = String.Empty
        Dim sortOrder As String = String.Empty
        If TypeOf Me.Page Is BaseStoreCategoryPage Then
            Dim CategoryPage As BaseStoreCategoryPage = DirectCast(Me.Page, BaseStoreCategoryPage)
            If CategoryPage.LocalCategory IsNot Nothing Then
                currentUrl = Utilities.UrlRewriter.BuildUrlForCategory(CategoryPage.LocalCategory, CategoryPage, _AllCats)
                sortOrder = CategoryPage.SortOrder
            End If
        ElseIf TypeOf Me.Page Is BaseSearchPage Then
            currentUrl = WebAppSettings.SiteStandardRoot.TrimEnd("/"c) & "/search.aspx"
            If Not String.IsNullOrEmpty(Request.QueryString("keyword")) Then
                currentUrl &= "?keyword=" & Request.QueryString("keyword")
            End If
        End If

        If Not String.IsNullOrEmpty(currentUrl) Then
            Dim urlSeperator As String = String.Empty
            If currentUrl.Contains("?") Then
                If Not String.IsNullOrEmpty(sortOrder) Then
                    urlSeperator = "&sortorder=" & sortOrder & "&page="
                Else
                    urlSeperator = "&page="
                End If
            Else
                If Not String.IsNullOrEmpty(sortOrder) Then
                    urlSeperator = "?sortorder=" & sortOrder & "&page="
                Else
                    urlSeperator = "?page="
                End If
            End If

            If Me.CurrentPage = 1 Then
                FirstListItem.InnerText = Content.SiteTerms.GetTerm("First")
                PreviousListItem.InnerText = Content.SiteTerms.GetTerm("Previous")
                Me.FirstListItem.Attributes.Add("class", "disabled")
                Me.PreviousListItem.Attributes.Add("class", "disabled")
            Else
                Dim FirstHyperLink As New HyperLink()
                FirstHyperLink.Text = Content.SiteTerms.GetTerm("First")
                FirstHyperLink.NavigateUrl = currentUrl & urlSeperator & "1"
                FirstListItem.Controls.Clear()
                FirstListItem.Controls.Add(FirstHyperLink)

                Dim PreviousHyperLink As New HyperLink()
                PreviousHyperLink.Text = Content.SiteTerms.GetTerm("Previous")
                PreviousHyperLink.NavigateUrl = currentUrl & urlSeperator & (Me.CurrentPage - 1).ToString()
                PreviousListItem.Controls.Clear()
                PreviousListItem.Controls.Add(PreviousHyperLink)

                prevUrl = PreviousHyperLink.NavigateUrl

                Me.FirstListItem.Attributes.Remove("class")
                Me.PreviousListItem.Attributes.Remove("class")
            End If

            If Me.CurrentPage = Me.GetPageCount Then
                LastListItem.InnerText = Content.SiteTerms.GetTerm("Last")
                NextListItem.InnerText = Content.SiteTerms.GetTerm("Next")
                Me.LastListItem.Attributes.Add("class", "disabled")
                Me.NextListItem.Attributes.Add("class", "disabled")
            Else
                Dim LastHyperLink As New HyperLink()
                LastHyperLink.Text = Content.SiteTerms.GetTerm("Last")
                LastHyperLink.NavigateUrl = currentUrl & urlSeperator & (Me.GetPageCount).ToString()
                LastListItem.Controls.Clear()
                LastListItem.Controls.Add(LastHyperLink)

                Dim NextHyperLink As New HyperLink()
                NextHyperLink.Text = Content.SiteTerms.GetTerm("Next")
                NextHyperLink.NavigateUrl = currentUrl & urlSeperator & (Me.CurrentPage + 1).ToString()
                NextListItem.Controls.Clear()
                NextListItem.Controls.Add(NextHyperLink)

                nextUrl = NextHyperLink.NavigateUrl

                Me.LastListItem.Attributes.Remove("class")
                Me.NextListItem.Attributes.Remove("class")
            End If

            Dim pageSet As Integer = ((Me.CurrentPage - 1) \ 10)
            Dim startPageNumber As Integer = (pageSet * 10) + 1

            PagesPlaceHolder.Controls.Clear()
            For i As Integer = 1 To 11
                If (startPageNumber + (i - 1)) <= Me.GetPageCount Then
                    Dim li As HtmlGenericControl = New HtmlGenericControl("li")
                    PagesPlaceHolder.Controls.Add(li)
                    If i <= 10 Then
                        Dim lb As New HyperLink()
                        lb.ID = "HyperLink" + i.ToString()
                        lb.Text = (startPageNumber + (i - 1)).ToString()

                        Dim url As String = currentUrl & urlSeperator & (startPageNumber + (i - 1)).ToString()
                        lb.NavigateUrl = url
                        li.Controls.Add(lb)

                        If lb.Text = Me.CurrentPage.ToString() Then
                            lb.Enabled = False
                            li.Attributes.Add("class", "current")
                        Else
                            lb.Enabled = True
                            li.Attributes.Remove("class")
                        End If
                    Else
                        Dim lb As New HyperLink()
                        lb.ID = "HyperLink" + i.ToString()
                        lb.Text = "..."
                        Dim url As String = currentUrl
                        lb.NavigateUrl = url & urlSeperator & (startPageNumber + (i - 1)).ToString()
                        li.Controls.Add(lb)
                    End If
                End If
            Next

            ' add rel="next" and rel="prev" tags
            If Me.Page IsNot Nothing AndAlso Me.Page.Header IsNot Nothing Then
                If Me.Page.Header.FindControl("RelNext") Is Nothing Then
                    If Not String.IsNullOrEmpty(nextUrl) Then
                        Dim nextLink As New HtmlLink()
                        nextLink.ID = "RelNext"
                        nextLink.EnableViewState = False
                        nextLink.Href = nextUrl
                        nextLink.Attributes.Add("rel", "next")

                        Try
                            Me.Page.Header.Controls.Add(nextLink)
                        Catch ex As Exception
                            ' do nothing
                        End Try
                    End If
                End If

                If Me.Page.Header.FindControl("RelPrev") Is Nothing Then
                    If Not String.IsNullOrEmpty(prevUrl) Then
                        Dim prevLink As New HtmlLink()
                        prevLink.ID = "RelPrev"
                        prevLink.EnableViewState = False
                        prevLink.Href = prevUrl
                        prevLink.Attributes.Add("rel", "prev")

                        Try
                            Me.Page.Header.Controls.Add(prevLink)
                        Catch ex As Exception
                            ' do nothing
                        End Try
                    End If
                End If
            End If
        End If
    End Sub

End Class
