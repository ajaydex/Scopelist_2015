Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Product_Grid_view
    Inherits Content.BVModule

    Public Event AddToCartClicked(ByVal productId As String)

    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)
        Me.EnableViewState = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim products As New Collection(Of Catalog.Product)
        Dim productList As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("ProductGrid")
        If productList IsNot Nothing Then
            For Each csli As Content.ComponentSettingListItem In productList
                Dim bvin As String = csli.Setting1
                If Not String.IsNullOrEmpty(bvin) Then
                    Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(bvin)
                    If p IsNot Nothing AndAlso p.IsVisible Then
                        products.Add(p)
                    End If
                End If
            Next
        End If

        If products.Count > 0 Then
            ' populate proper display
            ProductGridDisplay1.DataSource = products
            ProductGridDisplay1.Columns = SettingsManager.GetIntegerSetting("Columns")
            ProductGridDisplay1.DisplayMode = SettingsManager.GetIntegerSetting("DisplayMode")
            ProductGridDisplay1.CssClassPrefix = SettingsManager.GetSetting("CssClassPrefix")
            ProductGridDisplay1.DisplayName = SettingsManager.GetBooleanSetting("DisplayName")
            ProductGridDisplay1.DisplayDescription = SettingsManager.GetBooleanSetting("DisplayDescription")
            ProductGridDisplay1.DisplayPrice = SettingsManager.GetBooleanSetting("DisplayPrice")
            ProductGridDisplay1.DisplayAddToCartButton = SettingsManager.GetBooleanSetting("DisplayAddToCartButton")
            ProductGridDisplay1.DisplaySelectedCheckBox = SettingsManager.GetBooleanSetting("DisplaySelectedCheckBox")
            ProductGridDisplay1.DisplayQuantity = SettingsManager.GetBooleanSetting("DisplayQuantity")
            ProductGridDisplay1.RemainOnPageAfterAddToCart = SettingsManager.GetBooleanSetting("RemainOnPageAfterAddToCart")
            ProductGridDisplay1.DisplayImage = SettingsManager.GetBooleanSetting("DisplayImage")
            ProductGridDisplay1.DisplayNewBadge = SettingsManager.GetBooleanSetting("DisplayNewBadge")
            ProductGridDisplay1.BindProducts()

            ' Title
            Dim title As String = SettingsManager.GetSetting("Title")
            Dim headingTag As String = SettingsManager.GetSetting("HeadingTag")
            If String.IsNullOrEmpty(title) Then
                Me.litTitle.Visible = False
            Else
                Me.litTitle.Text = String.Format("<{0}>{1}</{0}>", headingTag, title)
            End If

            ' Pre & Post-Content Columns
            Me.litPreContentHtml.Text = SettingsManager.GetSetting("PreContentHtml_HtmlData")
            Me.litPostContentHtml.Text = SettingsManager.GetSetting("PostContentHtml_HtmlData")
        Else
            ' hide control if no products are found
            Me.Visible = False
        End If
    End Sub

    Protected Sub SingleProduct_AddToCartClicked(ByVal productId As String) Handles ProductGridDisplay1.AddToCartClicked
        RaiseEvent AddToCartClicked(productId)
    End Sub

End Class