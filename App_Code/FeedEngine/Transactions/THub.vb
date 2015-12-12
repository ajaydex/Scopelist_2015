Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine.Transactions

    Public Class THub
        Inherits BaseTransactionFeed

        Private Const COMPONENTID As String = "76A8D700-2273-11E0-B340-25A6DFD72085"

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FIELDDELIMITER() As String
            Get
                Return ","
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_DATEFORMAT As String
            Get
                Return "MM/dd/yyyy"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "T-Hub"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "thub.csv"
            End Get
        End Property

#End Region

#Region " Properties "

#End Region


        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Sub AddHeaderRow()
            AddRow( _
                "ORDER_NO", _
                "STORE_NAME", _
                "TXN_DT", _
                "CCY_CODE", _
                "PAYMENTMETHOD_REF", _
                "PHONE", _
                "EMAIL", _
                "BADDR_FIRST_NM", _
                "BADDR_LAST_NM", _
                "BADDR_COMPANY", _
                "BADDR_LINE1", _
                "BADDR_LINE2", _
                "BADDR_LINE3", _
                "BADDR_CITY", _
                "BADDR_STATE", _
                "BADDR_ZIP", _
                "BADDR_COUNTRY", _
                "SADDR_FIRST_NM", _
                "SADDR_LAST_NM", _
                "SADDR_PHONE", _
                "SADDR_EMAIL", _
                "SADDR_COMPANY", _
                "SADDR_LINE1", _
                "SADDR_LINE2", _
                "SADDR_LINE3", _
                "SADDR_CITY", _
                "SADDR_STATE", _
                "SADDR_ZIP", _
                "SADDR_COUNTRY", _
                "CreditCardType", _
                "CreditCardExpiration", _
                "CreditCardName", _
                "CreditCardNumber", _
                "PO_NUMBER", _
                "SALES_REP", _
                "TERMS_REF", _
                "SHIP_METHOD_REF", _
                "MEMO", _
                "TAX1_TOTAL", _
                "TAX2_TOTAL", _
                "EXCHANGE_RATE", _
                "CUST_FIELD1", _
                "CUST_FIELD2", _
                "CUST_FIELD3", _
                "CUST_FIELD4", _
                "CUST_FIELD5", _
                "TOTAL_SHIP_COST", _
                "TOTAL_HANDLING_COST", _
                "TOTAL_INSURANCE_COST", _
                "TOTAL_DISCOUNT_AMT", _
                "TOTAL_ORDER_AMT", _
                "ITEM_NAME", _
                "ITEM_DESC", _
                "ITEM_QUANTITY", _
                "ITEM_RATE", _
                "ITEM_AMOUNT")
        End Sub

        Protected Overrides Sub AddOrderRow(ByRef o As Orders.Order)
            Dim orderPayment As Orders.OrderPayment = GetOrderPayment(o)
            Dim creditCardName As String = If(orderPayment.PaymentMethodId = WebAppSettings.PaymentIdCreditCard, Payment.CreditCardType.FindByCode(orderPayment.CreditCardType).LongName, String.Empty)
            Dim items As Collection(Of Orders.LineItem) = Orders.LineItem.FindByOrderId(o.Bvin)

            For Each li As Orders.LineItem In items
                AddColumn(o.OrderNumber)
                AddColumn(WebAppSettings.SiteName)
                AddColumn(o.TimeOfOrder.ToString(Me.DateFormat))
                AddColumn("USD")
                AddColumn(orderPayment.PaymentMethodName)
                AddColumn(o.BillingAddress.Phone)
                AddColumn(o.UserEmail)
                AddColumn(o.BillingAddress.FirstName)
                AddColumn(o.BillingAddress.LastName)
                AddColumn(o.BillingAddress.Company)
                AddColumn(o.BillingAddress.Line1)
                AddColumn(o.BillingAddress.Line2)
                AddColumn(o.BillingAddress.Line3)
                AddColumn(o.BillingAddress.City)
                AddColumn(o.BillingAddress.RegionName)
                AddColumn(o.BillingAddress.PostalCode)
                AddColumn(o.BillingAddress.CountryName)
                AddColumn(o.ShippingAddress.FirstName)
                AddColumn(o.ShippingAddress.LastName)
                AddColumn(o.ShippingAddress.Phone)
                AddColumn(o.UserEmail)
                AddColumn(o.ShippingAddress.Company)
                AddColumn(o.ShippingAddress.Line1)
                AddColumn(o.ShippingAddress.Line2)
                AddColumn(o.ShippingAddress.Line3)
                AddColumn(o.ShippingAddress.City)
                AddColumn(o.ShippingAddress.RegionName)
                AddColumn(o.ShippingAddress.PostalCode)
                AddColumn(o.ShippingAddress.CountryName)
                AddColumn(creditCardName)
                AddColumn(If(orderPayment.PaymentMethodId = WebAppSettings.PaymentIdCreditCard, String.Format("{0}/{1}", orderPayment.CreditCardExpMonth, orderPayment.CreditCardExpYear), ""))
                AddColumn(orderPayment.CreditCardHolder)
                AddColumn(orderPayment.CreditCardNumber)
                AddColumn(orderPayment.PurchaseOrderNumber)
                AddColumn(String.Empty)
                AddColumn(String.Empty)
                AddColumn(o.ShippingMethodDisplayName)
                AddColumn(o.Instructions)
                AddColumn(System.Convert.ToDouble(o.TaxTotal))
                AddColumn(0D)
                AddColumn(0D)
                AddColumn(String.Empty)
                AddColumn(String.Empty)
                AddColumn(String.Empty)
                AddColumn(String.Empty)
                AddColumn(String.Empty)
                AddColumn(System.Convert.ToDouble(o.ShippingTotal))
                AddColumn(System.Convert.ToDouble(o.HandlingTotal))
                AddColumn(0D)
                AddColumn(System.Convert.ToDouble(o.OrderDiscounts))
                AddColumn(System.Convert.ToDouble(o.GrandTotal))
                AddColumn(li.ProductSku)
                AddColumn(li.ProductName)
                AddColumn(System.Convert.ToDouble(li.Quantity))
                AddColumn(System.Convert.ToDouble(li.AdjustedPrice))
                AddColumn(System.Convert.ToDouble(li.LineTotal))

                ' LINE BREAK
                AddColumn(ControlChars.NewLine)
            Next
        End Sub

        Protected Overrides Sub Generate()
            For Each o As Orders.Order In Me.Transactions
                AddOrderRow(o)
            Next
        End Sub

    End Class

End Namespace