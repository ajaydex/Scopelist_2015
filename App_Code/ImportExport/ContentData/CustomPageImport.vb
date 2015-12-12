Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Namespace ImportExport.ContentData

    Public Class CustomPageImport
        Inherits BaseImport

        Private templates As New StringCollection()

        
#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_IMPORTNAME As String
            Get
                Return "Custom Page Import"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_REQUIREDIMPORTFIELDS As String()
            Get
                Return New String() {"Name"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property Bvin As String
            Get
                Return "39A94678-FF30-42F0-8FD9-B013BEA1774E"
            End Get
        End Property

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Content.CustomPage)
            End Get
        End Property

#End Region

        Public Overrides Function ProcessPreImport() As Boolean
            Dim result As Boolean = True

            templates = New StringCollection()
            For Each template As String In Content.ModuleController.FindCategoryTemplates()
                templates.Add(template.ToLower())
            Next

            Return result
        End Function

        Public Overrides Function FindRowOjbect(key As Object) As Object
            Return Content.CustomPage.FindByBvin(key.ToString())
        End Function

        Public Overrides Function ValidateRowObject(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = MyBase.ValidateRowObject(data)

            If result Then
                Dim item As Content.CustomPage = CType(data(Me.KeyField), Content.CustomPage)

                ' TemplateName
                If Not String.IsNullOrEmpty(item.TemplateName) Then
                    If Not templates.Contains(item.TemplateName.ToLower()) Then
                        result = False
                        Me.AddMessage(Content.DisplayMessageType.Error, String.Format("TemplateName ""{0}"" does not exist - skipping row.", item.TemplateName))
                    End If
                End If
            End If

            Return result
        End Function

        Public Overrides Function SaveRow(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = False

            Try
                Dim item As Content.CustomPage = CType(data(Me.KeyField), Content.CustomPage)
                If String.IsNullOrEmpty(item.Bvin) Then
                    ' insert
                    If Content.CustomPage.Insert(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to save new custom page ""{0}"".", item.Name))
                    End If
                Else
                    ' update
                    If Content.CustomPage.Update(item) Then
                        result = True
                    Else
                        AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to update custom page ""{0}"".", item.Name))
                    End If
                End If
            Catch ex As Exception
                AddMessage(Content.DisplayMessageType.Exception, "Unable to save row: " + ex.ToString())
            End Try

            Return result
        End Function

    End Class

End Namespace