Imports System.Collections.ObjectModel
Imports System.IO
Imports System.Text.RegularExpressions
Imports System.Xml
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine

    Public MustInherit Class BaseSitemapFeed
        Inherits BaseProductFeed

        Protected _AdditionalUrlsFileName As String
        Protected _AdditionalUrlsFieldDelimiter As String
        Protected _DefaultPriority As Decimal
        Protected _DefaultChangeFreq As String
        Protected _DefaultLastMod As DateTime
        Protected _Categories As Collection(Of Catalog.Category)
        Protected _CustomPages As Collection(Of Content.CustomPage)
        Protected _AdditionalPages As Collection(Of Hashtable)
        Protected _SearchEngines As StringDictionary
        Protected _PingSearchEngines As Boolean


#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FIELDWRAPCHARACTER() As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Base Sitemap Feed"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "basesitemap.xml"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_ADDITIONALURLSFILENAME() As String
            Get
                Return "sitemapadditions.txt"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_ADDITIONALURLSFIELDDELIMITER() As String
            Get
                Return ControlChars.Tab
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_DEFAULTPRIORITY() As Decimal
            Get
                Return 0.5D
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_DEFAULTCHANGEFREQ() As String
            Get
                Return "weekly"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_DEFAULTLASTMOD() As DateTime
            Get
                Return DateTime.Now
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_SEARCHENGINES() As StringDictionary
            Get
                ' on some servers calling UrlEncode causes an error on application start -- removed call since it's not entirely necessary
                Dim sitemapEncodedUrl As String = Me.FileUrl   'HttpUtility.UrlEncode(Me.FileUrl)
                
                Dim result As New StringDictionary()
                result.Add("Google", String.Format("http://www.google.com/webmasters/tools/ping?sitemap={0}", sitemapEncodedUrl))
                result.Add("Bing", String.Format("http://www.bing.com/ping?sitemap={0}", sitemapEncodedUrl))

                Return result
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_PINGSEARCHENGINES As Boolean
            Get
                Return False
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property FeedType As String
            Get
                Return "Sitemap"
            End Get
        End Property

        Public Overridable Property AdditionalUrlsFileName() As String
            Get
                Return Me._AdditionalUrlsFileName
            End Get
            Set(ByVal value As String)
                Me._AdditionalUrlsFileName = value
            End Set
        End Property

        Public Overridable Property AdditionalUrlsFieldDelimiter() As String
            Get
                Return Me._AdditionalUrlsFieldDelimiter
            End Get
            Set(ByVal value As String)
                Me._AdditionalUrlsFieldDelimiter = value
            End Set
        End Property

        Public Overridable Property DefaultPriority() As Decimal
            Get
                Return Me._DefaultPriority
            End Get
            Set(ByVal value As Decimal)
                Me._DefaultPriority = value
            End Set
        End Property

        Public Overridable Property DefaultChangeFreq() As String
            Get
                Return Me._DefaultChangeFreq
            End Get
            Set(ByVal value As String)
                Me._DefaultChangeFreq = value
            End Set
        End Property

        Public Overridable Property DefaultLastMod() As DateTime
            Get
                Return Me._DefaultLastMod
            End Get
            Set(ByVal value As DateTime)
                Me._DefaultLastMod = value
            End Set
        End Property

        Public Overridable Property PingSearchEngines() As Boolean
            Get
                Return Me._PingSearchEngines
            End Get
            Set(ByVal value As Boolean)
                Me._PingSearchEngines = value
            End Set
        End Property

        Public Overridable ReadOnly Property Categories() As Collection(Of Catalog.Category)
            Get
                If Me._Categories Is Nothing OrElse Me._Categories.Count = 0 Then
                    Me._Categories = New Collection(Of Catalog.Category)

                    Dim allCategories As Collection(Of Catalog.Category) = Catalog.Category.FindAllLight()
                    For Each c As Catalog.Category In allCategories
                        If Not c.Hidden _
                            AndAlso c.SourceType <> Catalog.CategorySourceType.CustomPage _
                            AndAlso Not (c.SourceType = Catalog.CategorySourceType.CustomLink AndAlso Me.IsHomepageUrl(c.CustomPageUrl)) Then

                            Me._Categories.Add(c)
                        End If
                    Next
                    allCategories = Nothing

                    ' exclude Categories by custom criteria
                    'For i As Integer = Me._Categories.Count - 1 To 0 Step -1
                    '    ' example: exclude Custom Page categories
                    '    If Me._Categories(i).SourceType = Catalog.CategorySourceType.CustomPage Then
                    '        Me._Categories.RemoveAt(i)
                    '    End If
                    'Next
                End If

                Return Me._Categories
            End Get
        End Property

        Public Overridable ReadOnly Property CustomPages() As Collection(Of Content.CustomPage)
            Get
                If Me._CustomPages Is Nothing OrElse Me._CustomPages.Count = 0 Then
                    Me._CustomPages = New Collection(Of Content.CustomPage)

                    Dim allCustomPages As Collection(Of Content.CustomPage) = Content.CustomPage.FindAll()
                    For Each cp As Content.CustomPage In allCustomPages
                        Me._CustomPages.Add(cp)
                    Next
                    allCustomPages = Nothing

                    ' exclude Custom Pages by custom criteria
                    'For i As Integer = Me._CustomPages.Count - 1 To 0 Step -1
                    '    ' example: exclude Custom Pages shown in bottom menu
                    '    If Me._CustomPages(i).ShowInBottomMenu = True Then
                    '        Me._CustomPages.RemoveAt(i)
                    '    End If
                    'Next
                End If

                Return Me._CustomPages
            End Get
        End Property

        Public Overridable ReadOnly Property AdditionalPages() As Collection(Of Hashtable)
            Get
                If Me._AdditionalPages Is Nothing OrElse Me._AdditionalPages.Count = 0 Then
                    LoadAdditionalPages()
                End If

                Return Me._AdditionalPages
            End Get
        End Property

        Public Overridable Property SearchEngines() As StringDictionary
            Get
                Return Me._SearchEngines
            End Get
            Set(ByVal value As StringDictionary)
                Me._SearchEngines = value
            End Set
        End Property

