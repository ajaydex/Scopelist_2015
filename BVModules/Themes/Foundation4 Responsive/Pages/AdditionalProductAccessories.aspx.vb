Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_Pages_AdditionalProductInfo
    Inherits BaseStorePage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        AddHandler CrossSellDisplay.AddToCartClicked, AddressOf AddToCartClickedHandler
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Product.master")
        Me.PageTitle = Content.SiteTerms.GetTerm("CrossSellTitle")
    End Sub

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        Me.ContinueToCartImageButton.ImageUrl = PersonalizationServices.GetThemedButton("NoThankYou")

        If Request.QueryString("id") IsNot Nothing Then
            Dim lineItem As Orders.LineItem = Orders.LineItem.FindByBvin(Request.QueryString("id"))
            If lineItem.Bvin <> String.Empty Then
                Dim item As Catalog.Product = Catalog.InternalProduct.FindByBvin(lineItem.ProductId)
                If item.ParentId <> String.Empty Then
                    CrossSellDisplay.Product = Catalog.InternalProduct.FindByBvin(item.ParentId)
                Else
                    CrossSellDisplay.Product = item
                End If
                CrossSellDisplay.DataBind()
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

    End Sub
End Class
