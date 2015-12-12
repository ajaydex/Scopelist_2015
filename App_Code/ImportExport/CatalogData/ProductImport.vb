Imports System.Linq
Imports System.Collections.ObjectModel
Imports System.Reflection
Imports BVSoftware.BVC5.Core

Namespace ImportExport.CatalogData

    Public Class ProductImport
        Inherits BaseImport

        Private templates As New StringCollection()
        Private allCats As New Collection(Of Catalog.Category)


#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_IMPORTNAME As String
            Get
                Return "Product Import"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_REQUIREDIMPORTFIELDS As String()
            Get
                Return New String() {"Sku", _
                                     "ProductName", _
                                     "SitePrice"}
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_EXCLUDEDIMPORTFIELDS As String()
            Get
                Return New String() {"AdditionalImages", _
                                     "Categories", _
                                     "ChoiceCombinations", _
                                     "ChoicesAndInputs", _
                                     "CreationDate", _
                                     "CreationDateUtc", _
                                     "GlobalProduct", _
                                     "HasVariants", _
                                     "IsNew", _
                                     "LastUpdated", _
                                     "MarkedAsDeleted", _
                                     "ProductURL", _
                                     "Reviews", _
                                     "Saved", _
                                     "SitePriceForDisplay"}
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_CUSTOMIMPORTFIELDS As String()
            Get
                Return New String() {"CategoryBvins"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property Bvin As String
            Get
                Return "0506D3B1-E9BE-4095-878F-CF50B13E88E2"
            End Get
        End Property

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Catalog.Product)
            End Get
        End Property

