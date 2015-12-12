
Public Class FacebookOpenGraph

    Private _SiteName As String = String.Empty
    Private _Url As String = String.Empty
    Private _Title As String = String.Empty
    Private _PageType As String = "other"
    Private _Description As String = String.Empty
    Private _ImageUrl As String = String.Empty
    Private _Price As Decimal = -1D
    Private _Currency As String = String.Empty
    Private _Availability As String = String.Empty
    Private _Upc As String = String.Empty
    Private _Ean As String = String.Empty
    Private _Isbn As String = String.Empty
    Private _Fb_App_Id As String = String.Empty
    Private _Fb_Admins As String = String.Empty

#Region " Properties "

    Public Property SiteName As String
        Get
            Return Me._SiteName
        End Get
        Set(value As String)
            Me._SiteName = value
        End Set
    End Property
    Public Property Url As String
        Get
            Return Me._Url
        End Get
        Set(value As String)
            Me._Url = value
        End Set
    End Property

    Public Property Title As String
        Get
            Return _Title
        End Get
        Set(value As String)
            _Title = value
        End Set
    End Property

    Public Property PageType As String
        Get
            Return _PageType
        End Get
        Set(value As String)
            _PageType = value
        End Set
    End Property

    Public Property Description As String
        Get
            Return _description
        End Get
        Set(value As String)
            _description = value
        End Set
    End Property

    Public Property ImageUrl As String
        Get
            Return _ImageUrl
        End Get
        Set(value As String)
            _ImageUrl = value
        End Set
    End Property

    Public Property Price As Decimal
        Get
            Return _Price
        End Get
        Set(value As Decimal)
            _Price = value
        End Set
    End Property

    Public Property Currency As String
        Get
            Return _Currency
        End Get
        Set(value As String)
            _Currency = value
        End Set
    End Property

    Public Property Availability As String
        Get
            Return _Availability
        End Get
        Set(value As String)
            _Availability = value
        End Set
    End Property

    Public Property Upc As String
        Get
            Return Me._Upc
        End Get
        Set(value As String)
            Me._Upc = value
        End Set
    End Property

    Public Property Ean As String
        Get
            Return _Ean
        End Get
        Set(value As String)
            _Ean = value
        End Set
    End Property

    Public Property Isbn As String
        Get
            Return Me._Isbn
        End Get
        Set(value As String)
            Me._Isbn = value
        End Set
    End Property

    Public Property Fb_App_Id As String
        Get
            Return Me._Fb_App_Id
        End Get
        Set(value As String)
            Me._Fb_App_Id = value
        End Set
    End Property

    Public Property Fb_Admins As String
        Get
            Return Me._Fb_Admins
        End Get
        Set(value As String)
            Me._Fb_Admins = value
        End Set
    End Property

#End Region

    Public Sub AddMetaTags()
        Dim p As Page = TryCast(HttpContext.Current.Handler, Page)
        If p IsNot Nothing Then
            If p.Header IsNot Nothing Then
                Me.AddMetaTag("og:site_name", HttpUtility.HtmlEncode(Me.SiteName), p.Header)
                Me.AddMetaTag("og:url", Me.Url, p.Header)
                Me.AddMetaTag("og:title", HttpUtility.HtmlEncode(Me.Title), p.Header)
                Me.AddMetaTag("og:type", Me.PageType, p.Header)
                Me.AddMetaTag("og:description", Me.Description, p.Header)
                Me.AddMetaTag("og:image", Me.ImageUrl, p.Header)
                If Me.Price >= 0 Then
                    Me.AddMetaTag("og:price:amount", Me.Price.ToString(), p.Header)
                End If
                Me.AddMetaTag("og:price:currency", Me.Currency, p.Header)
                Me.AddMetaTag("og:availability", Me.Availability, p.Header)
                Me.AddMetaTag("og:upc", Me.Upc, p.Header)
                Me.AddMetaTag("og:ean", Me.Ean, p.Header)
                Me.AddMetaTag("og:isbn", Me.Isbn, p.Header)
                Me.AddMetaTag("fb:app_id", Me.Fb_App_Id, p.Header)
                Me.AddMetaTag("fb:admins", Me.Fb_Admins, p.Header)
            End If
        End If
    End Sub

    Private Sub AddMetaTag(ByVal name As String, ByVal content As String, ByVal headTag As HtmlHead)
        If Not String.IsNullOrEmpty(name) AndAlso Not String.IsNullOrEmpty(content) Then
            If headTag IsNot Nothing Then
                Dim meta As New HtmlMeta()
                meta.EnableViewState = False
                meta.Attributes.Add("property", name)
                meta.Content = content

                Try
                    headTag.Controls.Add(meta)
                Catch ex As Exception
                    ' do nothing
                End Try
            End If
        End If
    End Sub

End Class