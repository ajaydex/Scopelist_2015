Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Product_Rotator_view
    Inherits Content.BVModule

    Public Event AddToCartClicked(ByVal productId As String)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadProductImage()
    End Sub

    Private Sub LoadProductImage()
        Dim myProducts As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Products")
        If myProducts IsNot Nothing Then
            If myProducts.Count > 0 Then
                Dim displayIndex As Integer = GetImageIndex(myProducts.Count)
                Dim bvin As String = myProducts(displayIndex).Setting1
                Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(bvin)
                Dim count As Integer = 1
                While (product Is Nothing OrElse (Not product.IsVisible)) AndAlso count <= 5
                    displayIndex = GetImageIndex(myProducts.Count - 1)
                    bvin = myProducts(displayIndex).Setting1
                    product = Catalog.InternalProduct.FindByBvin(bvin)
                    count += 1
                End While

                If product IsNot Nothing AndAlso product.IsVisible Then
                    SetImage(product)
                End If
            End If
        End If

        ' Pre & Post-Content Columns
        Me.PreHtml.Text = SettingsManager.GetSetting("PreContentHtml_HtmlData")
        Me.PostHtml.Text = SettingsManager.GetSetting("PostContentHtml_HtmlData")
    End Sub

    Private Sub SetImage(ByVal product As Catalog.Product)
        If ucSingleProductDisplay IsNot Nothing Then
            ucSingleProductDisplay.DisplayMode = SettingsManager.GetIntegerSetting("DisplayMode")
            ucSingleProductDisplay.CssClassPrefix = SettingsManager.GetSetting("CssClassPrefix")
            ucSingleProductDisplay.DisplayName = SettingsManager.GetBooleanSetting("DisplayName")
            ucSingleProductDisplay.DisplayImage = SettingsManager.GetBooleanSetting("DisplayImage")
            ucSingleProductDisplay.DisplayNewBadge = SettingsManager.GetBooleanSetting("DisplayNewBadge")
            ucSingleProductDisplay.DisplayDescription = SettingsManager.GetBooleanSetting("DisplayDescription")
            ucSingleProductDisplay.DisplayPrice = SettingsManager.GetBooleanSetting("DisplayPrice")
            ucSingleProductDisplay.DisplayAddToCartButton = SettingsManager.GetBooleanSetting("DisplayAddToCartButton")
            ucSingleProductDisplay.DisplaySelectedCheckBox = SettingsManager.GetBooleanSetting("DisplaySelectedCheckBox")
            ucSingleProductDisplay.DisplayQuantity = SettingsManager.GetBooleanSetting("DisplayQuantity")
            ucSingleProductDisplay.RemainOnPageAfterAddToCart = SettingsManager.GetBooleanSetting("RemainOnPageAfterAddToCart")
            ucSingleProductDisplay.LoadWithProduct(product)
        End If
        If product.Sku.Trim = String.Empty Then
            lnkImage.NavigateUrl = ""
            lnkImage.Target = ""
            lnkProductName.NavigateUrl = ""
            lnkProductName.Target = ""
        Else
            lnkImage.NavigateUrl = product.ProductURL
            lnkProductName.NavigateUrl = product.ProductURL
        End If
        Me.lnkImage.ToolTip = product.ProductName
        Me.lnkProductName.Text = product.ProductName
    End Sub

    Private Function GetImageIndex(ByVal maxIndex As Integer) As Integer
        Dim result As Integer = 0

        If SettingsManager.GetBooleanSetting("ShowInOrder") = True Then

            ' Find the next image index to show in sequence
            Dim nextIndex As String = Me.NextImageIndex

            ' Make sure index is a valid integer
            If nextIndex = String.Empty Then
                result = 0
            Else
                result = Integer.Parse(nextIndex, System.Globalization.CultureInfo.InvariantCulture)
            End If

            ' Make sure result is at least zero
            If result < 0 Then
                result = 0
            End If

            ' Make sure result is not greater than the maximum allowed size
            If result > maxIndex Then
                result = maxIndex
            End If

            ' We have a valid number now, save the next index for next time.
            Dim saveIndex As Integer = result + 1
            If saveIndex > maxIndex Then
                saveIndex = 0
            End If
            Me.NextImageIndex = saveIndex.ToString(System.Globalization.CultureInfo.InvariantCulture)

        Else
            ' Select Random Image
            result = BVSoftware.Web.RandomNumbers.RandomInteger(maxIndex, 0)
        End If

        Return result
    End Function

    Private Property NextImageIndex() As String
        Get
            If Session(Me.BlockId & "BVSoftware.ProductRotator.NextImageIndex") Is Nothing Then
                Return String.Empty
            Else
                Return CType(Session(Me.BlockId & "BVSoftware.ProductRotator.NextImageIndex"), String)
            End If
        End Get
        Set(ByVal value As String)
            Session(Me.BlockId & "BVSoftware.ProductRotator.NextImageIndex") = value
        End Set
    End Property

    Protected Sub SingleProduct_AddToCartClicked(ByVal productId As String) Handles ucSingleProductDisplay.AddToCartClicked
        RaiseEvent AddToCartClicked(productId)
    End Sub

End Class