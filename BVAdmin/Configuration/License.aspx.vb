Imports BVSoftware.Bvc5.Core
Imports BvLicensing
Imports System.IO
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Configuration_License
    Inherits System.Web.UI.Page

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.Page.Title = "License"
        Session("ActiveAdminTab") = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Public Sub ValidateCurrentUserHasPermission(ByVal p As String)
        Dim l As New Collection(Of String)
        l.Add(p)
        ValidateCurrentUserHasPermissions(l)
    End Sub

    Public Sub ValidateCurrentUserHasPermissions(ByVal p As Collection(Of String))
        If SessionManager.IsUserAuthenticated = False Then
            ' Send to Login Page
            Response.Redirect("~/BVAdmin/Login.aspx?ReturnUrl=" & HttpUtility.UrlEncode(Me.Request.RawUrl))
        Else
            If Membership.UserAccount.DoesUserHaveAllPermissions(SessionManager.GetCurrentUserId, p) = False Then
                ' Send to no permissions page
                Response.Redirect("~/nopermissions.aspx")
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnUploadLicense.Enabled = False
            End If
            CheckLicense()
        End If
    End Sub

    Private Sub CheckLicense()
        Dim data As String = WebAppSettings.LicenseData
        If data.Trim.Length < 1 Then
            msg.ShowInformation("No license is installed. Please upload your license using the form below.")
            Exit Sub
        End If

        Dim l As New LicenseKey
        l.LoadFromString(WebAppSettings.LicenseData)

        If l.LicenseVersion = String.Empty Then
            Me.LicenseVersionField.Text = "Invalid Data"
        Else
            Me.LicenseVersionField.Text = l.LicenseVersion
        End If

        If l.ProductName = String.Empty Then
            Me.ProductNameField.Text = "Invalid Data"
        Else
            Me.ProductNameField.Text = TaskLoader.Brand.ApplicationName
        End If
        If l.ProductVersion = String.Empty Then
            Me.ProductVersionField.Text = "Invalid Data"
        Else
            Me.ProductVersionField.Text = l.ProductVersion
        End If
        If l.ProductType = String.Empty Then
            Me.ProductTypeField.Text = "Invalid Data"
        Else
            Me.ProductTypeField.Text = l.ProductType
        End If

        If l.CustomerName = String.Empty Then
            Me.CustomerNameField.Text = "Invalid Data"
        Else
            Me.CustomerNameField.Text = l.CustomerName
        End If
        If l.CustomerEmail = String.Empty Then
            Me.CustomerEmailField.Text = "Invalid Data"
        Else
            Me.CustomerEmailField.Text = l.CustomerEmail
        End If
        If l.WebSite = String.Empty Then
            Me.WebSiteField.Text = ""
        Else
            Me.WebSiteField.Text = l.WebSite
        End If
        If l.SerialNumber = String.Empty Then
            Me.SerialNumberField.Text = "Invalid Data"
        Else
            Me.SerialNumberField.Text = l.SerialNumber
        End If
        If l.Perpetual = True Then
            Me.lblExpires.Text = "Never"
        Else
            Me.lblExpires.Text = l.Expires.ToString
        End If

        If l.IsValid = True Then
            msg.ShowOk("License appears to be valid.")
        Else
            If l.IsExpired = True Then
                msg.ShowError(String.Format("License has expired. <a href=""{0}"">Contact BV Commerce</a> for assistance.", TaskLoader.Brand().SupportWebSite))
            Else
                msg.ShowError(String.Format("License does not appear to be valid. Contact <a href=""{0}"">BV Commerce</a> for assistance.", TaskLoader.Brand().SupportWebSite))
            End If
        End If
    End Sub

    Protected Sub btnUploadLicense_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUploadLicense.Click
        If Me.FileUpload1.FileName.Trim.Length > 0 Then
            Dim sr As New StreamReader(Me.FileUpload1.PostedFile.InputStream)
            Dim output As String = sr.ReadToEnd()
            WebAppSettings.LicenseData = output
            Response.Redirect("~/BVAdmin/Configuration/License.aspx")
        End If        
    End Sub

End Class
