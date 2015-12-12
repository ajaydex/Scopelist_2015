Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.Linq

Namespace ImportExport

    <Serializable()> _
    Public Class AvailableImportExports

        Private Shared _Imports As New Collection(Of BaseImport)
        Private Shared _Exports As New Collection(Of BaseExport)
        Private Shared _ImportsLock As New Object()
        Private Shared _ExportsLock As New Object()

        Public Shared Property [Imports] As Collection(Of BaseImport)
            Get
                Return _Imports
            End Get
            Set(value As Collection(Of BaseImport))
                SyncLock _ImportsLock
                    _Imports = value
                End SyncLock
            End Set
        End Property

        Public Shared Property Exports As Collection(Of BaseExport)
            Get
                Return _Exports
            End Get
            Set(value As Collection(Of BaseExport))
                SyncLock _ExportsLock
                    _Exports = value
                End SyncLock
            End Set
        End Property


        Public Shared Function FindImportByBvin(ByVal bvin As String) As BaseImport
            Return [Imports].FirstOrDefault(Function(i) String.Compare(i.Bvin, bvin, StringComparison.InvariantCultureIgnoreCase) = 0)
        End Function

        Public Shared Function FindExportByBvin(ByVal bvin As String) As BaseExport
            Return Exports.FirstOrDefault(Function(e) String.Compare(e.Bvin, bvin, StringComparison.InvariantCultureIgnoreCase) = 0)
        End Function

        Public Shared Function FindImportByType(ByVal type As Type) As BaseImport
            Return [Imports].FirstOrDefault(Function(i) i.ObjectType = type)
        End Function

        Public Shared Function FindExportByType(ByVal type As Type) As BaseExport
            Return Exports.FirstOrDefault(Function(e) e.ObjectType = type)
        End Function

    End Class

End Namespace