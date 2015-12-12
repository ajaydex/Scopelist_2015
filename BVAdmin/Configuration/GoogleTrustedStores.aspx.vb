Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_GoogleTrustedStores
    Inherits BaseAdminPage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Google Trusted Stores Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If

            PopulateCountries()
            PopulateShippingDaysAndTimes()
            
            Me.GoogleTrustedStoresEnabled.Checked = WebAppSettings.GoogleTrustedStoresEnabled
            Me.txtGoogleTrustedStoresAccountID.Text = WebAppSettings.GoogleTrustedStoresAccountID
            Me.ddlGoogleTrustedStoresBadgeLocation.SelectedValue = WebAppSettings.GoogleTrustedStoresBadgeLocation
            Me.ddlGoogleTrustedStoresShippingDays.SelectedIndex = WebAppSettings.GoogleTrustedStoresShippingDays - 1
            Me.ddlGoogleTrustedStoresShippingTime.Items.FindByValue(WebAppSettings.GoogleTrustedStoresShippingTime.Ticks.ToString()).Selected = True
            Me.chkGoogleTrustedStoresSaturdayShipping.Checked = WebAppSettings.GoogleTrustedStoresSaturdayShipping
            Me.txtGoogleTrustedStoresMaxTransitDays.Text = WebAppSettings.GoogleTrustedStoresMaxTransitDays.ToString()
            Me.txtGoogleTrustedStoresMaxBackorderDays.Text = WebAppSettings.GoogleTrustedStoresMaxBackorderDays.ToString()
            Me.txtGoogleShoppingAccountID.Text = WebAppSettings.GoogleShoppingAccountID
            Me.txtGoogleShoppingLanguage.Text = WebAppSettings.GoogleShoppingLanguage

            Dim country As Content.Country = Content.Country.FindByISOCode(WebAppSettings.GoogleShoppingCountry)
            If Me.ddlGoogleShoppingCountry.Items.FindByValue(country.Bvin) IsNot Nothing Then
                Me.ddlGoogleShoppingCountry.Items.FindByValue(country.Bvin).Selected = True
            End If
        End If

        Me.lblCustomBadgeLocation.Visible = (Me.ddlGoogleTrustedStoresBadgeLocation.SelectedValue = "USER_DEFINED")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            Me.ucMessageBox.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = True

        Try
            WebAppSettings.GoogleTrustedStoresEnabled = Me.GoogleTrustedStoresEnabled.Checked
            WebAppSettings.GoogleTrustedStoresAccountID = Me.txtGoogleTrustedStoresAccountID.Text.Trim()
            WebAppSettings.GoogleTrustedStoresBadgeLocation = Me.ddlGoogleTrustedStoresBadgeLocation.SelectedValue
            WebAppSettings.GoogleTrustedStoresShippingDays = Convert.ToInt32(Me.ddlGoogleTrustedStoresShippingDays.SelectedValue)
            WebAppSettings.GoogleTrustedStoresShippingTime = New TimeSpan(Me.ddlGoogleTrustedStoresShippingTime.SelectedValue)
            WebAppSettings.GoogleTrustedStoresSaturdayShipping = Me.chkGoogleTrustedStoresSaturdayShipping.Checked
            WebAppSettings.GoogleTrustedStoresMaxTransitDays = Me.txtGoogleTrustedStoresMaxTransitDays.Text.Trim()
            WebAppSettings.GoogleTrustedStoresMaxBackorderDays = Me.txtGoogleTrustedStoresMaxBackorderDays.Text.Trim()
            WebAppSettings.GoogleShoppingAccountID = Me.txtGoogleShoppingAccountID.Text.Trim()
            WebAppSettings.GoogleShoppingCountry = Content.Country.FindByBvin(Me.ddlGoogleShoppingCountry.SelectedValue).IsoCode
            WebAppSettings.GoogleShoppingLanguage = Me.txtGoogleShoppingLanguage.Text.Trim()
        Catch ex As Exception
            result = False
        End Try

        Return result
    End Function

    Private Sub PopulateCountries()
        Me.ddlGoogleShoppingCountry.DataSource = Content.Country.FindActive
        Me.ddlGoogleShoppingCountry.DataValueField = "Bvin"
        Me.ddlGoogleShoppingCountry.DataTextField = "DisplayName"
        Me.ddlGoogleShoppingCountry.DataBind()
    End Sub

    Private Sub PopulateShippingDaysAndTimes()
        Me.ddlGoogleTrustedStoresShippingDays.Items.Clear()

        For i As Integer = 1 To 14
            Me.ddlGoogleTrustedStoresShippingDays.Items.Add(New ListItem(i.ToString() + " Day" + If(i > 1, "s", String.Empty), i.ToString()))
        Next

        Dim ts As New TimeSpan(0, 15, 0)
        Dim dt As DateTime = DateTime.Today
        While dt.Day = DateTime.Today.Day
            Me.ddlGoogleTrustedStoresShippingTime.Items.Add(New ListItem(dt.ToShortTimeString(), dt.TimeOfDay.Ticks.ToString()))
            dt = dt.Add(ts)
        End While
    End Sub

    Private Sub ddlGoogleShoppingCountry_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlGoogleShoppingCountry.SelectedIndexChanged
        Try
            Me.txtGoogleShoppingLanguage.Text = New System.Globalization.CultureInfo(Content.Country.FindByBvin(Me.ddlGoogleShoppingCountry.SelectedValue).CultureCode).TwoLetterISOLanguageName
        Catch ex As Exception
            Me.ucMessageBox.ShowError("Unable to determine Google Shopping Language code based on the selected country")
        End Try
    End Sub

End Class