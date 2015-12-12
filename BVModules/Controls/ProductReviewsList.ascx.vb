Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core


Partial Class BVModules_Controls_ProductReviewsList
    Inherits System.Web.UI.UserControl

    Private _Title As String = String.Empty
    Private _MinimumRating As Integer = 1
    Private _IgnoreBadKarma As Boolean = False
    Private _IgnoreAnonymousReviews As Boolean = False
    Private _CategoryId As String = String.Empty
    Private _NumberOfItems As Integer = 10
    Private _TruncateReview As Boolean = False
    Private _TruncateReviewLength As Integer = 9999
    Private _DateFormat As String = "M/d/yyyy"
    Private _PreContentHtml As String = String.Empty
    Private _PostContentHtml As String = String.Empty

#Region " Properties "

    Public Property Title() As String
        Get
            Return Me._Title
        End Get
        Set(ByVal value As String)
            Me._Title = value
        End Set
    End Property

    Public Property MinimumRating() As Integer
        Get
            Return Me._MinimumRating
        End Get
        Set(ByVal value As Integer)
            Me._MinimumRating = value
        End Set
    End Property

    Public Property IgnoreBadKarma() As Boolean
        Get
            Return Me._IgnoreBadKarma
        End Get
        Set(ByVal value As Boolean)
            Me._IgnoreBadKarma = value
        End Set
    End Property

    Public Property IgnoreAnonymousReviews() As Boolean
        Get
            Return Me._IgnoreAnonymousReviews
        End Get
        Set(ByVal value As Boolean)
            Me._IgnoreAnonymousReviews = value
        End Set
    End Property

    Public Property CategoryId() As String
        Get
            Return Me._CategoryId
        End Get
        Set(ByVal value As String)
            Me._CategoryId = value
        End Set
    End Property

    Public Property NumberOfItems() As Integer
        Get
            Return Me._NumberOfItems
        End Get
        Set(ByVal value As Integer)
            Me._NumberOfItems = value
        End Set
    End Property

    Public Property TruncateReview() As Boolean
        Get
            Return Me._TruncateReview
        End Get
        Set(ByVal value As Boolean)
            Me._TruncateReview = value
        End Set
    End Property

    Public Property TruncateReviewLength() As Integer
        Get
            Return Me._TruncateReviewLength
        End Get
        Set(ByVal value As Integer)
            Me._TruncateReviewLength = value
        End Set
    End Property

    Public Property DateFormat() As String
        Get
            Return Me._DateFormat
        End Get
        Set(ByVal value As String)
            Me._DateFormat = value
        End Set
    End Property

#End Region

    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)

        Me.EnableViewState = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If String.IsNullOrEmpty(Me.Title) Then
            Me.hTitle.Visible = False
        Else
            Me.hTitle.InnerText = Me.Title
        End If

        Dim productReviews As Collection(Of Catalog.ProductReview) = Catalog.ProductReview.FindLatestProductReviews(Me.MinimumRating, Me.IgnoreBadKarma, Me.IgnoreAnonymousReviews, Me.CategoryId, Me.NumberOfItems)
        Me.rpProductReviewList.DataSource = productReviews
        Me.rpProductReviewList.DataBind()
    End Sub

    Protected Sub rpProductReviewList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rpProductReviewList.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim pr As Catalog.ProductReview = CType(e.Item.DataItem, Catalog.ProductReview)

            If pr IsNot Nothing Then

                Dim imgReviewRating As Image = CType(e.Item.FindControl("imgReviewRating"), Image)
                If imgReviewRating IsNot Nothing Then
                    If WebAppSettings.ProductReviewShowRating = True Then
                        imgReviewRating.ImageUrl = Catalog.ProductReview.GetStarImageUrl(pr.Rating)
                        imgReviewRating.AlternateText = String.Format("{0} Star{1}", pr.Rating.ToString(), If(pr.Rating > 1, "s", String.Empty))
                    Else
                        imgReviewRating.Visible = False
                    End If
                End If

                Dim lblName As Label = CType(e.Item.FindControl("lblName"), Label)
                If lblName IsNot Nothing Then
                    lblName.Text = Catalog.ProductReview.GetUserNameForDisplay(pr.UserID)
                End If

                Dim lblReviewDate As Label = CType(e.Item.FindControl("lblReviewDate"), Label)
                If lblReviewDate IsNot Nothing Then
                    lblReviewDate.Text = pr.ReviewDate.ToString(Me.DateFormat)
                End If

                Dim lblReviewDescription As Label = CType(e.Item.FindControl("lblReviewDescription"), Label)
                If lblReviewDescription IsNot Nothing Then
                    If Not String.IsNullOrEmpty(pr.Description) Then
                        If Me.TruncateReview AndAlso pr.Description.Length > Me.TruncateReviewLength Then
                            Dim pos As Integer = pr.Description.Substring(0, Me.TruncateReviewLength).LastIndexOf(" ")
                            If pos > 0 Then
                                lblReviewDescription.Text = pr.Description.Substring(0, pos) + "&hellip;"
                            Else
                                lblReviewDescription.Text = pr.Description.Substring(0, Me.TruncateReviewLength) + "&hellip;"
                            End If
                        Else
                            lblReviewDescription.Text = pr.Description
                        End If
                    End If
                End If

                ' display product
                Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(pr.ProductBvin)

                If p IsNot Nothing AndAlso Not String.IsNullOrEmpty(p.Bvin) Then
                    Dim lnkProductName As HyperLink = CType(e.Item.FindControl("lnkProductName"), HyperLink)
                    If lnkProductName IsNot Nothing Then
                        lnkProductName.Text = p.ProductName
                        lnkProductName.ToolTip = If(Not String.IsNullOrEmpty(p.MetaTitle), p.MetaTitle, String.Empty)
                        lnkProductName.NavigateUrl = Utilities.UrlRewriter.BuildUrlForProduct(p, Me.Page)
                    End If

                    Dim ucSingleProductDisplay As BaseSingleProductDisplay = e.Item.FindControl("ucSingleProductDisplay")
                    If ucSingleProductDisplay IsNot Nothing Then
                        ucSingleProductDisplay.LoadWithProduct(p)
                    End If
                End If
            End If
        End If
    End Sub

End Class
