Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core
Imports System.Xml
Imports System.IO

Namespace WS4Processors

    Public Class ProductUpdatePricing
        Inherits Services.WS4.CommandProcessor

        Public Overrides ReadOnly Property CommandName() As String
            Get
                Return "ProductUpdatePricing"
            End Get
        End Property

        Public Overrides Function Help(ByVal summary As Boolean) As String
            Return "Updates only the pricing information for a product."
        End Function

        Public Overrides Function ProcessRequest(ByVal data As String) As BVSoftware.Bvc5.Core.Services.WS4.WS4Response
            Dim result As New BVSoftware.Bvc5.Core.Services.WS4.WS4Response

            Try
                Dim req As New ProductUpdatePricingRequest()
                req.FromXml(data)

                Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(req.Bvin)
                If p IsNot Nothing Then
                    If p.Sku.ToLower.Trim = req.Bvin.ToLower Then

                        p.SitePrice = req.SitePrice
                        p.SiteCost = req.SiteCost
                        p.ListPrice = req.MSRP
                        result.Success = Catalog.InternalProduct.Update(p)
                    End If
                End If

            Catch ex As Exception
                result.Errors.Add(New BVSoftware.Bvc5.Core.Services.WS4.WS4Error("Exception", ex.Message))
            End Try

            Return result
        End Function
    End Class

    Public Class ProductUpdatePricingRequest

        Private _bvin As String = String.Empty
        Private _sitePrice As Decimal = 0
        Private _msrp As Decimal = 0
        Private _siteCost As Decimal = 0

        Public Property Bvin() As String
            Get
                Return _bvin
            End Get
            Set(ByVal value As String)
                _bvin = value
            End Set
        End Property
        Public Property SitePrice() As Decimal
            Get
                Return _sitePrice
            End Get
            Set(ByVal value As Decimal)
                _sitePrice = value
            End Set
        End Property
        Public Property MSRP() As Decimal
            Get
                Return _msrp
            End Get
            Set(ByVal value As Decimal)
                _msrp = value
            End Set
        End Property
        Public Property SiteCost() As Decimal
            Get
                Return _siteCost
            End Get
            Set(ByVal value As Decimal)
                _siteCost = value
            End Set
        End Property

        Public Sub New()

        End Sub

        Public Sub New(ByVal bvin As String, ByVal sitePrice As Decimal, ByVal msrp As Decimal, ByVal siteCost As Decimal)

        End Sub

        Public Function ToXml() As String
            Dim result As String = String.Empty

            Dim sw As StringWriter = New StringWriter(System.Globalization.CultureInfo.InvariantCulture)
            Dim xw As XmlTextWriter = New XmlTextWriter(sw)

            xw.Formatting = Formatting.Indented
            xw.Indentation = 3
            xw.WriteStartDocument()


            xw.WriteStartElement("ProductPricing")

            xw.WriteElementString("BVIN", _bvin)
            xw.WriteElementString("SitePrice", _sitePrice)
            xw.WriteElementString("MSRP", _msrp)
            xw.WriteElementString("SiteCost", _siteCost)

            xw.WriteEndElement()


            xw.WriteEndDocument()
            xw.Flush()
            xw.Close()
            result = sw.GetStringBuilder.ToString()
            sw.Close()

            Return result
        End Function

        Public Sub FromXml(ByVal data As String)

            Dim _BVXmlReaderSettings As New XmlReaderSettings
            Dim sw As New System.IO.StringReader(data)
            Dim xr As XmlReader = XmlReader.Create(sw)
            Dim xdoc As New XPath.XPathDocument(xr)
            Dim nav As XPath.XPathNavigator = xdoc.CreateNavigator()

            If Not nav.SelectSingleNode("/ProductPricing") Is Nothing Then
                If nav.SelectSingleNode("/ProductPricing/BVIN") IsNot Nothing Then
                    _bvin = nav.SelectSingleNode("/ProductPricing/BVIN").Value
                End If

                If nav.SelectSingleNode("/ProductPricing/SitePrice") IsNot Nothing Then
                    _sitePrice = nav.SelectSingleNode("/ProductPricing/SitePrice").Value
                End If
                If nav.SelectSingleNode("/ProductPricing/MSRP") IsNot Nothing Then
                    _msrp = nav.SelectSingleNode("/ProductPricing/MSRP").Value
                End If
                If nav.SelectSingleNode("/ProductPricing/SiteCost") IsNot Nothing Then
                    _siteCost = nav.SelectSingleNode("/ProductPricing/SiteCost").Value
                End If                
            End If

            sw.Dispose()
            xr.Close()

        End Sub

    End Class

End Namespace