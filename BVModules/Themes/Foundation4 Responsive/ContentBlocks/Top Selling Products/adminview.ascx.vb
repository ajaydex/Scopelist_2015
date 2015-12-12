Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Top_Selling_Products_adminview
    Inherits Content.BVModule

    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)

        Me.EnableViewState = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.ucProductGridDisplay.Visible = False
        Me.ucProductListDisplay.Visible = False
        Me.ucProductTableDisplay.Visible = False

        ' Title
        Dim title As String = SettingsManager.GetSetting("Title")
        If String.IsNullOrEmpty(title) Then
            Me.hTitle.Visible = False
        Else
            Me.hTitle.InnerText = title
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
            ' populate proper display control
            Select Case CType(SettingsManager.GetIntegerSetting("ProductDisplayType"), Controls.ProductDisplayType)
                Case BVSoftware.BVC5.Core.Controls.ProductDisplayType.Grid
                    Me.ucProductGridDisplay.Visible = True
                    Me.ucProductGridDisplay.DataSource = products
                    Me.ucProductGridDisplay.Columns = SettingsManager.GetIntegerSetting("Columns")

                Case BVSoftware.BVC5.Core.Controls.ProductDisplayType.List
                    Me.ucProductListDisplay.Visible = True
                    Me.ucProductListDisplay.DataSource = products

                Case BVSoftware.BVC5.Core.Controls.ProductDisplayType.Table
                    Me.ucProductTableDisplay.Visible = True
                    Me.ucProductTableDisplay.DataSource = products

                Case Else
                    Me.Visible = False

            End Select
        End If
    End Sub

End Class