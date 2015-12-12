Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Namespace ImportExport.ContentData

    Public Class CustomUrlImport
        Inherits BaseImport

        
#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_IMPORTNAME As String
            Get
                Return "Custom URL Import"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_KEYFIELD As String
            Get
                Return "RequestedUrl"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_REQUIREDIMPORTFIELDS As String()
            Get
                Return New String() {"RequestedUrl", _
                                     "RedirectToUrl"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property Bvin As String
            Get
                Return "72682388-C4EC-4FBE-AC44-6742A717CB16"
            End Get
        End Property

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Content.CustomUrl)
            End Get
        End Property

#End Region

        Public Overrides Function FindRowOjbect(key As Object) As Object
            Return Content.CustomUrl.FindByRequestedUrl(key.ToString())
        End Function

        Public Overrides Function SaveRow(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = False

            Try
                Dim item As Content.CustomUrl = CType(data(Me.KeyField), Content.CustomUrl)
                If String.IsNullOrEmpty(item.Bvin) Then
                    ' insert
                    If Content.CustomUrl.Insert(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to save new custom URL ""{0}"".", item.RequestedUrl))
                    End If
                Else
                    ' update
                    If Content.CustomUrl.Update(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to update custom URL ""{0}"".", item.RequestedUrl))
                    End If
                End If
            Catch ex As Exception
                AddMessage(Content.DisplayMessageType.Exception, "Unable to save row: " + ex.ToString())
            End Try

            Return result
        End Function

    End Class

End Namespace