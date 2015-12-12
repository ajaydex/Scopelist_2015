Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ImportExport_ProductCategoryExport_Export
    Inherits ImportExport.ExportTemplate

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
    End Sub

    Public Overrides Sub ApplyFormSettings(export As ImportExport.BaseExport)
        Dim pcExport As ImportExport.CatalogData.ProductCategoryExport = DirectCast(export, ImportExport.CatalogData.ProductCategoryExport)
        pcExport.CategoryId = Request.QueryString("categoryId")
    End Sub

End Class