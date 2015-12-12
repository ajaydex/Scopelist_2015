Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_ProductEditMenu
    Inherits Content.NotifyClickControl

    Protected Sub btnContinue_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnContinue.Click
        If Me.NotifyClicked("Continue") Then
            Response.Redirect("~/BVAdmin/Catalog/Default.aspx")
        End If
    End Sub

    Protected Sub lnkGeneral_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkGeneral.Click
        If Me.NotifyClicked("GeneralOptions") Then
            RedirectPath("~/BVAdmin/Catalog/products_edit.aspx")
        End If
    End Sub

    Protected Sub lnkCustomerChoices_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkCustomerChoices.Click
        If Me.NotifyClicked("CustomerChoices") Then
            RedirectPath("~/BVAdmin/Catalog/ProductChoices.aspx")
        End If
    End Sub

    Protected Sub RedirectPath(ByVal path As String)
        If String.IsNullOrEmpty(Request.Params("id")) Then
            Dim id As String = CType(HttpContext.Current.Items("productid"), String)
            If Not String.IsNullOrEmpty(id) Then
                Response.Redirect(path & "?id=" & id)           
            End If
        Else
            Response.Redirect(path & "?id=" & Request.Params("id"))
        End If

    End Sub

    Protected Sub lnkCustomerInput_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkFileDownloads.Click
        If Me.NotifyClicked("CustomerInput") Then
            RedirectPath("~/BVAdmin/Catalog/FileDownloads.aspx")
        End If
    End Sub

    Protected Sub lnkProductReviews_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkProductReviews.Click
        If Me.NotifyClicked("ProductReviews") Then
            RedirectPath("~/BVAdmin/Catalog/Products_Edit_Reviews.aspx")
        End If
    End Sub

    Protected Sub lnkUpSellCrossSell_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkUpSellCrossSell.Click
        If Me.NotifyClicked("ProductUpSellsCrossSells") Then
            RedirectPath("~/BVAdmin/Catalog/ProductUpSellCrossSell.aspx")
        End If
    End Sub

    Protected Sub lnkAdditionalImages_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAdditionalImages.Click
        If Me.NotifyClicked("AdditionalImages") Then
            RedirectPath("~/BVAdmin/Catalog/Products_Edit_Images.aspx")
        End If
    End Sub

    Protected Sub lnkVolumeDiscounts_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkVolumeDiscounts.Click
        If Me.NotifyClicked("VolumeDiscounts") Then
            RedirectPath("~/BVAdmin/Catalog/ProductVolumeDiscounts.aspx")
        End If
    End Sub

    Protected Sub lnkInventory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkInventory.Click
        If Me.NotifyClicked("Inventory") Then
            RedirectPath("~/BVAdmin/Catalog/Products_Edit_Inventory.aspx")
        End If
    End Sub

    Protected Sub lnkCustomerChoicesEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkCustomerChoicesEdit.Click
        If Me.NotifyClicked("CustomerChoicesEdit") Then
            RedirectPath("~/BVAdmin/Catalog/ProductCombinationsEdit.aspx")
        End If
    End Sub

    Protected Sub lnkCategories_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkCategories.Click
        If Me.NotifyClicked("Categories") Then
            RedirectPath("~/BVAdmin/Catalog/Products_Edit_Categories.aspx")
        End If
    End Sub

    Protected Sub lnkKit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkKit.Click
        If Me.NotifyClicked("Kits") Then
            RedirectPath("~/BVAdmin/Catalog/Products_Edit_KitGroups.aspx")
        End If
    End Sub
End Class
