Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_Inventory
    Inherits BaseAdminPage

    Private criteriaSessionKey As String = "InventoryCriteria"

    Private Enum Mode
        FilterView = 0
        EditView = 1
    End Enum

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Inventory Edit"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.InventoryDisabledLabel.Visible = WebAppSettings.DisableInventory

        If Not Page.IsPostBack Then
            Me.GridView1.PageSize = WebAppSettings.RowsPerPage
            GoPressed(SimpleProductFilter.LoadProducts())
        End If
    End Sub

    Protected Sub GoPressed(ByVal criteria As Catalog.ProductSearchCriteria) Handles SimpleProductFilter.GoPressed, SimpleProductFilter.FilterChanged
        criteria.ShowProductCombinations = True
        Me.Session(criteriaSessionKey) = criteria
        'GridView1.DataSource = Catalog.Product.FindByCriteria(criteria)
        GridView1.DataBind()
        GridView1.PageIndex = 0
        topLabel.Visible = (GridView1.PageCount > 1)
        BottomLabel.Visible = (GridView1.PageCount > 1)
        SaveChangesImageButton.Visible = (GridView1.PageCount > 0)
    End Sub

    Protected Sub SaveChangesImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveChangesImageButton.Click
        If Page.IsValid Then
            SaveChanges()
        End If
    End Sub

    Private Sub SaveChanges()
        Dim inventories As New Collection(Of Catalog.ProductInventory)()
        For Each row As GridViewRow In Me.GridView1.Rows
            If row.RowType = DataControlRowType.DataRow Then
                Dim trackInventory As Boolean = DirectCast(row.FindControl("TrackInventoryCheckBox"), CheckBox).Checked
                Dim mods As ASP.bvadmin_controls_inventorymodifications_ascx = DirectCast(row.FindControl("InventoryModifications"), ASP.bvadmin_controls_inventorymodifications_ascx)
                Dim key As String = Me.GridView1.DataKeys(row.RowIndex).Value
                Dim prod As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(key)
                If trackInventory Then
                    If mods.PostChanges(prod.Inventory) OrElse (Not prod.TrackInventory) Then
                        prod.Inventory.ProductBvin = prod.Bvin  ' make sure new inventory objects are associated with product
                        inventories.Add(prod.Inventory)
                    End If

                    ' enable inventory tracking for product, if needed
                    If Not prod.TrackInventory Then
                        prod.TrackInventory = True
                        Catalog.InternalProduct.Update(prod)
                    End If
                ElseIf prod.TrackInventory Then
                    ' disable inventory tracking for product
                    prod.TrackInventory = False
                    Catalog.InternalProduct.Update(prod)
                End If
            End If
        Next
        For Each item As Catalog.ProductInventory In inventories
            If String.IsNullOrEmpty(item.Bvin) Then
                Catalog.ProductInventory.Insert(item)
            Else
                Catalog.ProductInventory.Update(item)
            End If
        Next
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim product As Catalog.Product = DirectCast(e.Row.DataItem, Catalog.Product)
            DirectCast(e.Row.FindControl("QuantityAvailableLabel"), Label).Text = product.QuantityAvailable.ToString("0")
            DirectCast(e.Row.FindControl("OutOfStockPointLabel"), Label).Text = product.QuantityOutOfStockPoint.ToString("0")
            DirectCast(e.Row.FindControl("QuantityReservedLabel"), Label).Text = product.QuantityReserved.ToString("0")
            DirectCast(e.Row.FindControl("TrackInventoryCheckBox"), CheckBox).Checked = product.TrackInventory
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource1.Selecting
        If e.ExecutingSelectCount Then
            e.InputParameters("rowCount") = HttpContext.Current.Items("RowCount")
            HttpContext.Current.Items("RowCount") = Nothing
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If e.OutputParameters("RowCount") IsNot Nothing Then
            HttpContext.Current.Items("RowCount") = e.OutputParameters("RowCount")
        End If
    End Sub

    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        SaveChanges()
    End Sub

End Class