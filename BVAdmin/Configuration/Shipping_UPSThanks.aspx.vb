Imports BVSoftware.BVC5.Core

Partial Class BVAdmin_Configuration_Shipping_UPSThanks
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "UPS Online Tools Registration"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub btnContinue_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnContinue.Click
        Response.Redirect("Shipping.aspx", True)
    End Sub

End Class
