Imports System.Collections.ObjectModel
Imports System.Linq
Imports System.Reflection
Imports BVSoftware.Bvc5.Core

Namespace ImportExport.CatalogData

    Public Class CategoryExport
        Inherits BaseExport

        Private Const COMPONENTID As String = "F3C1883F-694D-4649-938A-1938940D08D5"


#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Category Export"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "categories.txt"
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Catalog.Category)
            End Get
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Function LoadExportData() As Generic.IEnumerable(Of Object)
            Return Catalog.Category.FindAll()
        End Function

    End Class

End Namespace