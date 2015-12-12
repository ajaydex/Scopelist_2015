Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Linq

Partial Class BVModules_Themes_Foundation4_Responsive_Pages_search
    Inherits BaseSearchPage

    Dim pricingWorkflow As BusinessRules.Workflow = Nothing

    Public Event AddToCartClicked(ByVal productId As String)

    'Properties of Single Product Display:
    Private _displayMode As Controls.SingleProductDisplayModes = BVSoftware.BVC5.Core.Controls.SingleProductDisplayModes.NoneUseCssClassPrefix
    Private _cssClassPrefix As String = String.Empty
    Private _displayName As Boolean = True
    Private _displayImage As Boolean = True
    Private _displayNewBadge As Boolean = True
    Private _displayDescription As Boolean = True
    Private _displayPrice As Boolean = True
    Private _displayAddToCartButton As Boolean = True
    Private _displaySelectedCheckBox As Boolean = False
    Private _displayQuantity As Boolean = False
    Private _remainOnPageAfterAddToCart As Boolean = True
    Private _columns As Integer = 3

    Protected Sub AddToCartClickedHandler(ByVal productId As String) Handles ProductGridDisplay.AddToCartClicked
        RaiseEvent AddToCartClicked(productId)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Pager1.ItemsPerPage = WebAppSettings.SearchItemsPerPage
        Pager2.ItemsPerPage = WebAppSettings.SearchItemsPerPage

        pricingWorkflow = BusinessRules.Workflow.FindByName("Product Pricing")

        ' If user clicked the search button, this will be bound via the SearchFired event, and we don't want to run the search twice
        If Request.Params.AllKeys.FirstOrDefault(Function(x) x.Contains("btnSearch")) Is Nothing Then
            If Request.QueryString("page") Is Nothing Then
                SessionManager.StoreSearchCriteria = Nothing
                If Me.SearchCriteria1.Keyword.Length > 0 Then
                    ' We have a search keyword but no page, new search
                    DoSearch(Me.SearchCriteria1.GetCriteria())
                End If
            End If

            If SessionManager.StoreSearchCriteria IsNot Nothing Then
                DoSearch(SessionManager.StoreSearchCriteria)
            End If
        End If

        If Not Page.IsPostBack Then
            'we run this code if the search term was passed from another page
            If Request.QueryString("keyword") IsNot Nothing Then
                Me.SearchCriteria1.Keyword = Request.QueryString("keyword")
                SessionManager.StoreSearchCriteria = Me.SearchCriteria1.GetCriteria()
                DoSearch(SessionManager.StoreSearchCriteria)
            End If
        End If

        Me.SearchCriteria1.FocusKeyword()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Search.master")
        Me.PageTitle = "Search"
    End Sub

    Private Sub DoSearch(ByVal criteria As Catalog.ProductStoreSearchCriteria)
        Dim results As Collection(Of Catalog.Product)
        Dim totalRowCount As Integer = 0
        If WebAppSettings.EnableAdvancedSearch Then
            results = Catalog.InternalProduct.StoreSearchAdvanced(criteria, SessionManager.GetCurrentUserId, False, Pager1.CurrentRow, Pager1.ItemsPerPage, totalRowCount)
        Else
            results = Catalog.InternalProduct.StoreSearch(criteria, SessionManager.GetCurrentUserId, False, Pager1.CurrentRow, Pager1.ItemsPerPage, totalRowCount)
        End If

        ' if only 1 result go directly to product page
        If results.Count = 1 AndAlso Pager1.CurrentPage = 1 AndAlso WebAppSettings.SearchRedirectToProductPage Then
            Response.Redirect(results(0).ProductURL)
        End If

        'Me.ucProductGridDisplay.DataSource = results
        ProductGridDisplay.DataSource = results
        ProductGridDisplay.Columns = _columns
        ProductGridDisplay.DisplayMode = _displayMode
        ProductGridDisplay.CssClassPrefix = _cssClassPrefix
        ProductGridDisplay.DisplayImage = _displayImage
        ProductGridDisplay.DisplayNewBadge = _displayNewBadge
        ProductGridDisplay.DisplayName = _displayName
        ProductGridDisplay.DisplayDescription = _displayDescription
        ProductGridDisplay.DisplayPrice = _displayPrice
        ProductGridDisplay.DisplayAddToCartButton = _displayAddToCartButton
        ProductGridDisplay.DisplaySelectedCheckBox = _displaySelectedCheckBox
        ProductGridDisplay.DisplayQuantity = _displayQuantity
        ProductGridDisplay.RemainOnPageAfterAddToCart = _remainOnPageAfterAddToCart
        ProductGridDisplay.BindProducts()

        Pager1.RowCount = totalRowCount
        Pager2.RowCount = totalRowCount

        If totalRowCount = 0 Then
            MessageBox1.ShowInformation(String.Format("Your search - <span class=""keyword"">{0}</span> - did not match any products.", criteria.Keyword))
        End If
    End Sub

    Protected Sub SearchCriteria1_SearchFired(ByVal sender As Object, ByVal e As BVModules_Themes_Foundation4_Responsive_Controls_SearchCriteria.SearchCriteriaEventArgs) Handles SearchCriteria1.SearchFired
        If (WebAppSettings.SearchDisableBlankSearchTerms) AndAlso (String.IsNullOrEmpty(e.Criteria.Keyword)) Then
            MessageBox1.ShowInformation("Please enter a search term.")
        Else
            Pager1.CurrentPage = 1
            Pager2.CurrentPage = 1
            SessionManager.StoreSearchCriteria = e.Criteria
            DoSearch(e.Criteria)
            Me.SearchCriteria1.FocusKeyword()
        End If
    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If Pager1.Visible Then
            Pager1.Visible = True
            Pager2.Visible = True
        End If
    End Sub
End Class
