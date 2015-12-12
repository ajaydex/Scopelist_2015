Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Namespace ImportExport.ContactsData

    Public Class ManufacturerExport
        Inherits BaseExport

        Private Const COMPONENTID As String = "CBB17285-85D6-4506-841A-7749E1BFCC10"


#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Manufacturer Export"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "manufacturers.txt"
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Contacts.Manufacturer)
            End Get
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Function LoadExportData() As Generic.IEnumerable(Of Object)
            Return Contacts.Manufacturer.FindAll()
        End Function
    End Class

End Namespace