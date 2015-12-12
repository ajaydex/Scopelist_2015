Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Content_CustomUrl_Edit
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Custom Url"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            SetSecurityModel()

            Me.RequestedUrlField.Focus()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadUrl()
            Else
                Me.BvinField.Value = String.Empty
            End If
        End If
    End Sub

    Private Sub SetSecurityModel()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = False Then
            Me.btnSaveChanges.Enabled = False
            Me.btnSaveChanges.Visible = False
        End If
    End Sub

    Private Sub LoadUrl()
        Dim c As Content.CustomUrl
        c = Content.CustomUrl.FindByBvin(Me.BvinField.Value)
        If Not c Is Nothing Then
            If c.Bvin <> String.Empty Then
                Me.RequestedUrlField.Text = c.RequestedUrl
                Me.RedirectToUrlField.Text = c.RedirectToUrl
            End If
        End If
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Me.Save = True Then
            Response.Redirect("CustomUrl.aspx")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("CustomUrl.aspx")
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim c As Content.CustomUrl
        c = Content.CustomUrl.FindByBvin(Me.BvinField.Value)
        If Not c Is Nothing Then
            c.RequestedUrl = Me.RequestedUrlField.Text.Trim
            c.RedirectToUrl = Me.RedirectToUrlField.Text.Trim

            If Me.BvinField.Value = String.Empty Then
                result = Content.CustomUrl.Insert(c)
            Else
                result = Content.CustomUrl.Update(c)
            End If

            If result = True Then
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = c.Bvin
            End If
        End If

        Return result
    End Function

End Class
