Imports System.IO
Imports System.Net
Imports System.Xml
Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_RSS_Feed_Viewer_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim feedUrl As String = SettingsManager.GetSetting("FeedUrl")
            Dim c As New RSSChannel()
            c.LoadFromFeed(feedUrl)
            Me.lblTitle.Text = c.Title
            Me.pnlTitle.Visible = Me.SettingsManager.GetBooleanSetting("ShowTitle")

            Me.lblDescription.Text = c.Description
            Me.pnlDescription.Visible = Me.SettingsManager.GetBooleanSetting("ShowDescription")

            Dim items As Collection(Of RSSItem) = c.GetChannelItems
            Dim finalItems As New Collection(Of RSSItem)
            Dim max As Integer = Me.SettingsManager.GetIntegerSetting("MaxItems")
            If max <= 0 Then
                max = 5
            End If
            For i As Integer = 0 To max - 1
                If items.Count > i Then
                    finalItems.Add(items(i))
                End If
            Next
            Me.DataList1.DataSource = finalItems
            Me.DataList1.DataBind()
        End If
    End Sub


#Region " RSS Classes "

    Private Class RSSChannel

        Private _Description As String = String.Empty
        Private _FeedUrl As String = String.Empty
        Private _Link As String = String.Empty
        Private _Title As String = String.Empty

        Public Property Description() As String
            Get
                Return _Description
            End Get
            Set(ByVal value As String)
                _Description = value
            End Set
        End Property
        Public Property FeedUrl() As String
            Get
                Return _FeedUrl
            End Get
            Set(ByVal value As String)
                _FeedUrl = value
            End Set
        End Property
        Public Property Link() As String
            Get
                Return _Link
            End Get
            Set(ByVal value As String)
                _Link = value
            End Set
        End Property
        Public Property Title() As String
            Get
                Return _Title
            End Get
            Set(ByVal value As String)
                _Title = value
            End Set
        End Property

        Public Sub LoadFromFeed(ByVal url As String)
            _FeedUrl = url
            LoadChannel()
        End Sub

        Private Function GetXMLDoc(ByVal node As String) As XmlNodeList
            Dim tempNodeList As System.Xml.XmlNodeList = Nothing
            Dim rssDoc As XmlDocument = New XmlDocument()

            Dim cached As String = Datalayer.CacheManager.GetStringFromCache("com.bvsoftware.rssfeedviewer.channel." & Me.FeedUrl)

            If (cached Is Nothing) OrElse (cached = String.Empty) Then
                ' Load From Web
                Dim request As WebRequest = WebRequest.Create(Me.FeedUrl)
                Dim response As WebResponse = request.GetResponse()
                Dim rssStream As Stream = response.GetResponseStream()
                Dim sr As New StreamReader(rssStream)
                Dim Data As String = sr.ReadToEnd()
                rssDoc.Load(New StringReader(Data))
                Datalayer.CacheManager.AddStringToCache("com.bvsoftware.rssfeedviewer.channel." & Me.FeedUrl, Data, 30)
            Else
                ' Load From Cache
                rssDoc.Load(New StringReader(cached))
            End If

            tempNodeList = rssDoc.SelectNodes(node)
            Return tempNodeList
        End Function

        Private Sub LoadChannel()
            Try
                Dim rss As XmlNodeList = GetXMLDoc("rss/channel")
                Title = rss(0).SelectSingleNode("title").InnerText
                Link = rss(0).SelectSingleNode("link").InnerText
                Description = rss(0).SelectSingleNode("description").InnerText
            Catch ex As Exception
                'BVSoftware.Bvc5.Core.EventLog.LogEvent(ex)
            End Try
        End Sub

        Public Function GetChannelItems() As Collection(Of RSSItem)
            Dim result As New Collection(Of RSSItem)

            Try
                Dim rssItems As XmlNodeList = GetXMLDoc("rss/channel/item")
                Dim item As XmlNode
                For Each item In rssItems
                    Dim newItem As New RSSItem
                    With newItem
                        .Title = item.SelectSingleNode("title").InnerText
                        .Link = item.SelectSingleNode("link").InnerText
                        .Description = item.SelectSingleNode("description").InnerText
                    End With
                    result.Add(newItem)
                Next
            Catch ex As Exception
                'BVSoftware.Bvc5.Core.EventLog.LogEvent(ex)
            End Try

            Return result
        End Function

    End Class

    Public Class RSSItem

        Private _Description As String = String.Empty
        Private _Link As String = String.Empty
        Private _Title As String = String.Empty

        Public Property Description() As String
            Get
                Return _Description
            End Get
            Set(ByVal value As String)
                _Description = value
            End Set
        End Property
        Public Property Link() As String
            Get
                Return _Link
            End Get
            Set(ByVal value As String)
                _Link = value
            End Set
        End Property
        Public Property Title() As String
            Get
                Return _Title
            End Get
            Set(ByVal value As String)
                _Title = value
            End Set
        End Property

    End Class

#End Region

End Class


