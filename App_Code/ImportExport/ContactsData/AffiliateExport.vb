Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Namespace ImportExport.ContactsData

    Public Class AffiliateExport
        Inherits BaseExport

        Private Const COMPONENTID As String = "C68A863E-D23D-4181-A480-41761B4E90FB"


#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Affiliate Export"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "affiliates.txt"
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Contacts.Affiliate)
            End Get
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Function LoadExportData() As Generic.IEnumerable(Of Object)
            Return Contacts.Affiliate.FindAll()
        End Function

    End Class

End Namespace