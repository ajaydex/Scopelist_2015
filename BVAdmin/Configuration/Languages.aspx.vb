Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Languages
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Language Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            PopulateCountries()
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If
            If Me.lstSiteCountry.Items.FindByValue(WebAppSettings.SiteCountryBvin) IsNot Nothing Then
                Me.lstSiteCountry.Items.FindByValue(WebAppSettings.SiteCountryBvin).Selected = True
            End If
            If Me.SiteShippingLengthTypeField.Items.FindByValue(WebAppSettings.SiteShippingLengthType) IsNot Nothing Then
                Me.SiteShippingLengthTypeField.ClearSelection()
                Me.SiteShippingLengthTypeField.Items.FindByValue(WebAppSettings.SiteShippingLengthType).Selected = True
            End If
            If Me.SiteShippingWeightTypeField.Items.FindByValue(WebAppSettings.SiteShippingWeightType) IsNot Nothing Then
                Me.SiteShippingWeightTypeField.ClearSelection()
                Me.SiteShippingWeightTypeField.Items.FindByValue(WebAppSettings.SiteShippingWeightType).Selected = True
            End If
        End If
    End Sub

    Private Sub PopulateCountries()
        Me.lstSiteCountry.DataSource = Content.Country.FindActive
        Me.lstSiteCountry.DataTextField = "SampleNameAndCurrency"
        Me.lstSiteCountry.DataValueField = "bvin"
        Me.lstSiteCountry.DataBind()
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

        WebAppSettings.SiteCountryBvin = Me.lstSiteCountry.SelectedValue
        Dim c As Content.Country = Content.Country.FindByBvin(Me.lstSiteCountry.SelectedValue)
        WebAppSettings.SiteCultureCode = c.CultureCode
        c = Nothing
        WebAppSettings.SiteShippingLengthType = Me.SiteShippingLengthTypeField.SelectedValue
        WebAppSettings.SiteShippingWeightType = Me.SiteShippingWeightTypeField.SelectedValue

        result = True

        Return result
    End Function

End Class