#End Region

        Public Overrides Function ProcessPreImport() As Boolean
            Dim result As Boolean = True

            templates = New StringCollection()
            For Each template As String In Content.ModuleController.FindCategoryTemplates()
                templates.Add(template.ToLower())
            Next

            allCats = Catalog.Category.FindAllLight()

            Return result
        End Function

        Public Overrides Function FindRowOjbect(key As Object) As Object
            Dim result As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(key.ToString())

            If result Is Nothing Then
                result = New Catalog.Product()
                result.ShippingMode = Shipping.ShippingMode.ShipFromSite
            End If

            Return result
        End Function

        Public Overrides Function ProcessCustomField(fieldName As String, fieldValue As String, ByVal obj As Object, ByRef output As Object) As Boolean
            Dim p As Catalog.Product = CType(obj, Catalog.Product)

            'Dim customFieldCount As Integer = Me.ImportHeader.Where(Function(field) Me.CustomImportFields.Contains(field.Key, StringComparer.InvariantCultureIgnoreCase)).Count()
            'output = New Object(customFieldCount) {}

            Select Case fieldName.ToLower()

                Case "categorybvins"
                    Dim categoryBvins As New Collection(Of String)
                    If String.IsNullOrEmpty(fieldValue) Then
                        ' do nothing
                    ElseIf fieldValue.Contains(",") Then
                        For Each bvin As String In fieldValue.Split(","c)
                            If Not String.IsNullOrEmpty(bvin) Then
                                categoryBvins.Add(bvin)
                            End If
                        Next
                    Else
                        categoryBvins.Add(fieldValue)
                    End If

                    output = categoryBvins

                    Dim oldCategoryBvins As Collection(Of String) = p.Categories
                    If oldCategoryBvins.Count = categoryBvins.Count Then
                        For Each bvin As String In oldCategoryBvins
                            If Not categoryBvins.Contains(bvin, StringComparer.InvariantCultureIgnoreCase) Then
                                Me.RowIsDirty = True
                                Exit For
                            End If
                        Next
                    Else
                        Me.RowIsDirty = True
                    End If

                Case Else
                    output = Nothing

            End Select

            Return True
        End Function

        Public Overrides Function ValidateRowObject(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = MyBase.ValidateRowObject(data)

            If result Then
                Dim item As Catalog.Product = CType(data(Me.KeyField), Catalog.Product)

                ' SpecialProductType -- make sure we have a Product (not a Gift Certificate or Kit)
                If item.SpecialProductType <> Catalog.SpecialProductTypes.Normal Then
                    result = False
                    Me.AddMessage(Content.DisplayMessageType.Error, String.Format("SpecialProductType ""{0}"" is invalid for this import -- only products (SpecialProductType = 0) are supported through this import - skipping row.", item.SpecialProductType.ToString()))
                End If

                ' Prevent adding of choice combination products
                If result Then
                    If String.IsNullOrEmpty(item.Bvin) AndAlso Not String.IsNullOrEmpty(item.ParentId) Then
                        result = False
                        Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Choice combination products (child products) can only be updated, not added, through the import tool - skipping row.", item.Sku))
                    End If
                End If

                ' Sku
                If result Then
                    Dim existingProduct As Catalog.Product = Catalog.InternalProduct.FindBySkuAll(item.Sku)
                    If existingProduct IsNot Nothing AndAlso existingProduct.Bvin <> item.Bvin Then
                        result = False
                        Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Sku ""{0}"" is already in use by another product - skipping row.", item.Sku))
                    End If
                End If

                ' TemplateName
                If result Then
                    If Me.ImportHeader.ContainsKey("TemplateName") Then
                        If Not templates.Contains(item.TemplateName.ToLower()) Then
                            result = False
                            Me.AddMessage(Content.DisplayMessageType.Error, String.Format("TemplateName ""{0}"" does not exist - skipping row.", item.TemplateName))
                        End If
                    End If
                End If
            End If
            
            Return result
        End Function

        Public Overrides Function ValidateCustomRowObjects(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = True

            ' CategoryBvins
            If data.ContainsKey("CategoryBvins") Then
                If TypeOf data("CategoryBvins") Is Collection(Of String) Then
                    Dim categoryBvins As Collection(Of String) = CType(data("CategoryBvins"), Collection(Of String))
                    For Each bvin As String In categoryBvins
                        If Catalog.Category.FindInCollection(allCats, bvin) Is Nothing Then
                            result = False
                            Me.AddMessage(Content.DisplayMessageType.Error, String.Format("CategoryBvins field contains the invalid bvin value ""{0}"" - skipping row.", bvin))
                        End If
                    Next
                Else
                    result = False
                    Me.AddMessage(Content.DisplayMessageType.Error, "Unable to validate field ""CategoryBvins"" - skipping row.")
                End If
            End If

            Return result
        End Function

        Public Overrides Function SaveRow(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = False

            Dim p As Catalog.Product = CType(data(Me.KeyField), Catalog.Product)

            If p.Commit() Then
                result = True

                ' only do this for parent products
                If String.IsNullOrEmpty(p.ParentId) Then
                    p.UpdateOrRemoveCustomUrls(p.RewriteUrl)

                    ' update Status and SitePriceOverrideText for child products
                    If p.ChoiceCombinations.Count > 0 Then
                        For Each child As Catalog.Product In Catalog.InternalProduct.FindChildren(p.Bvin)
                            If child.Status <> p.Status OrElse child.SitePriceOverrideText <> p.SitePriceOverrideText Then
                                child.Status = p.Status
                                child.SitePriceOverrideText = p.SitePriceOverrideText
                                If Not Catalog.InternalProduct.Update(child) Then
                                    Me.AddMessage(Content.DisplayMessageType.Error, "Unable to update Status and SitePriceOverrideText for child product ""{0}"".", child.Sku)
                                End If
                            End If
                        Next
                    End If
                End If
            Else
                Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to save product ""{0}"" - skipping row.", p.Sku))
            End If

            Return result
        End Function

        Public Overrides Function SaveCustomRowData(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = True

            Dim p As Catalog.Product = CType(data(Me.KeyField), Catalog.Product)

            ' CategoryBvins
            If data.ContainsKey("CategoryBvins") Then
                Dim currentCategories As Collection(Of String) = p.Categories
                Dim newCategories As Collection(Of String) = CType(data("CategoryBvins"), Collection(Of String))

                ' remove unselected categories
                For Each categoryBvin As String In currentCategories
                    If Not newCategories.Contains(categoryBvin, StringComparer.InvariantCultureIgnoreCase) Then
                        If Not Catalog.Category.RemoveProduct(categoryBvin, p.Bvin) Then
                            result = False
                            Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to remove product from category: {0}", categoryBvin))
                        End If
                    End If
                Next

                ' add new categories
                For Each categoryBvin As String In newCategories
                    If Not currentCategories.Contains(categoryBvin, StringComparer.InvariantCultureIgnoreCase) Then
                        If Not Catalog.Category.AddProduct(categoryBvin, p.Bvin) Then
                            result = False
                            Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to assign product to category: {0}", categoryBvin))
                        End If
                    End If
                Next
            End If

            Return result
        End Function

    End Class

End Namespace