Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ImportExport_ProductCategoryImport_Import
    Inherits ImportExport.ImportTemplate

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
    End Sub

    Public Overrides Sub ApplyFormSettings(import As ImportExport.BaseImport)
        Dim pcImport As ImportExport.CatalogData.ProductCategoryImport = DirectCast(import, ImportExport.CatalogData.ProductCategoryImport)
        pcImport.CategoryId = Request.QueryString("categoryId")
    End Sub

End Class