Imports System.Collections.ObjectModel
Imports System.Data
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_ProductReviewDisplayInline
    Inherits System.Web.UI.UserControl

    Private _LocalProduct As Catalog.Product = Nothing

#Region "Properties"

    Public Property ProductID() As String
        Get
            Dim result As String = String.Empty

            If Not String.IsNullOrEmpty(Me.bvinField.Value) Then
                result = Me.bvinField.Value
            ElseIf Not String.IsNullOrEmpty(Request.QueryString("ProductId")) Then
                result = Request.QueryString("ProductId")
            ElseIf TypeOf Me.Page Is BaseStoreProductPage Then
                Dim productPage As BaseStoreProductPage = DirectCast(Me.Page, BaseStoreProductPage)
                If productPage.LocalParentProduct IsNot Nothing Then
                    result = productPage.LocalParentProduct.Bvin
                End If
            End If

            Me.bvinField.Value = result
            Return result
        End Get
        Set(ByVal Value As String)
            Me.bvinField.Value = Value
        End Set
    End Property

    Public ReadOnly Property LocalProduct As Catalog.Product
        Get
            If Me._LocalProduct Is Nothing OrElse String.IsNullOrEmpty(Me._LocalProduct.Bvin) Then
                If TypeOf Me.Page Is BaseStoreProductPage Then
                    Dim productPage As BaseStoreProductPage = DirectCast(Me.Page, BaseStoreProductPage)
                    If productPage.LocalParentProduct IsNot Nothing Then
                        Me._LocalProduct = productPage.LocalParentProduct
                    End If
                Else
                    If Not String.IsNullOrEmpty(Me.ProductID) Then
                        Me._LocalProduct = Catalog.InternalProduct.FindByBvin(Me.ProductID)
                    End If
                End If
            End If

            Return Me._LocalProduct
        End Get
    End Property

    Private ReadOnly Property msg() As Generic.List(Of IMessageBox)
        Get
            Dim result As New Generic.List(Of IMessageBox)
            BVSoftware.Bvc5.Core.Controls.BVBaseUserControl.FindControlsByType(Me.Page.Controls, result)

            Return result
        End Get
    End Property

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' if ProductID cannot be determined, hide this control
        If String.IsNullOrEmpty(Me.ProductID) Then
            Me.Visible = False
            Return
        End If

        Me.lnkWriteAReview.NavigateUrl = Utilities.UrlRewriter.GetRewrittenUrlFromRequest(Me.Request) & "#Write"
        Me.btnSubmitReview.ImageUrl = PersonalizationServices.GetThemedButton("Submit")

        LoadStars()
        LoadUser()

        LoadReviews()
        ShowAppropriatePanels()
    End Sub

    Private Sub ShowAppropriatePanels()
        Me.pnlReviewDisplay.Visible = WebAppSettings.ProductReviewShow
        Me.pnlWriteAReview.Visible = WebAppSettings.ProductReviewAllow
    End Sub

    Private Sub LoadStars()
        For Each li As ListItem In Me.lstNewReviewRating.Items
            Dim rating As Integer = 0
            If (Integer.TryParse(li.Value, rating)) Then
                Dim img As String = "<img src=""{0}"" alt=""{1}"" />"
                Dim imgSrc As String = String.Empty
                Dim imgAlt As String = String.Empty

                Select Case rating
                    Case 1 To 5
                        imgSrc = Me.ResolveUrl(Catalog.ProductReview.GetStarImageUrl(rating))
                        imgAlt = String.Format("{0} Star{1}", rating.ToString(), If(rating > 1, "s", String.Empty))
                    Case Else
                        ' invalid rating -- hide image
                        img = "{0}{1}"
                End Select

                li.Text = String.Format(img, imgSrc, imgAlt) & li.Text
            End If
        Next
    End Sub

    Private Sub LoadUser()
        Dim bvin As String = SessionManager.GetCurrentUserId()

        Dim u As Membership.UserAccount = Nothing
        If Not String.IsNullOrEmpty(bvin) Then
            u = Membership.UserAccount.FindByBvin(bvin)
        End If

        If u IsNot Nothing AndAlso Not String.IsNullOrEmpty(u.Bvin) Then
            Me.Email.Text = u.Email
            Me.Email.Enabled = SessionManager.IsAdminUser ' allow admin users to alter the email address
            Me.Name.Text = Catalog.ProductReview.GetUserNameForDisplay(u)
        End If
    End Sub

    Private Sub LoadReviews()
        If WebAppSettings.ProductReviewShow Then
            Me.dlReviews.Visible = True

            Me.lblRating.Visible = False
            Me.imgAverageRating.Visible = False

            Me.lblTitle.Text = Content.SiteTerms.GetTerm("CustomerReviews")

            Dim reviews As Collection(Of Catalog.ProductReview) = If(Not WebAppSettings.ProductReviewModerate, Me.LocalProduct.Reviews, Catalog.ProductReview.FindByProductBvin(bvinField.Value, False))
            If reviews IsNot Nothing AndAlso reviews.Count > 0 Then
                If WebAppSettings.ProductReviewShowRating = True Then
                    Me.lblRating.Visible = True
                    Me.lblRating.Text = Content.SiteTerms.GetTerm("AverageRating")

                    Dim averageRating As Integer = Catalog.ProductReview.CalculateReviewAverage(reviews)
                    Me.imgAverageRating.Visible = True
                    Me.imgAverageRating.ImageUrl = Catalog.ProductReview.GetStarImageUrl(averageRating)

                    Me.metaReviewCount.Attributes.Add("content", reviews.Count.ToString())
                    Me.metaRatingValue.Attributes.Add("content", averageRating.ToString())
                Else
                    Me.phReviewRating.Visible = False
                End If

                Me.dlReviews.DataSource = reviews
                Me.dlReviews.DataBind()
            End If
        End If
    End Sub

    Private Sub dlReviews_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dlReviews.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
            Dim lnkNamedAnchor As HyperLink = CType(e.Item.FindControl("lnkNamedAnchor"), HyperLink)
            Dim ratingImage As Image = CType(e.Item.FindControl("imgReviewRating"), Image)
            Dim ratingDescription As Label = CType(e.Item.FindControl("lblReviewDescription"), Label)
            Dim ratingReviewDate As Label = CType(e.Item.FindControl("lblReviewDate"), Label)
            Dim userName As Label = CType(e.Item.FindControl("lblName"), Label)
            Dim karmaPanel As Panel = CType(e.Item.FindControl("pnlKarma"), Panel)
            Dim karmaLabel As Label = CType(e.Item.FindControl("lblProductReviewKarma"), Label)
            Dim karmaYes As ImageButton = CType(e.Item.FindControl("btnReviewKarmaYes"), ImageButton)
            Dim karmaNo As ImageButton = CType(e.Item.FindControl("btnReviewKarmaNo"), ImageButton)
            Dim metaRatingValue As HtmlGenericControl = CType(e.Item.FindControl("metaRatingValue"), HtmlGenericControl)

            If Not lnkNamedAnchor Is Nothing Then
                lnkNamedAnchor.Attributes.Add("name", DataBinder.Eval(e.Item.DataItem, "bvin").ToString())
            End If

            If Not ratingImage Is Nothing Then
                If WebAppSettings.ProductReviewShowRating = True Then
                    Dim rating As Integer = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "Rating"))
                    ratingImage.Visible = True
                    ratingImage.ImageUrl = Catalog.ProductReview.GetStarImageUrl(rating)
                    metaRatingValue.Attributes.Add("content", rating.ToString())
                Else
                    ratingImage.Visible = False
                End If
            End If

            If Not ratingDescription Is Nothing Then
                ratingDescription.Text = DataBinder.Eval(e.Item.DataItem, "Description")
            End If

            If Not ratingReviewDate Is Nothing Then
                ratingReviewDate.Text = Convert.ToDateTime(DataBinder.Eval(e.Item.DataItem, "ReviewDate")).ToString("MMMM d, yyyy")
            End If

            If Not userName Is Nothing Then
                Dim userID As String = DataBinder.Eval(e.Item.DataItem, "UserID")
                userName.Text = Catalog.ProductReview.GetUserNameForDisplay(userID)
            End If

            If Not karmaPanel Is Nothing Then
                karmaPanel.Visible = False
                If WebAppSettings.ProductReviewShowKarma = True Then
                    karmaPanel.Visible = True

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

        Dim message As String = "Thank you for rating a review!"
        msg.ForEach(Function(m) ShowMessage(m, message, Metrics.EventLogSeverity.Information))
        LoadReviews()
    End Sub

    Private Sub dlReviews_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlReviews.DeleteCommand
        Dim reviewID As String = dlReviews.DataKeys(e.Item.ItemIndex)
        Catalog.ProductReview.UpdateKarma(reviewID, -1)

        Dim message As String = "Thank you for rating a review!"
        msg.ForEach(Function(m) ShowMessage(m, message, Metrics.EventLogSeverity.Information))
        LoadReviews()
    End Sub

    Private Sub btnSubmitReview_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmitReview.Click
        Try
            Page.Validate("vgReview")
            If Not Page.IsValid() Then
                Dim message As String = "Your review is incomplete. Please <a href=""#Write"">check your review</a> below."
                msg.ForEach(Function(m) ShowMessage(m, message, Metrics.EventLogSeverity.Warning))
            Else
                Dim rev As New Catalog.ProductReview
                rev.ProductBvin = Me.ProductID
                rev.ProductName = Me.LocalProduct.ProductName   ' added so the ReplacementTags() function will have access to the ProductName field
                rev.Karma = 0

                Dim userId As String = SessionManager.GetCurrentUserId()
                Dim u As Membership.UserAccount = Nothing
                If Not String.IsNullOrEmpty(userId) Then
                    u = Membership.UserAccount.FindByBvin(userId)

                    ' allow admin users to write reviews under different email addresses/accounts 
                    If String.Compare(u.Email.Trim(), Email.Text.Trim(), True) <> 0 AndAlso Membership.UserAccount.DoesUserHavePermission(userId, Membership.SystemPermissions.LoginToAdmin) Then
                        u = Membership.UserAccount.FindByEmail(Me.Email.Text.Trim())
                    End If
                End If

                If u IsNot Nothing AndAlso Not String.IsNullOrEmpty(u.Bvin) Then
                    rev.UserID = u.Bvin
                Else
                    rev.UserID = "0"
                End If

                rev.Description = HttpUtility.HtmlEncode(Me.NewReviewDescription.Text.Trim)
                rev.ReviewDate = DateTime.Now()
                rev.Rating = If(WebAppSettings.ProductReviewShowRating, Convert.ToInt32(Me.lstNewReviewRating.SelectedValue), 5)

                If WebAppSettings.ProductReviewModerate = False OrElse SessionManager.IsAdminUser Then  ' always approve admin reviews
                    rev.Approved = True
                Else
                    rev.Approved = False
                End If

                If Catalog.ProductReview.Insert(rev) Then
                    Dim message As String = "Thank you for your review!"
                    msg.ForEach(Function(m) ShowMessage(m, message, Metrics.EventLogSeverity.Information))

                    If WebAppSettings.SendProductReviewNotificationEmail Then
                        SendEmail(rev)
                    End If

                    ' clear review fields
                    Me.NewReviewDescription.Text = String.Empty
                    Me.lstNewReviewRating.ClearSelection()
                    Me.Name.Text = String.Empty
                    Me.Email.Text = String.Empty
                End If
            End If

        Catch ex As Exception
            EventLog.LogEvent(ex)

            Dim message As String = "An error occurred while saving your review"
            msg.ForEach(Function(m) ShowMessage(m, message, Metrics.EventLogSeverity.Error))
        Finally
            LoadReviews()
        End Try
    End Sub

    Private Function SendEmail(ByVal r As Catalog.ProductReview) As Boolean
        Const EmailTemplateID_AdminProductReviewNotification As String = "fc2bf4e9-65cf-4d3e-8d64-c039f8de29ee"

        Dim result = False

        Dim t As Content.EmailTemplate = Content.EmailTemplate.FindByBvin(EmailTemplateID_AdminProductReviewNotification)
        If t IsNot Nothing Then
            Dim toEmail As String = Content.SiteTerms.GetTerm("ProductReviewEmail")
            If String.IsNullOrEmpty(toEmail) Then
                toEmail = WebAppSettings.ContactEmail
            End If

            Dim m As New System.Net.Mail.MailMessage(t.From, toEmail)
            If t.SendInPlainText = True Then
                m.IsBodyHtml = False
            Else
                m.IsBodyHtml = True
            End If
            m.Subject = Me.ReplacedSubject(t, r)
            m.Body = Me.ReplacedBody(t, r)

            result = Utilities.MailServices.SendMail(m)
        End If

        Return result
    End Function

    Private Function ReplacedSubject(ByVal t As Content.EmailTemplate, ByVal r As Catalog.ProductReview) As String
        Dim result As String = t.Subject
        result = Content.EmailTemplateTag.ReplaceTags(result, Me.ReplacementTags(r))
        result = Content.EmailTemplateTag.ReplaceTags(result, t.ReplacementTags())
        Return result
    End Function

    Private Function ReplacedBody(ByVal t As Content.EmailTemplate, ByVal r As Catalog.ProductReview) As String
        Dim result As String = t.Body
        If t.SendInPlainText = True Then
            result = t.BodyPlainText
        End If
        result = Content.EmailTemplateTag.ReplaceTags(result, Me.ReplacementTags(r))
        result = Content.EmailTemplateTag.ReplaceTags(result, t.ReplacementTags())
        Return result
    End Function

    Private Function ReplacementTags(ByVal r As Catalog.ProductReview) As Collection(Of Content.EmailTemplateTag)
        Dim result As New Collection(Of Content.EmailTemplateTag)

        result.Add(New Content.EmailTemplateTag("[[ProductReview.Bvin]]", r.Bvin))
        result.Add(New Content.EmailTemplateTag("[[ProductReview.Description]]", r.Description))
        result.Add(New Content.EmailTemplateTag("[[ProductReview.Rating]]", Convert.ToInt32(r.Rating).ToString()))
        result.Add(New Content.EmailTemplateTag("[[ProductReview.ReviewDate]]", r.ReviewDate))
        result.Add(New Content.EmailTemplateTag("[[ProductReview.Approved]]", If(r.Approved, "Approved", "Not Approved")))
        result.Add(New Content.EmailTemplateTag("[[ProductReview.ProductName]]", r.ProductName))
        result.Add(New Content.EmailTemplateTag("[[ProductReview.ProductBvin]]", r.ProductBvin))
        result.Add(New Content.EmailTemplateTag("[[ProductReview.Name]]", Me.Name.Text.Trim()))
        result.Add(New Content.EmailTemplateTag("[[ProductReview.Email]]", Me.Email.Text.Trim()))
        result.Add(New Content.EmailTemplateTag("[[ProductReview.IP]]", Request.UserHostAddress))
        result.Add(New Content.EmailTemplateTag("[[ProductReview.Host]]", Request.UserHostName))
        result.Add(New Content.EmailTemplateTag("[[ProductReview.Browser]]", Request.UserAgent))

        Return result
    End Function

    Private Function ShowMessage(ByVal msg As IMessageBox, ByVal message As String, ByVal messageType As Metrics.EventLogSeverity)
        Select Case messageType
            Case Metrics.EventLogSeverity.Information
                msg.ShowOk(message)

            Case Metrics.EventLogSeverity.Error
                msg.ShowError(message)

            Case Metrics.EventLogSeverity.Warning
                msg.ShowWarning(message)

        End Select

        Return Nothing
    End Function

End Class