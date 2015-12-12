Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Namespace ImportExport.ContactsData

    Public Class VendorImport
        Inherits BaseImport

        
#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_IMPORTNAME As String
            Get
                Return "Vendor Import"
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
                Return "1C26AB10-7FF9-44B3-84BE-6EE32B5762BA"
            End Get
        End Property

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Contacts.Vendor)
            End Get
        End Property

#End Region

        Public Overrides Function FindRowOjbect(key As Object) As Object
            Return Contacts.Vendor.FindByBvin(key.ToString())
        End Function

        Public Overrides Function SaveRow(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = False

            Try
                Dim item As Contacts.Vendor = CType(data(Me.KeyField), Contacts.Vendor)
                If String.IsNullOrEmpty(item.Bvin) Then
                    ' insert
                    If Contacts.Vendor.Insert(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to save new vendor ""{0}"".", item.DisplayName))
                    End If
                Else
                    ' update
                    If Contacts.Vendor.Update(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to update vendor ""{0}"".", item.DisplayName))
                    End If
                End If
            Catch ex As Exception
                AddMessage(Content.DisplayMessageType.Exception, "Unable to save row: " + ex.ToString())
            End Try

            Return result
        End Function

    End Class

End Namespace