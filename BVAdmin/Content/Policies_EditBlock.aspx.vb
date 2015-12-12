Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Content_Policies_EditBlock
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            SetSecurityModel()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
            Else
                If Request.QueryString("policyId") IsNot Nothing Then
                    Me.PolicyIdField.Value = Request.QueryString("policyId")
                End If
            End If
            LoadBlock()
        End If
    
    End Sub

    Private Sub SetSecurityModel()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = False Then
            Me.btnSaveChanges.Enabled = False
            Me.btnSaveChanges.Visible = False
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Policy Block"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Private Sub LoadBlock()
        If Me.BvinField.Value.Trim.Length > 0 Then
            Dim b As Content.PolicyBlock = Content.PolicyBlock.FindByBvin(Me.BvinField.Value)
            If b IsNot Nothing Then
                Me.NameField.Text = b.Name
                Me.DescriptionField.Text = b.Description
                If Me.DescriptionField.SupportsTransform = True Then
                    If b.DescriptionPreTransform.Trim.Length > 0 Then
                        Me.DescriptionField.Text = b.DescriptionPreTransform
                    End If
                End If
                Me.PolicyIdField.Value = b.PolicyID
            End If
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        RedirectOnComplete()
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Me.Save() = True Then
            RedirectOnComplete()
        Else
            msg.ShowError("Unable to save block!")
        End If
    End Sub

    Private Sub RedirectOnComplete()
        If Me.PolicyIdField.Value.Trim.Length > 0 Then
            Response.Redirect("Policies_Edit.aspx?id=" & Server.UrlEncode(Me.PolicyIdField.Value.Trim))
        Else
            Response.Redirect("Policies.aspx")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim b As Content.PolicyBlock
        b = Content.PolicyBlock.FindByBvin(Me.BvinField.Value)
        If Not b Is Nothing Then
            b.Name = Me.NameField.Text.Trim
            b.Description = Me.DescriptionField.Text.Trim
            b.DescriptionPreTransform = Me.DescriptionField.PreTransformText
            
            If Me.BvinField.Value = String.Empty Then
                b.PolicyID = Me.PolicyIdField.Value
                result = Content.PolicyBlock.Insert(b)
            Else
                result = Content.PolicyBlock.Update(b)
            End If

            If result = True Then
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = b.Bvin
            End If
        End If

        Return result
    End Function

End Class
