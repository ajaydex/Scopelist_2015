Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Content_CustomPages
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Pages"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadPages()
        End If
    End Sub

    Private Sub LoadPages()
        Dim pages As Collection(Of Content.CustomPage)
        pages = Content.CustomPage.FindAll
        Me.GridView1.DataSource = pages
        Me.GridView1.DataBind()
        Me.lblResults.Text = pages.Count & " Pages Found"
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        msg.ClearMessage()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)

            If WebAppSettings.AutoPopulateRedirectOnCustomPageDelete Then
                Dim cp As Content.CustomPage = Content.CustomPage.FindByBvin(bvin)
                If Not String.IsNullOrEmpty(cp.Bvin) Then
                    Dim customPageUrl As String = Utilities.UrlRewriter.BuildUrlForCustomPage(cp, Me)
                    If Content.CustomPage.Delete(bvin) Then
                        Response.Redirect(String.Format("~/BVAdmin/Content/UrlRedirect_Edit.aspx?RequestedUrl={0}&RedirectType={1}&SystemData={2}&ReturnUrl={3}", HttpUtility.UrlEncode(customPageUrl), Convert.ToInt32(Utilities.UrlRedirectType.CustomPage).ToString(), cp.Bvin, HttpUtility.UrlEncode(Me.Request.Url.AbsolutePath)))
                    Else
                        Me.msg.ShowWarning("Unable to delete this page.")
                    End If
                Else
                    Me.msg.ShowWarning("Unable to find page to delete.")
                End If
            Else
                If Content.CustomPage.Delete(bvin) = False Then
                    Me.msg.ShowWarning("Unable to delete this page.")
                End If
            End If
        End If
        LoadPages()
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("CustomPages_Edit.aspx?id=" & bvin)
    End Sub


End Class
