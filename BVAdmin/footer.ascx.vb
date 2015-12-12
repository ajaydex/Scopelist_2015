Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Commerce.Branding

Partial Class BVAdmin_footer
    Inherits System.Web.UI.UserControl

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            LoadCopyright()
            LoadVersion()
        End If
    End Sub

    Protected Sub LoadCopyright()
        Dim brand As IBVBranding = TaskLoader.Brand()
        If (brand Is Nothing) Then
            brand = New BVSoftware.Commerce.Branding.Default()
        End If
        Me.lblCopyright.Text = "© Copyright " & DateTime.Now.Year.ToString & " " & brand.CompanyName
        Dim def As New BVSoftware.Commerce.Branding.Default()
        If (brand.CompanyName <> def.CompanyName) Then
            Me.lblCopyright.Text += ", " & def.CompanyName
        End If
        Me.lblCopyright.Text += ", All Rights Reserved"
    End Sub

    Sub LoadVersion()
        lblVersion.Text = TaskLoader.Brand.ApplicationName & " " & WebAppSettings.BvcVersionNumber
    End Sub

End Class