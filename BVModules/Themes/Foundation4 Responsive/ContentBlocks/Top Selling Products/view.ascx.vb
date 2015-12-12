Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Top_Selling_Products_view
    Inherits Content.BVModule

    Public Event AddToCartClicked(ByVal productId As String)

    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)
        Me.EnableViewState = False
    End Sub

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
        Me.litPreContentHtml.Text = SettingsManager.GetSetting("PreContentHtml_HtmlData")
        Me.litPostContentHtml.Text = SettingsManager.GetSetting("PostContentHtml_HtmlData")

        ' get date range to use for finding products
        Dim dateRange As New BVSoftware.BVC5.Core.Utilities.DateRange()
        dateRange.RangeType = CType(SettingsManager.GetIntegerSetting("DateRangeType"), BVSoftware.BVC5.Core.Utilities.DateRangeType)
        If dateRange.RangeType = BVSoftware.BVC5.Core.Utilities.DateRangeType.Custom Then
            Dim tempDateTime As String = SettingsManager.GetSetting("StartDate")
            If Not String.IsNullOrEmpty(tempDateTime) Then
                dateRange.StartDate = Convert.ToDateTime(tempDateTime)
            End If

            tempDateTime = SettingsManager.GetSetting("EndDate")
            If Not String.IsNullOrEmpty(tempDateTime) Then
                dateRange.EndDate = Convert.ToDateTime(tempDateTime)
            End If
        End If

        ' Products
        Dim products As Collection(Of Catalog.Product) = Catalog.InternalProduct.FindTopSellingProducts( _
            dateRange.StartDate, _
            dateRange.EndDate, _
            SettingsManager.GetSetting("CategoryId"), _
            False, _
            SettingsManager.GetIntegerSetting("NumberOfItems"))
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
        Else
            ' hide control if no products are found
            Me.Visible = False
        End If
    End Sub

    Protected Sub SingleProduct_AddToCartClicked(ByVal productId As String) Handles ProductGridDisplay1.AddToCartClicked
        RaiseEvent AddToCartClicked(productId)
    End Sub

End Class