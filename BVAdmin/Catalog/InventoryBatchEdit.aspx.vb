Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_InventoryBatchEdit
    Inherits BaseAdminPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.PageTitle = "Inventory Batch Editing"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub ViewImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ViewImageButton.Click
        If Page.IsValid Then
            Dim criteria As New Catalog.ProductSearchCriteria()
            criteria.ShowProductCombinations = ChoiceCombinationsCheckBox.Checked
            ProductFilter1.LoadCriteria(criteria)
            Dim products As Collection(Of Catalog.Product) = Catalog.InternalProduct.FindByCriteria(criteria)
            Dim inventories As New Collection(Of Catalog.ProductInventory)()
            For Each item As Catalog.Product In products                
                If item.Inventory IsNot Nothing AndAlso item.Inventory.Bvin <> String.Empty Then
                    inventories.Add(item.Inventory)
                End If
            Next

            If inventories.Count > 0 Then
                For Each item As Catalog.ProductInventory In inventories
                    InventoryModifications1.PostChanges(item)
                Next

                Dim inventoriesToBind As New Collection(Of Catalog.ProductInventory)
                Dim limit As Integer = 9
                If inventories.Count < limit Then
                    limit = (inventories.Count - 1)
                    AdditionalProductsLabel.Visible = False
                Else
                    AdditionalProductsLabel.Visible = True
                    AdditionalProductsLabel.Text = "An additional " & CStr(inventories.Count - 10) & " items will also be changed"
                End If
                For i As Integer = 0 To limit
                    inventoriesToBind.Add(inventories(i))
                Next

                ProductsGridView.DataSource = inventoriesToBind
                ProductsGridView.DataKeyNames = New String() {"bvin"}
                ProductsGridView.DataBind()

                ViewState("inventories") = inventories
                BatchEditMultiView.ActiveViewIndex = 1
            Else
                MessageBox1.ShowError("No inventory data was returned based on the parameters you specified")
                MessageBox2.ShowError("No inventory data was returned based on the parameters you specified")
            End If
        End If
    End Sub

    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveImageButton.Click
        If Page.IsValid Then
            Dim inventories As Collection(Of Catalog.ProductInventory) = DirectCast(ViewState("inventories"), Collection(Of Catalog.ProductInventory))
            If inventories IsNot Nothing Then
                For Each inventory As Catalog.ProductInventory In inventories
                    Catalog.ProductInventory.Update(inventory)
                Next
                MessageBox1.ShowOk("Inventory changes have been saved to the database")
                MessageBox2.ShowOk("Inventory changes have been saved to the database")
            Else
                MessageBox1.ShowError("An error has occurred while trying to retrieve the list of inventory items")
                MessageBox2.ShowError("An error has occurred while trying to retrieve the list of inventory items")
            End If
            BatchEditMultiView.ActiveViewIndex = 0
        End If
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        BatchEditMultiView.ActiveViewIndex = 0
    End Sub

    Protected Sub ProductsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles ProductsGridView.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) AndAlso (e.Row.DataItem IsNot Nothing) Then
            Dim Inv As Catalog.ProductInventory = DirectCast(e.Row.DataItem, Catalog.ProductInventory)

            Dim productBvin As String = e.Row.Cells(0).Text
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(productBvin)
            e.Row.Cells(0).Text = p.ProductName
            If p.ParentId <> String.Empty Then
                Dim pairs As Collection(Of Catalog.ProductChoiceAndChoiceOptionPair) = Catalog.ProductChoiceAndChoiceOptionPair.FindByCombinationBvin(p.Bvin)
                Dim sb As New StringBuilder()
                For Each pair As Catalog.ProductChoiceAndChoiceOptionPair In pairs
                    sb.Append(pair.ChoiceName)
                    sb.Append(":")
                    sb.Append(pair.ChoiceOptionName)
                    sb.Append(", ")
                Next
                sb.Remove(sb.Length - 2, 2)
                e.Row.Cells(0).Text += sb.ToString()
            End If

        End If
    End Sub
End Class
