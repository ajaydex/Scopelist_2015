Imports BVSoftware.Bvc5.Core
Imports System.Xml.Serialization
Imports System.Collections.ObjectModel


Partial Class BVAdmin_Catalog_ProductBatchEdit
    Inherits BaseAdminPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.PageTitle = "Product Batch Editing"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub ViewImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ViewImageButton.Click
        If Page.IsValid Then
            Dim criteria As New Catalog.ProductSearchCriteria()
            criteria.ShowProductCombinations = ChoiceCombinationsCheckBox.Checked
            ProductFilter1.LoadCriteria(criteria)
            criteria.SpecialProductTypeOne = Catalog.SpecialProductTypes.Normal            
            Dim products As Collection(Of Catalog.Product) = Catalog.InternalProduct.FindByCriteria(criteria)
            If products.Count > 0 Then
                For Each item As Catalog.Product In products
                    ProductModifications1.PostChangesToProduct(item)
                Next

                Dim productsToBind As New Collection(Of Catalog.Product)
                Dim limit As Integer = 10
                If products.Count < limit Then
                    limit = products.Count
                    AdditionalProductsLabel.Visible = False
                Else
                    AdditionalProductsLabel.Visible = True
                    AdditionalProductsLabel.Text = "An additional " & CStr(products.Count - 10) & " items will also be changed"
                End If

                For i As Integer = 0 To limit - 1
                    productsToBind.Add(products(i))
                Next

                ProductsGridView.DataSource = productsToBind
                ProductsGridView.DataKeyNames = New String() {"bvin"}
                ProductsGridView.DataBind()

                ViewState("products") = products
                BatchEditMultiView.ActiveViewIndex = 1
            Else
                MessageBox1.ShowError("No products were returned based on the parameters you specified")
                MessageBox2.ShowError("No products were returned based on the parameters you specified")
            End If
        End If
    End Sub

    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveImageButton.Click
        If Page.IsValid Then
            Dim products As Collection(Of Catalog.Product) = ViewState("products")
            If products IsNot Nothing Then
                For Each product As Catalog.Product In products
                    product.GlobalProduct.Commit()
                Next
                MessageBox1.ShowOk("Product changes have been saved to the database")
                MessageBox2.ShowOk("Product changes have been saved to the database")
            Else
                MessageBox1.ShowError("An error has occurred while trying to retrieve the list of products")
                MessageBox2.ShowError("An error has occurred while trying to retrieve the list of products")
            End If
            BatchEditMultiView.ActiveViewIndex = 0
        End If
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        BatchEditMultiView.ActiveViewIndex = 0
    End Sub

    Protected Sub ProductsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles ProductsGridView.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) AndAlso (e.Row.DataItem IsNot Nothing) Then
            Dim product As Catalog.Product = DirectCast(e.Row.DataItem, Catalog.Product)
            For Each cell As TableCell In e.Row.Cells
                If product.ParentId <> String.Empty Then
                    Dim pairs As Collection(Of Catalog.ProductChoiceAndChoiceOptionPair) = Catalog.ProductChoiceAndChoiceOptionPair.FindByCombinationBvin(product.Bvin)
                    Dim sb As New StringBuilder()
                    For Each pair As Catalog.ProductChoiceAndChoiceOptionPair In pairs
                        sb.Append(pair.ChoiceName)
                        sb.Append(":")
                        sb.Append(pair.ChoiceOptionName)
                        sb.Append(", ")
                    Next
                    sb.Remove(sb.Length - 2, 2)
                    e.Row.Cells(2).Text = sb.ToString()
                End If
            Next
        End If
    End Sub
End Class
