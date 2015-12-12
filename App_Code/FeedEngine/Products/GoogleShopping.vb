Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine.Products

    Public Class GoogleShopping
        Inherits BaseProductFeed

        Private Const COMPONENTID As String = "AB948F1F-440B-4c04-9FAD-2059897DC992"

        Private _AdditionalAttributes As Collection(Of Catalog.ProductProperty)
        Private _CustomAttributes As Collection(Of Catalog.ProductProperty)

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FIELDWRAPCHARACTER As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Google Shopping"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "googleshopping.txt"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_HOSTNAME() As String
            Get
                Return "uploads.google.com"
            End Get
        End Property

#End Region

#Region " Properties "

        Protected Overridable Property AdditionalAttributes() As Collection(Of Catalog.ProductProperty)
            Get
                Return Me._AdditionalAttributes
            End Get
            Set(ByVal value As Collection(Of Catalog.ProductProperty))
                Me._AdditionalAttributes = value
            End Set
        End Property

        Protected Overridable Property CustomAttributes() As Collection(Of Catalog.ProductProperty)
            Get
                Return Me._CustomAttributes
            End Get
            Set(ByVal value As Collection(Of Catalog.ProductProperty))
                Me._CustomAttributes = value
            End Set
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)

            Me._AdditionalAttributes = New Collection(Of Catalog.ProductProperty)
            Me._CustomAttributes = New Collection(Of Catalog.ProductProperty)
        End Sub

        Public Overrides Sub GenerateFeed()
            Me._AdditionalAttributes = New Collection(Of Catalog.ProductProperty)
            Me._CustomAttributes = New Collection(Of Catalog.ProductProperty)

            MyBase.GenerateFeed()

            ' memory cleanup - clear large in-memory objects
            Me._AdditionalAttributes = Nothing
            Me._CustomAttributes = Nothing
        End Sub

        Protected Overrides Sub AddHeaderRow()
            AddColumn("expiration_date")
            AddColumn("description")
            AddColumn("id")
            If Me.IncludeChoiceCombinations Then
                AddColumn("item_group_id")
            End If
            AddColumn("image_link")
            AddColumn("additional_image_link")
            AddColumn("link")
            AddColumn("location")
            AddColumn("payment_accepted")
            AddColumn("payment_notes")
            AddColumn("pickup")
            AddColumn("price")
            AddColumn("price_type")
            AddColumn("quantity")
            AddColumn("title")
            AddColumn("condition")
            AddColumn("brand")
            AddColumn("mpn")
            AddColumn("product_type")
            AddColumn("availability")
            AddColumn("shipping")
            AddColumn("manufacturer")
            AddColumn("shipping_weight")
            AddColumn("shipping_length")
            AddColumn("shipping_width")
            AddColumn("shipping_height")
            AddColumn("product_review_count")
            AddColumn("product_review_average")

            ' TODO: gtin, isbn, upc --- combine into comma-delimited gtin field

            For Each pp As Catalog.ProductProperty In Catalog.ProductProperty.FindAll()
                Select Case FormatAttributeName(pp)

                    Case _
                        "adult", _
                        "adwords_grouping", _
                        "adwords_labels", _
                        "adwords_redirect", _
                        "age_group", _
                        "author", _
                        "color", _
                        "custom_label_0", _
                        "custom_label_1", _
                        "custom_label_2", _
                        "custom_label_3", _
                        "custom_label_4", _
                        "edition", _
                        "energy_efficiency_class", _
                        "excluded_destination", _
                        "feature", _
                        "featured_product", _
                        "gender", _
                        "genre", _
                        "google_product_category", _
                        "gtin", _
                        "identifier_exists", _
                        "isbn", _
                        "is_bundle", _
                        "material", _
                        "multipack", _
                        "online_only", _
                        "pattern", _
                        "promotion_id", _
                        "size", _
                        "unit_pricing_base_measure", _
                        "unit_pricing_measure", _
                        "upc", _
                        "year"

                        If pp.TypeCode <> Catalog.ProductPropertyType.None Then
                            Me.AdditionalAttributes.Add(pp)
                        End If

                    Case Else
                        If pp.TypeCode <> Catalog.ProductPropertyType.None AndAlso pp.DisplayOnSite = True Then
                            Me.CustomAttributes.Add(pp)
                        End If

                End Select
            Next

            ' Additional Attributes
            For Each pp As Catalog.ProductProperty In Me.AdditionalAttributes
                AddColumn(FormatAttributeName(pp))
            Next

            ' Custom Attributes
            For Each pp As Catalog.ProductProperty In Me.CustomAttributes
                Dim columnName As String = FormatAttributeName(pp)
                Dim columnType As String = String.Empty

                Select Case pp.TypeCode
                    Case Catalog.ProductPropertyType.TextField, _
                        Catalog.ProductPropertyType.MultipleChoiceField ', _
                        'Catalog.ProductPropertyType.MultiSelectChoiceField

                        columnType = "string"

                    Case Catalog.ProductPropertyType.DateField
                        columnType = "dateTime"

                    Case Catalog.ProductPropertyType.CurrencyField
                        columnType = "decimal"

                    Case Catalog.ProductPropertyType.HyperLink
                        columnType = "url"

                End Select

                AddColumn(String.Format("c:{0}:{1}", columnName, columnType), 100)
            Next

            AddColumn(ControlChars.NewLine)
        End Sub

        Protected Overrides Sub AddProductRow(ByRef p As BVSoftware.BVC5.Core.Catalog.Product)
            Dim manufacturerName As String = Me.GetProductManufacturer(p)

            ' expiration_date
            AddColumn(DateTime.Today.AddDays(30 - 1).ToString(Me.DateFormat))    ' subtract 1 day from 30 to allow for processing time

            ' description
            AddColumn(p.LongDescription, 5000)

            ' id
            AddColumn(p.Sku, 50)

            ' item_group_id
            If Me.IncludeChoiceCombinations Then
                AddColumn(Me.GetParentProduct(p).Sku, 50)
            End If

            ' image_link
            AddColumn(Me.CreateProductImageUrl(p), 2000)

            ' additional_image_link
            Dim images As New StringBuilder()
            Dim pi As Collection(Of Catalog.ProductImage) = Catalog.ProductImage.FindByProductId(Me.GetParentProductBvin(p))
            For i As Integer = 0 To pi.Count - 1
                If images.Length > 0 Then
                    images.Append(",")
                End If

                images.Append(Me.CreateFullyQualifiedUrl(pi(i).FileName))

                If i = (10 - 1) Then
                    Exit For
                End If
            Next
            AddColumn(images.ToString())

            ' link
            AddColumn(Me.CreateProductUrl(p), 2000)

            ' location
            AddColumn(Me.ConvertAddressToString(Me.GetProductShipFromAddress(p)))

            ' payment_accepted
            AddColumn(Me.GetPaymentMethods())

            ' payment_notes
            AddColumn(String.Empty)

            ' pickup
            If p.ShippingMode = Shipping.ShippingMode.ShipFromSite Then
                AddColumn(Boolean.TrueString.ToLower())
            Else
                AddColumn(Boolean.FalseString.ToLower())
            End If

            ' price
            AddColumn(Me.GetProductPrice(p))

            ' price_type
            AddColumn("starting")

            ' quantity
            AddColumn(Me.GetProductInventory(p))

            ' title
            AddColumn(p.ProductName, 150)

            ' condition
            AddColumn("new")

            ' brand
            AddColumn(manufacturerName, 70)

            ' mpn
            AddColumn(p.Sku, 70)

            ' product_type
            AddColumn(Me.GetProductCategoryBreadcrumb(p), 750)  ' 750 character length also enforced in GetProductCategoryBreadcrumb function

            ' availability
            If p.IsInStock Then
                AddColumn("in stock")
            ElseIf p.IsBackordered Then
                AddColumn("preorder")
            Else
                AddColumn("out of stock")
            End If

            ' shipping
            AddColumn(String.Empty)

            ' manufacturer
            AddColumn(manufacturerName)

            ' shipping_weight
            AddColumn(GetProductShippingWeight(p))

            ' shipping_length
            AddColumn(GetProductDimension(p.ShippingLength))

            ' shipping_width
            AddColumn(GetProductDimension(p.ShippingWidth))

            ' shipping_height
            AddColumn(GetProductDimension(p.ShippingHeight))

            ' product_review_count
            Dim reviews As Collection(Of Catalog.ProductReview) = Nothing
            If WebAppSettings.ProductReviewShow = True Then
                If WebAppSettings.ProductReviewModerate = True Then
                    reviews = Catalog.ProductReview.FindByProductBvin(p.Bvin, False)
                Else
                    reviews = Catalog.ProductReview.FindByProductBvin(p.Bvin, True)
                End If

                AddColumn(reviews.Count.ToString())
            Else
                AddColumn(String.Empty)
            End If

            ' product_review_average
            If WebAppSettings.ProductReviewShow = True AndAlso reviews.Count > 0 Then
                Dim rating As Integer = Catalog.ProductReview.CalculateReviewAverage(reviews)
                If rating > 0 Then
                    AddColumn(rating.ToString(0.0))
                Else
                    AddColumn(String.Empty)
                End If
            Else
                AddColumn(String.Empty)
            End If

            ' Additional Attributes
            Dim productProperties As Collection(Of Catalog.ProductProperty) = Catalog.ProductProperty.FindByProductType(Me.GetParentProduct(p).ProductTypeId)
            For Each pp As Catalog.ProductProperty In Me.AdditionalAttributes
                Dim currentProperty As Catalog.ProductProperty = pp
                If productProperties.Any(Function(productProperty As Catalog.ProductProperty) productProperty.Bvin = currentProperty.Bvin) Then
                    AddColumn(Me.GetProductPropertyValue(Me.GetParentProduct(p), pp))
                Else
                    AddColumn(String.Empty)
                End If
            Next

            ' Custom Attributes
            For Each pp As Catalog.ProductProperty In Me.CustomAttributes
                Dim currentProperty As Catalog.ProductProperty = pp
                If productProperties.Any(Function(productProperty As Catalog.ProductProperty) productProperty.Bvin = currentProperty.Bvin) Then
                    AddColumn(Me.GetProductPropertyValue(Me.GetParentProduct(p), pp))
                Else
                    AddColumn(String.Empty)
                End If
            Next
        End Sub


