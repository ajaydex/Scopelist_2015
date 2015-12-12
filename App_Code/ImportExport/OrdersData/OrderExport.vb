Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Namespace ImportExport.OrdersData

    Public Class OrderExport
        Inherits BaseExport

        Private Const COMPONENTID As String = "1981E254-BABB-4C0C-8C0F-23BC2A4E619F"

        Private _Criteria As Orders.OrderSearchCriteria = Nothing

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Order Export"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "orders.txt"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_EXCLUDEDEXPORTFIELDS As String()
            Get
                Return New String() {"Coupons", _
                                     "GiftCertificates", _
                                     "IsCalculatingTax", _
                                     "Items", _
                                     "LastLineItemAdded", _
                                     "Notes", _
                                     "Payments", _
                                     "User"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Orders.Order)
            End Get
        End Property

        Public Overridable Property Criteria As Orders.OrderSearchCriteria
            Get
                Return Me._Criteria
            End Get
            Set(value As Orders.OrderSearchCriteria)
                Me._Criteria = value
            End Set
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Function LoadExportData() As Generic.IEnumerable(Of Object)
            If Me.Criteria IsNot Nothing Then
                Return Orders.Order.FindByCriteria(Me.Criteria)
            Else
                Return Orders.Order.FindByCriteria(New Orders.OrderSearchCriteria())
            End If
        End Function

    End Class

End Namespace