Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Namespace ImportExport.ContactsData

    Public Class ManufacturerImport
        Inherits BaseImport

        
#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_IMPORTNAME As String
            Get
                Return "Manufacturer Import"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_REQUIREDIMPORTFIELDS As String()
            Get
                Return New String() {"DisplayName"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property Bvin As String
            Get
                Return "CBB17285-85D6-4506-841A-7749E1BFCC10"
            End Get
        End Property

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Contacts.Manufacturer)
            End Get
        End Property

#End Region

        Public Overrides Function FindRowOjbect(key As Object) As Object
            Return Contacts.Manufacturer.FindByBvin(key.ToString())
        End Function

        Public Overrides Function SaveRow(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = False

            Try
                Dim item As Contacts.Manufacturer = CType(data(Me.KeyField), Contacts.Manufacturer)
                If String.IsNullOrEmpty(item.Bvin) Then
                    ' insert
                    If Contacts.Manufacturer.Insert(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to save new manufacturer ""{0}"".", item.DisplayName))
                    End If
                Else
                    ' update
                    If Contacts.Manufacturer.Update(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to update manufacturer ""{0}"".", item.DisplayName))
                    End If
                End If
            Catch ex As Exception
                AddMessage(Content.DisplayMessageType.Exception, "Unable to save row: " + ex.ToString())
            End Try

            Return result
        End Function

    End Class

End Namespace