Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Content_StoreClosed
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Store Closed Content"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            SetSecurityModel()

            Me.ContentField.Focus()
            LoadData()

        End If
    End Sub

    Private Sub SetSecurityModel()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = False Then
            Me.btnSaveChanges.Enabled = False
            Me.btnSaveChanges.Visible = False
        End If
    End Sub

    Private Sub LoadData()
        Me.ContentField.PreTransformText = WebAppSettings.StoreClosedDescriptionPreTransform

        Me.ContentField.Text = WebAppSettings.StoreClosedDescription
        If Me.ContentField.SupportsTransform Then
            If WebAppSettings.StoreClosedDescriptionPreTransform.Length > 0 Then
                Me.ContentField.Text = WebAppSettings.StoreClosedDescriptionPreTransform
            End If
        End If
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Me.Save = True Then
            Response.Redirect("default.aspx")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("Default.aspx")
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        WebAppSettings.StoreClosedDescription = Me.ContentField.Text
        WebAppSettings.StoreClosedDescriptionPreTransform = Me.ContentField.PreTransformText
        result = True

        Return result
    End Function


End Class
