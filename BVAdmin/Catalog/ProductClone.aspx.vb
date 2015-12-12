Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Catalog_ProductClone
    Inherits BaseProductAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("id") Is Nothing Then
            Response.Redirect("~/BVAdmin/Catalog/default.aspx")
        Else
            ViewState("id") = Request.QueryString("id")
            If Not Page.IsPostBack Then
                Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(ViewState("id"))
                If product IsNot Nothing Then
                    If Not String.IsNullOrEmpty(product.ParentId) Then
                        Response.Redirect(String.Format("{0}?id={1}", HttpContext.Current.Request.Url.AbsolutePath, product.ParentId))
                    End If
                    Me.ProductChoicesCheckBox.Checked = True
                    Me.CategoryPlacementCheckBox.Checked = True
                    Me.ImagesCheckBox.Checked = True
                    Me.NameTextBox.Text = product.ProductName & " Copy"
                    Me.SkuTextBox.Text = product.Sku & "-COPY"
                End If
            End If            
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Clone"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub CloneButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CloneButton.Click
        If Page.IsValid Then
            Save()
        End If
    End Sub

    Protected Overrides Function Save() As Boolean
        Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(ViewState("id"))
        If product IsNot Nothing Then
            If product.Bvin <> String.Empty Then
                Dim newProduct As Catalog.Product = product.Clone(ProductChoicesCheckBox.Checked, ImagesCheckBox.Checked)
                If InactiveCheckBox.Checked Then
                    newProduct.Status = Catalog.ProductStatus.Disabled
                End If
                newProduct.ProductName = NameTextBox.Text
                newProduct.Sku = SkuTextBox.Text
                If newProduct.Commit() Then
                    If product.ProductTypeId <> String.Empty Then
                        Dim productTypes As Collections.Generic.List(Of Catalog.ProductProperty) = Catalog.ProductType.FindPropertiesForType(product.ProductTypeId)
                        For Each item As Catalog.ProductProperty In productTypes
                            Dim value As String = Catalog.InternalProduct.GetPropertyValue(product.Bvin, item.Bvin)
                            Catalog.InternalProduct.SetPropertyValue(newProduct.Bvin, item.Bvin, value)
                        Next
                    End If

                    If CategoryPlacementCheckBox.Checked Then
                        If Not Catalog.InternalProduct.CopyCategoryPlacement(product.Bvin, newProduct.Bvin) Then
                            MessageBox1.ShowError("An error occurred while trying to copy the category placement.")
                        End If
                    End If

                    Response.Redirect("~/BVAdmin/Catalog/default.aspx")
                Else
                    MessageBox1.ShowError("An error occurred while trying to save the clone. Please try again.")
                    Return False
                End If
            End If
        End If
        Return True
    End Function

    Protected Sub CancelButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelButton.Click
        Response.Redirect("~/BVAdmin/Catalog/default.aspx")
    End Sub
End Class
