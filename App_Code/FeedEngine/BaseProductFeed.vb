Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.IO
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine

    Public MustInherit Class BaseProductFeed
        Inherits BaseFeed

        Private pricingWorkflow As BusinessRules.Workflow
        Private _IncludeChoiceCombinations As Boolean
        Private _IncludeChoiceCombinationParents As Boolean
        Protected _Products As Collection(Of Catalog.Product)

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Base Product Feed"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "baseproduct.txt"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_PRODUCTINVENTORY() As String
            Get
                Return "9999"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_INCLUDECHOICECOMBINATIONS() As Boolean
            Get
                Return False
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_INCLUDECHOICECOMBINATIONPARENTS() As Boolean
            Get
                Return False
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property FeedType As String
            Get
                Return "Product"
            End Get
        End Property

        Public Overridable ReadOnly Property Products() As Collection(Of Catalog.Product)
            Get
                If Me._Products Is Nothing OrElse Me._Products.Count = 0 Then
                    Me._Products = New Collection(Of Catalog.Product)

                    Dim psc As New Catalog.ProductSearchCriteria()
                    psc.DisplayInactiveProducts = False
                    psc.Status = Catalog.ProductStatus.Active
                    psc.SpecialProductTypeOne = Catalog.SpecialProductTypes.Normal  ' excludes kits & gift certificates

                    ' get ALL products
                    Me._Products = Catalog.InternalProduct.FindByCriteria(psc)

                    ' get first 10 products (use for testing)
                    'Me._Products = Catalog.InternalProduct.FindByCriteria(psc, 1, 10, 10)    ' use for testing: gets first 10 products (instead of all)

                    ' get ALL products in 250 product chunks (pages) - use for larger product catalogs where the above method is hitting a SQL timeout and returning 0 items
                    'Dim pageSize As Integer = 250
                    'Dim rowCount As Integer = 0
                    'Dim i As Integer = 0
                    'Do
                    '    Dim results As Collection(Of Catalog.Product) = Catalog.InternalProduct.FindByCriteria(psc, i, pageSize, rowCount)
                    '    For Each p As Catalog.Product In results
                    '        Me._Products.Add(p)
                    '    Next

                    '    rowCount = results.Count
                    '    results = Nothing
                    '    i += pageSize
                    'Loop While rowCount = pageSize

                    ' EXAMPLE: exclude products by custom criteria
                    'For i As Integer = Me._Products.Count - 1 To 0 Step -1
                    '    ' remove product from feed if it is one of these two Product Types
                    '    Dim productTypeId As String = Me._Products(i).ProductTypeId
                    '    If productTypeId = "2BFD6936-652B-4684-833E-3C0799DEAC4C" OrElse productTypeId = "7CB31D02-DC1B-414A-94FB-1EC6D8978101" Then
                    '        Me._Products.RemoveAt(i)
                    '    End If
                    'Next
                End If

                Return Me._Products
            End Get
        End Property

        Public Overridable Property IncludeChoiceCombinations() As Boolean
            Get
                Return Me._IncludeChoiceCombinations
            End Get
            Set(value As Boolean)
                Me._IncludeChoiceCombinations = value
            End Set
        End Property

        Public Overridable Property IncludeChoiceCombinationParents() As Boolean
            Get
                Return Me._IncludeChoiceCombinationParents
            End Get
            Set(value As Boolean)
                Me._IncludeChoiceCombinationParents = value
            End Set
        End Property

