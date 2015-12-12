Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_AddToWishlist
    Inherits System.Web.UI.UserControl

    Public Event Clicked(ByVal args As AddToWishlistClickedEventArgs)

    Protected Sub AddToWishlist_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddToWishlist.Click
        Dim args As New AddToWishlistClickedEventArgs()
        RaiseEvent Clicked(args)

        If args.IsValid Then
            If Page.IsValid Then
                Dim selectedProduct As Catalog.Product
                If args.VariantsDisplay IsNot Nothing Then
                    If Not args.VariantsDisplay.IsValid Then
                        Return
                    End If
                    selectedProduct = args.VariantsDisplay.GetSelectedProduct(Nothing)
                    If selectedProduct Is Nothing Then
                        EventLog.LogEvent("AddToWishlist.aspx.vb", "Product could not be found from Variants display. Current product: " & args.Page.LocalProduct.Bvin & " " & args.Page.LocalProduct.Sku, Metrics.EventLogSeverity.Error)
                        Return
                    Else
                        If args.VariantsDisplay.IsValidCombination Then
                            args.Page.LocalProduct = selectedProduct
                        Else
                            args.MessageBox.ShowError("Cannot Add To " & Content.SiteTerms.GetTerm("WishList") & ". Current Selection Is Not Available.")
                        End If
                    End If
                Else
                    selectedProduct = args.Page.LocalProduct
                End If

                args.Page.ModuleProductQuantity = args.Quantity

                Dim li As New Orders.LineItem()
                li.ProductId = selectedProduct.Bvin
                li.Quantity = args.Quantity
                If args.VariantsDisplay IsNot Nothing Then
                    args.VariantsDisplay.WriteValuesToLineItem(li)
                End If

                If Not String.IsNullOrEmpty(SessionManager.GetCurrentUserId) Then
                    Catalog.WishList.AddItemToList(SessionManager.GetCurrentUserId, li)
                Else
                    Session.Add(WebAppSettings.WishlistItemSessionKey, li)
                End If
                Response.Redirect("~/MyAccount_WishList.aspx")
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Me.AddToWishlist.ImageUrl = PersonalizationServices.GetThemedButton("AddToWishList")
            Me.AddToWishlist.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-addto-wishlist.png")
        End If
    End Sub
End Class
