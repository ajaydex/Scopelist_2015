Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_ProductVolumeDiscounts
    Inherits BaseProductAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Volume Discounts"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString("id") Is Nothing Then
                Response.Redirect(DefaultCatalogPage)
            Else
                Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Request.QueryString("id"))
                If Not String.IsNullOrEmpty(p.ParentId) Then
                    Response.Redirect(String.Format("{0}?id={1}", HttpContext.Current.Request.Url.AbsolutePath, p.ParentId))
                End If
                ViewState("id") = Request.QueryString("id")
                BindGridViews()
            End If
        End If
    End Sub

    Protected Sub BindGridViews()
        VolumeDiscountsGridView.DataSource = Catalog.ProductVolumeDiscount.FindByProductId(ViewState("id"))
        VolumeDiscountsGridView.DataBind()
    End Sub

    Protected Sub NewLevelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles NewLevelImageButton.Click
        Dim quantity As Integer = 0
        Dim amount As Decimal = 0D
        If Not Integer.TryParse(QuantityTextBox.Text, quantity) Then
            MessageBox1.ShowError("Quantity must be numeric.")
        End If

        If Not Decimal.TryParse(PriceTextBox.Text, amount) Then
            MessageBox1.ShowError("Price must be a monetary amount.")
        End If

        Dim volumeDiscounts As Collection(Of Catalog.ProductVolumeDiscount) = Catalog.ProductVolumeDiscount.FindByProductId(ViewState("id"))
        Dim volumeDiscount As Catalog.ProductVolumeDiscount = Nothing
        For Each item As Catalog.ProductVolumeDiscount In volumeDiscounts
            If item.Qty = quantity Then
                volumeDiscount = item
            End If
        Next
        If volumeDiscount Is Nothing Then
            volumeDiscount = New Catalog.ProductVolumeDiscount()
        End If

        volumeDiscount.DiscountType = Catalog.ProductVolumeDiscountType.Amount
        volumeDiscount.Amount = amount
        volumeDiscount.Qty = quantity
        volumeDiscount.ProductId = ViewState("id")

        Dim result As Boolean = False
        If volumeDiscount.Bvin = String.Empty Then
            result = Catalog.ProductVolumeDiscount.Insert(volumeDiscount)
        Else
            result = Catalog.ProductVolumeDiscount.Update(volumeDiscount)
        End If
        If result Then
            MessageBox1.ShowOk("Volume Discount Updated")
            QuantityTextBox.Text = ""
            PriceTextBox.Text = ""
        Else
            MessageBox1.ShowError("Error occurred while inserting new volume discount")
        End If
        BindGridViews()
    End Sub

    Protected Sub VolumeDiscountsGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles VolumeDiscountsGridView.RowDeleting
        If Catalog.ProductVolumeDiscount.Delete(VolumeDiscountsGridView.DataKeys(e.RowIndex).Value) Then
            MessageBox1.ShowOk("Volume discount level deleted")
        Else
            MessageBox1.ShowOk("An error occurred while trying to delete the volume discount level")
        End If
        BindGridViews()
    End Sub

    Protected Overrides Function Save() As Boolean
        Return True
    End Function
End Class
