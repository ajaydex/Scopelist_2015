Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_ProductMainImage
    Inherits System.Web.UI.UserControl

    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    'End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If TypeOf Me.Page Is BaseStoreProductPage Then
            Dim product As Catalog.Product = DirectCast(Me.Page, BaseStoreProductPage).LocalProduct
            If product IsNot Nothing Then                
                ' Image
                Me.imgMain.ImageUrl = Me.Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(product.ImageFileMedium, True))
                Me.imgMain.AlternateText = HttpUtility.HtmlEncode(product.ImageFileMediumAlternateText)
                Me.imgMain.Attributes.Add("itemprop", "image")

                ' New badge
                If product.IsNew() AndAlso WebAppSettings.NewProductBadgeAllowed Then
                    BadgeImage.Visible = True
                Else
                    BadgeImage.Visible = False
                End If
            End If
        End If

        ' Force Image Size
        ViewUtilities.ForceImageSize(imgMain, imgMain.ImageUrl, ViewUtilities.Sizes.Medium, Me.Page)

        Dim id As String = Request.QueryString("ProductID")
        Dim baseProd As Catalog.Product = Catalog.InternalProduct.FindByBvin(id)
        If baseProd IsNot Nothing Then
            If baseProd.AdditionalImages.Count > 0 Then
                Me.AdditionalImagesLink.Visible = True
                Me.AdditionalImagesLink.Style.Add("cursor", "pointer")
                Me.AdditionalImagesLink.Attributes.Add("onclick", ViewUtilities.GetAdditionalImagesPopupJavascript(id, Me.Page))
            End If
        End If
    End Sub
End Class
