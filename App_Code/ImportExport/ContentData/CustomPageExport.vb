Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Namespace ImportExport.ContentData

    Public Class CustomPageExport
        Inherits BaseExport

        Private Const COMPONENTID As String = "39A94678-FF30-42F0-8FD9-B013BEA1774E"


#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Custom Page Export"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "custompages.txt"
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Content.CustomPage)
            End Get
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Function LoadExportData() As Generic.IEnumerable(Of Object)
            Return Content.CustomPage.FindAll()
        End Function

    End Class

End Namespace