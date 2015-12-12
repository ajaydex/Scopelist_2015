Imports System.Collections.ObjectModel
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ImportExport_ProductExport_Export
    Inherits ImportExport.ExportTemplate

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim criteria As Catalog.ProductStoreSearchCriteria = SessionManager.StoreSearchCriteria
            If criteria IsNot Nothing Then
                Me.ucProductFilter.LoadFilter(criteria.ConvertToProductSearchCriteria())
            End If
        End If
    End Sub

    Public Overrides Sub ApplyFormSettings(export As ImportExport.BaseExport)
        Dim productExport As ImportExport.CatalogData.ProductExport = DirectCast(export, ImportExport.CatalogData.ProductExport)
        productExport.Criteria = New Catalog.ProductSearchCriteria()
        Me.ucProductFilter.LoadCriteria(productExport.Criteria)
        productExport.Criteria.SpecialProductTypeOne = Catalog.SpecialProductTypes.Normal
        productExport.Criteria.ShowProductCombinations = Me.IncludeChoiceCombinations.Checked

        If Me.IncludeProductCategories.Checked Then
            If Not productExport.CustomExportFields.Contains("CategoryBvins", StringComparer.InvariantCultureIgnoreCase) Then
                Dim newCustomExportFields As String() = New String(productExport.CustomExportFields.Length) {}
                newCustomExportFields(newCustomExportFields.Length - 1) = "CategoryBvins"

                productExport.CustomExportFields = newCustomExportFields
            End If
        Else
            If productExport.CustomExportFields.Contains("CategoryBvins", StringComparer.InvariantCultureIgnoreCase) Then
                Dim newCustomExportFields As New Collection(Of String)
                For Each field As String In productExport.CustomExportFields
                    If field IsNot Nothing AndAlso String.Compare(field, "CategoryBvins", True) <> 0 Then
                        newCustomExportFields.Add(field)
                    End If
                Next

                If newCustomExportFields.Count > 0 Then
                    productExport.CustomExportFields = newCustomExportFields.ToArray()
                Else
                    productExport.CustomExportFields = New String(-1) {}
                End If
            End If
        End If
    End Sub

End Class