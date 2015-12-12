Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Default
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Pick an Option"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

End Class
