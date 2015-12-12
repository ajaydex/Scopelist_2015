Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_Products_Edit_Inventory
    Inherits BaseProductAdminPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.PageTitle = "Edit Product Inventory"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Catalog
            If Request.QueryString("id") IsNot Nothing Then
                Me.bvinfield.Value = Request.QueryString("id")
                Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Me.bvinfield.Value)
                If Not String.IsNullOrEmpty(p.ParentId) Then
                    Response.Redirect(String.Format("{0}?id={1}", HttpContext.Current.Request.Url.AbsolutePath, p.ParentId))
                End If
            End If       
            LoadInventory()
            SetOutOfStockMode()
        End If
        If WebAppSettings.DisableInventory Then
            InventoryDisabledLabel.Visible = True
        Else
            InventoryDisabledLabel.Visible = False
        End If
    End Sub

    Private Sub SetOutOfStockMode()
        Dim prod As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(Me.bvinfield.Value)
        If prod IsNot Nothing Then
            If Me.OutOfStockModeField.Items.FindByValue(prod.OutOfStockMode) IsNot Nothing Then
                Me.OutOfStockModeField.ClearSelection()
                Me.OutOfStockModeField.Items.FindByValue(prod.OutOfStockMode).Selected = True
            End If
        End If        
    End Sub

    Private Sub LoadInventory()
        Dim localProduct As Catalog.Product = Catalog.InternalProduct.FindByBvin(Me.bvinfield.Value)
        Dim edits As Collection(Of Catalog.Product) = Catalog.InternalProduct.FindChildren(localProduct.Bvin)
        If edits.Count = 0 Then
            edits.Add(localProduct)
        End If
        Me.EditsGridView.DataSource = edits
        Me.EditsGridView.DataBind()

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("~/BVAdmin/Catalog/Products_Edit.aspx?id=" & Request.QueryString("id"))
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        Me.MessageBox1.ClearMessage()
        If Me.Save() Then
            Me.MessageBox1.ShowOk("Changes Saved!")
        End If
        LoadInventory()
    End Sub

    Protected Overrides Function Save() As Boolean
        Dim result As Boolean = False

        Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(Me.bvinfield.Value)

        ' Make Sure Parent (if one) has inventory object
        If product.Inventory Is Nothing OrElse String.IsNullOrEmpty(product.Inventory.Bvin) Then
            Dim inv As New Catalog.ProductInventory()
            inv.ProductBvin = Me.bvinfield.Value
            If Catalog.ProductInventory.Insert(inv) Then
                ' update status & quantities
                product.SetAvailableQuantity(0)
            End If
        End If

        product.OutOfStockMode = Me.OutOfStockModeField.SelectedValue

        Catalog.InternalProduct.Update(product)

        ' Process each variant/product row
        For Each row As GridViewRow In Me.EditsGridView.Rows
            If row.RowType = DataControlRowType.DataRow Then
                ProcessRow(row)
            End If
        Next

        result = True
        Return result
    End Function

    Private Sub ProcessRow(ByVal row As GridViewRow)
        Dim productBvin As String = CStr(Me.EditsGridView.DataKeys(row.RowIndex).Value)
        Dim localProduct As Catalog.Product = Catalog.InternalProduct.FindByBvin(productBvin)

        Dim AdjustmentField As TextBox = row.FindControl("AdjustmentField")
        Dim AdjustmentModeField As DropDownList = row.FindControl("AdjustmentModeField")
        Dim OutOfStockPointField As TextBox = row.FindControl("OutOfStockPointField")
        Dim ReorderPointField As TextBox = row.FindControl("ReorderPointField")
        Dim chkTrackInventory As CheckBox = row.FindControl("chkTrackInventory")

        If chkTrackInventory IsNot Nothing Then
            ' only update product object if needed
            If localProduct.TrackInventory <> chkTrackInventory.Checked Then
                localProduct.TrackInventory = chkTrackInventory.Checked
                Catalog.InternalProduct.Update(localProduct)
            End If
        End If

        Dim oldQuantityAvailable As Decimal = localProduct.Inventory.QuantityAvailable
        Dim oldQuantityOutOfStockPoint As Decimal = localProduct.Inventory.QuantityOutOfStockPoint
        Dim oldReorderPoint As Decimal = localProduct.Inventory.ReorderPoint

        If AdjustmentModeField IsNot Nothing AndAlso AdjustmentField IsNot Nothing Then
            Dim qty As Decimal = 0D
            If Decimal.TryParse(AdjustmentField.Text, qty) Then
                Select Case AdjustmentModeField.SelectedValue
                    Case 1 ' Add
                        localProduct.Inventory.QuantityAvailable += qty
                    Case 2 ' Subtract
                        localProduct.Inventory.QuantityAvailable -= qty
                    Case 3 ' Set To
                        localProduct.Inventory.QuantityAvailable = qty
                    Case Else ' Add
                        localProduct.Inventory.QuantityAvailable += qty
                End Select
            End If
        End If
        If OutOfStockPointField IsNot Nothing Then
            Decimal.TryParse(OutOfStockPointField.Text, localProduct.Inventory.QuantityOutOfStockPoint)
        End If
        If ReorderPointField IsNot Nothing Then
            Decimal.TryParse(ReorderPointField.Text, localProduct.Inventory.ReorderPoint)
        End If

        If String.IsNullOrEmpty(localProduct.Inventory.Bvin) Then
            localProduct.Inventory.ProductBvin = productBvin
            Catalog.ProductInventory.Insert(localProduct.Inventory)
        Else
            ' only update inventory if needed
            If oldQuantityAvailable <> localProduct.Inventory.QuantityAvailable _
                OrElse oldQuantityOutOfStockPoint <> localProduct.Inventory.QuantityOutOfStockPoint _
                OrElse oldReorderPoint <> localProduct.Inventory.ReorderPoint Then
                Catalog.ProductInventory.Update(localProduct.Inventory)
            End If
        End If
    End Sub

    Protected Sub EditsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles EditsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim rowP As Catalog.Product = CType(e.Row.DataItem, Catalog.Product)
            If rowP IsNot Nothing Then                
                Dim lblStatus As Label = e.Row.FindControl("lblStatus")
                Dim lblQuantityAvailable As Label = e.Row.FindControl("lblQuantityAvailable")
                Dim lblQuantityAvailableForSale As Label = e.Row.FindControl("lblQuantityAvailableForSale")
                Dim lblQuantityReserved As Label = e.Row.FindControl("lblQuantityReserved")
                Dim OutOfStockPointField As TextBox = e.Row.FindControl("OutOfStockPointField")
                Dim ReorderPointField As TextBox = e.Row.FindControl("ReorderPointField")
                Dim chkTrackInventory As CheckBox = e.Row.FindControl("chkTrackInventory")

                If lblStatus IsNot Nothing Then
                    lblStatus.Text = Utilities.EnumToString.ProductInventoryStatus(rowP.InventoryStatus)
                End If
                If lblQuantityAvailable IsNot Nothing Then
                    If rowP.QuantityAvailable = 0 Then
                        lblQuantityAvailable.Text = "0"
                    Else
                        lblQuantityAvailable.Text = rowP.QuantityAvailable.ToString("#")
                    End If
                End If
                If lblQuantityAvailableForSale IsNot Nothing Then
                    If rowP.QuantityAvailableForSale = 0 Then
                        lblQuantityAvailableForSale.Text = "0"
                    Else
                        lblQuantityAvailableForSale.Text = rowP.QuantityAvailableForSale.ToString("#")
                    End If
                End If
                If lblQuantityReserved IsNot Nothing Then
                    If rowP.QuantityReserved = 0 Then
                        lblQuantityReserved.Text = "0"
                    Else
                        lblQuantityReserved.Text = rowP.QuantityReserved.ToString("#")
                    End If
                End If
                If OutOfStockPointField IsNot Nothing Then
                    If rowP.QuantityOutOfStockPoint = 0 Then
                        OutOfStockPointField.Text = "0"
                    Else
                        OutOfStockPointField.Text = rowP.QuantityOutOfStockPoint.ToString("#")
                    End If
                End If
                If ReorderPointField IsNot Nothing Then
                    If rowP.InventoryReorderPoint <= 0 Then
                        ReorderPointField.Text = "0"
                    Else
                        ReorderPointField.Text = rowP.InventoryReorderPoint.ToString("#")
                    End If
                End If
                If chkTrackInventory IsNot Nothing Then
                    chkTrackInventory.Checked = rowP.TrackInventory
                End If                
            End If
        End If
    End Sub

End Class
