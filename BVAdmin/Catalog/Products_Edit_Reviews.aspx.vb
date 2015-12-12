Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Partial Class products_products_edit_reviews
    Inherits BaseProductAdminPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.PageTitle = "Edit Product Reviews"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Catalog

            LoadReviews()
            SetProductName()
        End If
    End Sub

    Private Sub SetProductName()
        Dim p As New Catalog.Product
        p = Catalog.InternalProduct.FindByBvin(Request.QueryString("ID"))
        If Not String.IsNullOrEmpty(p.ParentId) Then
            Response.Redirect(String.Format("{0}?id={1}", HttpContext.Current.Request.Url.AbsolutePath, p.ParentId))
        End If
        If Not p Is Nothing Then
            Me.lblProductName.Text = p.Sku & " " & p.ProductName
        End If
        p = Nothing
    End Sub

    Private Sub LoadReviews()
        Dim reviews As New Collection(Of Catalog.ProductReview)
        reviews = Catalog.ProductReview.FindByProductBvin(Request.QueryString("ID"), True)

        If Not reviews Is Nothing Then
            Me.dlReviews.DataSource = reviews
            Me.dlReviews.DataBind()
        End If

        reviews = Nothing
    End Sub

    Private Sub dlReviews_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlReviews.DeleteCommand
        Dim reviewID As String = dlReviews.DataKeys(e.Item.ItemIndex)
        Catalog.ProductReview.Delete(reviewID)
        LoadReviews()
    End Sub

    Private Sub dlReviews_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlReviews.EditCommand
        Dim reviewID As String = dlReviews.DataKeys(e.Item.ItemIndex)
        Response.Redirect("Reviews_Edit.aspx?reviewID=" & reviewID & "&ReturnURL=" & Server.UrlEncode("products_edit_reviews.aspx?id=" & Request.QueryString("id")))
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
        End If
    End Sub

    Private Sub btnNew_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Dim pr As New Catalog.ProductReview
        pr.Approved = True
        pr.Description = "New Review"
        pr.UserID = SessionManager.GetCurrentUserId
		pr.ReviewDate = Date.Now
        pr.ProductBvin = Request.QueryString("ID")
        'If Datalayer.ProductReviewMapper.SaveAsNew(pr) = True Then
        If Catalog.ProductReview.Insert(pr) = True Then
            Response.Redirect("Reviews_Edit.aspx?reviewID=" & pr.Bvin & "&DOC=1" & "&ReturnURL=" & Server.UrlEncode("products_edit_reviews.aspx?id=" & Request.QueryString("id")))
        End If

    End Sub

    Protected Overrides Function Save() As Boolean
        Return True
    End Function

End Class