#End Region

        Sub New(ByVal componentId As String)
            MyBase.New(componentId)

            Me.SettingsManager = New Datalayer.ComponentSettingsManager(componentId)

            Dim setting As String = String.Empty

            setting = Me.SettingsManager.GetSetting("IncludeChoiceCombinations")
            Me._IncludeChoiceCombinations = If(Not String.IsNullOrEmpty(setting), System.Convert.ToBoolean(setting), Me.DEFAULT_INCLUDECHOICECOMBINATIONS)

            setting = Me.SettingsManager.GetSetting("IncludeChoiceCombinationParents")
            Me._IncludeChoiceCombinationParents = If(Not String.IsNullOrEmpty(setting), System.Convert.ToBoolean(setting), Me.DEFAULT_INCLUDECHOICECOMBINATIONPARENTS)

            pricingWorkflow = BusinessRules.Workflow.FindByName("Product Pricing")
            Me._Products = Nothing
        End Sub

        Public Overrides Sub SaveSettings()
            MyBase.SaveSettings()

            Me.SettingsManager.SaveSetting("IncludeChoiceCombinations", Me.IncludeChoiceCombinations.ToString(), "Develisys", "Product Feed", Me.FeedName)
            Me.SettingsManager.SaveSetting("IncludeChoiceCombinationParents", Me.IncludeChoiceCombinationParents.ToString(), "Develisys", "Product Feed", Me.FeedName)
        End Sub


        Public Overrides Sub GenerateFeed()
            MyBase.GenerateFeed()

            ' memory cleanup - clear large in-memory objects
            Me._Products = Nothing
        End Sub

        Protected Overrides Sub Generate()
            For Each p As Catalog.Product In Me.Products
                If p IsNot Nothing AndAlso Not String.IsNullOrEmpty(p.Bvin) Then
                    If Me.IncludeChoiceCombinationParents OrElse Not Me.IncludeChoiceCombinations Then
                        AddProductRow(p)

                        ' LINE BREAK
                        AddColumn(ControlChars.NewLine)
                    End If

                    If Me.IncludeChoiceCombinations Then
                        For Each choiceP As Catalog.Product In Me.GetChoiceProducts(p)
                            AddProductRow(choiceP)

                            ' LINE BREAK
                            AddColumn(ControlChars.NewLine)
                        Next
                    End If
                End If
            Next

            ' clear the feed file if no products were returned
            If Me._Products.Count = 0 Then
                AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Warning, Me.FeedName, "Feed returned 0 products...clearing feed file.")

                Try
                    Me.Feed.Close()
                    Me.Feed.Dispose()
                    Me.Feed = New FileStream(Me.PhysicalFilePath, FileMode.Create)
                Catch ex As Exception
                    AuditLog.LogException(ex)
                End Try
            End If
        End Sub

        Protected MustOverride Sub AddProductRow(ByRef p As Catalog.Product)

