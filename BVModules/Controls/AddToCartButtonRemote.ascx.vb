Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_AddToCartButtonRemote
    Inherits BVSoftware.Bvc5.Core.Controls.BVBaseUserControl

    Private _LocalProduct As Catalog.Product = Nothing

#Region " Properties "

    Public Property LocalProduct() As Catalog.Product
        Get
            Return Me._LocalProduct
        End Get
        Set(ByVal value As Catalog.Product)
            Me._LocalProduct = value
        End Set
    End Property

#End Region

    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)

        Me.EnableViewState = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Me.LocalProduct Is Nothing Then
            Me.Visible = False
        Else
            Me.lnkAddToCart.CssClass = Me.CssClass

            If Me.LocalProduct.HasVariants OrElse Me.LocalProduct.IsKit Then
                Me.lnkAddToCart.ImageUrl = Me.ResolveUrl(PersonalizationServices.GetThemedButton("Details"))
                Me.lnkAddToCart.ToolTip = "Details"
                Me.lnkAddToCart.NavigateUrl = Utilities.UrlRewriter.BuildUrlForProduct(Me.LocalProduct, Me.Page.Request)
            Else
                Me.lnkAddToCart.ImageUrl = Me.ResolveUrl(PersonalizationServices.GetThemedButton("AddToCart"))
                Me.lnkAddToCart.ToolTip = "Add to Cart"
                Me.lnkAddToCart.NavigateUrl = Me.ResolveUrl(String.Format("~/Cart.aspx?quickaddid={0}&quickaddqty={1}", Me.LocalProduct.Bvin, "1"))
            End If
        End If
    End Sub

End Class