#End Region

        Sub New(ByVal componentId As String)
            MyBase.New(componentId)

            Me.SettingsManager = New Datalayer.ComponentSettingsManager(componentId)

            Dim setting As String = String.Empty

            setting = Me.SettingsManager.GetSetting("AdditionalUrlsFileName")
            Me._AdditionalUrlsFileName = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_ADDITIONALURLSFILENAME)

            setting = Me.SettingsManager.GetSetting("AdditionalUrlsFieldDelimiter")
            Me._AdditionalUrlsFieldDelimiter = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_ADDITIONALURLSFIELDDELIMITER)

            setting = Me.SettingsManager.GetSetting("DefaultPriority")
            Me._DefaultPriority = If(Not String.IsNullOrEmpty(setting), System.Convert.ToDecimal(setting), Me.DEFAULT_DEFAULTPRIORITY)

            setting = Me.SettingsManager.GetSetting("DefaultChangeFreq")
            Me._DefaultChangeFreq = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_DEFAULTCHANGEFREQ)

            setting = Me.SettingsManager.GetSetting("DefaultLastMod")
            Me._DefaultLastMod = If(Not String.IsNullOrEmpty(setting), System.Convert.ToDateTime(setting), Me.DEFAULT_DEFAULTLASTMOD)

            setting = Me.SettingsManager.GetSetting("PingSearchEngines")
            Me._PingSearchEngines = If(Not String.IsNullOrEmpty(setting), System.Convert.ToBoolean(setting), Me.DEFAULT_PINGSEARCHENGINES)

            Me._SearchEngines = Me.DEFAULT_SEARCHENGINES

            Me._Products = Nothing
            Me._Categories = Nothing
            Me._CustomPages = Nothing
        End Sub

        Public Overrides Sub SaveSettings()
            MyBase.SaveSettings()

            Me.SettingsManager.SaveSetting("AdditionalUrlsFileName", Me.AdditionalUrlsFileName, "Develisys", "Sitemap Feed", Me.FeedName)
            Me.SettingsManager.SaveSetting("DefaultPriority", Me.DefaultPriority, "Develisys", "Sitemap Feed", Me.FeedName)
            Me.SettingsManager.SaveSetting("DefaultChangeFreq", Me.DefaultChangeFreq, "Develisys", "Sitemap Feed", Me.FeedName)
            Me.SettingsManager.SaveSetting("PingSearchEngines", Me.PingSearchEngines, "Develisys", "Sitemap Feed", Me.FeedName)
        End Sub

        Public Overrides Sub GenerateFeed()
            MyBase.GenerateFeed()

            ' memory cleanup - clear large in-memory objects
            Me._Products = Nothing
            Me._Categories = Nothing
            Me._CustomPages = Nothing
            Me._AdditionalPages = Nothing
        End Sub

        Protected Overrides Sub Generate()
            ' Homepage
            Me.AddRow(Me.GetHomepageUrl())

            ' Categories
            For Each c As Catalog.Category In Me.Categories
                AddCategoryRow(c)
            Next
            Me._Categories = Nothing

            ' Product pages
            For Each p As Catalog.Product In Me.Products
                AddProductRow(p)
            Next
            Me._Products = Nothing

            ' Custom Pages
            For Each cp As Content.CustomPage In Me.CustomPages
                AddCustomPageRow(cp)
            Next
            Me._CustomPages = Nothing

            ' additional pages
            For Each ap As Hashtable In Me.AdditionalPages
                AddAdditionalPageRow(ap)
            Next
            Me._AdditionalPages = Nothing
        End Sub

        Protected MustOverride Sub AddCategoryRow(ByRef c As Catalog.Category)
        Protected MustOverride Sub AddCustomPageRow(ByRef cp As Content.CustomPage)
        Protected MustOverride Sub AddAdditionalPageRow(ByRef ap As Hashtable)

