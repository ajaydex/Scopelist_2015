Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ImportExport_ProductInventoryExport_Export
    Inherits ImportExport.ExportTemplate

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Session("InventoryCriteria") IsNot Nothing Then
                Dim criteria As Catalog.ProductSearchCriteria = CType(Session("InventoryCriteria"), Catalog.ProductSearchCriteria)
                If criteria IsNot Nothing Then
                    Me.ucProductFilter.LoadFilter(criteria)
                End If
            End If
        End If
    End Sub

    Public Overrides Sub ApplyFormSettings(export As ImportExport.BaseExport)
        Dim piExport As ImportExport.CatalogData.ProductInventoryExport = DirectCast(export, ImportExport.CatalogData.ProductInventoryExport)
        piExport.Criteria = New Catalog.ProductSearchCriteria()
        Me.ucProductFilter.LoadCriteria(piExport.Criteria)
        piExport.Criteria.ShowProductCombinations = Me.IncludeChoiceCombinations.Checked
        piExport.Criteria.SpecialProductTypeOne = Catalog.SpecialProductTypes.Normal
    End Sub

End Class