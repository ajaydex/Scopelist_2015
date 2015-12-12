Imports Microsoft.VisualBasic.FileIO
Imports System.Collections.ObjectModel
Imports System.Collections.Specialized
Imports System.IO
Imports System.Linq
Imports System.Reflection
Imports System.Text.RegularExpressions
Imports System.Xml.Serialization
Imports BVSoftware.BVC5.Core

Namespace ImportExport

    Public MustInherit Class BaseImport
        Implements IDisposable

        Private _FieldDelimiter As String = String.Empty
        Private _FieldWrapCharacter As String = String.Empty
        Private _ImportName As String = String.Empty
        Private _KeyField As String = String.Empty
        Private _ImportFields As New Collection(Of String)
        Private _CustomImportFields() As String = Nothing
        Private _RequiredImportFields() As String = Nothing
        Private _ExcludedImportFields() As String = Nothing
        Private _ImportHeader As Generic.Dictionary(Of String, Integer) = Nothing
        Private _RowIsDirty As Boolean = False
        Private _Messages As New Collection(Of Content.DisplayMessage)
        Protected _ImportFileEncoding As Encoding = Nothing

        Protected ImportFile As StreamReader = Nothing

#Region " Default Properties "

        Protected Overridable ReadOnly Property DEFAULT_FIELDDELIMITER() As String
            Get
                Return ControlChars.Tab
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_FIELDWRAPCHARACTER() As String
            Get
                Return ControlChars.Quote
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_IMPORTNAME() As String
            Get
                Return "Base Import"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_KEYFIELD() As String
            Get
                Return "Bvin"
            End Get
        End Property

        Protected MustOverride ReadOnly Property DEFAULT_REQUIREDIMPORTFIELDS() As String()

        Protected Overridable ReadOnly Property DEFAULT_EXCLUDEDIMPORTFIELDS() As String()
            Get
                Return New String() {"CreationDate", _
                                     "LastUpdated"}
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_CUSTOMIMPORTFIELDS() As String()
            Get
                Return New String() {}
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_IMPORTFILEENCODING() As Encoding
            Get
                Return Encoding.UTF8
            End Get
        End Property

#End Region

#Region " Properties "

        Public MustOverride ReadOnly Property Bvin() As String

        Public Overridable Property FieldDelimiter() As String
            Get
                Return Me._FieldDelimiter
            End Get
            Set(ByVal value As String)
                Me._FieldDelimiter = value
            End Set
        End Property

        Public Overridable Property FieldWrapCharacter() As String
            Get
                Return Me._FieldWrapCharacter
            End Get
            Set(ByVal value As String)
                Me._FieldWrapCharacter = value
            End Set
        End Property

        Public Overridable Property ImportName() As String
            Get
                Return Me._ImportName
            End Get
            Set(value As String)
                Me._ImportName = value
            End Set
        End Property

        Public MustOverride ReadOnly Property ObjectType As Type

        Public Overridable Property KeyField() As String
            Get
                Return Me._KeyField
            End Get
            Set(value As String)
                Me._KeyField = value
            End Set
        End Property

        Public Overridable ReadOnly Property ImportFields() As Collection(Of String)
            Get
                If Me._ImportFields Is Nothing OrElse Me._ImportFields.Count = 0 Then
                    Me._ImportFields = New Collection(Of String)

                    Dim objType As Type = Me.ObjectType
                    Dim testObj As Object = Activator.CreateInstance(objType)
                    For Each propInfo As PropertyInfo In objType.GetProperties()
                        ' skip excluded properties
                        If Not Me.ExcludedImportFields.Contains(propInfo.Name, StringComparer.InvariantCultureIgnoreCase) Then
                            ' exclude read-only and write-only properties
                            If propInfo.CanRead AndAlso propInfo.CanWrite Then
                                Try
                                    ' test whether property can be converted to string...
                                    Dim propValue As Object = propInfo.GetValue(testObj, Nothing)
                                    propInfo.SetValue(testObj, propValue, Nothing)

                                    ' ...if it didn't throw an exception, include the column.
                                    Me._ImportFields.Add(propInfo.Name)
                                Catch ex As Exception
                                    Me.AddMessage(Content.DisplayMessageType.Exception, String.Format("Property ""{0}"" cannot be converted to a string for import - skipping property.", propInfo.Name))
                                End Try
                            Else
                                ' do nothing
                            End If
                        End If
                    Next
                End If

                Return Me._ImportFields
            End Get
        End Property

        Public Overridable Property RequiredImportFields() As String()
            Get
                Return Me._RequiredImportFields
            End Get
            Set(value As String())
                Me._RequiredImportFields = value
            End Set
        End Property

        Public Overridable Property ExcludedImportFields() As String()
            Get
                Return Me._ExcludedImportFields
            End Get
            Set(value As String())
                Me._ExcludedImportFields = value
            End Set
        End Property

        Public Overridable Property CustomImportFields() As String()
            Get
                Return Me._CustomImportFields
            End Get
            Set(value As String())
                Me._CustomImportFields = value
            End Set
        End Property

        Public Overridable Property ImportHeader As Generic.Dictionary(Of String, Integer)
            Get
                Return Me._ImportHeader
            End Get
            Set(value As Generic.Dictionary(Of String, Integer))
                Me._ImportHeader = value
            End Set
        End Property

        Public Overridable Property ImportFileEncoding() As Encoding
            Get
                Return Me._ImportFileEncoding
            End Get
            Set(ByVal value As Encoding)
                Me._ImportFileEncoding = value
            End Set
        End Property

        Public Property RowIsDirty() As Boolean
            Get
                Return Me._RowIsDirty
            End Get
            Set(value As Boolean)
                Me._RowIsDirty = value
            End Set
        End Property

        Public Property Messages() As Collection(Of Content.DisplayMessage)
            Get
                Return Me._Messages
            End Get
            Set(value As Collection(Of Content.DisplayMessage))
                Me._Messages = value
            End Set
        End Property

