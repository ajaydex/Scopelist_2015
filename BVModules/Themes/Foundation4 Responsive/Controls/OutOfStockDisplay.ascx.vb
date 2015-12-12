Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_OutOfStockDisplay
    Inherits System.Web.UI.UserControl

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        Me.OutOfStockPanel.Visible = False

        Dim available As Boolean = True
        If HttpContext.Current.Items("BVSelectedCombinationValid") IsNot Nothing Then
            available = CBool(HttpContext.Current.Items("BVSelectedCombinationValid"))
        End If

        If Not available Then
            Me.OutOfStockPanel.Visible = True
            Me.OutOfStockLiteral.Text = Content.SiteTerms.GetTerm("ProductCombinationNotAvailable")
        Else
            Me.OutOfStockLiteral.Text = String.Empty
            If Not WebAppSettings.DisableInventory Then
                If TypeOf Me.Page Is BaseStoreProductPage Then
                    Dim prodPage As BaseStoreProductPage = DirectCast(Me.Page, BaseStoreProductPage)
                    Dim prod As Catalog.Product = prodPage.LocalProduct
                    Dim parentProd As Catalog.Product = prodPage.LocalParentProduct

                    If prodPage.LocalProduct.Bvin = prodPage.LocalParentProduct.Bvin AndAlso parentProd.GlobalProduct.GetChoices().Count > 0 Then
                        ' nothing is selected yet (for products w/choices), so skip inventory check
                    Else
                        Select Case prod.InventoryStatus
                            Case Catalog.ProductInventoryStatus.NotAvailable
                                Me.OutOfStockPanel.Visible = True
                                If prodPage.LocalProduct.OutOfStockMode = Catalog.ProductInventoryMode.OutOfStockAllowOrders Then
                                    Me.OutOfStockLiteral.Text = Content.SiteTerms.GetTerm("OutOfStockAllowPurchase")
                                ElseIf prodPage.LocalProduct.OutOfStockMode = Catalog.ProductInventoryMode.OutOfStockDisallowOrders Then
                                    Me.OutOfStockLiteral.Text = Content.SiteTerms.GetTerm("OutOfStockNoPurchase")
                                ElseIf prodPage.LocalProduct.OutOfStockMode = Catalog.ProductInventoryMode.RemoveFromStore Then
                                    Me.OutOfStockLiteral.Text = Content.SiteTerms.GetTerm("OutOfStockNoPurchase")
                                End If
                            Case Else
                                If prodPage.LocalProduct.OutOfStockMode = Catalog.ProductInventoryMode.OutOfStockAllowOrders Then
                                    If (prod.QuantityAvailableForSale <= 0) AndAlso (prodPage.LocalProduct.Inventory.Bvin <> String.Empty) Then
                                        Me.OutOfStockPanel.Visible = True
                                        Me.OutOfStockLiteral.Text = Content.SiteTerms.GetTerm("OutOfStockAllowPurchase")
                                    End If
                                End If
                        End Select
                    End If
                End If
            End If
        End If
    End Sub
End Class
