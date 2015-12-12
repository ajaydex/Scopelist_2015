Imports System.Collections.ObjectModel
Imports System.IO
Imports System.Text.RegularExpressions
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine

    Public MustInherit Class BaseFeed
        Implements IDisposable

        Protected SettingsManager As Datalayer.ComponentSettingsManager
        Private _Context As HttpContext
        Private _ApplicationPath As String
        Private _FieldDelimiter As String
        Private _FieldWrapCharacter As String
        Private _DateFormat As String
        Private _FeedName As String
        Private _FileName As String
        Private _FilePath As String
        Private _HostName As String
        Private _UserName As String
        Private _Password As String
        Private _AffiliateID As String
        Private _AffiliateReferralID As String
        Protected Feed As FileStream
        Protected _FeedEncoding As Encoding

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

        Protected Overridable ReadOnly Property DEFAULT_DATEFORMAT() As String
            Get
                Return "yyyy-MM-dd"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Base Feed"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "base.txt"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_FILEPATH() As String
            Get
                Return "files\feeds\"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_HOSTNAME() As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_USERNAME() As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_PASSWORD() As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_AFFILIATEID() As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_FEEDENCODING() As Encoding
            Get
                Return Encoding.UTF8
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overridable ReadOnly Property Context() As HttpContext
            Get
                If Me._Context Is Nothing Then
                    If HttpContext.Current IsNot Nothing Then
                        Me._Context = HttpContext.Current
                    Else
                        Me._Context = New HttpContext(New System.Web.Hosting.SimpleWorkerRequest(String.Empty, String.Empty, New System.IO.StringWriter()))
                    End If
                End If

                Return Me._Context
            End Get
        End Property

        Public Overridable ReadOnly Property PhysicalApplicationPath() As String
            Get
                Return Me.Context.Request.PhysicalApplicationPath
            End Get
        End Property

        Public Overridable ReadOnly Property ApplicationPath() As String
            Get
                If String.IsNullOrEmpty(Me._ApplicationPath) Then
                    Dim pos As Integer = WebAppSettings.SiteStandardRoot.IndexOf(Uri.SchemeDelimiter)

                    If pos > 0 Then
                        pos = WebAppSettings.SiteStandardRoot.IndexOf("/", pos + Uri.SchemeDelimiter.Length)
                        If pos > 0 Then
                            Me._ApplicationPath = WebAppSettings.SiteStandardRoot.Substring(pos)
                        Else
                            Me._ApplicationPath = "/"
                        End If
                    Else

                    End If
                End If

                Return Me._ApplicationPath
            End Get
        End Property

        Public Overridable ReadOnly Property PhysicalFileFolderPath() As String
            Get
                Return Path.Combine(Me.PhysicalApplicationPath, Me.FileFolderPath)
            End Get
        End Property

        Public Overridable ReadOnly Property PhysicalFilePath() As String
            Get
                Return Path.Combine(Me.PhysicalFileFolderPath, Me.FileName)
            End Get
        End Property

        Public Overridable Property FileFolderPath() As String
            Get
                Return Me._FilePath
            End Get
            Set(ByVal value As String)
                Me._FilePath = value
            End Set
        End Property

        Public Overridable Property FileName() As String
            Get
                Return Me._FileName
            End Get
            Set(ByVal value As String)
                Me._FileName = value
            End Set
        End Property

        Public Overridable ReadOnly Property FileUrl() As String
            Get
                Return Me.CreateFullyQualifiedUrl(Path.Combine(Me.FileFolderPath, Me.FileName))
            End Get
        End Property

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

        Public Overridable Property DateFormat() As String
            Get
                Return Me._DateFormat
            End Get
            Set(ByVal value As String)
                Me._DateFormat = value
            End Set
        End Property

        Public Overridable ReadOnly Property Bvin() As String
            Get
                Return SettingsManager.BlockId
            End Get
        End Property

        Public Overridable Property FeedName() As String
            Get
                Return Me._FeedName
            End Get
            Set(ByVal value As String)
                Me._FeedName = value
            End Set
        End Property

        Public MustOverride ReadOnly Property FeedType() As String

        Public Overridable Property HostName() As String
            Get
                Return Me._HostName
            End Get
            Set(ByVal value As String)
                Me._HostName = value
            End Set
        End Property

        Public Overridable Property UserName() As String
            Get
                Return Me._UserName
            End Get
            Set(ByVal value As String)
                Me._UserName = value
            End Set
        End Property

        Public Overridable Property Password() As String
            Get
                Return Me._Password
            End Get
            Set(ByVal value As String)
                Me._Password = value
            End Set
        End Property

        Public Overridable Property AffiliateID() As String
            Get
                Return Me._AffiliateID
            End Get
            Set(ByVal value As String)
                Me._AffiliateID = value
            End Set
        End Property

        Public Overridable ReadOnly Property AffiliateReferralID() As String
            Get
                Return Me._AffiliateReferralID
            End Get
        End Property

        Public Overridable Property FeedEncoding() As Encoding
            Get
                Return Me._FeedEncoding
            End Get
            Set(ByVal value As Encoding)
                Me._FeedEncoding = value
            End Set
        End Property

