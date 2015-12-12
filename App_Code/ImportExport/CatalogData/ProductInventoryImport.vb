Imports System.Collections.ObjectModel
Imports System.Linq
Imports System.Reflection
Imports BVSoftware.BVC5.Core

Namespace ImportExport.CatalogData

    Public Class ProductInventoryImport
        Inherits BaseImport

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_IMPORTNAME As String
            Get
                Return "Inventory Import"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_REQUIREDIMPORTFIELDS As String()
            Get
                Return New String() {"ProductBvin"}
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_EXCLUDEDIMPORTFIELDS As String()
            Get
                Return New String() {"LastUpdated", _
                                     "Status", _
                                     "QuantityAvailableForSale", _
                                     "ReorderLevel"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property Bvin As String
            Get
                Return "1261AD24-2274-45B6-917F-21891D3915AE"
            End Get
        End Property

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Catalog.ProductInventory)
            End Get
        End Property

#End Region

        Public Overrides Function FindRowOjbect(key As Object) As Object
            Return Catalog.ProductInventory.FindByBvin(key.ToString())
        End Function

        Public Overrides Function ValidateRowObject(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result = MyBase.ValidateRowObject(data)

            If result Then
                Dim item As Catalog.ProductInventory = CType(data(Me.KeyField), Catalog.ProductInventory)

                ' make sure that the corresponding product exists and has inventory tracking enabled
                Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(item.ProductBvin)
                If p Is Nothing Then
                    result = False
                    Me.AddMessage(Content.DisplayMessageType.Error, String.Format("ProductBvin ""{0}"" does not match a product in the database - skipping row.", item.ProductBvin))
                Else
                    If Not p.TrackInventory Then
                        p.TrackInventory = True
                        If Not Catalog.InternalProduct.Update(p) Then
                            result = False
                            Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Failed to enable inventory tracking for ProductBvin ""{0}"" - skipping row.", item.ProductBvin))
                        End If
                    End If
                End If

                If result Then
                    ' prevent inserting of duplicate inventory records
                    If String.IsNullOrEmpty(item.Bvin) Then
                        Dim existingItem As Catalog.ProductInventory = Catalog.ProductInventory.FindByProductId(item.ProductBvin, p.TrackInventory)
                        If Not String.IsNullOrEmpty(existingItem.Bvin) Then
                            result = False
                            Me.AddMessage(Content.DisplayMessageType.Error, String.Format("ProductBvin ""{0}"" already has an inventory record. You must update this existing record rather than trying to create a new one - skipping row.", item.ProductBvin))
                        End If
                    End If
                End If
            End If

            Return result
        End Function

        Public Overrides Function SaveRow(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = False

            If TypeOf data(0) Is Catalog.ProductInventory Then
                Dim item As Catalog.ProductInventory = CType(data(0), Catalog.ProductInventory)

                If String.IsNullOrEmpty(item.Bvin) Then
                    ' insert
                    If Catalog.ProductInventory.Insert(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to save new inventory record for ProductBvin ""{0}"".", item.ProductBvin))
                    End If
                Else
                    ' update
                    If Catalog.ProductInventory.Update(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to update inventory record ""{0}"" for ProductBvin ""{1}"". Make sure that this inventory record exists.", item.Bvin, item.ProductBvin))
                    End If
                End If
            End If

            Return result
        End Function

    End Class

End Namespace