#Region " URL Functions "

        Protected Overridable Function IsHomepageUrl(ByVal url As String) As Boolean
            Const defaultPageName As String = "default.aspx"

            ' standardize homepage URL for testing
            Dim homepageUrl As String = Me.GetHomepageUrl().ToLower()
            If homepageUrl.EndsWith(defaultPageName) Then
                If homepageUrl.Length > defaultPageName.Length Then
                    homepageUrl = homepageUrl.Substring(0, homepageUrl.Length - defaultPageName.Length)
                Else
                    homepageUrl = String.Empty
                End If
            End If

            If Not homepageUrl.EndsWith("/") Then
                homepageUrl += "/"
            End If

            ' standardize input URL for testing
            url = url.ToLower()
            If url.EndsWith(defaultPageName) Then
                If url.Length > defaultPageName.Length Then
                    url = url.Substring(0, url.Length - defaultPageName.Length)
                Else
                    url = String.Empty
                End If
            End If

            If Not url.EndsWith("/") Then
                url += "/"
            End If
            url = Me.CreateFullyQualifiedUrl(url)


            ' test URLs for equality
            Return (homepageUrl = url)
        End Function

        Protected Overridable Function GetHomepageUrl() As String
            Return WebAppSettings.SiteStandardRoot
        End Function

        Protected Overridable Function CreateCategoryUrl(ByRef c As Catalog.Category) As String
            Dim result As String = String.Empty

            If c IsNot Nothing AndAlso Not String.IsNullOrEmpty(c.Bvin) Then
                result = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Context.Request, Me.Categories)
                result = Me.CreateFullyQualifiedUrl(result)
            End If

            Return result
        End Function

        Protected Overridable Function CreateCustomPageUrl(ByRef cp As Content.CustomPage) As String
            Dim result As String = String.Empty

            If cp IsNot Nothing AndAlso Not String.IsNullOrEmpty(cp.Bvin) Then
                result = Utilities.UrlRewriter.BuildUrlForCustomPage(cp.Bvin)
                result = Me.CreateFullyQualifiedUrl(result)
            End If

            Return result
        End Function

