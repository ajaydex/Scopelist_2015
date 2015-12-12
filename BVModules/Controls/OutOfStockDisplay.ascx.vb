Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_OutOfStockDisplay
    Inherits System.Web.UI.UserControl

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        Dim available As Boolean = True
        If HttpContext.Current.Items("BVSelectedCombinationValid") IsNot Nothing Then
            available = CBool(HttpContext.Current.Items("BVSelectedCombinationValid"))
        End If

        If Not available Then
            Me.OutOfStockLiteral.Text = Content.SiteTerms.GetTerm("ProductCombinationNotAvailable")
        Else
            Me.OutOfStockLiteral.Text = String.Empty
            If Not WebAppSettings.DisableInventory Then
                If TypeOf Me.Page Is BaseStoreProductPage Then
                    Dim prodPage As BaseStoreProductPage = DirectCast(Me.Page, BaseStoreProductPage)
                    Dim prod As Catalog.Product = prodPage.LocalProduct
                    Select Case prod.InventoryStatus
                        Case Catalog.ProductInventoryStatus.NotAvailable
                            Me.OutOfStockLiteral.Visible = True
                            If prodPage.LocalProduct.OutOfStockMode = Catalog.ProductInventoryMode.OutOfStockAllowOrders Then
                                Me.OutOfStockLiteral.Text = Content.SiteTerms.GetTerm("OutOfStockAllowPurchase")
                            ElseIf prodPage.LocalProduct.OutOfStockMode = Catalog.ProductInventoryMode.OutOfStockDisallowOrders Then
                                'Commented By kamala
                                'Me.OutOfStockLiteral.Text = Content.SiteTerms.GetTerm("OutOfStockNoPurchase")
                                'End
                                Me.OutOfStockLiteral.Text = "<p class='mail' style='width:312px;'><br />E-mail <a href='mailto:sales@scopelist.com' style='font-size:135%'>sales@scopelist.com</a><br />or Call <span style='font-size:120%'>(866) 271-7212</span> to Back Order</p>"
                            ElseIf prodPage.LocalProduct.OutOfStockMode = Catalog.ProductInventoryMode.RemoveFromStore Then
                                ' Me.OutOfStockLiteral.Text = Content.SiteTerms.GetTerm("OutOfStockNoPurchase")
                                Me.OutOfStockLiteral.Text = "<p class='mail' style='width:312px;'><br />E-mail <a href='mailto:sales@scopelist.com' style='font-size:135%'>sales@scopelist.com</a><br />or Call <span style='font-size:120%'>(866) 271-7212</span> to Back Order</p>"
                            End If
                        Case Else
                            If prodPage.LocalProduct.OutOfStockMode = Catalog.ProductInventoryMode.OutOfStockAllowOrders Then
                                If (prod.QuantityAvailableForSale <= 0) AndAlso (prodPage.LocalProduct.Inventory.Bvin <> String.Empty) Then
                                    Me.OutOfStockLiteral.Visible = True
                                    Me.OutOfStockLiteral.Text = Content.SiteTerms.GetTerm("OutOfStockAllowPurchase")
                                Else
                                    Me.OutOfStockLiteral.Visible = False
                                End If
                            Else
                                Me.OutOfStockLiteral.Visible = False
                            End If
                    End Select
                End If
            End If
        End If
    End Sub
End Class
