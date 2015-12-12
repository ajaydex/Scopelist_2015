Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Returns
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Return Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If

            BindForm()

            EnableReturnsCheckBox.Checked = WebAppSettings.EnableReturns

            If WebAppSettings.AutomaticallyIssueRMANumbers Then
                Me.AutomaticallyIssueRMACheckBoxList.SelectedValue = "1"
            Else
                Me.AutomaticallyIssueRMACheckBoxList.SelectedValue = "0"
            End If

            ddlNewRMA.SelectedValue = WebAppSettings.RMANewEmailTemplate
            ddlAcceptedRMA.SelectedValue = WebAppSettings.RMAAcceptedEmailTemplate
            ddlRejectedRMA.SelectedValue = WebAppSettings.RMARejectedEmailTemplate
            
        End If
    End Sub

    Protected Sub BindForm()
        ddlAcceptedRMA.DataSource = Content.EmailTemplate.FindAll
        ddlAcceptedRMA.DataTextField = "DisplayName"
        ddlAcceptedRMA.DataValueField = "bvin"        
        ddlAcceptedRMA.DataBind()
        ddlAcceptedRMA.SelectedValue = WebAppSettings.EmailTemplateID_ForgotPassword

        ddlRejectedRMA.DataSource = Content.EmailTemplate.FindAll
        ddlRejectedRMA.DataTextField = "DisplayName"
        ddlRejectedRMA.DataValueField = "bvin"        
        ddlRejectedRMA.DataBind()
        ddlRejectedRMA.SelectedValue = WebAppSettings.EmailTemplateID_ForgotPassword

        ddlNewRMA.DataSource = Content.EmailTemplate.FindAll
        ddlNewRMA.DataTextField = "DisplayName"
        ddlNewRMA.DataValueField = "bvin"
        ddlNewRMA.DataBind()
        ddlNewRMA.SelectedValue = WebAppSettings.EmailTemplateID_ForgotPassword
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False
        WebAppSettings.EnableReturns = EnableReturnsCheckBox.Checked
        WebAppSettings.AutomaticallyIssueRMANumbers = (AutomaticallyIssueRMACheckBoxList.SelectedValue = "1")
        WebAppSettings.RMANewEmailTemplate = ddlNewRMA.SelectedValue
        WebAppSettings.RMAAcceptedEmailTemplate = ddlAcceptedRMA.SelectedValue
        WebAppSettings.RMARejectedEmailTemplate = ddlRejectedRMA.SelectedValue
        result = True
        Return result
    End Function

End Class
