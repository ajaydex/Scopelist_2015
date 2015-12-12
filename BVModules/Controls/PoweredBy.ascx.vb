Imports BVSoftware.Commerce.Branding

Partial Class BVModules_Controls_PoweredBy
    Inherits System.Web.UI.UserControl

    Protected Sub BVModules_Controls_PoweredBy_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim brand As IBVBranding = TaskLoader.Brand
            Dim def As New BVSoftware.Commerce.Branding.Default()
            If (brand.CompanyName <> def.CompanyName) Then
                Me.lnkCompany.Visible = True
                Me.lnkCompany.NavigateUrl = brand.CompanyWebSite
                Me.lnkCompany.Target = "_blank"
                Me.lnkCompany.Text = brand.ApplicationName & " powered by "
            Else
                Me.lnkCompany.Visible = False
            End If
        End If
    End Sub
End Class