#End Region

        Sub New(ByVal componentId As String)
            Me.SettingsManager = New Datalayer.ComponentSettingsManager(componentId)

            Dim setting As String = String.Empty

            setting = Me.SettingsManager.GetSetting("FieldDelimiter")
            Me._FieldDelimiter = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_FIELDDELIMITER)

            setting = Me.SettingsManager.GetSetting("FieldWrapCharacter")
            Me._FieldWrapCharacter = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_FIELDWRAPCHARACTER)

            setting = Me.SettingsManager.GetSetting("DateFormat")
            Me._DateFormat = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_DATEFORMAT)

            setting = Me.SettingsManager.GetSetting("FeedName")
            Me._FeedName = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_FEEDNAME)

            setting = Me.SettingsManager.GetSetting("FileName")
            Me._FileName = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_FILENAME)

            setting = Me.SettingsManager.GetSetting("FilePath")
            Me._FilePath = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_FILEPATH)

            setting = Me.SettingsManager.GetSetting("HostName")
            Me._HostName = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_HOSTNAME)

            setting = Me.SettingsManager.GetSetting("UserName")
            Me._UserName = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_USERNAME)

            setting = Me.SettingsManager.GetSetting("Password")
            Me._Password = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_PASSWORD)

            setting = Me.SettingsManager.GetSetting("AffiliateID")
            Me._AffiliateID = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_AFFILIATEID)

            If Not String.IsNullOrEmpty(Me.AffiliateID) Then
                Dim a As Contacts.Affiliate = Contacts.Affiliate.FindByBvin(Me.AffiliateID)
                If Not String.IsNullOrEmpty(a.Bvin) Then
                    Me._AffiliateReferralID = a.ReferralId
                    a = Nothing
                End If
            End If

            setting = Me.SettingsManager.GetSetting("FeedEncoding")
            Me._FeedEncoding = If(Not String.IsNullOrEmpty(setting), Encoding.GetEncoding(setting), Me.DEFAULT_FEEDENCODING)

            Me.Feed = Nothing
        End Sub

        Public Overridable Sub SaveSettings()
            Me.SettingsManager.SaveSetting("FileName", Me.FileName, "Develisys", "Product Feed", Me.FeedName)
            Me.SettingsManager.SaveSetting("HostName", Me.HostName, "Develisys", "Product Feed", Me.FeedName)
            Me.SettingsManager.SaveSetting("UserName", Me.UserName, "Develisys", "Product Feed", Me.FeedName)
            Me.SettingsManager.SaveSetting("Password", Me.Password, "Develisys", "Product Feed", Me.FeedName)
            Me.SettingsManager.SaveSetting("AffiliateID", Me.AffiliateID, "Develisys", "Product Feed", Me.FeedName)
        End Sub

        Public Overridable Function GenerateFeedAndUpload() As Boolean
            GenerateFeed()
            Return UploadFile()
        End Function

        Public Overridable Function GenerateFeedAndUpload(ByVal state As Object) As Boolean
            Return GenerateFeedAndUpload()
        End Function

        Public Overridable Sub GenerateFeed()
            AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Information, Me.FeedName, "GenerateFeed() started")

            Try
                ' make sure feed file directory exists - if not, create it
                If Not Directory.Exists(Me.PhysicalFileFolderPath) Then
                    Directory.CreateDirectory(Me.PhysicalFileFolderPath)
                End If

                Me.Feed = New FileStream(Me.PhysicalFilePath, FileMode.Create)

                Me.AddHeaderRow()
                Me.Generate()

                AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success, Me.FeedName, "GenerateFeed() complete")
            Catch ex As Exception
                AuditLog.LogException(ex)
            Finally
                If Me.Feed IsNot Nothing Then
                    Me.Feed.Close()
                    Me.Feed.Dispose()
                End If
            End Try
        End Sub

        Public Overridable Sub GenerateFeed(ByVal state As Object)
            GenerateFeed()
        End Sub

        Protected MustOverride Sub Generate()

        Protected Overridable Sub Write(ByVal value As String)
            Dim encValue As Byte() = Me.FeedEncoding.GetBytes(value)

            Me.Feed.Write(encValue, 0, encValue.Length)
        End Sub

