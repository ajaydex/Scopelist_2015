Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Namespace ImportExport.ContentData

    Public Class UrlRedirectImport
        Inherits BaseImport


#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_IMPORTNAME As String
            Get
                Return "URL Redirect Import"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_REQUIREDIMPORTFIELDS As String()
            Get
                Return New String() {"RequestedUrl", _
                                     "RedirectToUrl", _
                                     "IsRegex"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property Bvin As String
            Get
                Return "22283262-8238-4B2B-875E-1FFC3FD7A445"
            End Get
        End Property

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Utilities.UrlRedirect)
            End Get
        End Property

#End Region

        Public Overrides Function FindRowOjbect(key As Object) As Object
            Dim result As Object = Nothing

            Dim item As Utilities.UrlRedirect = Utilities.UrlRedirect.FindByBvin(key.ToString())
            If item IsNot Nothing AndAlso Not String.IsNullOrEmpty(item.Bvin) Then
                result = item
            Else
                result = New Utilities.UrlRedirect()
            End If

            Return result
        End Function

        Public Overrides Function SaveRow(ByVal data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = False

            Try
                Dim item As Utilities.UrlRedirect = CType(data(Me.KeyField), Utilities.UrlRedirect)
                If String.IsNullOrEmpty(item.Bvin) Then
                    ' insert
                    If Utilities.UrlRedirect.Insert(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to save new redirect for ""{0}"".", item.RequestedUrl))
                    End If
                Else
                    ' update
                    If Utilities.UrlRedirect.Update(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to update redirect for ""{0}"".", item.RequestedUrl))
                    End If
                End If
            Catch ex As Exception
                AddMessage(Content.DisplayMessageType.Exception, "Unable to save row: " + ex.ToString())
            End Try

            Return result
        End Function

    End Class

End Namespace