#End Region

        Protected Overridable Function GetCategoryPriority(ByRef c As Catalog.Category) As Decimal
            Dim result As Decimal = Me.DefaultPriority

            Dim trail As Collection(Of Catalog.Category) = New Collection(Of Catalog.Category)
            Catalog.Category.BuildParentTrail(Me.Categories, c.Bvin, trail)

            If trail.Count > 9 Then
                result = 0.1D
            Else
                result = 1D - (System.Convert.ToDecimal(trail.Count) / 10)
            End If

            ' prevent category priority from being lower than the default priority (which is used for products)
            If result < Me.DefaultPriority Then
                result = Me.DefaultPriority
            End If

            Return result
        End Function

        Protected Overridable Sub LoadAdditionalPages()
            Me._AdditionalPages = New Collection(Of Hashtable)

            Dim path As String = Me.PhysicalFileFolderPath + Me.AdditionalUrlsFileName
            If File.Exists(path) Then
                Using sr As System.IO.StreamReader = File.OpenText(path)
                    Dim headerRow As String() = Nothing

                    While Not sr.EndOfStream

                        Dim line As String = sr.ReadLine()

                        If Not String.IsNullOrEmpty(line) Then
                            Dim row() As String = line.Split(Me.AdditionalUrlsFieldDelimiter)

                            If headerRow Is Nothing Then
                                If row.Length = 1 Then
                                    ' assume there is no header row and file contains only URLs
                                    headerRow = New String() {"url"}
                                Else
                                    headerRow = row
                                End If
                            Else
                                Dim ht As New Hashtable(row.Length)
                                For i As Integer = 0 To row.Length - 1
                                    If i > headerRow.Length - 1 Then
                                        Exit For
                                    End If

                                    ht.Add(headerRow(i), row(i))
                                Next
                                Me._AdditionalPages.Add(ht)
                            End If
                        End If
                    End While
                End Using
            End If
        End Sub

        Public Overridable Function PingAllSearchEngines() As Boolean
            Dim result As Boolean = True

            For Each se As Object In Me.SearchEngines.Values
                If Not Ping(se.ToString()) Then
                    result = False
                End If
            Next

            Return result
        End Function

        Public Overridable Function Ping(ByVal url As String) As Boolean
            Dim result As Boolean = False

            ' make sure feed file exists, if not, create it
            If Not File.Exists(Me.PhysicalFilePath) Then
                Me.GenerateFeed()
            End If

            If Not File.Exists(Me.PhysicalFilePath) Then
                Throw New ApplicationException(String.Format("File '{0}' not found and could not be generated", Me.FileName))
            End If


            Try
                Dim request As System.Net.HttpWebRequest = System.Net.WebRequest.Create(url)
                Dim response As System.Net.HttpWebResponse = request.GetResponse()

                If response.StatusCode = System.Net.HttpStatusCode.OK Then
                    AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success, Me.FeedName, String.Format("Notified the search engine at {0} that a new sitemap is available", url))
                    result = True
                Else
                    Dim errorMessage As String = String.Format("{0} error submitting to {1}: {2}", response.StatusCode.ToString(), url, response.StatusDescription)
                    AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, Me.FeedName, errorMessage)
                End If
            Catch ex As Exception
                Dim errorMessage As String = String.Format("{0} [ {1} ]", ex.Message, ex.StackTrace)
                AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, Me.FeedName, errorMessage)
            End Try

            Return result
        End Function

    End Class

End Namespace