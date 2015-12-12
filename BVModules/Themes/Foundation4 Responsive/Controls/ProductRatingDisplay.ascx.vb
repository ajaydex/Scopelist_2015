Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_ProductRatingDisplay
    Inherits System.Web.UI.UserControl

    Private _LocalProduct As Catalog.Product = Nothing

#Region " Properties "

    Public Property LocalProduct As Catalog.Product
        Get
            If Me._LocalProduct Is Nothing Then
                If TypeOf Me.Page Is BaseStoreProductPage Then
                    Dim productPage As BaseStoreProductPage = DirectCast(Me.Page, BaseStoreProductPage)
                    If productPage.LocalParentProduct IsNot Nothing Then
                        Me._LocalProduct = productPage.LocalParentProduct
                    End If
                Else
                    If Not String.IsNullOrEmpty(Request.QueryString("ProductId")) Then
                        Me._LocalProduct = Catalog.InternalProduct.FindByBvin(Request.QueryString("ProductId"))
                    End If
                End If
            End If

            Return Me._LocalProduct
        End Get
        Set(value As Catalog.Product)
            Me._LocalProduct = value
        End Set
    End Property

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If WebAppSettings.ProductReviewShow Then
            If Me.LocalProduct IsNot Nothing Then
                If Me.LocalProduct.Reviews.Count > 0 Then
                    Me.lnkWriteReview.Visible = False

                    Dim rating As Integer = Catalog.ProductReview.CalculateReviewAverage(Me.LocalProduct.Reviews)
                    Dim img As String = "<img src=""{0}"" alt=""{1}"" />"
                    Dim imgSrc As String = String.Empty
                    Dim imgAlt As String = String.Empty

                    Select Case rating
                        Case 1 To 5
                            imgSrc = Me.ResolveUrl(Catalog.ProductReview.GetStarImageUrl(rating))
                            imgAlt = String.Format("{0} Star{1}", rating.ToString(), If(rating > 1, "s", String.Empty))
                        Case Else
                            ' invalid rating -- hide image
                            img = "{0}{1}"
                    End Select

                    Me.lnkRating.Text = String.Format(Me.lnkRating.Text, _
                                                      String.Format(img, imgSrc, imgAlt), _
                                                      Me.LocalProduct.Reviews.Count.ToString(), _
                                                      If(Me.LocalProduct.Reviews.Count > 1, "s", String.Empty))

                    Me.lnkRating.NavigateUrl = Utilities.UrlRewriter.BuildUrlForProduct(Me.LocalProduct, Me.Request.ApplicationPath, String.Empty) + "#Write"
                Else
                    Me.lnkRating.Visible = False

                    Me.lnkWriteReview.NavigateUrl = String.Format("{0}#Write", Utilities.UrlRewriter.BuildUrlForProduct(Me.LocalProduct, Me.Request))
                End If
            Else
                Me.Visible = False
            End If
        Else
            Me.Visible = False
        End If
    End Sub

End Class