#Region " Helper Functions "

        Protected Overrides Function GetProductCategoryBreadcrumb(ByRef p As Catalog.Product) As String
            If p Is Nothing OrElse String.IsNullOrEmpty(p.Bvin) Then
                Return String.Empty
            End If

            Dim result As New StringBuilder()

            Dim categories As Collection(Of Catalog.Category) = Catalog.InternalProduct.GetCategories(Me.GetParentProductBvin(p))
            For Each category As Catalog.Category In categories
                Dim trail As New StringBuilder()
                Dim breadcrumbTrail As List(Of Catalog.Category) = Catalog.Category.BuildParentTrail(category.Bvin).Reverse().ToList()
                For Each c As Catalog.Category In breadcrumbTrail
                    If trail.Length > 0 Then
                        trail.Append(" > ")
                    End If

                    trail.Append(c.Name)
                Next

                If (result.Length + trail.Length < 750) Then
                    If result.Length > 0 Then
                        result.Append(",")
                    End If

                    result.Append(trail.ToString())
                End If
            Next

            Return result.ToString()
        End Function

        Protected Overridable Function GetProductShippingWeight(ByRef p As Catalog.Product) As String
            Dim result As String = String.Empty

            If p.ShippingWeight > 0 Then
                Select Case WebAppSettings.SiteShippingWeightType

                    Case Shipping.WeightType.Kilograms
                        result = String.Format("{0} kg", Math.Ceiling(p.ShippingWeight).ToString())

                    Case Shipping.WeightType.Pounds
                        result = String.Format("{0} oz", ( _
                                               System.Convert.ToInt32(16 * Math.Floor(p.ShippingWeight)) _
                                               + BVSoftware.BVC5.Core.Utilities.Conversions.DecimalPoundsToOunces(p.ShippingWeight)).ToString())

                    Case Else
                        ' do nothing

                End Select
            End If

            Return result
        End Function

        Protected Overridable Function GetProductDimension(ByVal dimension As Decimal) As String
            Dim result As String = String.Empty

            If dimension > 0 Then
                Select Case WebAppSettings.SiteShippingLengthType

                    Case Shipping.LengthType.Centimeters
                        result = String.Format("{0} cm", Math.Ceiling(dimension).ToString())

                    Case Shipping.LengthType.Inches
                        result = String.Format("{0} in", Math.Ceiling(dimension).ToString())

                    Case Else
                        ' do nothing

                End Select
            End If

            Return result
        End Function

        Protected Overrides Function GetPaymentMethods() As String
            Dim result As String = String.Empty

            For Each pm As Payment.PaymentMethod In Payment.AvailablePayments.EnabledMethods
                If pm.MethodId = WebAppSettings.PaymentIdCreditCard Then
                    For Each ct As Payment.CreditCardType In Payment.CreditCardType.FindAllActive()
                        result &= ct.LongName & ","
                    Next
                ElseIf pm.MethodId = WebAppSettings.PaymentIdCash _
                    OrElse pm.MethodId = WebAppSettings.PaymentIdCheck Then
                    result &= pm.MethodName & ","
                Else
                    ' ignore the other payment methods (PayPalExpress, GiftCertificate, LoyaltyPoints, CashOnDelivery, PurchaseOrder, Telephone)
                End If
            Next

            Return result.Trim().TrimEnd(","c)
        End Function

        Protected Overridable Function FormatAttributeName(ByVal pp As Catalog.ProductProperty) As String
            Dim result As StringBuilder

            Dim name As String = String.Empty
            If Not String.IsNullOrEmpty(pp.DisplayName) Then
                name = pp.DisplayName
            ElseIf Not String.IsNullOrEmpty(pp.PropertyName) Then
                name = pp.PropertyName
            Else
                name = pp.Bvin.Replace("-", String.Empty)
            End If

            result = New StringBuilder(Me.CleanText(name.Trim()).ToLower())
            result.Replace(".", " ")
            result.Replace(",", " ")
            result.Replace("?", String.Empty)
            result.Replace("!", String.Empty)
            result.Replace("-", "_")
            result.Replace("/", "_")
            result.Replace(":", "_")
            result.Replace("(", "_")
            result.Replace(")", "_")

            result.Replace("  ", "_")
            result.Replace(" ", "_")
            result.Replace("__", "_")

            Return result.ToString().TrimEnd("_"c)
        End Function

#End Region

    End Class

End Namespace