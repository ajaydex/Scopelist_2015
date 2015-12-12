Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_Categories_SortProducts
    Inherits System.Web.UI.Page

    Private _displayButtons As Boolean = True

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            Dim ids As String = Request.Form("ids")
            Dim catId As String = Request.Form("categoryid")
            Resort(ids, catId)
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

    Private Sub Resort(ByVal ids As String, ByVal catId As String)

        Dim sorted() As String = ids.Split(",")
        Dim l As New List(Of String)
        For Each id As String In sorted
            l.Add(id)
        Next

        If (Catalog.Category.ResortProducts(catId, l)) Then
            Me.litOutput.Text = "true"
        Else
            Me.litOutput.Text = "false"
        End If

    End Sub

End Class
