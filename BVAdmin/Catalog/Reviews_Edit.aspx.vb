Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class Reviews_Edit
    Inherits BaseProductAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        If Not Request.QueryString("returnURL") Is Nothing Then
            Page.MasterPageFile = "~/BVAdmin/BVAdminProduct.master"
        End If

        Me.PageTitle = "Edit Product Review"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Catalog
            
            If Not Request.QueryString("ReturnURL") Is Nothing Then
                ViewState("ReturnURL") = Request.QueryString("ReturnURL")
            End If

            If Not Request.QueryString("ReviewID") Is Nothing Then
                Dim rid As String = String.Empty
                rid = Request.QueryString("ReviewID")
                ProductReviewEditor1.ReviewID = rid
                ProductReviewEditor1.LoadReview()
            End If
        End If
    End Sub

    Protected Overrides Function Save() As Boolean
        'we do not want them to be able to click "save and continue"
        Return False
    End Function
End Class
