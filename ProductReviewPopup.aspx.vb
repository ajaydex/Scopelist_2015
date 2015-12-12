Imports BVSoftware.Bvc5.Core
Imports System.Data
Imports System.Collections.ObjectModel

Partial Class ProductReviewPopup
	Inherits BaseStorePage

    Private _productID As String = ""

	Public Property ProductID() As String
		Get
			Return _productID
		End Get
		Set(ByVal Value As String)
			_productID = Value
		End Set
    End Property

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit

        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Popup.master")

    End Sub

	Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
		If Not Page.IsPostBack Then
            Page.Title = "Reviews"

            Me.lnkWrite.InnerText = Content.SiteTerms.GetTerm("WriteAReview")

		End If

        Me.btnSubmitReview.ImageUrl = PersonalizationServices.GetThemedButton("Submit")


        _productID = Request.QueryString("ProductID")

        ShowAppropriatePanels()

        If Not Page.IsPostBack Then

            If WebAppSettings.ProductReviewShow = True Then
                Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(_productID)
                If Not p Is Nothing Then

                    ' Amazon
                    'If p.ProductTypeID = -100 Then
                    '	LoadAmazonReviews()
                    'Else

                    LoadReviews()

                    'End If

                End If

            End If

        End If
	End Sub

    Private Sub ShowAppropriatePanels()
        If WebAppSettings.ProductReviewShow = False Then
            Me.pnlReviewDisplay.Visible = False
            Me.pnlWriteAReview.Visible = False
        Else
            Me.pnlReviewDisplay.Visible = True
        End If

        If WebAppSettings.ProductReviewAllow = True Then
            Me.lnkWrite.Visible = True
            Me.pnlWriteAReview.Visible = True
        Else
            Me.lnkWrite.Visible = False
            Me.pnlWriteAReview.Visible = False
        End If

    End Sub

    Private Sub LoadReviews()

        Me.dlReviews.Visible = True
        Me.dlAmazonReviews.Visible = False

        Me.lblRating.Visible = False
        Me.imgAverageRating.Visible = False

        Me.lblTitle.Text = Content.SiteTerms.GetTerm("CustomerReviews")

        If WebAppSettings.ProductReviewAllow = True Then
            Me.lblWriteAReview.Text = Content.SiteTerms.GetTerm("WriteAReview")
        End If

        Dim reviews As New Collection(Of Catalog.ProductReview)
        If WebAppSettings.ProductReviewModerate = True Then
            reviews = Catalog.ProductReview.FindByProductBvin(_productID, False)
        Else
            reviews = Catalog.ProductReview.FindByProductBvin(_productID, True)
        End If

        If Not reviews Is Nothing Then
            If reviews.Count > 0 Then

                ' Average Rating Code
                If WebAppSettings.ProductReviewShowRating = True Then

                    If (reviews.Count > 0) Then
                        Me.lblRating.Visible = True
                        Me.imgAverageRating.Visible = True
                    End If

                    Dim AverageRating As Integer = 3
                    Dim tempRating As Double = 3.0
                    Dim sumRatings As Double = 0.0
                    For i As Integer = 0 To reviews.Count - 1
                        sumRatings += reviews(i).Rating
                    Next
                    If sumRatings > 0 Then
                        tempRating = sumRatings / reviews.Count
                        AverageRating = Math.Ceiling(tempRating)
                    End If

                    Me.lblRating.Text = Content.SiteTerms.GetTerm("AverageRating")

                    Select Case AverageRating
                        Case 1
                            Me.imgAverageRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars1")
                        Case 2
                            Me.imgAverageRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars2")
                        Case 3
                            Me.imgAverageRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars3")
                        Case 4
                            Me.imgAverageRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars4")
                        Case 5
                            Me.imgAverageRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars5")
                    End Select
                    Me.imgAverageRating.ImageUrl = Me.imgAverageRating.ImageUrl
                End If

                Me.dlReviews.DataSource = reviews
                Me.dlReviews.DataBind()

            End If
        End If

    End Sub


    'Private Sub LoadAmazonReviews()

    '	Me.dlReviews.Visible = False
    '	Me.dlAmazonReviews.Visible = True

    '	Me.lblRating.Visible = True
    '	Me.imgAverageRating.Visible = True

    '	Me.lblTitle.Text = Content.SiteTerm.FindSafeTermValue("CustomerReviews")

    '	Me.lnkWrite.Visible = False
    '	Me.pnlWriteAReview.Visible = False

    '       Dim ap As BVSoftware.AmazonWebServices4.AmazonProduct
    '       ap = AmazonCache.GetAmazonProduct(ViewState("ProductID"))
    '       If Not ap Is Nothing Then
    '           If ap.HasReviews = True Then
    '               Me.dlAmazonReviews.DataSource = ap.Reviews
    '               Me.dlAmazonReviews.DataBind()
    '           End If
    '       End If

    '       Dim AverageRating As Integer = 3
    '       Dim tempRating As Double = ap.AverageCustomerRating
    '       AverageRating = Math.Ceiling(tempRating)
    '       Me.lblRating.Text = Content.SiteTerm.FindSafeTermValue("AverageRating")
    '       Select Case AverageRating
    '           Case 1
    '               Me.imgAverageRating.ImageUrl = Utilities.ImageHelper.GetThemedButton("Stars1.gif")
    '           Case 2
    '               Me.imgAverageRating.ImageUrl = Utilities.ImageHelper.GetThemedButton("Stars2.gif")
    '           Case 3
    '               Me.imgAverageRating.ImageUrl = Utilities.ImageHelper.GetThemedButton("Stars3.gif")
    '           Case 4
    '               Me.imgAverageRating.ImageUrl = Utilities.ImageHelper.GetThemedButton("Stars4.gif")
    '           Case 5
    '               Me.imgAverageRating.ImageUrl = Utilities.ImageHelper.GetThemedButton("Stars5.gif")
    '       End Select
    '       Me.imgAverageRating.ImageUrl = Me.imgAverageRating.ImageUrl

    '   End Sub

    Private Function TrimDataTable(ByVal sourceTable As DataTable, ByVal recordsPerPage As Integer, _
      ByVal pageNumber As Integer) As System.Data.DataTable
        Dim result As DataTable

        result = sourceTable

        Dim iStartRecord As Integer = recordsPerPage * (pageNumber - 1)
        Dim iCurrentRecord As Integer = 0
        Dim iStopRecord As Integer = iStartRecord + recordsPerPage - 1

        For i As Integer = 0 To result.Rows.Count() - 1
            If i < iStartRecord OrElse i > iStopRecord Then
                result.Rows(i).Delete()
            End If
        Next

        result.AcceptChanges()

        Return result
    End Function

    Private Sub dlReviews_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dlReviews.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
            Dim ratingImage As System.Web.UI.WebControls.Image
            Dim ratingDescription As System.Web.UI.WebControls.Label
            Dim karmaPanel As System.Web.UI.WebControls.Panel
            Dim karmaLabel As System.Web.UI.WebControls.Label
            Dim karmaYes As System.Web.UI.WebControls.ImageButton
            Dim karmaNo As System.Web.UI.WebControls.ImageButton

            ratingImage = e.Item.FindControl("imgReviewRating")
            ratingDescription = e.Item.FindControl("lblReviewDescription")
            karmaPanel = e.Item.FindControl("pnlKarma")

            If Not ratingImage Is Nothing Then
                If WebAppSettings.ProductReviewShowRating = True Then
                    ratingImage.Visible = True
                    'Select Case e.Item.DataItem("Rating")
                    Dim rating As Catalog.ProductReviewRating = DataBinder.Eval(e.Item.DataItem, "Rating")

                    Select Case rating
                        Case Catalog.ProductReviewRating.ZeroStars
                            ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars0")
                        Case Catalog.ProductReviewRating.OneStar
                            ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars1")
                        Case Catalog.ProductReviewRating.TwoStars
                            ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars2")
                        Case Catalog.ProductReviewRating.ThreeStars
                            ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars3")
                        Case Catalog.ProductReviewRating.FourStars
                            ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars4")
                        Case Catalog.ProductReviewRating.FiveStars
                            ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars5")
                    End Select
                Else
                    ratingImage.Visible = False
                End If
            End If

            If Not ratingDescription Is Nothing Then
                ratingDescription.Text = DataBinder.Eval(e.Item.DataItem, "Description")
            End If

            If Not karmaPanel Is Nothing Then
                If WebAppSettings.ProductReviewShowKarma = True Then
                    karmaPanel.Visible = True

                    karmaLabel = e.Item.FindControl("lblProductReviewKarma")
                    karmaYes = e.Item.FindControl("btnReviewKarmaYes")
                    karmaNo = e.Item.FindControl("btnReviewKarmaNo")

                    If Not karmaLabel Is Nothing Then
                        karmaLabel.Text = Content.SiteTerms.GetTerm("WasThisReviewHelpful")
                    End If
                    If Not karmaYes Is Nothing Then
                        karmaYes.ImageUrl = PersonalizationServices.GetThemedButton("Yes")
                    End If
                    If Not karmaNo Is Nothing Then
                        karmaNo.ImageUrl = PersonalizationServices.GetThemedButton("No")
                    End If
                Else
                    karmaPanel.Visible = False
                End If
            End If
        End If
    End Sub

    Private Sub btnSubmitReview_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmitReview.Click
        Try
            If Me.NewReviewDescription.Text.Trim.Length < 1 Then
                msg.ShowWarning("Reviews can not be blank. Please enter your review and try again.")
            Else
                Dim rev As New Catalog.ProductReview
                rev.ProductBvin = Me._productID
                rev.Karma = 0
                If SessionManager.IsUserAuthenticated = True Then
                    rev.UserID = SessionManager.GetCurrentUserId
                Else
                    rev.UserID = 0
                End If

                rev.Description = HttpUtility.HtmlEncode(Me.NewReviewDescription.Text.Trim)
                rev.ReviewDate = Now()
                rev.Rating = Me.lstNewReviewRating.SelectedValue

                If WebAppSettings.ProductReviewModerate = False Then
                    rev.Approved = True
                Else
                    rev.Approved = False
                End If

                Catalog.ProductReview.Insert(rev)

                msg.ShowOK("Thank you for your review!")
                Me.NewReviewDescription.Text = ""
            End If

        Catch ex As Exception
            'EventLog.LogEvent(ex)
            msg.ShowException(ex)
        Finally
            LoadReviews()
        End Try

    End Sub

    Private Sub dlReviews_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlReviews.EditCommand
        Dim reviewBvin As String = dlReviews.DataKeys(e.Item.ItemIndex)

        Catalog.ProductReview.UpdateKarma(reviewBvin, 1)

        Me.LoadReviews()
    End Sub

    Private Sub dlReviews_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlReviews.DeleteCommand

        Dim reviewBvin As String = dlReviews.DataKeys(e.Item.ItemIndex)

        Catalog.ProductReview.UpdateKarma(reviewBvin, -1)

        Me.LoadReviews()
    End Sub

    'Private Sub dlAmazonReviews_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dlAmazonReviews.ItemDataBound
    '    If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
    '        Dim ratingImage As System.Web.UI.WebControls.Image
    '        Dim amazonSummary As System.Web.UI.WebControls.Label
    '        Dim amazonComment As System.Web.UI.WebControls.Label

    '        ratingImage = e.Item.FindControl("imgAmazonRating")
    '        amazonSummary = e.Item.FindControl("lblAmazonSummary")
    '        amazonComment = e.Item.FindControl("lblAmazonComment")

    '        Dim rev As BVSoftware.AmazonWebServices4.AmazonReview
    '        rev = CType(e.Item.DataItem(), BVSoftware.AmazonWebServices4.AmazonReview)

    '        If Not rev Is Nothing Then
    '            If Not ratingImage Is Nothing Then
    '                ratingImage.Visible = True
    '                Select Case Math.Ceiling(Convert.ToDecimal(rev.Rating))
    '                    Case 1
    '                        ratingImage.ImageUrl = Utilities.ImageHelper.GetThemedButton("Stars1.gif")
    '                    Case 2
    '                        ratingImage.ImageUrl = Utilities.ImageHelper.GetThemedButton("Stars2.gif")
    '                    Case 3
    '                        ratingImage.ImageUrl = Utilities.ImageHelper.GetThemedButton("Stars3.gif")
    '                    Case 4
    '                        ratingImage.ImageUrl = Utilities.ImageHelper.GetThemedButton("Stars4.gif")
    '                    Case 5
    '                        ratingImage.ImageUrl = Utilities.ImageHelper.GetThemedButton("Stars5.gif")
    '                End Select
    '            End If

    '            If Not amazonSummary Is Nothing Then
    '                amazonSummary.Text = rev.Summary
    '            End If

    '            If Not amazonComment Is Nothing Then
    '                amazonComment.Text = rev.Comment
    '            End If
    '        End If


    '    End If
    'End Sub

End Class
