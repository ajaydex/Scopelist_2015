Imports System.Collections.ObjectModel
Imports System.Linq
Imports System.Reflection
Imports BVSoftware.BVC5.Core

Namespace ImportExport.CatalogData

    Public Class ProductCategoryExport
        Inherits BaseExport

        Private Const COMPONENTID As String = "0284309E-BF9A-4D39-900A-26E5AE3FC419"

        Private _CategoryId As String = Nothing
        Private _Category As Catalog.Category = Nothing
        Private _Products As Collection(Of Catalog.Product) = Nothing


#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Product Category Export"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "productcategories.txt"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_CUSTOMEXPORTFIELDS As String()
            Get
                Return {"ProductName", _
                        "Sku"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Catalog.CategoryProductAssociation)
            End Get
        End Property

        Public Overridable Property CategoryId As String
            Get
                Return Me._CategoryId
            End Get
            Set(value As String)
                Me._CategoryId = value
            End Set
        End Property

        Public Overridable ReadOnly Property Category As Catalog.Category
            Get
                If Me._Category Is Nothing Then
                    If Not String.IsNullOrEmpty(Me.CategoryId) Then
                        Me._Category = Catalog.Category.FindByBvin(Me.CategoryId)
                    End If
                End If

                Return Me._Category
            End Get
        End Property

        Public Overridable ReadOnly Property Products As Collection(Of Catalog.Product)
            Get
                If Me._Products Is Nothing AndAlso Me.Category IsNot Nothing Then
                    Me._Products = Me.Category.FindAllProducts(Me.Category.DisplaySortOrder, True, True)
                End If

                Return Me._Products
            End Get
        End Property

#End Region


        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Sub AddCustomField(fieldName As String, obj As Object)
            Dim cpa As Catalog.CategoryProductAssociation = CType(obj, Catalog.CategoryProductAssociation)
            Dim p As Catalog.Product = Me.Products.FirstOrDefault(Function(product) product.Bvin = cpa.ProductId)

            Select Case fieldName.ToLower()

                Case "productname"
                    AddColumn(p.ProductName)

                Case "sku"
                    AddColumn(p.Sku)

            End Select

        End Sub

        Protected Overrides Function LoadExportData() As Generic.IEnumerable(Of Object)
            Return Datalayer.CategoryProductAssociationMapper.FindByCategory(Me.CategoryId)
        End Function

    End Class

End Namespace