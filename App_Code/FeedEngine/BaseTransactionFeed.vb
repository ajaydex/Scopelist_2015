Imports System.Collections.ObjectModel
Imports System.IO
Imports System.Text.RegularExpressions
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine

    Public MustInherit Class BaseTransactionFeed
        Inherits BaseFeed

        Protected _Transactions As Collection(Of Orders.Order)

        Private _StartDate As DateTime
        Private _EndDate As DateTime

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Base Order Feed"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "baseorder.txt"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_STARTDATE() As DateTime
            Get
                Return System.Data.SqlTypes.SqlDateTime.MinValue
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_ENDDATE() As DateTime
            Get
                Return System.Data.SqlTypes.SqlDateTime.MaxValue
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property FeedType As String
            Get
                Return "Transaction"
            End Get
        End Property


        Public Property StartDate() As DateTime
            Get
                Return _StartDate
            End Get
            Set(ByVal value As DateTime)
                _StartDate = value
            End Set
        End Property

        Public Property EndDate() As DateTime
            Get
                Return _EndDate
            End Get
            Set(ByVal value As DateTime)
                _EndDate = value
            End Set
        End Property

        Public Overridable ReadOnly Property Transactions() As Collection(Of Orders.Order)
            Get
                If Me._Transactions Is Nothing OrElse Me._Transactions.Count = 0 Then
                    Dim criteria As New Orders.OrderSearchCriteria()
                    criteria.IsPlaced = True
                    criteria.PaymentStatus = BVSoftware.BVC5.Core.Orders.OrderPaymentStatus.Paid
                    criteria.StartDate = Me.StartDate
                    criteria.EndDate = Me.EndDate

                    Me._Transactions = BVSoftware.BVC5.Core.Orders.Order.FindByCriteria(criteria)
                End If

                Return Me._Transactions
            End Get
        End Property

#End Region

        Sub New(ByVal componentId As String)
            MyBase.New(componentId)

            Dim setting As String = String.Empty

            setting = Me.SettingsManager.GetSetting("StartDate")
            Me._StartDate = If(Not String.IsNullOrEmpty(setting), System.Convert.ToDateTime(setting), Me.DEFAULT_STARTDATE)

            setting = Me.SettingsManager.GetSetting("EndDate")
            Me._EndDate = If(Not String.IsNullOrEmpty(setting), System.Convert.ToDateTime(setting), Me.DEFAULT_ENDDATE)

            Me._Transactions = Nothing
        End Sub

        Protected MustOverride Sub AddOrderRow(ByRef o As Orders.Order)

        Protected Overrides Sub Generate()
            For Each o As Orders.Order In Me.Transactions
                AddOrderRow(o)

                ' LINE BREAK
                AddColumn(ControlChars.NewLine)
            Next
        End Sub

        Public Overrides Sub GenerateFeed()
            MyBase.GenerateFeed()

            ' memory cleanup - clear large in-memory objects
            Me._Transactions = Nothing
        End Sub


#Region " Order Helper Functions "

        Protected Overridable Function GetOrderPayment(ByVal o As Orders.Order) As Orders.OrderPayment
            Dim result As New Orders.OrderPayment()

            If o.Payments IsNot Nothing Then
                For Each op As Orders.OrderPayment In o.Payments
                    If op.AmountCharged > 0 Then
                        result = op
                        Exit For
                    End If
                Next
            End If

            Return result
        End Function

#End Region

    End Class

End Namespace