Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel


Partial Class BVAdmin_Controls_ProductReviewEditor
    Inherits System.Web.UI.UserControl

    Public Property ReviewID() As String
        Get
            Return Request.QueryString("ReviewID").ToString
        End Get
        Set(ByVal Value As String)
            ViewState("ReviewID") = Value
        End Set
    End Property

    Public Sub LoadReview()
        If Not Request.QueryString("ReviewID") Is Nothing Then
            Dim r As New Catalog.ProductReview
            r = Catalog.ProductReview.FindByBvin(ReviewID)

            If Not r Is Nothing Then
                Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(r.ProductBvin)
                If Not p Is Nothing Then
                    Me.lblProductName.Text = p.ProductName
                Else
                    Me.lblProductName.Text = "Unknown"
                End If
                If Not String.IsNullOrEmpty(r.UserName) Then
                    Me.txtUserName.Text = r.UserName
                Else
                    Me.txtUserName.Text = Catalog.ProductReview.GetUserNameForDisplay(r.UserID)
                End If
                If Not String.IsNullOrEmpty(r.UserEmail) Then
                    Me.txtEmail.Text = r.UserEmail
                Else
                    If Not String.IsNullOrEmpty(r.UserID) Then
                        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(r.UserID)
                        If Not String.IsNullOrEmpty(u.Bvin) Then
                            Me.txtEmail.Text = u.Email
                        End If
                    End If
                End If
                Me.lblReviewDate.Text = r.ReviewDate.ToString
                Me.chkApproved.Checked = r.Approved
                Me.KarmaField.Text = r.Karma.ToString
                Select Case r.Rating
                    Case Catalog.ProductReviewRating.ZeroStars
                        lstRating.SelectedValue = 0
                    Case Catalog.ProductReviewRating.OneStar
                        lstRating.SelectedValue = 1
                    Case Catalog.ProductReviewRating.TwoStars
                        lstRating.SelectedValue = 2
                    Case Catalog.ProductReviewRating.ThreeStars
                        lstRating.SelectedValue = 3
                    Case Catalog.ProductReviewRating.FourStars
                        lstRating.SelectedValue = 4
                    Case Catalog.ProductReviewRating.FiveStars
                        lstRating.SelectedValue = 5
                End Select
                Me.DescriptionField.Text = r.Description
            End If
            r = Nothing
        End If
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        If Request.QueryString("returnURL") Is Nothing Then
            Response.Redirect("ReviewsToModerate.aspx")
        Else
            Response.Redirect(Request.QueryString("returnURL"))
        End If
    End Sub

    Private Sub btnOK_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOK.Click
        Try
            If Not Request.QueryString("ReviewID") Is Nothing Then
                Dim r As New Catalog.ProductReview
                r = Catalog.ProductReview.FindByBvin(ReviewID)
                If Not r Is Nothing Then
                    r.Approved = Me.chkApproved.Checked
                    r.Karma = Convert.ToInt32(Me.KarmaField.Text.Trim)
                    r.Rating = Convert.ToInt32(Me.lstRating.SelectedValue)
                    r.Description = Me.DescriptionField.Text.Trim
                End If
                Catalog.ProductReview.Update(r)
                r = Nothing

                If Request.QueryString("returnURL") Is Nothing Then
                    Response.Redirect("ReviewsToModerate.aspx")
                Else
                    Response.Redirect(Request.QueryString("returnURL"))
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub
End Class
