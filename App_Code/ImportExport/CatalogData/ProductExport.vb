Imports System.Collections.ObjectModel
Imports System.Reflection
Imports BVSoftware.Bvc5.Core

Namespace ImportExport.CatalogData

    Public Class ProductExport
        Inherits BaseExport

        Private Const COMPONENTID As String = "0506D3B1-E9BE-4095-878F-CF50B13E88E2"

        Private _Criteria As Catalog.ProductSearchCriteria = Nothing

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Product Export"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "products.txt"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_EXCLUDEDEXPORTFIELDS As String()
            Get
                Return New String() {"AdditionalImages", _
                                     "Categories", _
                                     "ChoiceCombinations", _
                                     "ChoicesAndInputs", _
                                     "CreationDateUtc", _
                                     "GlobalProduct", _
                                     "HasVariants", _
                                     "IsNew", _
                                     "MarkedAsDeleted", _
                                     "ProductURL", _
                                     "Reviews", _
                                     "Saved", _
                                     "SitePriceForDisplay"}
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_CUSTOMEXPORTFIELDS As String()
            Get
                Return New String() {"CategoryBvins"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Catalog.Product)
            End Get
        End Property

        Public Overridable Property Criteria As Catalog.ProductSearchCriteria
            Get
                Return Me._Criteria
            End Get
            Set(value As Catalog.ProductSearchCriteria)
                Me._Criteria = value
            End Set
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Sub AddCustomField(fieldName As String, obj As Object)
            Dim p As Catalog.Product = CType(obj, Catalog.Product)

            Select Case fieldName.ToLower()

                Case "categorybvins"
                    AddColumn(String.Join(",", p.Categories))

            End Select

        End Sub

        Protected Overrides Function LoadExportData() As Generic.IEnumerable(Of Object)
            If Me.Criteria IsNot Nothing Then
                Return Catalog.InternalProduct.FindByCriteria(Me.Criteria)
            Else
                Dim psc As New Catalog.ProductSearchCriteria()
                psc.SpecialProductTypeOne = Catalog.SpecialProductTypes.Normal

                Return Catalog.InternalProduct.FindByCriteria(psc)
            End If
        End Function

    End Class

End Namespace