#Region " Product Helper Functions "

        Protected Overridable Function GetParentProductBvin(ByRef p As Catalog.Product) As String
            Dim result As String = p.Bvin

            If Not String.IsNullOrEmpty(p.ParentId) Then
                result = p.ParentId
            End If

            Return result
        End Function

        Protected Overridable Function GetParentProduct(ByRef p As Catalog.Product) As Catalog.Product
            Dim result As Catalog.Product = Nothing
            
            If p IsNot Nothing AndAlso Not String.IsNullOrEmpty(p.Bvin) Then
                If String.IsNullOrEmpty(p.ParentId) Then
                    result = p
                Else
                    result = CType(Me.Context.Items("ParentProduct" + Me.Bvin), Catalog.Product)
                    If result Is Nothing OrElse result.Bvin <> p.ParentId Then
                        result = Catalog.InternalProduct.FindByBvin(p.ParentId)
                        Me.Context.Items("ParentProduct" + Me.Bvin) = result
                    End If
                End If
            End If

            Return result
        End Function

        Protected Overridable Function GetChoiceProducts(ByRef p As Catalog.Product) As Collection(Of Catalog.Product)
            Dim result As New Collection(Of Catalog.Product)
            
            If p IsNot Nothing AndAlso Not String.IsNullOrEmpty(p.Bvin) Then
                If String.IsNullOrEmpty(p.ParentId) Then
                    p = Catalog.InternalProduct.FindByBvin(p.Bvin)  ' load the full Product object so we can check the choice combinations
                    Me.Context.Items("ParentProduct" + Me.Bvin) = p

                    If p.ChoiceCombinations.Count > 0 Then
                        For Each choiceP As Catalog.Product In p.GlobalProduct.GetCombinationProducts()
                            ' merge up-to-date parent data
                            choiceP.AdditionalImages = p.AdditionalImages
                            choiceP.CustomProperties = p.CustomProperties
                            choiceP.ImageFileMediumAlternateText = p.ImageFileMediumAlternateText
                            choiceP.ImageFileSmallAlternateText = p.ImageFileSmallAlternateText
                            choiceP.ManufacturerId = p.ManufacturerId
                            choiceP.MetaKeywords = p.MetaKeywords
                            choiceP.MetaTitle = p.MetaTitle
                            choiceP.MinimumQty = p.MinimumQty
                            choiceP.OutOfStockMode = p.OutOfStockMode
                            choiceP.PostContentColumnId = p.PostContentColumnId
                            choiceP.PreContentColumnId = p.PreContentColumnId
                            choiceP.Reviews = p.Reviews
                            choiceP.RewriteUrl = p.RewriteUrl
                            choiceP.ShippingHeight = p.ShippingHeight
                            choiceP.ShippingLength = p.ShippingLength
                            choiceP.ShippingMode = p.ShippingMode
                            choiceP.ShippingWidth = p.ShippingWidth
                            choiceP.ShipSeparately = p.ShipSeparately
                            choiceP.SpecialProductType = p.SpecialProductType
                            choiceP.TaxClass = p.TaxClass
                            choiceP.TaxExempt = p.TaxExempt
                            choiceP.TemplateName = p.TemplateName
                            choiceP.VendorId = p.VendorId

                            result.Add(choiceP)
                        Next
                    End If
                End If
            End If

            Return result
        End Function

        Protected Overridable Function GetProductCategory(ByRef p As Catalog.Product) As String
            Dim result As String = String.Empty

            Dim categories As Collection(Of Catalog.Category) = Catalog.InternalProduct.GetCategories(Me.GetParentProductBvin(p))
            If categories.Count > 0 Then
                If categories.Count = 1 Then
                    result = categories(0).Name
                Else
                    For Each c As Catalog.Category In categories
                        ' favor manual categories over auto-generated ones
                        If c.SourceType = Catalog.CategorySourceType.Manual Then
                            result = c.Name
                            Exit For
                        End If
                    Next

                    ' if no manual category was found, arbitrarily pick the first category
                    If String.IsNullOrEmpty(result) Then
                        result = categories(0).Name
                    End If
                End If
            End If

            Return result
        End Function

        Protected Overridable Function GetProductCategoryBreadcrumb(ByRef p As Catalog.Product) As String
            If p Is Nothing OrElse String.IsNullOrEmpty(p.Bvin) Then
                Return String.Empty
            End If

            Dim result As New StringBuilder()

            Dim categories As Collection(Of Catalog.Category) = Catalog.InternalProduct.GetCategories(Me.GetParentProductBvin(p))
            If categories IsNot Nothing AndAlso categories.Count > 0 Then
                ' 1. Find a category to use to build the breadcrumb
                Dim bvin As String = String.Empty

                ' favor non-hidden categories
                Dim visibleCategories As List(Of Catalog.Category) = categories.Where(Function(c) c.Hidden = False).ToList()
                If visibleCategories.Count > 0 Then
                    If visibleCategories.Count = 1 Then
                        bvin = visibleCategories(0).Bvin
                    Else
                        ' favor non-hidden, manual categories
                        Dim manualCategories As List(Of Catalog.Category) = visibleCategories.Where(Function(c) c.SourceType = Catalog.CategorySourceType.Manual).ToList()
                        If manualCategories.Count > 0 Then
                            bvin = manualCategories(0).Bvin
                        Else
                            ' if none of the visible categories are Manual categories, return the first visible category
                            bvin = visibleCategories(0).Bvin
                        End If
                    End If
                Else
                    Dim manualCategories As List(Of Catalog.Category) = categories.Where(Function(c) c.SourceType = Catalog.CategorySourceType.Manual).ToList()
                    If manualCategories.Count > 0 Then
                        ' return the first (hidden) Manual category
                        bvin = manualCategories(0).Bvin
                    End If
                End If

                ' if no non-hidden and/or manual category was found, arbitrarily pick the first category
                If String.IsNullOrEmpty(bvin) Then
                    bvin = categories(0).Bvin
                End If


                ' 2. Build the breadcrumb
                Dim breadcrumbTrail As List(Of Catalog.Category) = Catalog.Category.BuildParentTrail(bvin).Reverse().ToList()
                For Each c As Catalog.Category In breadcrumbTrail
                    If result.Length > 0 Then
                        result.Append(" > ")
                    End If

                    result.Append(c.Name)
                Next
            End If

            Return result.ToString()
        End Function

        Protected Overridable Function GetProductManufacturer(ByRef p As Catalog.Product) As String
            Dim result As String = String.Empty

            Dim parentP As Catalog.Product = Me.GetParentProduct(p)
            If parentP IsNot Nothing Then
                If Not String.IsNullOrEmpty(parentP.ManufacturerId) AndAlso parentP.ManufacturerId <> "- No Manufacturer -" Then
                    Dim m As Contacts.Manufacturer = Contacts.Manufacturer.FindByBvin(parentP.ManufacturerId)
                    If m IsNot Nothing AndAlso Not String.IsNullOrEmpty(m.Bvin) Then
                        result = m.DisplayName
                    End If
                End If
            End If

            Return result
        End Function

        Protected Overridable Function GetProductVendor(ByRef p As Catalog.Product) As String
            Dim result As String = String.Empty

            Dim parentP As Catalog.Product = Me.GetParentProduct(p)
            If parentP IsNot Nothing Then
                If Not String.IsNullOrEmpty(parentP.VendorId) AndAlso parentP.VendorId <> "- No Vendor -" Then
                    Dim v As Contacts.Vendor = Contacts.Vendor.FindByBvin(parentP.VendorId)
                    If v IsNot Nothing AndAlso Not String.IsNullOrEmpty(v.Bvin) Then
                        result = v.DisplayName
                    End If
                End If
            End If

            Return result
        End Function

        Protected Overridable Function GetProductPrice(ByRef p As Catalog.Product) As String
            Return p.GetCurrentPrice(String.Empty, 0D, Nothing, pricingWorkflow).ToString("0.00")
        End Function

        Protected Overridable Function GetProductShipFromAddress(ByRef p As Catalog.Product) As Contacts.Address
            Dim result As Contacts.Address = Nothing

            Dim parentP As Catalog.Product = Me.GetParentProduct(p)
            If parentP IsNot Nothing Then
                Select Case parentP.ShippingMode

                    Case Shipping.ShippingMode.ShipFromSite
                        result = WebAppSettings.SiteShippingAddress

                    Case Shipping.ShippingMode.ShipFromManufacturer
                        Dim m As Contacts.Manufacturer = Contacts.Manufacturer.FindByBvin(parentP.ManufacturerId)
                        If Not String.IsNullOrEmpty(m.Bvin) Then
                            result = m.Address
                        End If

                    Case Shipping.ShippingMode.ShipFromVendor
                        Dim v As Contacts.Vendor = Contacts.Vendor.FindByBvin(parentP.VendorId)
                        If Not String.IsNullOrEmpty(v.Bvin) Then
                            result = v.Address
                        End If

                    Case Shipping.ShippingMode.None
                        ' do nothing
                End Select
            End If

            Return result
        End Function

        Protected Overridable Function GetProductType(ByRef p As Catalog.Product) As String
            Dim result As String = String.Empty

            Dim parentP As Catalog.Product = Me.GetParentProduct(p)
            If parentP IsNot Nothing Then
                Dim pt As Catalog.ProductType = Catalog.ProductType.FindByBvin(parentP.ProductTypeId)
                If Not String.IsNullOrEmpty(pt.Bvin) Then
                    result = pt.ProductTypeName
                End If
            End If

            Return result
        End Function

        Protected Overridable Function GetProductPropertyValue(ByRef p As Catalog.Product, ByRef pp As Catalog.ProductProperty) As String
            Dim result As String = String.Empty

            Dim propertyValue As String = Catalog.InternalProduct.GetPropertyValue(Me.GetParentProductBvin(p), pp.Bvin)
            result = Catalog.ProductProperty.GetProductTypePropertyValue(pp, propertyValue)

            Return result
        End Function

        Protected Overridable Function GetProductInventory(ByRef p As Catalog.Product) As String
            Dim result As String = Me.DEFAULT_PRODUCTINVENTORY

            If p.IsTrackingInventory Then
                result = p.Inventory.QuantityAvailableForSale.ToString("0")
            End If

            Return result
        End Function

        Protected Overridable Function GetProductKeywords(ByRef p As Catalog.Product, ByVal delimiter As Char, ByVal maxLength As Integer) As String
            Return GetProductKeywords(p, delimiter, Integer.MaxValue, maxLength)
        End Function
        Protected Overridable Function GetProductKeywords(ByRef p As Catalog.Product, ByVal delimiter As Char, ByVal maxLength As Integer, ByVal maxKeywordPhrases As Integer) As String
            Dim result As String = String.Empty

            Dim parentP As Catalog.Product = Me.GetParentProduct(p)
            If parentP IsNot Nothing Then
                Dim sb As New StringBuilder()
                Dim keywords As New Collection(Of String)

                ' start with the MetaKeywords
                If Not String.IsNullOrEmpty(parentP.MetaKeywords) Then
                    Dim metaKeywordArray As String() = parentP.MetaKeywords.Replace("  ", " ").Replace(";", ",").Split(",")
                    For Each kw As String In metaKeywordArray
                        keywords.Add(kw)

                        If keywords.Count = maxKeywordPhrases Then
                            Exit For
                        End If
                    Next
                End If

                ' if we don't have enough keywords, add the (search) Keywords
                If keywords.Count < maxKeywordPhrases Then
                    If Not String.IsNullOrEmpty(parentP.Keywords) Then
                        Dim keywordArray As String() = parentP.Keywords.Replace("  ", " ").Replace(";", ",").Split(",")
                        For Each kw As String In keywordArray
                            keywords.Add(kw)

                            If keywords.Count = maxKeywordPhrases Then
                                Exit For
                            End If
                        Next
                    End If
                End If

                ' if we don't have ANY keywords, use the store Meta Keywords as a last ditch attempt
                If keywords.Count = 0 Then
                    If Not String.IsNullOrEmpty(WebAppSettings.MetaKeywords) Then
                        Dim keywordArray As String() = WebAppSettings.MetaKeywords.Replace("  ", " ").Replace(";", ",").Split(",")
                        For Each kw As String In keywordArray
                            keywords.Add(kw)

                            If keywords.Count = maxKeywordPhrases Then
                                Exit For
                            End If
                        Next
                    End If
                End If

                For Each sku As String In keywords
                    sb.AppendFormat("{0}{1}", sku, delimiter)
                Next
                result = sb.ToString().TrimEnd(delimiter)

                If result.Length > maxLength Then
                    Dim pos As Integer = result.Substring(0, maxLength).LastIndexOf(delimiter)
                    If pos > 0 Then
                        result = result.Substring(0, pos)
                    Else
                        result = result.Substring(0, maxLength)
                    End If
                End If
            End If

            Return result
        End Function

        Protected Overridable Function GetProductReviews(ByRef p As Catalog.Product) As Collection(Of Catalog.ProductReview)
            Dim result As Collection(Of Catalog.ProductReview)

            If p.Reviews IsNot Nothing AndAlso p.Reviews.Count > 0 Then
                result = p.Reviews
            Else
                result = Catalog.ProductReview.FindByProductBvin(Me.GetParentProductBvin(p), False)
            End If

            Return result
        End Function

