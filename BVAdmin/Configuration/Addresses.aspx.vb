Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Addresses
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Address Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)        
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not Page.IsPostBack Then

            Try
                Me.chkBillShowMiddleInitial.Checked = WebAppSettings.BillAddressShowMiddleInitial
                Me.chkBillShowCompany.Checked = WebAppSettings.BillAddressShowCompany
                Me.chkBillShowPhoneNumber.Checked = WebAppSettings.BillAddressShowPhone
                Me.chkBillShowFaxNumber.Checked = WebAppSettings.BillAddressShowFax
                Me.chkBillShowWebSiteURL.Checked = WebAppSettings.BillAddressShowWebSiteUrl
                Me.chkBillRequireCompany.Checked = WebAppSettings.BillAddressRequireCompany
                Me.chkBillRequireFax.Checked = WebAppSettings.BillAddressRequireFax
                Me.chkBillRequireFirstName.Checked = WebAppSettings.BillAddressRequireFirstName
                Me.chkBillRequireLastName.Checked = WebAppSettings.BillAddressRequireLastName
                Me.chkBillRequirePhone.Checked = WebAppSettings.BillAddressRequirePhone
                Me.chkBillRequireWebSiteURL.Checked = WebAppSettings.BillAddressRequireWebSiteURL

                Me.chkShipShowMiddleInitial.Checked = WebAppSettings.ShipAddressShowMiddleInitial
                Me.chkShipShowCompany.Checked = WebAppSettings.ShipAddressShowCompany
                Me.chkShipShowPhoneNumber.Checked = WebAppSettings.ShipAddressShowPhone
                Me.chkShipShowFaxNumber.Checked = WebAppSettings.ShipAddressShowFax
                Me.chkShipShowWebSiteURL.Checked = WebAppSettings.ShipAddressShowWebSiteURL
                Me.chkShipRequireCompany.Checked = WebAppSettings.ShipAddressRequireCompany
                Me.chkShipRequireFax.Checked = WebAppSettings.ShipAddressRequireFax
                Me.chkShipRequireFirstName.Checked = WebAppSettings.ShipAddressRequireFirstName
                Me.chkShipRequireLastName.Checked = WebAppSettings.ShipAddressRequireLastName
                Me.chkShipRequirePhone.Checked = WebAppSettings.ShipAddressRequirePhone
                Me.chkShipRequireWebSiteURL.Checked = WebAppSettings.ShipAddressRequireWebSiteURL


            Catch Ex As Exception
                msg.ShowException(Ex)

            End Try
        End If
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        msg.ClearMessage()

        Try
            WebAppSettings.BillAddressShowMiddleInitial = Me.chkBillShowMiddleInitial.Checked
            WebAppSettings.BillAddressShowCompany = Me.chkBillShowCompany.Checked
            WebAppSettings.BillAddressShowPhone = Me.chkBillShowPhoneNumber.Checked
            WebAppSettings.BillAddressShowFax = Me.chkBillShowFaxNumber.Checked
            WebAppSettings.BillAddressShowWebSiteUrl = Me.chkBillShowWebSiteURL.Checked
            WebAppSettings.BillAddressRequireCompany = Me.chkBillRequireCompany.Checked
            WebAppSettings.BillAddressRequireFax = Me.chkBillRequireFax.Checked
            WebAppSettings.BillAddressRequireFirstName = Me.chkBillRequireFirstName.Checked
            WebAppSettings.BillAddressRequireLastName = Me.chkBillRequireLastName.Checked
            WebAppSettings.BillAddressRequirePhone = Me.chkBillRequirePhone.Checked
            WebAppSettings.BillAddressRequireWebSiteURL = Me.chkBillRequireWebSiteURL.Checked

            WebAppSettings.ShipAddressShowMiddleInitial = Me.chkShipShowMiddleInitial.Checked
            WebAppSettings.ShipAddressShowCompany = Me.chkShipShowCompany.Checked
            WebAppSettings.ShipAddressShowPhone = Me.chkShipShowPhoneNumber.Checked
            WebAppSettings.ShipAddressShowFax = Me.chkShipShowFaxNumber.Checked
            WebAppSettings.ShipAddressShowWebSiteURL = Me.chkShipShowWebSiteURL.Checked
            WebAppSettings.ShipAddressRequireCompany = Me.chkShipRequireCompany.Checked
            WebAppSettings.ShipAddressRequireFax = Me.chkShipRequireFax.Checked
            WebAppSettings.ShipAddressRequireFirstName = Me.chkShipRequireFirstName.Checked
            WebAppSettings.ShipAddressRequireLastName = Me.chkShipRequireLastName.Checked
            WebAppSettings.ShipAddressRequirePhone = Me.chkShipRequirePhone.Checked
            WebAppSettings.ShipAddressRequireWebSiteURL = Me.chkShipRequireWebSiteURL.Checked
            msg.ShowOk("Settings saved successfully.")
        Catch Ex As Exception
            msg.ShowException(Ex)
            EventLog.LogEvent(Ex)
        End Try

    End Sub

End Class
