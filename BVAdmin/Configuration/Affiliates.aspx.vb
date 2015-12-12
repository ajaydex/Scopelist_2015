Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Affiliates
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Affiliate Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If

            Me.AffiliateCommissionAmountField.Text = WebAppSettings.AffiliateCommissionAmount.ToString
            Me.AffiliateThemesCheckBox.Checked = WebAppSettings.AllowAffiliateThemes
            Me.AffiliateReferralDays.Text = WebAppSettings.AffiliateReferralDays.ToString
            Me.lstCommissionType.ClearSelection()
            Select Case WebAppSettings.AffiliateCommissionType
                Case Contacts.AffiliateCommissionType.PercentageCommission, Contacts.AffiliateCommissionType.None
                    Me.lstCommissionType.Items.FindByValue("1").Selected = True
                Case Contacts.AffiliateCommissionType.FlatRateCommission
                    Me.lstCommissionType.Items.FindByValue("2").Selected = True
                Case Else
                    Me.lstCommissionType.Items.FindByValue("1").Selected = True
            End Select
            Me.AffiliateConflictModeField.ClearSelection()
            Select Case WebAppSettings.AffiliateConflictMode
                Case Contacts.AffiliateConflictMode.FavorOldAffiliate, Contacts.AffiliateConflictMode.None
                    Me.AffiliateConflictModeField.Items.FindByValue("1").Selected = True
                Case Contacts.AffiliateConflictMode.FavorNewAffiliate
                    Me.AffiliateConflictModeField.Items.FindByValue("2").Selected = True
                Case Else
                    Me.AffiliateConflictModeField.Items.FindByValue("1").Selected = True
            End Select

        End If
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

        WebAppSettings.AffiliateCommissionAmount = Decimal.Parse(Me.AffiliateCommissionAmountField.Text)
        WebAppSettings.AffiliateReferralDays = Integer.Parse(Me.AffiliateReferralDays.Text)
        Dim typeSelection As Integer = CType(Me.lstCommissionType.SelectedValue, Integer)
        WebAppSettings.AffiliateCommissionType = CType(typeSelection, Contacts.AffiliateCommissionType)
        Dim conflictSelection As Integer = CType(Me.AffiliateConflictModeField.SelectedValue, Integer)
        WebAppSettings.AffiliateConflictMode = CType(conflictSelection, Contacts.AffiliateConflictMode)
        WebAppSettings.AllowAffiliateThemes = Me.AffiliateThemesCheckBox.Checked

        result = True

        Return result
    End Function

End Class
