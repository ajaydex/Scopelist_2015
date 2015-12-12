Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Data

Partial Class BVModules_Controls_ProductReviewDisplay
    Inherits System.Web.UI.UserControl
    
    Public Property ProductID() As String
        Get
            Return Me.bvinField.Value
        End Get
        Set(ByVal Value As String)
            Me.bvinField.Value = Value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If ProductID.Trim.Length < 1 Then
            If ProductID.Trim = String.Empty Then
                ProductID = Request.QueryString("ProductId")
            End If            
        End If

        ShowAppropriatePanels()

        If WebAppSettings.ProductReviewShow = True Then
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(ProductID)
            If Not p Is Nothing Then
                ' Amazon
                'If p.ProductTypeId = -100 Then
                '    LoadAmazonReviews()
                'Else
                LoadReviews()
            End If
            If WebAppSettings.ProductReviewAllow = True Then
                Dim destinationUrl As String = "~/ProductReviewPopup.aspx"
                destinationUrl = Page.ResolveClientUrl(destinationUrl)
                Me.lnkWriteAReview.Attributes.Add("onclick", "JavaScript:window.open('" & destinationUrl & "?productID=" & Server.UrlEncode(Request.QueryString("ProductID")) & "#Write','Images','width=600, height=400, menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no')")
                Me.lnkWriteAReview.Visible = True
            Else
                Me.lnkWriteAReview.Visible = False
            End If
        End If

        'End If

    End Sub

    Private Sub ShowAppropriatePanels()
        If WebAppSettings.ProductReviewShow = False Then
            Me.pnlReviewDisplay.Visible = False
        Else
            Me.pnlReviewDisplay.Visible = True
        End If
    End Sub

    Private Sub LoadReviews()
        Me.dlReviews.Visible = True
        Me.dlAmazonReviews.Visible = False

        Me.lblRating.Visible = False
        Me.imgAverageRating.Visible = False
        Me.lnkAllReviews.Visible = False

        Me.lblTitle.Text = Content.SiteTerms.GetTerm("CustomerReviews")
       
        Dim reviews As Collection(Of Catalog.ProductReview)

        If WebAppSettings.ProductReviewModerate = True Then
            reviews = Catalog.ProductReview.FindByProductBvin(bvinField.Value, False)
        Else
            reviews = Catalog.ProductReview.FindByProductBvin(bvinField.Value, True)
        End If

        If Not reviews Is Nothing Then
            If reviews.Count > 0 Then

                'Average Rating Code
                If WebAppSettings.ProductReviewShowRating = True Then

                    If (reviews.Count > 0) Then
                        Me.lblRating.Visible = True
                        Me.imgAverageRating.Visible = True

                        Dim destinationUrl As String = "~/ProductReviewPopup.aspx"
                        destinationUrl = Page.ResolveClientUrl(destinationUrl)

                        Me.lnkAllReviews.Visible = True
                        Me.lnkAllReviews.Text = "View All " & reviews.Count & " Reviews"
                        Me.lnkAllReviews.Attributes.Add("onclick", "JavaScript:window.open('" & destinationUrl & "?productID=" & Server.UrlEncode(Request.QueryString("ProductID")) & "','Images','width=600, height=400, menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no')")
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

                ' Trim Reviews if more than count and display
                If WebAppSettings.ProductReviewCount < reviews.Count Then
                    Me.dlReviews.DataSource = TrimReviewList(reviews, WebAppSettings.ProductReviewCount)
                Else
                    Me.dlReviews.DataSource = reviews
                End If

                Me.dlReviews.DataBind()

            End If
        End If

    End Sub

    Private Sub LoadAmazonReviews()
        Me.dlReviews.Visible = False
        Me.dlAmazonReviews.Visible = True

        Me.lblRating.Visible = False
        Me.imgAverageRating.Visible = False
        Me.lnkAllReviews.Visible = False

        Me.lblTitle.Text = Content.SiteTerms.GetTerm("CustomerReviews")

        'Dim ap As BVSoftware.AmazonWebServices4.AmazonProduct
        'ap = AmazonCache.GetAmazonProduct(ViewState("ProductID"))
        'If Not ap Is Nothing Then
        '    If ap.HasReviews = True Then

        '        Me.lnkAllReviews.Visible = True
        '        Me.lnkAllReviews.Text = "View All " & ap.Reviews.Count & " Reviews"
        '        Me.lnkAllReviews.Attributes.Add("onclick", "JavaScript:window.open('ProductReviewPopup.aspx?productID=" & Server.UrlEncode(ViewState("ProductID")) & "','Images','width=600, height=400, menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no')")

        '        If ap.Reviews.Count <= WebAppSettings.ProductReviewCount Then
        '            Me.dlAmazonReviews.DataSource = ap.Reviews
        '            Me.dlAmazonReviews.DataBind()
        '        Else
        '            Dim trimmedReviews As New Collection(Of BVSoftware.AmazonWebServices4.AmazonReview)
        '            For i As Integer = 0 To WebAppSettings.ProductReviewCount - 1
        '                trimmedReviews.Add(ap.Reviews(i))
        '            Next
        '            Me.dlAmazonReviews.DataSource = trimmedReviews
        '            Me.dlAmazonReviews.DataBind()
        '        End If
        '    End If
        'End If

        'Dim AverageRating As Integer = 3
        'Dim tempRating As Double = ap.AverageCustomerRating
        'AverageRating = Math.Ceiling(tempRating)

        ''Me.lblRating.Text = Content.SiteTerm.FindSafeTermValue("AverageRating")
        'Me.lblRating.Text = "Average Rating"

        'Select Case AverageRating
        '    Case 1
        '        Me.imgAverageRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars1")
        '    Case 2
        '        Me.imgAverageRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars2")
        '    Case 3
        '        Me.imgAverageRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars3")
        '    Case 4
        '        Me.imgAverageRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars4")
        '    Case 5
        '        Me.imgAverageRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars5")
        'End Select
        'Me.imgAverageRating.ImageUrl = Me.imgAverageRating.ImageUrl

    End Sub

    Private Function TrimReviewList(ByVal source As Collection(Of Catalog.ProductReview), ByVal maxReviews As Integer) As Collection(Of Catalog.ProductReview)
        Dim result As New Collection(Of Catalog.ProductReview)
        For i As Integer = 0 To source.Count - 1
            If i < maxReviews Then
                result.Add(source(i))
            End If
        Next
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
                    Select Case CInt(DataBinder.Eval(e.Item.DataItem, "Rating"))
                        Case 1
                            ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars1")
                        Case 2
                            ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars2")
                        Case 3
                            ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars3")
                        Case 4
                            ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars4")
                        Case 5
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

                karmaPanel.Visible = False
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

    Private Sub dlReviews_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlReviews.EditCommand
        Dim reviewID As String = dlReviews.DataKeys(e.Item.ItemIndex)
        Catalog.ProductReview.UpdateKarma(reviewID, 1)
    End Sub

    Private Sub dlReviews_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlReviews.DeleteCommand
        Dim reviewID As String = dlReviews.DataKeys(e.Item.ItemIndex)
        Catalog.ProductReview.UpdateKarma(reviewID, -1)
    End Sub

    Private Sub dlAmazonReviews_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dlAmazonReviews.ItemDataBound
        'If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
        '    Dim ratingImage As System.Web.UI.WebControls.Image
        '    Dim amazonSummary As System.Web.UI.WebControls.Label
        '    Dim amazonComment As System.Web.UI.WebControls.Label

        '    ratingImage = e.Item.FindControl("imgAmazonRating")
        '    amazonSummary = e.Item.FindControl("lblAmazonSummary")
        '    amazonComment = e.Item.FindControl("lblAmazonComment")


        '    Dim rev As BVSoftware.AmazonWebServices4.AmazonReview
        '    rev = CType(e.Item.DataItem(), BVSoftware.AmazonWebServices4.AmazonReview)

        '    If Not rev Is Nothing Then
        '        If Not ratingImage Is Nothing Then
        '            ratingImage.Visible = True
        '            Select Case Math.Ceiling(Convert.ToDecimal(rev.Rating))
        '                Case 1
        '                    ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars1")
        '                Case 2
        '                    ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars2")
        '                Case 3
        '                    ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars3")
        '                Case 4
        '                    ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars4")
        '                Case 5
        '                    ratingImage.ImageUrl = PersonalizationServices.GetThemedButton("Stars5")
        '            End Select
        '        End If

        '        If Not amazonSummary Is Nothing Then
        '            amazonSummary.Text = rev.Summary
        '        End If

        '    End If


        'End If
    End Sub

End Class