#End Region


        Sub New()
            Me._FieldDelimiter = Me.DEFAULT_FIELDDELIMITER
            Me._FieldWrapCharacter = Me.DEFAULT_FIELDWRAPCHARACTER
            Me._ImportName = Me.DEFAULT_IMPORTNAME
            Me._KeyField = Me.DEFAULT_KEYFIELD
            Me._RequiredImportFields = Me.DEFAULT_REQUIREDIMPORTFIELDS
            Me._ExcludedImportFields = Me.DEFAULT_EXCLUDEDIMPORTFIELDS
            Me._CustomImportFields = Me.DEFAULT_CUSTOMIMPORTFIELDS
            Me._ImportFileEncoding = Me.DEFAULT_IMPORTFILEENCODING
            Me._ImportHeader = New Generic.Dictionary(Of String, Integer)(StringComparer.CurrentCultureIgnoreCase)

            Me.ImportFile = Nothing
        End Sub

        Public Overridable Sub Import(ByVal data As Stream)
            AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Information, "Import", String.Format("{0} started", Me.ImportName))

            Dim rowNumber As Integer = 1
            Dim rowsChanged As Integer = 0
            Dim rowsUnchanged As Integer = 0
            Dim importAborted As Boolean = False

            Me.ImportFile = New StreamReader(data, Me.ImportFileEncoding)

            Try
                While Not Me.ImportFile.EndOfStream
                    Dim line As String = Me.ImportFile.ReadLine()

                    If Not String.IsNullOrEmpty(line) Then
                        Dim row() As String = line.Split(Me.FieldDelimiter)
                        row = Me.StripFieldWrapCharacters(row, Me.FieldWrapCharacter, True)

                        If rowNumber = 1 Then
                            If Not Me.ProcessHeaderRow(row) Then
                                ' if header row does not have all of the required fields, abort the import!
                                importAborted = True
                                Exit While
                            End If
                        Else
                            If rowNumber = 2 Then
                                If Not Me.ProcessPreImport() Then
                                    ' if pre-import processing fails for any reason, abort the import before we start modifying data!
                                    importAborted = True
                                    Exit While
                                End If
                            End If

                            ' make sure the row has at least as many columns as the header
                            If row.Length >= Me.ImportHeader.Count Then
                                Dim dataObjs As New Generic.Dictionary(Of String, Object)(StringComparer.InvariantCultureIgnoreCase)

                                If Me.ProcessRow(row, rowNumber, dataObjs) Then
                                    If Me.ProcessPostRow(row, rowNumber, dataObjs) Then
                                        If Me.RowIsDirty Then
                                            If dataObjs IsNot Nothing AndAlso dataObjs.Count > 0 Then
                                                If Me.ValidateRowObject(dataObjs) AndAlso Me.ValidateCustomRowObjects(dataObjs) Then
                                                    If Me.SaveRow(dataObjs) Then
                                                        ' the return value of this function isn't used because the main object has already been updated at this point
                                                        Me.SaveCustomRowData(dataObjs)

                                                        rowsChanged += 1
                                                    End If
                                                End If
                                            End If
                                        Else
                                            rowsUnchanged += 1
                                        End If
                                    End If
                                End If

                                ' reset row dirty flag
                                Me.RowIsDirty = False
                            Else
                                Me.AddMessage(Content.DisplayMessageType.Warning, "Incorrect number of columns - skipping.", rowNumber)
                            End If
                        End If
                    Else
                        Me.AddMessage(Content.DisplayMessageType.Warning, "Empty line - skipping.", rowNumber)
                    End If

                    rowNumber += 1
                End While

                If Not ProcessPostImport() Then
                    ' do nothing
                End If
            Catch ex As Exception
                Me.AddMessage(Content.DisplayMessageType.Exception, ex.ToString())
            Finally
                If Me.ImportFile IsNot Nothing Then
                    Me.ImportFile.Close()
                    Me.ImportFile.Dispose()
                End If
            End Try

            If Not importAborted Then
                Me.Messages.Insert(0, New Content.DisplayMessage(Content.DisplayMessageType.Success, String.Format("Rows added/updated: {0}<br/>Rows unchanged: {1}<br/>Rows skipped: {2}", rowsChanged.ToString(), rowsUnchanged.ToString(), If(rowNumber > 1, ((rowNumber - 2) - rowsChanged - rowsUnchanged).ToString(), "0"))))
            End If
        End Sub

        Public Overridable Function ProcessHeaderRow(ByVal row As String()) As Boolean
            Dim result As Boolean = True

            Me.ImportHeader = New Generic.Dictionary(Of String, Integer)(StringComparer.CurrentCultureIgnoreCase)

            For i As Integer = 0 To row.Length - 1
                Dim field As String = row(i)
                If Me.ImportFields.Contains(field, StringComparer.InvariantCultureIgnoreCase) OrElse Me.CustomImportFields.Contains(field, StringComparer.InvariantCultureIgnoreCase) Then
                    Me.ImportHeader.Add(field, i)
                ElseIf Me.ExcludedImportFields.Contains(field, StringComparer.InvariantCultureIgnoreCase) Then
                    Me.AddMessage(Content.DisplayMessageType.Information, String.Format("Column ""{0}"" is ignored - skipping column.", row(i)), 1)
                Else
                    Me.AddMessage(Content.DisplayMessageType.Warning, String.Format("Invalid column name ""{0}"" - skipping column.", row(i)), 1)
                End If
            Next

            ' required key field
            If Not Me.ImportHeader.ContainsKey(Me.KeyField) Then
                result = False
                Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Missing key column ""{0}"" - aborting import", Me.KeyField), 1)
            End If

            ' required fields
            For Each field As String In Me.RequiredImportFields
                If Not Me.ImportHeader.ContainsKey(field) Then
                    result = False
                    Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Column ""{0}"" is required for this import - aborting import", field), 1)
                End If
            Next

            Return result
        End Function

        Public Overridable Function ProcessPreImport() As Boolean
            Return True
        End Function

        Public Overridable Function ProcessRow(ByVal row As String(), ByVal rowNumber As Integer, ByRef output As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = True

            Dim obj As Object = Nothing
            Dim key As String = row(Me.ImportHeader(Me.KeyField))
            If Not String.IsNullOrEmpty(key) Then
                obj = Me.FindRowOjbect(row(Me.ImportHeader(Me.KeyField)))
            Else
                obj = Activator.CreateInstance(Me.ObjectType)
            End If

            output.Add(Me.KeyField, obj)

            For i As Integer = 0 To row.Length - 1
                Dim fieldIndex As Integer = i
                Dim fieldName As String = Me.ImportHeader.FirstOrDefault(Function(field) field.Value = fieldIndex).Key
                If fieldName IsNot Nothing Then
                    Dim propInfo As System.Reflection.PropertyInfo = Me.ObjectType.GetProperty(fieldName)
                    If propInfo IsNot Nothing Then
                        Try
                            ' make sure we have a value for required fields
                            If String.IsNullOrEmpty(row(i)) AndAlso Me.RequiredImportFields.Contains(propInfo.Name, StringComparer.InvariantCultureIgnoreCase) Then
                                result = False
                                Me.AddMessage(Content.DisplayMessageType.Error, String.Format("No value was specified for required column ""{0}"" - skipping row.", propInfo.Name), rowNumber)
                                Exit For
                            End If

                            Me.SetValue(propInfo, row(i), obj)
                        Catch ex As Exception
                            result = False
                            Me.AddMessage(Content.DisplayMessageType.Exception, String.Format("An error occurred while processing column ""{0}"" - skipping row. Exception: {1}", propInfo.Name, ex.ToString()), rowNumber)
                            Exit For
                        End Try
                    ElseIf Me.CustomImportFields.Contains(fieldName, StringComparer.InvariantCultureIgnoreCase) Then
                        ' make sure we have a value for required fields
                        If String.IsNullOrEmpty(row(i)) AndAlso Me.RequiredImportFields.Contains(fieldName, StringComparer.InvariantCultureIgnoreCase) Then
                            result = False
                            Me.AddMessage(Content.DisplayMessageType.Error, String.Format("No value was specified for required column ""{0}"" - skipping row.", fieldName), rowNumber)
                            Exit For
                        End If

                        Dim customObj As Object = Nothing
                        result = ProcessCustomField(fieldName, row(i), obj, customObj)
                        If customObj IsNot Nothing Then
                            output.Add(fieldName, customObj)
                        End If
                    Else
                        result = False
                        Me.AddMessage(Content.DisplayMessageType.Warning, String.Format("Unable to find column ""{0}"" - skipping row.", fieldName), rowNumber)
                        Exit For
                    End If
                End If
            Next

            Return result
        End Function

        Public Overridable Function ProcessCustomField(ByVal fieldName As String, ByVal fieldValue As String, ByVal obj As Object, ByRef output As Object) As Boolean
            output = Nothing
            Return True
        End Function

        Public Overridable Function ProcessPostRow(ByVal row As String(), ByVal rowNumber As Integer, ByRef output As Generic.Dictionary(Of String, Object)) As Boolean
            Return True
        End Function

        Public Overridable Function ProcessPostImport() As Boolean
            Return True
        End Function

        Public MustOverride Function FindRowOjbect(ByVal key As Object) As Object

        Public Overridable Function ValidateRowObject(ByVal data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = True

            If data(Me.KeyField) Is Nothing Then
                result = False
                Me.AddMessage(Content.DisplayMessageType.Error, "Unable to validate row because the row object is null - skipping row.")
            Else
                If data(Me.KeyField).GetType() IsNot Me.ObjectType Then
                    result = False
                    Me.AddMessage(Content.DisplayMessageType.Error, "Unable to validate row because the row object is of the wrong data type - skipping row.")
                End If
            End If

            Return result
        End Function

        Public Overridable Function ValidateCustomRowObjects(ByVal data As Generic.Dictionary(Of String, Object)) As Boolean
            Return True
        End Function

        Public MustOverride Function SaveRow(ByVal data As Generic.Dictionary(Of String, Object)) As Boolean

        Public Overridable Function SaveCustomRowData(ByVal data As Generic.Dictionary(Of String, Object)) As Boolean
            Return True
        End Function

        Public Overridable Function SetValue(ByVal propInfo As System.Reflection.PropertyInfo, ByVal newValue As String, ByVal obj As Object) As Boolean
            Dim oldValue As String = propInfo.GetValue(obj, Nothing).ToString()
            Dim isChanged As Boolean = (oldValue <> newValue)

            If isChanged Then
                ' make sure that null or empty strings are valid for property
                If Not String.IsNullOrEmpty(newValue) OrElse (Not propInfo.PropertyType.IsValueType OrElse (System.Nullable.GetUnderlyingType(propInfo.PropertyType) IsNot Nothing)) Then
                    Dim newValueObj As Object = Nothing

                    If propInfo.PropertyType.IsEnum Then
                        ' Enum
                        Try
                            newValueObj = [Enum].Parse(propInfo.PropertyType, newValue)
                            Dim oldValueObj As Object = [Enum].Parse(propInfo.PropertyType, oldValue)
                            isChanged = Not [Enum].Equals(oldValueObj, newValueObj)
                        Catch ex As Exception
                            AddMessage(Content.DisplayMessageType.Warning, String.Format("Unable to parse Enum column ""{0}"" - skipping column.", propInfo.Name))
                            isChanged = False
                        End Try
                    ElseIf propInfo.PropertyType Is GetType(Boolean) Then
                        ' Boolean
                        If newValue = "1" Then
                            newValueObj = True
                        ElseIf newValue = "0" Then
                            newValueObj = False
                        Else
                            Try
                                newValueObj = Convert.ChangeType(newValue, propInfo.PropertyType)
                            Catch ex As Exception
                                AddMessage(Content.DisplayMessageType.Warning, String.Format("Unable to parse Boolean column ""{0}"" - skipping column.", propInfo.Name))
                                isChanged = False
                            End Try
                        End If

                        If isChanged Then
                            Try
                                Dim oldValueObj As Boolean = Convert.ToBoolean(oldValue)
                                isChanged = Not oldValueObj.Equals(newValueObj)
                            Catch ex As Exception
                                AddMessage(Content.DisplayMessageType.Warning, String.Format("Unable to parse Boolean column ""{0}"" - skipping column.", propInfo.Name))
                            End Try
                        End If
                    ElseIf propInfo.PropertyType Is GetType(CustomPropertyCollection) Then
                        ' CustomPropertyCollection
                        Try
                            newValueObj = Me.ConvertStringToCustomPropertyCollection(newValue)
                            Dim oldValueObj As CustomPropertyCollection = Me.ConvertStringToCustomPropertyCollection(oldValue)
                            isChanged = Not oldValueObj.Equals(newValueObj) 'Not newValueObj.Equals(oldValueObj)
                        Catch ex As Exception
                            AddMessage(Content.DisplayMessageType.Warning, String.Format("Unable to parse CustomPropertyCollection column ""{0}"" - skipping column.", propInfo.Name))
                            isChanged = False
                        End Try
                    ElseIf propInfo.PropertyType Is GetType(Contacts.Address) Then
                        ' Address
                        Try
                            newValueObj = Me.ConvertStringToAddress(newValue)
                            Dim oldValueObj As Contacts.Address = Me.ConvertStringToAddress(oldValue)
                            isChanged = oldValueObj.Equals(newValueObj) 'Not newValueObj.Equals(oldValueObj)
                        Catch ex As Exception
                            AddMessage(Content.DisplayMessageType.Warning, String.Format("Unable to parse Address column ""{0}"" - skipping column.", propInfo.Name))
                            isChanged = False
                        End Try
                    Else
                        ' everything else
                        Try
                            newValueObj = Convert.ChangeType(newValue, propInfo.PropertyType)
                            Dim oldValueObj As Object = Convert.ChangeType(oldValue, propInfo.PropertyType)
                            isChanged = Not oldValueObj.Equals(newValueObj)
                        Catch ex As Exception
                            AddMessage(Content.DisplayMessageType.Warning, String.Format("Unable to parse column ""{0}"" - skipping column.", propInfo.Name))
                            isChanged = False
                        End Try
                    End If

                    If isChanged Then
                        propInfo.SetValue(obj, newValueObj, Nothing)
                        Me.RowIsDirty = True
                    End If
                Else
                    isChanged = False
                End If
            End If

            Return isChanged
        End Function

        Public Overridable Function SetValue(Of TValueType)(newValue As TValueType, ByRef oldValue As TValueType) As Boolean
            Dim isChanged As Boolean = (Not [Object].Equals(newValue, oldValue))

            If isChanged Then
                oldValue = newValue
                Me.RowIsDirty = True
            End If

            Return isChanged
        End Function

        Public Overridable Sub AddMessage(ByVal messageType As Content.DisplayMessageType, ByVal message As String)
            AddMessage(messageType, message, -1)
        End Sub

        Public Overridable Sub AddMessage(ByVal messageType As Content.DisplayMessageType, ByVal message As String, ByVal rowNumber As Integer)
            If rowNumber > 0 Then
                message = String.Format("Row {0}: {1}", rowNumber.ToString(), message)
            End If

            Me.Messages.Add(New Content.DisplayMessage(messageType, message))
        End Sub

#Region " String Functions "

        Private Function StripFieldWrapCharacters(ByVal row() As String, ByVal fieldWrapCharacters As String, ByVal removeFieldWrapCharacterEscaping As Boolean) As String()
            For i As Integer = 0 To row.Length - 1
                row(i) = StripFieldWrapCharacters(row(i), fieldWrapCharacters, removeFieldWrapCharacterEscaping)
            Next

            Return row
        End Function
        Private Function StripFieldWrapCharacters(ByVal s As String, ByVal fieldWrapCharacters As String, ByVal removeFieldWrapCharacterEscaping As Boolean) As String
            If Not String.IsNullOrEmpty(fieldWrapCharacters) Then
                If s.StartsWith(fieldWrapCharacters) AndAlso s.EndsWith(fieldWrapCharacters) Then
                    If s.Length >= (fieldWrapCharacters.Length * 2) Then
                        s = s.Substring(fieldWrapCharacters.Length, s.Length - (fieldWrapCharacters.Length * 2))
                    End If

                    If removeFieldWrapCharacterEscaping = True Then
                        s = s.Replace(fieldWrapCharacters + fieldWrapCharacters, fieldWrapCharacters)
                    End If
                End If
            End If

            Return s
        End Function

#End Region

#Region " Helper Functions "

        ' copied/modified from CustomizableBusinessEntityBase.CustomPropertiesFromXml() method
        Public Overridable Function ConvertStringToCustomPropertyCollection(ByVal data As String) As CustomPropertyCollection
            Dim result As New CustomPropertyCollection()

            If Not String.IsNullOrEmpty(data) Then
                Try
                    Dim tr As New StringReader(data)
                    Dim xs As New XmlSerializer(result.GetType)
                    result = CType(xs.Deserialize(tr), CustomPropertyCollection)
                Catch ex As Exception
                    AddMessage(Content.DisplayMessageType.Exception, ex.ToString())
                End Try
            End If

            Return result
        End Function

        Public Overridable Function ConvertStringToAddress(ByVal data As String) As Contacts.Address
            Dim result As New Contacts.Address()

            If Not String.IsNullOrEmpty(data) Then
                Try
                    result.FromXmlString(data)
                Catch ex As Exception
                    AddMessage(Content.DisplayMessageType.Exception, ex.ToString())
                End Try
            End If

            Return result
        End Function

#End Region


#Region " IDisposable Support "

        Private disposedValue As Boolean = False        ' To detect redundant calls

        ' IDisposable
        Protected Overridable Sub Dispose(ByVal disposing As Boolean)
            If Not Me.disposedValue Then
                If disposing Then
                    If Me.ImportFile IsNot Nothing AndAlso Me.ImportFile.BaseStream.CanWrite Then
                        Me.ImportFile.Close()
                    End If
                    Me.ImportFile.Dispose()
                End If
            End If
            Me.disposedValue = True
        End Sub

        ' This code added by Visual Basic to correctly implement the disposable pattern.
        Public Sub Dispose() Implements IDisposable.Dispose
            ' Do not change this code.  Put cleanup code in Dispose(ByVal disposing As Boolean) above.
            Dispose(True)
            GC.SuppressFinalize(Me)
        End Sub

#End Region

    End Class

End Namespace