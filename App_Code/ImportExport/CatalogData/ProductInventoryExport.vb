Imports System.Collections.ObjectModel
Imports System.Linq
Imports System.Reflection
Imports BVSoftware.BVC5.Core

Namespace ImportExport.CatalogData

    Public Class ProductInventoryExport
        Inherits BaseExport

        Private Const COMPONENTID As String = "1261AD24-2274-45B6-917F-21891D3915AE"

        Private _Criteria As Catalog.ProductSearchCriteria = Nothing

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Inventory Export"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "inventory.txt"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_EXCLUDEDEXPORTFIELDS As String()
            Get
                Return New String() {"QuantityAvailableForSale", _
                                     "ReorderLevel", _
                                     "Status"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Catalog.ProductInventory)
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

        Protected Overrides Function LoadExportData() As Generic.IEnumerable(Of Object)
            Dim result As New Collection(Of Catalog.ProductInventory)()

            Dim products As Collection(Of Catalog.Product) = Nothing
            If Me.Criteria IsNot Nothing Then
                products = Catalog.InternalProduct.FindByCriteria(Me.Criteria)
            Else
                Dim psc As New Catalog.ProductSearchCriteria()
                psc.SpecialProductTypeOne = Catalog.SpecialProductTypes.Normal
                products = Catalog.InternalProduct.FindByCriteria(psc)
            End If

            For Each p As Catalog.Product In products
                If p.TrackInventory Then
                    result.Add(p.Inventory)
                End If
            Next
            products = Nothing

            Return result
        End Function

    End Class

End Namespace