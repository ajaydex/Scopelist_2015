Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Partial Class Products_ReviewsToModerate
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Moderate Reviews"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Catalog
            LoadReviews()
        End If
    End Sub

    Private Sub LoadReviews()    
        If Catalog.ProductReview.GetNotApproved.Count = 0 Then
            lblNoReviews.Visible = "True"
            pnlApproveAll.Visible = False
        Else
            Me.dlReviews.DataSource = Catalog.ProductReview.GetNotApproved
            Me.dlReviews.DataBind()
            pnlApproveAll.Visible = True
        End If

    End Sub

    Private Sub dlReviews_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlReviews.DeleteCommand
        Dim reviewID As String = dlReviews.DataKeys(e.Item.ItemIndex)
        Catalog.ProductReview.Delete(reviewID)
        Response.Redirect("ReviewsToModerate.aspx")
        'LoadReviews()
    End Sub

    Private Sub dlReviews_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlReviews.EditCommand
        Dim reviewID As String = dlReviews.DataKeys(e.Item.ItemIndex)
        Dim pid As String = Request.QueryString(ID)
        Response.Redirect("Reviews_Edit.aspx?reviewID=" & reviewID)
    End Sub

    Private Sub dlReviews_UpdateCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlReviews.UpdateCommand
        Dim reviewID As String = dlReviews.DataKeys(e.Item.ItemIndex)
        Dim r As Catalog.ProductReview
        r = Catalog.ProductReview.FindByBvin(reviewID)
        r.Approved = True
        Catalog.ProductReview.Update(r)
        'LoadReviews()
        Response.Redirect("ReviewsToModerate.aspx")
    End Sub

    Private Sub dlReviews_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dlReviews.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
            Dim imgRating As System.Web.UI.WebControls.Image
            imgRating = e.Item.FindControl("imgRating")
            If Not imgRating Is Nothing Then
                Dim rating As Catalog.ProductReviewRating = DataBinder.Eval(e.Item.DataItem, "Rating")
                Select Case rating
                    Case Catalog.ProductReviewRating.ZeroStars
                        imgRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars0")
                    Case Catalog.ProductReviewRating.OneStar
                        imgRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars1")
                    Case Catalog.ProductReviewRating.TwoStars
                        imgRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars2")
                    Case Catalog.ProductReviewRating.ThreeStars
                        imgRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars3")
                    Case Catalog.ProductReviewRating.FourStars
                        imgRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars4")
                    Case Catalog.ProductReviewRating.FiveStars
                        imgRating.ImageUrl = PersonalizationServices.GetThemedButton("Stars5")
                End Select
            End If

            Dim r As Catalog.ProductReview = CType(e.Item.DataItem, Catalog.ProductReview)
            If r IsNot Nothing Then
                Dim lblUserName As Label = CType(e.Item.FindControl("lblUserName"), Label)
                If lblUserName IsNot Nothing Then
                    lblUserName.Text = r.GetUserNameForDisplay() + " - " + r.UserEmail
                End If
            End If
        End If
    End Sub

    Protected Sub btnApproveAll_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnApproveAll.Click
        For Each item As DataListItem In dlReviews.Items
            Dim bvin As String = dlReviews.DataKeys(item.ItemIndex)

            Dim r As Catalog.ProductReview = Catalog.ProductReview.FindByBvin(bvin)
            r.Approved = True
            Catalog.ProductReview.Update(r)
        Next

        Response.Redirect("ReviewsToModerate.aspx")
    End Sub

End Class