#End Region

#Region " Product URL Functions "

        Protected Overridable Function CreateProductUrl(ByRef p As Catalog.Product) As String
            Dim result As String = String.Empty

            If p IsNot Nothing AndAlso Not String.IsNullOrEmpty(p.Bvin) Then
                Dim affid As String = String.Empty
                If Not String.IsNullOrEmpty(Me.AffiliateReferralID) Then
                    affid = String.Format("{0}={1}", WebAppSettings.AffiliateQueryStringName, Me.AffiliateReferralID)
                End If

                result = BVSoftware.Bvc5.Core.Utilities.UrlRewriter.BuildUrlForProduct(Me.GetParentProduct(p), WebAppSettings.SiteStandardRoot, affid)
                result = CreateFullyQualifiedUrl(result)
            End If

            Return result
        End Function

        Protected Overridable Function CreateProductImageUrl(ByRef p As Catalog.Product) As String
            Dim result As String = String.Empty

            If p IsNot Nothing AndAlso Not String.IsNullOrEmpty(p.Bvin) Then
	        Dim imageUrl As String = p.ImageFileMedium
                If String.IsNullOrEmpty(imageUrl) AndAlso Not String.IsNullOrEmpty(p.ParentId) Then
                    Dim parentP As Catalog.Product = Me.GetParentProduct(p)
                    If parentP IsNot Nothing Then
                        If Not String.IsNullOrEmpty(parentP.ImageFileMedium) Then
                            imageUrl = parentP.ImageFileMedium
                        End If
                    End If
                End If

                If Not String.IsNullOrEmpty(imageUrl) Then
                    result = Me.CreateFullyQualifiedUrl(imageUrl)
                End If
	    End If
            
            Return result
        End Function

        Protected Overridable Function CreateProductAdditionalImageUrl(ByRef pi As Catalog.ProductImage) As String
            Dim result As String = String.Empty

            If pi IsNot Nothing AndAlso Not String.IsNullOrEmpty(pi.Bvin) Then
                If Not String.IsNullOrEmpty(pi.FileName) Then
                    result = Me.CreateFullyQualifiedUrl(pi.FileName)
                End If
            End If

            Return result
        End Function

#End Region

    End Class

End Namespace