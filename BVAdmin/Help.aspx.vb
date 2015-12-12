Imports BVSoftware.Commerce.Branding

Partial Class BVAdmin_Help
    Inherits BaseAdminPage

    Protected Sub BVAdmin_Help_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim brand As IBVBranding = TaskLoader.Brand()
        'Dim def As IBVBranding = New BVSoftware.Commerce.Branding.Default()

        'If (brand IsNot Nothing) Then
        'lnkSupport.NavigateUrl = brand.SupportWebSite
        'lnkSupport.Text = brand.SupportWebSite

        'If (brand.UserManualLink <> String.Empty) Then
        'lnkManual.NavigateUrl = brand.UserManualLink
        'Else
        'lnkManual.NavigateUrl = def.UserManualLink
        'End If

        'If (brand.SupportPhoneNumber().Trim() <> String.Empty) Then
        'liPhone.Visible = True
        'litPhone.Text = brand.SupportPhoneNumber
        'Else
        'liPhone.Visible = False
        'End If
        'End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Help"
        Me.CurrentTab = AdminTabType.None
    End Sub


End Class
