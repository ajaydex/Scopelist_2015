Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_Categories_RemoveProduct
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            Dim id As String = Request.Form("id")
            Dim catId As String = Request.Form("categoryid")
            RemoveFromCategory(id, catId)
        End If

    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.LoginToAdmin)
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogEdit)
    End Sub

    Public Sub ValidateCurrentUserHasPermission(ByVal p As String)
        Dim l As New Collection(Of String)
        l.Add(p)
        ValidateCurrentUserHasPermissions(l)
    End Sub

    Public Sub ValidateCurrentUserHasPermissions(ByVal p As Collection(Of String))
        If SessionManager.IsUserAuthenticated = False Then
            ' Send to Login Page
            Dim url As String = Me.Request.RawUrl
            url = url.Replace("&Anthem_CallBack=true", "")
            url = url.Replace("?Anthem_CallBack=true", "")
            Response.Redirect("~/BVAdmin/Login.aspx?ReturnUrl=" & HttpUtility.UrlEncode(url))
        Else
            If Membership.UserAccount.DoesUserHaveAllPermissions(SessionManager.GetCurrentUserId, p) = False Then
                ' Send to no permissions page
                Response.Redirect("~/nopermissions.aspx")
            End If
        End If
    End Sub

    Private Sub RemoveFromCategory(ByVal id As String, ByVal catId As String)

        If (Catalog.Category.RemoveProduct(catId, id)) Then            
            Me.litOutput.Text = "true"
        Else
            Me.litOutput.Text = "false"
        End If

    End Sub

End Class
