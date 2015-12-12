Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Namespace ImportExport.ContactsData

    Public Class AffiliateImport
        Inherits BaseImport


#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_IMPORTNAME As String
            Get
                Return "Affiliate Import"
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
                Return "C68A863E-D23D-4181-A480-41761B4E90FB"
            End Get
        End Property

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Contacts.Affiliate)
            End Get
        End Property

#End Region

        Public Overrides Function FindRowOjbect(key As Object) As Object
            Return Contacts.Affiliate.FindByBvin(key.ToString())
        End Function

        Public Overrides Function SaveRow(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = False

            Try
                Dim item As Contacts.Affiliate = CType(data(Me.KeyField), Contacts.Affiliate)
                If String.IsNullOrEmpty(item.Bvin) Then
                    ' insert
                    If Contacts.Affiliate.Insert(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to save new affiliate ""{0}"".", item.DisplayName))
                    End If
                Else
                    ' update
                    If Contacts.Affiliate.Update(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to update affiliate ""{0}"".", item.DisplayName))
                    End If
                End If
            Catch ex As Exception
                AddMessage(Content.DisplayMessageType.Exception, "Unable to save row: " + ex.ToString())
            End Try

            Return result
        End Function

    End Class

End Namespace