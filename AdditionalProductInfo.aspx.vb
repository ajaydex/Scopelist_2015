Imports BVSoftware.Bvc5.Core

Partial Class AdditionalProductInfo
    Inherits BaseStorePage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        AddHandler UpSellDisplay.AddToCartClicked, AddressOf AddToCartClickedHandler
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Product.master")
        Me.PageTitle = Content.SiteTerms.GetTerm("UpSellTitle")
    End Sub


    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        Me.ContinueToCartImageButton.ImageUrl = PersonalizationServices.GetThemedButton("NoThankYou")

        If Request.QueryString("id") IsNot Nothing Then
            Dim lineItem As Orders.LineItem = Orders.LineItem.FindByBvin(Request.QueryString("id"))
            If lineItem.Bvin <> String.Empty Then
                Dim item As Catalog.Product = Catalog.InternalProduct.FindByBvin(lineItem.ProductId)
                If item.ParentId <> String.Empty Then
                    UpSellDisplay.Product = Catalog.InternalProduct.FindByBvin(item.ParentId)
                Else
                    UpSellDisplay.Product = item
                End If
                UpSellDisplay.Quantity = lineItem.Quantity
                UpSellDisplay.DataBind()
            Else
                Response.Redirect("~/Default.aspx")
            End If
        Else
            Response.Redirect("~/Default.aspx")
        End If
    End Sub

    Protected Sub ContinueToCartImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ContinueToCartImageButton.Click
        If WebAppSettings.RedirectToCartAfterAddProduct Then
            Response.Redirect("~/Cart.aspx")
        End If
    End Sub

    Protected Sub AddToCartClickedHandler(ByVal productId As String)
        Orders.LineItem.Delete(Request.QueryString("id"))
    End Sub
End Class
