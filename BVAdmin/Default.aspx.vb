Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Default
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (WebAppSettings.LicenseData.Trim().Length > 0) Then
            Dim LicenseExpirationDate As DateTime = SessionManager.GetLicenseExpiration()
            Dim expireDays As Integer = Math.Floor((LicenseExpirationDate - DateTime.Now).TotalDays)
            If expireDays < 30 AndAlso expireDays > -1 Then
                MessageBox1.ShowWarning("Your license will expire in " & expireDays & " days. Please <a href=""http://www.bvcommerce.com/contactus.aspx"">contact BV Commerce</a> for an updated license.")
            End If
        End If

        If Not SessionManager.IsLicenseValid() Then
            MessageBox1.ShowInformation("No License Installed. Store is running in Lite mode and is limited to 10 products.")
            MessageBox1.ShowInformation("<a href=""" & TaskLoader.Brand.CompanyWebSite & """>Purchase a License</a>&nbsp;|&nbsp;<a href=""Configuration/License.aspx"">Install a Purchased License</a>.")
        End If
        

    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Dashboard"
        Me.CurrentTab = AdminTabType.Dashboard
    End Sub

End Class
