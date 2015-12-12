Imports BVSoftware.Bvc5.Core
Imports System.Linq
Imports System.Collections.ObjectModel
Imports BVModules_Controls_SearchCriteria
Imports System.Collections.Generic

Partial Class Search
    Inherits BaseSearchPage

    Dim pricingWorkflow As BusinessRules.Workflow = Nothing

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Pager1.ItemsPerPage = WebAppSettings.SearchItemsPerPage
        Pager2.ItemsPerPage = WebAppSettings.SearchItemsPerPage

        DataList1.RepeatColumns = WebAppSettings.SearchItemsPerRow
        DataList1.RepeatDirection = RepeatDirection.Horizontal

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
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Product.master")
        Me.PageTitle = "Search"
    End Sub

    Private Sub DoSearch(ByVal criteria As Catalog.ProductStoreSearchCriteria)
        'Dim results As Collection(Of Catalog.Product)
        'Dim totalRowCount As Integer = 0
        'If WebAppSettings.EnableAdvancedSearch Then
        '    results = Catalog.InternalProduct.StoreSearchAdvanced(criteria, SessionManager.GetCurrentUserId, False, Pager1.CurrentRow, Pager1.ItemsPerPage, totalRowCount)
        'Else
        '    results = Catalog.InternalProduct.StoreSearch(criteria, SessionManager.GetCurrentUserId, False, Pager1.CurrentRow, Pager1.ItemsPerPage, totalRowCount)
        'End If

        '' if only 1 result go directly to product page
        'If results.Count = 1 AndAlso Pager1.CurrentPage = 1 AndAlso WebAppSettings.SearchRedirectToProductPage Then
        '    Response.Redirect(results(0).ProductURL)
        'End If

        'DataList1.DataSource = results
        'DataList1.DataBind()

        'Pager1.RowCount = totalRowCount
        'Pager2.RowCount = totalRowCount

        'If totalRowCount = 0 Then
        '    MessageBox1.ShowInformation(String.Format("Your search - <span class=""keyword"">{0}</span> - did not match any products.", criteria.Keyword))
        'End If

        Dim allresults As List(Of Catalog.Product)
        Dim results As List(Of Catalog.Product)
        Dim totalRowCount As Integer = 0

        If WebAppSettings.EnableAdvancedSearch Then
            allresults = Catalog.InternalProduct.StoreSearchAdvanced(criteria, SessionManager.GetCurrentUserId, False, 0, 1000, totalRowCount).ToList()
        Else
            allresults = Catalog.InternalProduct.StoreSearch(criteria, SessionManager.GetCurrentUserId, False, 0, 1000, totalRowCount).ToList()
        End If

        Select Case WebAppSettings.EnableAdvancedSearch
            Case 1
                results = allresults.Skip(Pager1.CurrentRow).Take(Pager1.ItemsPerPage).ToList()
            Case Else
                results = allresults.OrderByDescending(Function(p) p.IsInStock).ThenByDescending(Function(p) p.CreationDate).Skip(Pager1.CurrentRow).Take(Pager1.ItemsPerPage).ToList()
        End Select

        If results.Count() = 0 Then
            EmptyTemplate.Visible = True
            dgvResults.Visible = False
        Else
            EmptyTemplate.Visible = False
            dgvResults.Visible = True
        End If

        DataList1.DataSource = results
        DataList1.DataBind()

        Pager1.RowCount = totalRowCount
        Pager2.RowCount = totalRowCount

        If totalRowCount = 0 Then
            MessageBox1.ShowInformation(String.Format("Your search - <span class=""keyword"">{0}</span> - did not match any products.", criteria.Keyword))
        End If
    End Sub

    Protected Sub SearchCriteria1_SearchFired(ByVal sender As Object, ByVal e As SearchCriteriaEventArgs) Handles SearchCriteria1.SearchFired
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

    Protected Sub DataList1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim p As Catalog.Product = CType(e.Item.DataItem, Catalog.Product)
            If p IsNot Nothing Then
                Dim destinationLink As String = Utilities.UrlRewriter.BuildUrlForProduct(p, Me.Page.Request)
                Dim imageUrl As String
                imageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(p.ImageFileSmall, True))

                DirectCast(e.Item.FindControl("ImageAnchor"), HtmlAnchor).HRef = destinationLink
                Dim ProductImage As HtmlImage = DirectCast(e.Item.FindControl("ProductImage"), HtmlImage)
                ProductImage.Src = imageUrl
                ProductImage.Alt = p.ProductName & " " & p.Sku

                ' Force Image Size
                ViewUtilities.ForceImageSize(ProductImage, p.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)

                Dim NameAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("NameAnchor"), HtmlAnchor)
                NameAnchor.HRef = destinationLink
                NameAnchor.InnerHtml = p.ProductName

                If (NameAnchor.InnerHtml.Length > 40) Then
                    NameAnchor.InnerHtml = NameAnchor.InnerHtml.Substring(0, 40)
                End If

                NameAnchor.InnerHtml &= ".."

                Dim SkuAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("SkuAnchor"), HtmlAnchor)
                SkuAnchor.HRef = destinationLink
                SkuAnchor.InnerText = p.Sku

                'Commented by ven because converting link to lable

                'Dim PriceAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("PriceAnchor"), HtmlAnchor)
                'PriceAnchor.HRef = destinationLink
                'PriceAnchor.InnerText = p.GetSitePriceForDisplay(0D, pricingWorkflow)

                'End comment

                'Editing by ven lable code.
                Dim PriceAnchor As Label = DirectCast(e.Item.FindControl("PriceAnchor"), Label)
                PriceAnchor.Text = p.GetSitePriceForDisplay(0D, pricingWorkflow)
                'End Editing

            Else
                Dim NameAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("NameAnchor"), HtmlAnchor)
                NameAnchor.InnerHtml = "Product Could Not Be Located."
            End If
        End If
    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If Pager1.Visible Then
            Pager1.Visible = True
            Pager2.Visible = True
        End If
    End Sub
End Class
