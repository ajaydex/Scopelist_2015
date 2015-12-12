Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Analytics
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Analytics Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If

            ' Google Analytics
            Me.chkGoogleTracker.Checked = WebAppSettings.AnalyticsUseGoogleTracker
            Me.GoogleTrackingIdField.Text = WebAppSettings.AnalyticsGoogleTrackingId
            Me.chkAnalyticsGoogleUseDisplayFeatures.Checked = WebAppSettings.AnalyticsGoogleUseDisplayFeatures
            Me.chkAnalyticsGoogleUseEnhancedLinkAttribution.Checked = WebAppSettings.AnalyticsGoogleUseEnhancedLinkAttribution
            Me.chkGoogleEcommerce.Checked = WebAppSettings.AnalyticsUseGoogleEcommerce
            Me.GoogleEcommerceStoreNameField.Text = WebAppSettings.AnalyticsGoogleEcommerceStoreName

            ' Google AdWords
            Me.chkGoogleAdwords.Checked = WebAppSettings.AnalyticsUseGoogleAdwords
            Me.GoogleAdwordsConversionIdField.Text = WebAppSettings.AnalyticsGoogleAdwordsConversionId
            Me.GoogleAdwordsLabelField.Text = WebAppSettings.AnalyticsGoogleAdwordsConversionLabel
            Me.GoogleAdwordsBackgroundColorField.Text = WebAppSettings.AnalyticsGoogleAdwordsBackgroundColor

            ' Google Tag Manager            
            Me.chkGoogleTagManager.Checked = WebAppSettings.AnalyticsUseGoogleTagManager
            Me.GoogleTagManagerContainerIdField.Text = WebAppSettings.AnalyticsGoogleTagManagerContainerId

            ' Microsoft AdCenter
            Me.chkMicrosoftAdcenter.Checked = WebAppSettings.AnalyticsUseMicrosoftAdCenter
            Me.MicrosoftAdCenterTrackingCodeField.Text = WebAppSettings.AnalyticsMicrosoftAdCenterTrackingCode

            ' Yahoo Advertising
            Me.chkYahoo.Checked = WebAppSettings.AnalyticsUseYahoo
            Me.YahooAccountIdField.Text = WebAppSettings.AnalyticsYahooAccountId
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        ' Google Analytics
        WebAppSettings.AnalyticsUseGoogleTracker = Me.chkGoogleTracker.Checked
        WebAppSettings.AnalyticsGoogleTrackingId = Me.GoogleTrackingIdField.Text
        WebAppSettings.AnalyticsGoogleUseDisplayFeatures = Me.chkAnalyticsGoogleUseDisplayFeatures.Checked
        WebAppSettings.AnalyticsGoogleUseEnhancedLinkAttribution = Me.chkAnalyticsGoogleUseEnhancedLinkAttribution.Checked
        WebAppSettings.AnalyticsUseGoogleEcommerce = Me.chkGoogleEcommerce.Checked
        WebAppSettings.AnalyticsGoogleEcommerceStoreName = Me.GoogleEcommerceStoreNameField.Text

        ' Google AdWords
        WebAppSettings.AnalyticsUseGoogleAdwords = Me.chkGoogleAdwords.Checked
        WebAppSettings.AnalyticsGoogleAdwordsConversionId = Me.GoogleAdwordsConversionIdField.Text
        WebAppSettings.AnalyticsGoogleAdwordsConversionLabel = Me.GoogleAdwordsLabelField.Text
        WebAppSettings.AnalyticsGoogleAdwordsBackgroundColor = Me.GoogleAdwordsBackgroundColorField.Text

        ' Google Tag Manager
        WebAppSettings.AnalyticsUseGoogleTagManager = Me.chkGoogleTagManager.Checked
        WebAppSettings.AnalyticsGoogleTagManagerContainerId = Me.GoogleTagManagerContainerIdField.Text

        ' Microsoft AdCenter
        WebAppSettings.AnalyticsUseMicrosoftAdCenter = Me.chkMicrosoftAdcenter.Checked
        WebAppSettings.AnalyticsMicrosoftAdCenterTrackingCode = Me.MicrosoftAdCenterTrackingCodeField.Text.Trim()

        ' Yahoo Advertising
        WebAppSettings.AnalyticsUseYahoo = Me.chkYahoo.Checked
        WebAppSettings.AnalyticsYahooAccountId = Me.YahooAccountIdField.Text

        
        Me.MessageBox1.ShowOk("Settings Saved!")
    End Sub

End Class