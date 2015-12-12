Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_VolumeDiscounts
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If TypeOf Me.Page Is BaseStoreProductPage Then
                Dim prodPage As BaseStoreProductPage = DirectCast(Me.Page, BaseStoreProductPage)
                Dim volumeDiscounts As Collection(Of Catalog.ProductVolumeDiscount)
                If prodPage.LocalProduct.ParentId = String.Empty Then
                    volumeDiscounts = Catalog.ProductVolumeDiscount.FindByProductId(prodPage.LocalProduct.Bvin)
                Else
                    volumeDiscounts = Catalog.ProductVolumeDiscount.FindByProductId(prodPage.LocalProduct.ParentId)
                End If
                If volumeDiscounts.Count > 0 Then
                    pnlVolumeDiscounts.Visible = True
                    dgVolumeDiscounts.DataSource = volumeDiscounts
                    dgVolumeDiscounts.DataBind()
                Else
                    pnlVolumeDiscounts.Visible = False
                End If
            End If
        End If
    End Sub
End Class
