Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core

Public Class BaseStoreCategoryPage
    Inherits BaseStorePage

    Private _blockId As String = String.Empty
    Private _settingsManager As New Datalayer.ComponentSettingsManager()
    Private _productSearchCriteria As Catalog.ProductSearchCriteria = Nothing

    Private _LocalCategory As Catalog.Category = Nothing
    Private _sortOrder As Catalog.CategorySortOrder = Catalog.CategorySortOrder.None

    Public Property LocalCategory() As Catalog.Category
        Get
            If _LocalCategory Is Nothing Then
                _LocalCategory = New Catalog.Category()
            End If
            Return _LocalCategory
        End Get
        Set(ByVal value As Catalog.Category)
            _LocalCategory = value
            If Not Me.IsPostBack AndAlso String.IsNullOrEmpty(Me.Request.QueryString("sortorder")) Then
                _sortOrder = _LocalCategory.DisplaySortOrder
            End If
        End Set
    End Property

    Public Property SortOrder() As Catalog.CategorySortOrder
        Get                                    
            Return _sortOrder
        End Get
        Set(ByVal value As Catalog.CategorySortOrder)                        
            _sortOrder = value            
        End Set
    End Property

    Public Overrides ReadOnly Property DisplaysActiveCategoryTab() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Property BlockId() As String
        Get
            Return _blockId
        End Get
        Set(ByVal value As String)
            _settingsManager.BlockId = value
            _blockId = value
        End Set
    End Property

    Public Property ProductSearchCriteria() As Catalog.ProductSearchCriteria
        Get
            If Session("CategorySearchCriteria" & Me.LocalCategory.Bvin) IsNot Nothing Then
                _productSearchCriteria = DirectCast(Session("CategorySearchCriteria" & Me.LocalCategory.Bvin), Catalog.ProductSearchCriteria)
            End If

            If _productSearchCriteria IsNot Nothing Then
                If Me.LocalCategory IsNot Nothing Then
                    _productSearchCriteria.CategoryId = Me.LocalCategory.Bvin
                End If
            End If

            Return _productSearchCriteria
        End Get
        Set(ByVal value As Catalog.ProductSearchCriteria)
            _productSearchCriteria = value
            If (Me.LocalCategory IsNot Nothing) Then
                Session("CategorySearchCriteria" & Me.LocalCategory.Bvin) = value
            End If
        End Set
    End Property

    Protected ReadOnly Property SettingsManager() As Datalayer.ComponentSettingsManager
        Get
            Return _settingsManager
        End Get
    End Property

    Private Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Request.QueryString("CategoryID") IsNot Nothing Then
            LocalCategory = Catalog.Category.FindByBvin(Request.QueryString("CategoryID"))
            SessionManager.CategoryLastId = LocalCategory.Bvin
            If LocalCategory Is Nothing OrElse String.IsNullOrEmpty(LocalCategory.Bvin) Then
                EventLog.LogEvent("Category Page", "Requested Category of id " & Request.QueryString("CategoryID") & " was not found", Metrics.EventLogSeverity.Error)
                Utilities.UrlRewriter.RedirectToErrorPage(BVSoftware.Bvc5.Core.ErrorTypes.Category, Response)
            End If
        Else
            Utilities.UrlRewriter.RedirectToErrorPage(BVSoftware.Bvc5.Core.ErrorTypes.Category, Response)
        End If
    End Sub

    Protected Overrides Sub LoadCanonicalUrl()
        Dim url As String = Utilities.UrlRewriter.ResolveServerUrl(Utilities.UrlRewriter.BuildUrlForCategory(Me.LocalCategory, Me, Catalog.Category.FindAllLight()))

        ' page number
        Dim page As String = Request.QueryString("page")
        If Not String.IsNullOrEmpty(page) Then
            url += String.Format("?page={0}", page)
            'Else
            '    page = Request.QueryString("p")
            '    If Not String.IsNullOrEmpty(page) Then
            '        url += String.Format("?p={0}", page)
            '    End If
        End If

        Me.CanonicalUrl = url
    End Sub

    Protected Overrides Sub LoadFacebookOpenGraph()
        MyBase.LoadFacebookOpenGraph()

        If Me.LocalCategory IsNot Nothing Then
            ' Url
            Me.FbOpenGraph.Url = Me.CanonicalUrl

            ' Title
            Me.FbOpenGraph.Title = Me.LocalCategory.Name

            ' PageType
            Me.FbOpenGraph.PageType = "category"

            ' Description
            If String.IsNullOrEmpty(Me.FbOpenGraph.Description) Then
                If Not String.IsNullOrEmpty(Me.LocalCategory.MetaDescription) Then
                    Me.FbOpenGraph.Description = Me.LocalCategory.MetaDescription
                ElseIf Not String.IsNullOrEmpty(Me.LocalCategory.ShortDescription) Then
                    Me.FbOpenGraph.Description = Me.LocalCategory.ShortDescription
                Else
                    Me.FbOpenGraph.Description = Utilities.TextUtilities.StripHtml(Me.LocalCategory.Description)
                End If
            End If

            ' ImageUrl
            If String.IsNullOrEmpty(Me.FbOpenGraph.ImageUrl) Then
                If Not String.IsNullOrEmpty(Me.LocalCategory.ImageUrl) Then
                    Me.FbOpenGraph.ImageUrl = Utilities.UrlRewriter.CreateFullyQualifiedUrl(Me.LocalCategory.ImageUrl)
                ElseIf Not String.IsNullOrEmpty(Me.LocalCategory.BannerImageUrl) Then
                    Me.FbOpenGraph.ImageUrl = Utilities.UrlRewriter.CreateFullyQualifiedUrl(Me.LocalCategory.BannerImageUrl)
                End If
            End If
        End If
    End Sub

End Class