Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_CategoryTemplates_Bulk_Order_Quantity_List_Category
    Inherits BaseStoreCategoryPage

    Dim pricingWorkflow As BusinessRules.Workflow = Nothing

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.BlockId = "d35c7990-592a-4e94-8609-01c64f645bab"
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Category.master")
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        LoadContentColumns()
    End Sub

    Private Sub LoadContentColumns()
        If LocalCategory.PreContentColumnId <> String.Empty Then
            Me.PreContentColumn.ColumnID = LocalCategory.PreContentColumnId
            Me.PreContentColumn.LoadColumn()
        End If
        If LocalCategory.PostContentColumnId <> String.Empty Then
            Me.PostContentColumn.ColumnID = LocalCategory.PostContentColumnId
            Me.PostContentColumn.LoadColumn()
        End If
    End Sub

    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.btnAddToCart.ImageUrl = PersonalizationServices.GetThemedButton("AddToCart")
        If WebAppSettings.RedirectToCartAfterAddProduct Then
            Me.btnAddToCart.EnableCallBack = False
        Else
            Me.btnAddToCart.EnableCallBack = True
        End If
        ItemAddedToCartLabel.Text = WebAppSettings.ItemAddedToCartText

        If LocalCategory IsNot Nothing Then
            pricingWorkflow = BusinessRules.Workflow.FindByName("Product Pricing")
            LoadProducts()
        End If
    End Sub

    Protected Sub LoadProducts()
        If LocalCategory IsNot Nothing Then
            PopulateCategoryInfo()

            Dim displayProducts As Collection(Of Catalog.Product) = Nothing
            If Me.ProductSearchCriteria IsNot Nothing Then
                displayProducts = LocalCategory.FindAllProductsByCriteria(Me.ProductSearchCriteria, Me.SortOrder, WebAppSettings.DisableInventory, False)
            Else
                displayProducts = LocalCategory.FindAllProducts(Me.SortOrder, WebAppSettings.DisableInventory, False)
            End If

            If displayProducts.Count < 1 Then
                Me.btnAddToCart.Visible = False
            Else
                Me.btnAddToCart.Visible = True
            End If

            Me.DataList1.DataSource = displayProducts
            Me.DataList1.DataBind()
        End If
    End Sub

    Public Sub PopulateCategoryInfo()

        ' Page Title
        If LocalCategory.MetaTitle.Trim.Length > 0 Then
            Me.PageTitle = LocalCategory.MetaTitle
        Else
            Me.PageTitle = LocalCategory.Name
        End If

        ' Meta Keywords
        If LocalCategory.MetaKeywords.Trim.Length > 0 Then
            CType(Page, BaseStorePage).MetaKeywords = LocalCategory.MetaKeywords
        End If

        ' Meta Description
        If LocalCategory.MetaDescription.Trim.Length > 0 Then
            CType(Page, BaseStorePage).MetaDescription = LocalCategory.MetaDescription
        End If

        ' Title
        If LocalCategory.ShowTitle = False Then
            Me.lblTitle.Visible = False
        Else
            Me.lblTitle.Visible = True
            Me.lblTitle.Text = LocalCategory.Name
        End If

        'Description
        If LocalCategory.Description.Trim.Length > 0 Then
            Me.DescriptionLiteral.Text = LocalCategory.Description
        Else
            Me.DescriptionLiteral.Text = String.Empty
        End If

        If LocalCategory.BannerImageUrl.Trim.Length > 0 Then
            Me.BannerImage.Visible = True
            Me.BannerImage.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(LocalCategory.BannerImageUrl, True))
            Me.BannerImage.AlternateText = LocalCategory.Name
        Else
            Me.BannerImage.Visible = False
        End If

    End Sub

    Protected Sub DataList1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles DataList1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim p As Catalog.Product = CType(e.Row.DataItem, Catalog.Product)
            If p IsNot Nothing Then
                Dim litRecord As Literal = e.Row.FindControl("litRecord")
                If litRecord IsNot Nothing Then
                    Dim QuantityTextBox As TextBox = e.Row.FindControl("QuantityTextBox")
                    Dim detailsButton As ImageButton = DirectCast(e.Row.FindControl("DetailsImageButton"), ImageButton)

                    If p.IsKit OrElse p.GlobalProduct.HasChoicesInputsOrModifiers() Then
                        detailsButton.ImageUrl = PersonalizationServices.GetThemedButton("Details")
                        detailsButton.AlternateText = "Details"
                        detailsButton.PostBackUrl = Utilities.UrlRewriter.BuildUrlForProduct(p, Me)
                        detailsButton.CommandArgument = p.Bvin
                        detailsButton.Visible = True
                        QuantityTextBox.Visible = False
                        QuantityTextBox.Text = "0"
                    Else
                        QuantityTextBox.Visible = True
                        detailsButton.Visible = False
                    End If

                    Dim destinationLink As String = Utilities.UrlRewriter.BuildUrlForProduct(p, Me.Page.Request)

                    Dim sb As New StringBuilder

                    ' Sku
                    sb.Append("<div class=""recordsku"">")
                    sb.Append("<a href=""")
                    sb.Append(destinationLink)
                    sb.Append(""">")
                    sb.Append(p.Sku)
                    sb.Append("</a>")
                    sb.Append("</div>")

                    ' Name
                    sb.Append("<div class=""recordname"">")
                    sb.Append("<a href=""")
                    sb.Append(destinationLink)
                    sb.Append(""">")
                    sb.Append(p.ProductName)
                    sb.Append("</a>")
                    sb.Append("</div>")

                    ' Price
                    sb.Append("<div class=""recordprice"">")
                    sb.Append("<a href=""")
                    sb.Append(destinationLink)
                    sb.Append(""">")
                    sb.Append(p.GetSitePriceForDisplay(0D, pricingWorkflow))
                    sb.Append("</a>")
                    sb.Append("</div>")

                    litRecord.Text = sb.ToString
                Else
                    litRecord.Text = "Product could not be located"
                End If
            End If
        End If
    End Sub


    Protected Sub btnAddToCart_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddToCart.Click
        If Page.IsValid Then
            Dim itemsFound As Boolean = False
            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart

            For i As Integer = 0 To Me.DataList1.Rows.Count - 1
                If DataList1.Rows(i).RowType = DataControlRowType.DataRow Then
                    Dim quantityTextBox As TextBox = Me.DataList1.Rows(i).FindControl("QuantityTextBox")
                    If quantityTextBox IsNot Nothing Then
                        Dim val As Integer = 0
                        If Integer.TryParse(Me.Request.Form(quantityTextBox.UniqueID), val) Then
                            If val > 0 Then
                                itemsFound = True
				
				Dim li As New Orders.LineItem()
                                li.ProductId = CType(DataList1.DataKeys(DataList1.Rows(i).RowIndex).Value, String)
                                li.Quantity = val
                                If Not Basket.AddItem(li) Then
                                    Me.ucMessageBox.ShowError("Unable to add item to the cart.")
                                End If
                            End If
                        End If
                    End If
                End If
            Next

            If itemsFound Then
                If WebAppSettings.RedirectToCartAfterAddProduct Then
                    Response.Redirect("~/Cart.aspx")
                Else
                    ItemAddedToCartLabel.Visible = True
                    ItemAddedToCartLabel.UpdateAfterCallBack = True
                End If
            Else
                Me.ucMessageBox.ShowError("Please select the item(s) that you would like to purchase.")
            End If
        End If
    End Sub

End Class
