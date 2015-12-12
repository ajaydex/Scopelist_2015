Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Last_Products_Viewed_view
    Inherits Content.BVModule

    Public Event AddToCartClicked(ByVal productId As String)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Title
        Dim title As String = SettingsManager.GetSetting("Title")
        Dim headingTag As String = SettingsManager.GetSetting("HeadingTag")
        If String.IsNullOrEmpty(title) Then
            Me.litTitle.Visible = False
        Else
            Me.litTitle.Text = String.Format("<{0}>{1}</{0}>", headingTag, title)
        End If

        ' Pre & Post-Content Columns
        Me.PreHtml.Text = SettingsManager.GetSetting("PreContentHtml_HtmlData")
        Me.PostHtml.Text = SettingsManager.GetSetting("PostContentHtml_HtmlData")

        LoadProductGrid()
    End Sub

    Private Sub LoadProductGrid()
        Dim i As Integer = 0

        Dim products As New Collection(Of Catalog.Product)
        For Each p As Catalog.Product In PersonalizationServices.GetProductsViewed()
            If i < WebAppSettings.LastProductsViewedMaxResults Then
                If p IsNot Nothing Then
                    If Not String.IsNullOrEmpty(p.ParentId) Then
                        p = Catalog.InternalProduct.FindByBvinLight(p.ParentId)
                    End If

                    If p IsNot Nothing AndAlso p.IsVisible Then
                        If Not products.Contains(p) Then
                            products.Add(p)
                            i += 1
                        End If
                    End If
                End If
            End If
        Next

        If products.Count > 0 Then
            ProductGrid.Visible = True
            PreHtml.Visible = True
            PostHtml.Visible = True

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
        Else
            ProductGrid.Visible = False
            PreHtml.Visible = False
            PostHtml.Visible = False
        End If
    End Sub

End Class