Imports System.Collections.ObjectModel
Imports System.Linq
Imports System.Reflection
Imports BVSoftware.BVC5.Core

Namespace ImportExport.CatalogData

    Public Class ProductCategoryImport
        Inherits BaseImport

        Private _CategoryId As String = Nothing
        Private _Category As Catalog.Category = Nothing
        Private _Products As Collection(Of Catalog.Product) = Nothing
        Private _ImportedProducts As Collection(Of String) = Nothing
        Private _CategoryProductAssocations As Collection(Of Catalog.CategoryProductAssociation) = Nothing

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_IMPORTNAME As String
            Get
                Return "Product Category Import"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_KEYFIELD As String
            Get
                Return "ProductId"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_REQUIREDIMPORTFIELDS As String()
            Get
                Return New String() {"CategoryId", _
                                     "ProductId"}
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_EXCLUDEDIMPORTFIELDS() As String()
            Get
                Return New String() {"CreationDate", _
                                     "LastUpdated", _
                                     "ProductName", _
                                     "Sku"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property Bvin As String
            Get
                Return "0284309E-BF9A-4D39-900A-26E5AE3FC419"
            End Get
        End Property

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

        Public Overridable Property ImportedProducts As Collection(Of String)
            Get
                Return Me._ImportedProducts
            End Get
            Set(value As Collection(Of String))
                Me._ImportedProducts = value
            End Set
        End Property

        Public Overridable ReadOnly Property CategoryProductAssocations As Collection(Of Catalog.CategoryProductAssociation)
            Get
                If Me._CategoryProductAssocations Is Nothing Then
                    Me._CategoryProductAssocations = Datalayer.CategoryProductAssociationMapper.FindByCategory(Me.CategoryId)
                End If

                Return Me._CategoryProductAssocations
            End Get
        End Property

#End Region


        Public Overrides Function FindRowOjbect(key As Object) As Object
            Dim result As Catalog.CategoryProductAssociation = Me.CategoryProductAssocations.FirstOrDefault(Function(cpa) cpa.ProductId = key.ToString())
            If result Is Nothing Then
                result = New Catalog.CategoryProductAssociation()
            End If

            Return result
        End Function

        Public Overrides Function ProcessPreImport() As Boolean
            Dim result As Boolean = True

            ' initialize/clear list of current and imported products
            Me._CategoryProductAssocations = Nothing
            Me._ImportedProducts = New Collection(Of String)
            Me._Products = Nothing

            ' make sure that an import category was specified
            If String.IsNullOrEmpty(Me.CategoryId) Then
                result = False
                Me.AddMessage(Content.DisplayMessageType.Error, "The CategoryId property of the ProductCategoryImport class was not specified - aborting import")
            End If

            Return result
        End Function

        Public Overrides Function ProcessPostRow(row() As String, rowNumber As Integer, ByRef output As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = MyBase.ProcessPostRow(row, rowNumber, output)

            If result Then
                Dim cpa As Catalog.CategoryProductAssociation = CType(output(Me.KeyField), Catalog.CategoryProductAssociation)
                Me.ImportedProducts.Add(cpa.ProductId)
            End If

            Return result
        End Function

        Public Overrides Function ValidateRowObject(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = MyBase.ValidateRowObject(data)

            If result Then
                Dim cpa As Catalog.CategoryProductAssociation = CType(data(Me.KeyField), Catalog.CategoryProductAssociation)

                ' SortOrder
                If cpa.SortOrder <= 0 Then
                    result = False
                    Me.AddMessage(Content.DisplayMessageType.Error, String.Format("SortOrder ""{0}"" for ProductId ""{1}"" must be greater than 0 - skipping row.", cpa.SortOrder.ToString(), cpa.ProductId))
                End If

                ' CategoryId
                If result Then
                    If cpa.CategoryId <> Me.CategoryId Then
                        result = False
                        Me.AddMessage(Content.DisplayMessageType.Error, String.Format("CategoryId ""{0}"" is invalid for this import. This import is for CategoryId ""{1}"" - skipping row.", cpa.CategoryId, Me.CategoryId))
                    End If
                End If

                ' ProductId
                If result Then
                    ' if product isn't already in the category, make sure that this new product is a parent product (not a child/choice combination product)
                    If Not Me.Products.Any(Function(p) p.Bvin = cpa.ProductId) Then
                        Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(cpa.ProductId)
                        If Not String.IsNullOrEmpty(p.ParentId) Then
                            result = False
                            Me.AddMessage(Content.DisplayMessageType.Error, String.Format("ProductId ""{0}"" is a choice combination product (child product) and cannot be assigned to a category; only its parent product can be - skipping row.", cpa.ProductId))
                        End If
                    End If
                End If

                If Not result Then
                    Me.ImportedProducts.Remove(cpa.ProductId)
                End If
            End If

            Return result
        End Function

        Public Overrides Function SaveRow(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = True

            Try
                Dim cpa As Catalog.CategoryProductAssociation = CType(data(Me.KeyField), Catalog.CategoryProductAssociation)

                If Me.Products.Any(Function(p) p.Bvin = cpa.ProductId) Then
                    ' update SortOrder value, if present
                    If Me.ImportFields.Contains("SortOrder", StringComparer.InvariantCultureIgnoreCase) Then
                        If Not Datalayer.CategoryProductAssociationMapper.UpdateSortOrder(cpa) Then
                            result = False
                            Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to update sort order of existing mapping for product ""{0}"".", cpa.ProductId))
                        End If
                    End If
                Else
                    ' insert
                    If Catalog.Category.AddProduct(cpa.CategoryId, cpa.ProductId) Then
                        ' update SortOrder value after insert, if present
                        If Me.ImportFields.Contains("SortOrder", StringComparer.InvariantCultureIgnoreCase) Then
                            If Not Datalayer.CategoryProductAssociationMapper.UpdateSortOrder(cpa) Then
                                result = False
                                Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to update sort order of newly added mapping for product ""{0}"".", cpa.ProductId))
                            End If
                        End If
                    Else
                        Me.ImportedProducts.Remove(cpa.ProductId)

                        result = False
                        Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to assign product ""{0}"" to category.", cpa.ProductId))
                    End If
                End If
            Catch ex As Exception
                AddMessage(Content.DisplayMessageType.Exception, "Unable to save row: " + ex.ToString())
            End Try

            Return result
        End Function

        Public Overrides Function ProcessPostImport() As Boolean
            Dim result As Boolean = True

            ' remove products from the category that were not in the import
            For Each p As Catalog.Product In Me.Products
                If Not Me.ImportedProducts.Contains(p.Bvin, StringComparer.InvariantCultureIgnoreCase) Then
                    If Not Catalog.Category.RemoveProduct(Me.CategoryId, p.Bvin) Then
                        result = False
                        Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to remove product ""{0}"" from category.", p.Bvin))
                    End If
                End If
            Next

            Return result
        End Function

    End Class

End Namespace