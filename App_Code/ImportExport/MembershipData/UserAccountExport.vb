Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Namespace ImportExport.MembershipData

    Public Class UserAccountExport
        Inherits BaseExport

        Private Const COMPONENTID As String = "E3895D67-7B33-48F1-A80B-072D00D02E5E"

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "User Export"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "users.txt"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_EXCLUDEDEXPORTFIELDS As String()
            Get
                Return New String() {"Addresses"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Membership.UserAccount)
            End Get
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Function LoadExportData() As Generic.IEnumerable(Of Object)
            Return Membership.UserAccount.FindAll()
        End Function

    End Class

End Namespace