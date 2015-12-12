Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_ProductNextPrevious
    Inherits System.Web.UI.UserControl

    Private _ProductId As String = String.Empty
    Private _LocalProduct As Catalog.Product = Nothing

#Region "Properties"

    Public Property ProductId() As String
        Get
            If String.IsNullOrEmpty(Me._ProductId) Then
                If Not String.IsNullOrEmpty(Request.QueryString("ProductId")) Then
                    Me._ProductId = Request.QueryString("ProductId")
                ElseIf TypeOf Me.Page Is BaseStoreProductPage Then
                    Dim productPage As BaseStoreProductPage = DirectCast(Me.Page, BaseStoreProductPage)
                    If productPage.LocalParentProduct IsNot Nothing Then
                        Me._ProductId = productPage.LocalParentProduct.Bvin
                    End If
                End If
            End If

            Return Me._ProductId
        End Get
        Set(ByVal value As String)
            Me._ProductId = value
        End Set
    End Property

    Public ReadOnly Property LocalProduct As Catalog.Product
        Get
            If Me._LocalProduct Is Nothing OrElse String.IsNullOrEmpty(Me._LocalProduct.Bvin) Then
                If TypeOf Me.Page Is BaseStoreProductPage Then
                    Dim productPage As BaseStoreProductPage = DirectCast(Me.Page, BaseStoreProductPage)
                    If productPage.LocalParentProduct IsNot Nothing Then
                        Me._LocalProduct = productPage.LocalParentProduct
                    End If
                Else
                    If Not String.IsNullOrEmpty(Me.ProductId) Then
                        Me._LocalProduct = Catalog.InternalProduct.FindByBvin(Me.ProductId)
                    End If
                End If
            End If

            Return Me._LocalProduct
        End Get
    End Property

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.Visible = False

            If Not String.IsNullOrEmpty(Me.ProductId) Then
                Dim catId As String = SessionManager.CurrentCategoryId()
                If Not String.IsNullOrEmpty(catId) Then
                    Dim c As Catalog.Category = Catalog.Category.FindByBvin(catId)
                    If Not String.IsNullOrEmpty(c.Bvin) Then
                        Dim products As Collection(Of Catalog.Product) = c.FindAllProducts(c.DisplaySortOrder, WebAppSettings.DisableInventory, False, 0, Integer.MaxValue, Nothing)
                        If products.Count > 1 Then
                            Me.Visible = True

                            Me.lnkNext.Text = "<i class=""fa fa-chevron-right""></i>"
                            Me.lnkPrev.Text = "<i class=""fa fa-chevron-left""></i>"

                            Dim pos As Integer = products.IndexOf(Me.LocalProduct)
                            If pos < 0 Then
                                Me.Visible = False
                            ElseIf pos = 0 Then
                                Me.lnkPrev.Enabled = False
                                Me.lnkNext.NavigateUrl = products(pos + 1).ProductURL
                            ElseIf pos < products.Count - 1 Then
                                Me.lnkPrev.NavigateUrl = products(pos - 1).ProductURL
                                Me.lnkNext.NavigateUrl = products(pos + 1).ProductURL
                            Else
                                Me.lnkPrev.NavigateUrl = products(pos - 1).ProductURL
                                Me.lnkNext.Enabled = False
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

End Class