#Region " Text file Functions "

        Protected MustOverride Sub AddHeaderRow()

        Protected Overridable Sub AddColumn(ByVal value As String)
            AddColumn(value, Integer.MaxValue)
        End Sub
        Protected Overridable Sub AddColumn(ByVal value As String, ByVal maxLength As Integer)
            ' if 'value' is a New Line character, don't wrap it with the FieldWrapCharacter
            If value = ControlChars.NewLine Then
                Me.Write(value)
            Else
                If Me.Feed.Length > 1 Then
                    ' check if we need to add a delimiter
                    Dim buffer(Me.FeedEncoding.GetBytes(ControlChars.NewLine).Length - 1) As Byte
                    Me.Feed.Seek(-1 * buffer.Length, SeekOrigin.Current)
                    Me.Feed.Read(buffer, 0, buffer.Length)

                    Dim lastChars As String = Me.FeedEncoding.GetString(buffer) 'System.Convert.ToBase64String(buffer)
                    If lastChars <> ControlChars.NewLine Then
                        Me.Write(Me.FieldDelimiter)
                    End If
                End If

                Me.Write(Me.FieldWrapCharacter)

                ' clean text and strip HTML/CSS/JavaScript
                Dim column As String = CleanText(value)

                ' trim column to length, if neccessary
                If column.Length > maxLength Then
                    column = column.Substring(0, maxLength - 1)

                    ' make sure the column doesn't end with one double quote, if that's our field wrap character
                    If Me.FieldWrapCharacter = """" Then
                        If column.EndsWith("""") AndAlso Not column.EndsWith("""""") Then
                            column = column.Substring(0, column.Length - 2) & """"""
                        End If
                    End If
                End If

                Me.Write(column)

                Me.Write(Me.FieldWrapCharacter)
            End If
        End Sub

        Protected Overridable Sub AddRow(ByVal ParamArray values As String())
            If Me.Feed.Length > 1 Then
                ' check if we need to add a line break
                Dim buffer(Me.FeedEncoding.GetBytes(ControlChars.NewLine).Length - 1) As Byte
                Me.Feed.Seek(-1 * buffer.Length, SeekOrigin.Current)
                Me.Feed.Read(buffer, 0, buffer.Length)

                Dim lastChars As String = Me.FeedEncoding.GetString(buffer)
                If lastChars <> ControlChars.NewLine Then
                    Me.Write(ControlChars.NewLine)
                End If
            End If

            If values IsNot Nothing AndAlso values.Length > 0 Then
                For Each value As String In values
                    AddColumn(value)
                Next
                Me.Write(ControlChars.NewLine)
            End If
        End Sub

#End Region

        Public Overridable Function UploadFile() As Boolean
            Dim result As Boolean = False

            AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Information, Me.FeedName, "UploadFile() started")

            Try
                If String.IsNullOrEmpty(Me.HostName) Then
                    Throw New ApplicationException("FTP upload failed: no host name was specified")
                Else
                    ' make sure feed file exists, if not, create it
                    If Not File.Exists(Me.PhysicalFilePath) Then
                        Me.GenerateFeed()

                        If Not File.Exists(Me.PhysicalFilePath) Then
                            Throw New ApplicationException(String.Format("File '{0}' not found and could not be generated", Me.FileName))
                        End If
                    End If

                    Dim fi As New FileInfo(Me.PhysicalFilePath)

                    ' make sure feed file has content
                    If fi.Length = 0 Then
                        Throw New ApplicationException(String.Format("File '{0}' is empty...aborting upload.", Me.FileName))
                    Else
                        Dim ftpUri As New Uri(Uri.UriSchemeFtp & Uri.SchemeDelimiter & Me.HostName & "/" & Me.FileName)

                        Dim ftp As Net.FtpWebRequest = CType(Net.FtpWebRequest.Create(ftpUri), Net.FtpWebRequest)
                        ftp.Credentials = New Net.NetworkCredential(Me.UserName, Me.Password)
                        ftp.KeepAlive = False   ' do not keep alive (stateless mode)

                        'Set request to upload a file in binary
                        ftp.Method = Net.WebRequestMethods.Ftp.UploadFile
                        ftp.UseBinary = True

                        'Notify FTP of the expected size
                        ftp.ContentLength = fi.Length

                        'create byte array to store: ensure at least 1 byte!
                        Const BufferSize As Integer = 2048
                        Dim content(BufferSize - 1) As Byte, dataRead As Integer

                        'open file for reading 
                        Using fs As FileStream = fi.OpenRead()
                            Try
                                'open request to send
                                Using rs As Stream = ftp.GetRequestStream
                                    Do
                                        dataRead = fs.Read(content, 0, BufferSize)
                                        rs.Write(content, 0, dataRead)
                                    Loop Until dataRead < BufferSize
                                    rs.Close()
                                End Using
                                result = True

                                AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success, Me.FeedName, "UploadFile() complete")
                            Catch ex As Exception
                                AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, Me.FeedName, String.Format("{0} [{1}]", ex.Message, ex.StackTrace))
                            Finally
                                'ensure file closed
                                fs.Close()
                            End Try
                        End Using

                        ftp = Nothing
                    End If
                End If
            Catch ex As Exception
                AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, Me.FeedName, String.Format("{0} [{1}]", ex.Message, ex.StackTrace))
            End Try

            Return result
        End Function

        Public Overridable Function UploadFile(ByVal state As Object) As Boolean
            Return UploadFile()
        End Function

#Region " String Functions "

        Protected Overridable Function ConvertIntegerToBooleanString(ByVal i As Integer) As String
            Dim result As String = "false"

            If i > 0 Then
                result = "true"
            End If

            Return result
        End Function

        Protected Overridable Function ConvertBooleanToYesOrNo(ByVal trueOrFalse As Boolean) As String
            Dim result As String = "No"

            If trueOrFalse = True Then
                result = "Yes"
            End If

            Return result
        End Function

        Protected Overridable Function ConvertAddressToString(ByVal a As Contacts.Address) As String
            Dim result As String = String.Empty
            Dim sb As New StringBuilder()

            If a IsNot Nothing Then
                'If Not String.IsNullOrEmpty(a.NickName) Then
                '    sb.Append(String.Format("{0}, ", a.NickName))
                'End If

                'If Not String.IsNullOrEmpty(a.FirstName) OrElse Not String.IsNullOrEmpty(a.LastName) Then
                '    sb.Append(String.Format("{0} {1} {2}, ", a.FirstName, a.MiddleInitial, a.LastName))
                'End If

                'If Not String.IsNullOrEmpty(a.Company) Then
                '    sb.Append(String.Format("{0}, ", a.Company))
                'End If

                If Not String.IsNullOrEmpty(a.Line1) Then
                    sb.Append(String.Format("{0}, ", a.Line1))
                End If
                If Not String.IsNullOrEmpty(a.Line2) Then
                    sb.Append(String.Format("{0}, ", a.Line2))
                End If
                If Not String.IsNullOrEmpty(a.Line3) Then
                    sb.Append(String.Format("{0}, ", a.Line3))
                End If

                If Not String.IsNullOrEmpty(a.City) Then
                    sb.Append(String.Format("{0}, ", a.City))
                End If

                If Not String.IsNullOrEmpty(a.RegionName) Then
                    sb.Append(String.Format("{0}, ", a.RegionName))
                End If

                If Not String.IsNullOrEmpty(a.PostalCode) Then
                    sb.Append(String.Format("{0}, ", a.PostalCode))
                End If

                If Not String.IsNullOrEmpty(a.CountryName) Then
                    sb.Append(String.Format("{0}, ", a.CountryName))
                End If

                result = sb.Replace("  ", " ").ToString().Trim().TrimEnd(","c)
                sb = Nothing
            End If

            Return result
        End Function

        Protected Overridable Function CleanText(ByVal text As String) As String
            Dim sb As New StringBuilder(StripHtml(text))

            sb.Replace(ControlChars.Tab, " ")
            sb.Replace(ControlChars.NewLine, " ")
            sb.Replace(ControlChars.Cr, " ")
            sb.Replace(ControlChars.Lf, " ")

            sb.Replace(Chr(133), "...")
            sb.Replace(Chr(145), "'")
            sb.Replace(Chr(146), "'")
            sb.Replace(Chr(147), ControlChars.Quote)
            sb.Replace(Chr(148), ControlChars.Quote)
            sb.Replace(Chr(150), "-")
            sb.Replace(Chr(151), "--")
            sb.Replace(Chr(153), "(TM)")
            sb.Replace(Chr(162), "c")
            sb.Replace(Chr(163), "GBP")
            sb.Replace(Chr(128), "EUR")
            sb.Replace(Chr(169), "(C)")
            sb.Replace(Chr(174), "(R)")
            sb.Replace(Chr(176), "deg")
            sb.Replace(Chr(177), "+/-")
            sb.Replace(Chr(178), "^2")
            sb.Replace(Chr(188), "1/4")
            sb.Replace(Chr(189), "1/2")
            sb.Replace(Chr(190), "3/4")
            sb.Replace(ChrW(237), "i")  ' í
            sb.Replace(ChrW(8211), "-")  ' –
            sb.Replace(ChrW(8212), "--")  ' —
            sb.Replace(ChrW(8217), "'") ' ’
            sb.Replace(ChrW(8220), ControlChars.Quote)  ' “
            sb.Replace(ChrW(8221), ControlChars.Quote)    ' ”
            sb.Replace(ChrW(8226), "*")  ' •
            sb.Replace(ChrW(8230), "...")   ' …
            sb.Replace(ChrW(8480), "(sm)")    ' ℠
            sb.Replace(ChrW(8482), "(tm)")  ' ™
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

        Public Overridable Function CleanXmlText(ByVal text As String) As String
            If text Is Nothing Then
                Return String.Empty
            End If

            Dim sb As New StringBuilder(text.Length)
            For Each c As Char In text
                If Me.IsLegalXmlChar("1.0", System.Convert.ToInt32(c)) Then
                    sb.Append(c)
                End If
            Next

            Return sb.ToString()
        End Function

        ''' <summary>
        ''' Get whether an integer represents a legal XML 1.0 or 1.1 character. See
        ''' the specification at w3.org for these characters.
        ''' </summary>
        ''' <param name="xmlVersion">
        ''' The version number as a string. Use "1.0" for XML 1.0 character
        ''' validation, and use "1.1" for XML 1.1 character validation.
        ''' </param>
        Public Overridable Function IsLegalXmlChar(xmlVersion As String, character As Integer) As Boolean
            Select Case xmlVersion
                Case "1.1"
                    ' http://www.w3.org/TR/xml11/#charsets
                    If True Then
                        Return Not (character <= &H8 OrElse character = &HB OrElse character = &HC OrElse (character >= &HE AndAlso character <= &H1F) OrElse (character >= &H7F AndAlso character <= &H84) OrElse (character >= &H86 AndAlso character <= &H9F) OrElse character > &H10FFFF)
                    End If
                Case "1.0"
                    ' http://www.w3.org/TR/REC-xml/#charsets
                    If True Then
                        ' == '\t' == 9   
                        ' == '\n' == 10  
                        ' == '\r' == 13  
                        Return (character = &H9 OrElse character = &HA OrElse character = &HD OrElse (character >= &H20 AndAlso character <= &HD7FF) OrElse (character >= &HE000 AndAlso character <= &HFFFD) OrElse (character >= &H10000 AndAlso character <= &H10FFFF))
                    End If
                Case Else
                    If True Then
                        Throw New ArgumentOutOfRangeException("xmlVersion", String.Format("'{0}' is not a valid XML version."))
                    End If
            End Select
        End Function

        Protected Overridable Function StripHtml(ByVal text As String) As String
            Return Utilities.TextUtilities.StripHtml(text)
        End Function

#End Region

#Region " URL Functions "

        Protected Overridable Function CreateFullyQualifiedUrl(ByVal url As String) As String
            Return Utilities.UrlRewriter.CreateFullyQualifiedUrl(url)
        End Function

        Protected Overridable Function ResolveUrl(ByVal relativeUrl As String) As String
            Dim result As String = relativeUrl

            If Not String.IsNullOrEmpty(result) Then
                ' check if URL is fully-qualified
                If result.IndexOf(Uri.SchemeDelimiter) < 0 Then
                    result = result.Replace("\", "/").Replace(" ", "%20")

                    ' resolve to application root
                    If result.StartsWith("/") Then
                        ' do nothing
                    ElseIf result.StartsWith("~/") Then
                        result = Me.ApplicationPath & result.Substring("~/".Length)
                    Else
                        result = Me.ApplicationPath & result
                    End If
                End If
            End If

            Return result
        End Function

#End Region

#Region " Helper Functions "

        Protected Overridable Function GetPaymentMethods() As String
            Dim result As String = String.Empty

            For Each pm As Payment.PaymentMethod In Payment.AvailablePayments.EnabledMethods
                If pm.MethodId = WebAppSettings.PaymentIdCreditCard Then
                    For Each ct As Payment.CreditCardType In Payment.CreditCardType.FindAllActive()
                        result &= ct.LongName & ", "
                    Next
                Else
                    result &= pm.MethodName & ", "
                End If
            Next

            Return result.Trim().TrimEnd(","c)
        End Function

#End Region


#Region " IDisposable Support "

        Private disposedValue As Boolean = False        ' To detect redundant calls

        ' IDisposable
        Protected Overridable Sub Dispose(ByVal disposing As Boolean)
            If Not Me.disposedValue Then
                If disposing Then
                    Me.SettingsManager = Nothing

                    If Me.Feed IsNot Nothing AndAlso Me.Feed.CanWrite Then
                        Me.Feed.Close()
                    End If
                    Me.Feed.Dispose()
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