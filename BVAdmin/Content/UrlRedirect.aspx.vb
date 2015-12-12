Imports System.Collections.ObjectModel
Imports System.Collections.Generic
Imports System.Data
Imports System.IO
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Content_UrlRedirect
    Inherits BaseAdminPage

    Private FilePath As String = String.Empty

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "URL Redirects"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Pre_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        Me.FilePath = Request.PhysicalApplicationPath + "files\redirects.txt"
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.gvRedirects.PageSize = WebAppSettings.RowsPerPage
            LoadUrls()
        End If
    End Sub

    Private Sub LoadUrls()
        Dim redirects As List(Of Utilities.UrlRedirect)

        ' filter by Type
        If String.IsNullOrEmpty(Me.ddlTypeFilter.SelectedValue) Then
            redirects = Utilities.UrlRedirect.FindAll().ToList()
        Else
            redirects = Utilities.UrlRedirect.FindByType(CType(ddlTypeFilter.SelectedValue, Utilities.UrlRedirectType)).ToList()
        End If

        ' filter by keyword
        If Not String.IsNullOrEmpty(Me.FilterField.Text) Then
            redirects = redirects.Where(Function(r) r.RequestedUrl.IndexOf(Me.FilterField.Text.Trim(), StringComparison.OrdinalIgnoreCase) >= 0 OrElse r.RedirectToUrl.IndexOf(Me.FilterField.Text.Trim(), StringComparison.OrdinalIgnoreCase) >= 0).ToList()
        End If

        Me.gvRedirects.DataSource = redirects
        Me.gvRedirects.DataBind()

        lblResults.Text = If(redirects.Count > 0, redirects.Count.ToString() + " Results", "No Results")
    End Sub

    Protected Sub gvRedirects_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvRedirects.RowDeleting
        ucMessageBox.ClearMessage()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = True Then
            Utilities.UrlRedirect.Delete(CType(gvRedirects.DataKeys(e.RowIndex).Value, String))
        End If
        LoadUrls()
        Utilities.UrlRedirector.ReloadRegexRedirects()  ' refresh regex dictionary
    End Sub

    Protected Sub gvRedirects_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvRedirects.RowEditing
        Dim bvin As String = CType(gvRedirects.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("UrlRedirect_Edit.aspx?id=" & bvin)
    End Sub

    Protected Sub gvRedirects_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs) Handles gvRedirects.PageIndexChanging
        gvRedirects.PageIndex = e.NewPageIndex
        LoadUrls()
    End Sub

    Protected Sub btnGo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGo.Click
        LoadUrls()
    End Sub

    Protected Sub ddlTypeFilter_IndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlTypeFilter.SelectedIndexChanged
        LoadUrls()
    End Sub

End Class