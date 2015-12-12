Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Namespace ImportExport.ContentData

    Public Class CustomUrlExport
        Inherits BaseExport

        Private Const COMPONENTID As String = "72682388-C4EC-4FBE-AC44-6742A717CB16"


#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Custom URL Export"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "customurls.txt"
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Content.CustomUrl)
            End Get
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Function LoadExportData() As Generic.IEnumerable(Of Object)
            Return Content.CustomUrl.FindAll()
        End Function

    End Class

End Namespace