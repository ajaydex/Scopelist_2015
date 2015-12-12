Imports System.Collections.ObjectModel
Imports System.Linq
Imports System.Reflection
Imports BVSoftware.Bvc5.Core

Namespace ImportExport

    Public MustInherit Class BaseExport
        Inherits FeedEngine.BaseFeed

        Private _ContentType As String
        Private _ExportFields As New Collection(Of String)
        Private _CustomExportFields() As String = Nothing
        Private _ExcludedExportFields() As String = Nothing
        Private _ExportData As Generic.IEnumerable(Of Object) = Nothing

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Base Export"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "baseexport.txt"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_CONTENTTYPE() As String
            Get
                Return "text/csv; charset=" + Me.FeedEncoding.WebName
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_EXCLUDEDEXPORTFIELDS() As String()
            Get
                Return New String() {}
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_CUSTOMEXPORTFIELDS() As String()
            Get
                Return New String() {}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property FeedType As String
            Get
                Return "Export"
            End Get
        End Property

        Public Overridable Property ContentType As String
            Get
                Return Me._ContentType
            End Get
            Set(value As String)
                Me._ContentType = value
            End Set
        End Property

        Public MustOverride ReadOnly Property ObjectType As Type

        Public Overridable ReadOnly Property ExportFields() As Collection(Of String)
            Get
                If Me._ExportFields Is Nothing OrElse Me._ExportFields.Count = 0 Then
                    Me._ExportFields = New Collection(Of String)

                    Dim objType As Type = Me.ObjectType
                    Dim testObj As Object = Activator.CreateInstance(objType)
                    For Each propInfo As PropertyInfo In objType.GetProperties().OrderBy(Function(pi) pi.Name)
                        ' skip excluded properties
                        If Not Me.ExcludedExportFields.Contains(propInfo.Name, StringComparer.InvariantCultureIgnoreCase) Then
                            ' exclude read-only and write-only properties
                            If propInfo.CanRead AndAlso propInfo.CanWrite Then
                                Try
                                    ' test whether property can be converted to string...
                                    Dim propValue As Object = propInfo.GetValue(testObj, Nothing)
                                    propInfo.SetValue(testObj, propValue, Nothing)

                                    ' ...if it didn't throw an exception, include the column.
                                    Me._ExportFields.Add(propInfo.Name)
                                Catch ex As Exception
                                    ' do nothing
                                End Try
                            End If
                        End If
                    Next
                End If

                Return Me._ExportFields
            End Get
        End Property

        Public Overridable Property ExcludedExportFields() As String()
            Get
                Return Me._ExcludedExportFields
            End Get
            Set(value As String())
                Me._ExcludedExportFields = value
            End Set
        End Property

        Public Overridable Property CustomExportFields() As String()
            Get
                Return Me._CustomExportFields
            End Get
            Set(value As String())
                Me._CustomExportFields = value
            End Set
        End Property

        Public Overridable Property ExportData As Generic.IEnumerable(Of Object)
            Get
                If Me._ExportData Is Nothing Then
                    Me._ExportData = Me.LoadExportData()
                End If

                Return Me._ExportData
            End Get
            Set(value As Generic.IEnumerable(Of Object))
                Me._ExportData = value
            End Set
        End Property

#End Region

        Sub New(ByVal componentId As String)
            MyBase.New(componentId)

            Me._ContentType = Me.DEFAULT_CONTENTTYPE
            Me._ExcludedExportFields = Me.DEFAULT_EXCLUDEDEXPORTFIELDS
            Me._CustomExportFields = Me.DEFAULT_CUSTOMEXPORTFIELDS
        End Sub

        Protected Overrides Sub AddHeaderRow()
            Dim obj As Type = Me.ObjectType
            For Each propInfo As PropertyInfo In obj.GetProperties().OrderBy(Function(pi) pi.Name)
                If Me.ExportFields.Contains(propInfo.Name) Then
                    AddColumn(propInfo.Name)
                End If
            Next

            ' custom fields
            For Each field As String In Me.CustomExportFields.OrderBy(Function(f) f)
                AddColumn(field)
            Next

            ' LINE BREAK
            AddColumn(ControlChars.NewLine)
        End Sub

        Protected Overrides Sub Generate()
            For Each obj As Object In Me.ExportData
                For Each propInfo As PropertyInfo In Me.ObjectType.GetProperties().OrderBy(Function(pi) pi.Name)
                    If Me.ExportFields.Contains(propInfo.Name) Then
                        Try
                            AddColumn(propInfo.GetValue(obj, Nothing).ToString())
                        Catch ex As Exception
                            ' output message...
                        End Try
                    End If
                Next

                ' custom fields
                For Each field As String In Me.CustomExportFields.OrderBy(Function(f) f)
                    AddCustomField(field, obj)
                Next

                ' LINE BREAK
                AddColumn(ControlChars.NewLine)
            Next

            ' memory cleanup - clear large in-memory objects
            Me._ExportData = Nothing
        End Sub

        Protected Overridable Sub AddCustomField(ByVal fieldName As String, ByVal obj As Object)
            ' override this function to implement custom fields
        End Sub


        Protected MustOverride Function LoadExportData() As Generic.IEnumerable(Of Object)

#Region " String Functions "

        Protected Overrides Function CleanText(text As String) As String
            Dim sb As New StringBuilder(text)

            sb.Replace(ControlChars.Tab, " ")
            sb.Replace(ControlChars.NewLine, " ")
            sb.Replace(ControlChars.Cr, " ")
            sb.Replace(ControlChars.Lf, " ")

            'sb.Replace("  ", " ")

            If Me.FieldWrapCharacter = """" Then
                sb.Replace("""", """""")
            End If

            ' if fields are not being wrapped, remove the field delimiter from the content
            If String.IsNullOrEmpty(Me.FieldWrapCharacter) Then
                sb.Replace(Me.FieldDelimiter, " ")
            End If

            'Return sb.ToString().Trim()
            Return Regex.Replace(sb.ToString().Trim(), "\s+", " ")
        End Function

#End Region

    End Class

End Namespace