Imports System.Collections.ObjectModel
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine.Transactions

    Public Class GoogleTrustedStoresCancellation
        Inherits BaseTransactionFeed

        Private Const COMPONENTID As String = "1AC2C660-EE8E-4E0C-A014-98CA0211CF8D"

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FIELDWRAPCHARACTER As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Google Trusted Stores Cancellation"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "gts-cancellation.txt"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_STARTDATE() As DateTime
            Get
                Return DateTime.Today.AddDays(-30)
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

                    Dim osc As New Orders.OrderSearchCriteria()
                    osc.IsPlaced = True
                    osc.StartDate = Me.StartDate
                    osc.EndDate = Me.EndDate
                    
                    For Each order As Orders.Order In Orders.Order.FindByCriteria(osc).Where(Function(o) _
                                                                                                 o.StatusCode <> WebAppSettings.OrderStatusCodeComplete _
                                                                                                 AndAlso o.StatusCode <> WebAppSettings.OrderStatusCodeInProcess _
                                                                                                 AndAlso o.CustomPropertyGet("Develisys", "GTS-Cancelled") <> Boolean.TrueString)
                        Me._Transactions.Add(order)
                    Next
                End If

                Return Me._Transactions
            End Get
        End Property

#End Region


        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Sub AddHeaderRow()
            AddRow( _
                "merchant order id", _
                "reason")
        End Sub

        Protected Overrides Sub AddOrderRow(ByRef o As Orders.Order)
            ' merchant order id
            AddColumn(o.OrderNumber)

            ' reason
            AddColumn(Me.GetCancellationReason(o).ToString())


            ' mark order as exported so it is not exported again
            o.CustomPropertySet("Develisys", "GTS-Cancelled", Boolean.TrueString)
            Orders.Order.Update(o)
        End Sub

#Region " Helper Functions "

        Protected Overridable Function GetCancellationReason(ByRef o As Orders.Order) As CancellationReason
            Return CancellationReason.MerchantCanceled
        End Function

#End Region


        Protected Enum CancellationReason
            BuyerCanceled
            MerchantCanceled
            DuplicateInvalid
            FraudFake
        End Enum

    End Class

End Namespace