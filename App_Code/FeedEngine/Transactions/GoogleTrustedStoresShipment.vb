Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine.Transactions

    Public Class GoogleTrustedStoresShipment
        Inherits BaseTransactionFeed

        Private Const COMPONENTID As String = "0DF4DFDA-E48F-4EC6-A4EB-021B1A526A58"
        Private _Carriers As StringDictionary

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FIELDWRAPCHARACTER As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Google Trusted Stores Shipment"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "gts-shipment.txt"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_STARTDATE() As DateTime
            Get
                Return DateTime.Today.AddDays(-1)
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_ENDDATE() As DateTime
            Get
                Return DateTime.Today
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_HOSTNAME() As String
            Get
                Return "uploads.google.com"
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property Transactions() As Collection(Of Orders.Order)
            Get
                If Me._Transactions Is Nothing OrElse Me._Transactions.Count = 0 Then
                    Me._Transactions = New Collection(Of Orders.Order)

                    Dim dr As New Datalayer.DataRequest()
                    dr.ConnectionString = WebAppSettings.ConnectionString
                    dr.CommandType = Data.CommandType.Text
                    dr.Command = String.Format("SELECT * FROM bvc_Order WHERE Bvin IN (SELECT OrderId FROM bvc_OrderPackage WHERE ShipDate > '{0}' AND ShipDate < '{1}' AND HasShipped = 1 AND TrackingNumber <> '') ORDER BY OrderNumber", Me.StartDate.ToShortDateString(), Me.EndDate.ToShortDateString())

                    Dim ds As Data.DataSet = Datalayer.SqlDataHelper.ExecuteDataSet(dr)
                    If ds IsNot Nothing AndAlso ds.Tables.Count > 0 Then
                        For Each row As Data.DataRow In ds.Tables(0).Rows
                            Dim o As Orders.Order = Orders.Order.ConvertDataRow(row)

                            If o.CustomPropertyGet("Develisys", "GTS-Cancelled") <> Boolean.TrueString Then
                                Me._Transactions.Add(o)
                            End If
                        Next
                    End If
                End If

                Return Me._Transactions
            End Get
        End Property

        Public Overridable ReadOnly Property Carriers As StringDictionary
            Get
                If Me._Carriers Is Nothing OrElse Me._Carriers.Count = 0 Then
                    Me._Carriers = New StringDictionary()

                    ' populate carriers
                    _Carriers.Add("ABFS", "ABF Freight Systems")
                    _Carriers.Add("AMWST", "America West")
                    _Carriers.Add("BEKINS", "Bekins")
                    _Carriers.Add("CNWY", "Conway")
                    _Carriers.Add("DHL", "DHL")
                    _Carriers.Add("ESTES", "Estes")
                    _Carriers.Add("HDUSA", "Home Direct USA")
                    _Carriers.Add("LASERSHIP", "LaserShip")
                    _Carriers.Add("MYFLWR", "Mayflower")
                    _Carriers.Add("ODFL", "Old Dominion Freight")
                    _Carriers.Add("RDAWAY", "Reddaway")
                    _Carriers.Add("TWW", "Team Worldwide")
                    _Carriers.Add("WATKINS", "Watkins")
                    _Carriers.Add("YELL", "Yellow Freight")
                    _Carriers.Add("YRC", "YRC")
                    _Carriers.Add("OTHER", "All Other Carriers")
                End If

                Return Me._Carriers
            End Get
        End Property

#End Region


        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Sub AddHeaderRow()
            AddRow( _
                "merchant order id", _
                "tracking number", _
                "carrier code", _
                "other carrier name", _
                "ship date")
        End Sub

        Protected Overrides Sub Generate()
            For Each o As Orders.Order In Me.Transactions
                AddOrderRow(o)
            Next
        End Sub

        Protected Overrides Sub AddOrderRow(ByRef o As Orders.Order)
            Dim packages As Collection(Of Shipping.Package) = o.FindShippedPackages()

            For Each package As Shipping.Package In o.FindShippedPackages()
                If package IsNot Nothing AndAlso Not String.IsNullOrEmpty(package.TrackingNumber) Then
                    ' merchant order id
                    AddColumn(o.OrderNumber)

                    ' tracking number
                    AddColumn(package.TrackingNumber)

                    ' carrier code
                    Dim code As CarrierCode = Me.GetCarrierCode(o, package)
                    AddColumn(code.ToString())

                    ' other carrier name
                    If code = CarrierCode.Other Then
                        AddColumn(Me.GetOtherCarrierName(o))
                    Else
                        AddColumn(String.Empty)
                    End If

                    ' ship date
                    AddColumn(package.ShipDate.ToString(Me.DateFormat))


                    ' LINE BREAK
                    AddColumn(ControlChars.NewLine)
                Else
                    AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Warning, Me.FeedName, String.Format("Shipped order {0} does not contain any shipping packages that have a tracking number or match the shipping method or shipping provider of the order -- excluding order from feed.", o.OrderNumber))
                End If
            Next
        End Sub

#Region " Helper Functions "

        Protected Overridable Function GetCarrierCode(ByRef o As Orders.Order, ByRef p As Shipping.Package) As CarrierCode
            Dim result As CarrierCode = CarrierCode.Other

            Select Case p.ShippingProviderId
                Case New BVSoftware.BVC5.Shipping.Ups.UpsProvider().ProviderId
                    result = CarrierCode.UPS

                Case New BVSoftware.BVC5.Shipping.FedEx.FedExProvider().ProviderId
                    result = CarrierCode.FedEx

                Case New BVSoftware.BVC5.Shipping.USPostal.USPostalProvider().ProviderId
                    result = CarrierCode.USPS

                Case Else
                    Dim methodName As String = o.ShippingMethodDisplayName.ToLower()
                    If methodName.Contains("ups") OrElse methodName.Contains("united parcel service") Then
                        result = CarrierCode.UPS
                    ElseIf methodName.Contains("fedex") OrElse methodName.Contains("federal express") Then
                        result = CarrierCode.FedEx
                    ElseIf methodName.Contains("usps") OrElse methodName.Contains("uspostal") OrElse methodName.Contains("us postal") OrElse methodName.Contains("united states postal") Then
                        result = CarrierCode.USPS
                    End If
            End Select

            Return result
        End Function

        Protected Overridable Function GetOtherCarrierName(ByRef o As Orders.Order) As String
            Dim result As String = "OTHER"

            Dim methodName As String = o.ShippingMethodDisplayName.ToLower()
            For Each de As DictionaryEntry In Me.Carriers
                If methodName.Contains(de.Value.ToString().ToLower()) OrElse methodName.Contains(de.Key.ToString().ToLower()) Then
                    result = de.Key.ToString()
                    Exit For
                End If
            Next

            Return result
        End Function

#End Region


        Protected Enum CarrierCode
            UPS
            FedEx
            USPS
            Other
        End Enum

    End Class

End Namespace