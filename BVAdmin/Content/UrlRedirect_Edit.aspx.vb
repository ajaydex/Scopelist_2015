Imports BVSoftware.Bvc5.Core
Imports System.Data

Partial Class BVAdmin_Content_UrlRedirect_Edit
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit URL Redirect"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            SetSecurityModel()

            Me.txtRequestedUrlField.Focus()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadUrl()
            Else
                Me.BvinField.Value = String.Empty

                ' check for query string parameters
                If Not String.IsNullOrEmpty(Request.QueryString("RequestedUrl")) Then
                    Me.txtRequestedUrlField.Text = HttpUtility.UrlDecode(Request.QueryString("RequestedUrl"))
                End If
                If Not String.IsNullOrEmpty(Request.QueryString("RedirectType")) Then
                    Me.ddlRedirectTypeField.SelectedValue = Request.QueryString("RedirectType")
                End If
                If Not String.IsNullOrEmpty(Request.QueryString("SystemData")) Then
                    Me.txtSystemDataField.Text = Request.QueryString("SystemData")
                End If
            End If

            ddlRedirectTypeField_IndexChanged(Nothing, Nothing)
        End If
    End Sub

    Private Sub SetSecurityModel()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = False Then
            Me.btnSaveChanges.Enabled = False
            Me.btnSaveChanges.Visible = False
        End If
    End Sub

    Private Sub LoadUrl()
        Dim redirect As Utilities.UrlRedirect = Utilities.UrlRedirect.FindByBvin(BvinField.Value)
        If redirect IsNot Nothing AndAlso Not String.IsNullOrEmpty(redirect.Bvin) Then
            Me.txtRequestedUrlField.Text = redirect.RequestedUrl
            Me.txtRedirectToUrlField.Text = redirect.RedirectToUrl
            Me.ddlRedirectTypeField.SelectedValue = Convert.ToInt32(redirect.RedirectType).ToString()
            Me.ddlStatusCodeField.SelectedValue = redirect.StatusCode.ToString()
            Me.txtSystemDataField.Text = redirect.SystemData
            Me.chkIsRegexField.Checked = redirect.IsRegex
        End If
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Me.Save = True Then
            Utilities.UrlRedirector.ReloadRegexRedirects()  ' refresh regex dictionary
            If String.IsNullOrEmpty(Request.QueryString("ReturnUrl")) Then
                Response.Redirect("UrlRedirect.aspx")
            Else
                Response.Redirect(HttpUtility.UrlDecode(Request.QueryString("ReturnUrl")))
            End If
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        If String.IsNullOrEmpty(Request.QueryString("ReturnUrl")) Then
            Response.Redirect("UrlRedirect.aspx")
        Else
            Response.Redirect(HttpUtility.UrlDecode(Request.QueryString("ReturnUrl")))
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Page.Validate()
        If Page.IsValid Then
            Dim redirect As New Utilities.UrlRedirect()
            redirect.Bvin = Request.QueryString("id")
            redirect.RequestedUrl = txtRequestedUrlField.Text
            redirect.RedirectToUrl = txtRedirectToUrlField.Text
            redirect.RedirectType = CType(ddlRedirectTypeField.SelectedValue, Utilities.UrlRedirectType)
            redirect.SystemData = txtSystemDataField.Text
            redirect.StatusCode = Convert.ToInt32(ddlStatusCodeField.SelectedValue)
            redirect.IsRegex = chkIsRegexField.Checked

            If String.IsNullOrEmpty(redirect.Bvin) Then
                result = Utilities.UrlRedirect.Insert(redirect)
            Else
                result = Utilities.UrlRedirect.Update(redirect)
            End If

            If result = False Then
                Me.ucMessageBox.ShowError(redirect.ValidationResult.Message)
            End If
        End If

        Return result
    End Function

    Protected Sub ddlRedirectTypeField_IndexChanged(ByVal sendder As Object, ByVal e As EventArgs) Handles ddlRedirectTypeField.SelectedIndexChanged
        If ddlRedirectTypeField.SelectedValue = "0" Then
            txtSystemDataField.Enabled = False
            txtSystemDataField.Text = String.Empty
        Else
            txtSystemDataField.Enabled = True
        End If
    End Sub

End Class