Imports BVSoftware.Bvc5.Core
Imports System.Xml
Imports System.IO
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Configuration_Security
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Security Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If WebAppSettings.ConnectionString.ToLower().Contains("demosite") Then
            sslWarningTr.Visible = True
        End If

        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If
            'Me.CryptographyKey3DESField.Text = WebAppSettings.Cryptography3DesKey
            Me.SiteStandardRoot.Text = WebAppSettings.SiteStandardRoot
            Me.SecureSiteRoot.Text = WebAppSettings.SiteSecureRoot
            Me.chkUseSSL.Checked = WebAppSettings.UseSsl
            Me.CookieDomainTextBox.Text = WebAppSettings.CookieDomain
            Me.CookiePathTextBox.Text = WebAppSettings.CookiePath
            Me.DifferentTLDCheckBox.Checked = WebAppSettings.SiteRootsOnDifferentTLDs
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            Me.msg.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean

        msg.ClearMessage()

        Try

            'WebAppSettings.Cryptography3DesKey = Me.CryptographyKey3DESField.Text.Trim
            WebAppSettings.UseSsl = Me.chkUseSSL.Checked

            ' Save Standard Root
            Dim tempStandardURL As String = String.Empty
            tempStandardURL = SiteStandardRoot.Text.Trim()
            If tempStandardURL.EndsWith("/") = False Then
                tempStandardURL += "/"
            End If

            ' Save Secure Root
            Dim tempSecureURL As String = String.Empty
            tempSecureURL = SecureSiteRoot.Text.Trim()
            If tempSecureURL.EndsWith("/") = False Then
                tempSecureURL += "/"
            End If

            WebAppSettings.SiteStandardRoot = tempStandardURL
            WebAppSettings.SiteSecureRoot = tempSecureURL

            'If WriteWebConfigSetting(tempStandardURL, tempSecureURL) = True Then
            '    msg.ShowOk("Changes Saved")
            'End If

            WebAppSettings.CookieDomain = Me.CookieDomainTextBox.Text.Trim
            WebAppSettings.CookiePath = Me.CookiePathTextBox.Text

            WebAppSettings.SiteRootsOnDifferentTLDs = Me.DifferentTLDCheckBox.Checked


            msg.ShowOk("Changes Saved")
        Catch Ex As Exception
            msg.ShowException(Ex)
            EventLog.LogEvent(Ex)
        End Try
    End Function

    'Private Function WriteWebConfigSetting(ByVal standardURL As String, ByVal secureURL As String) As Boolean
    '    Dim result As Boolean = False

    '    Dim installFolder As String = Request.PhysicalApplicationPath

    '    Dim configFilePath As String = Path.Combine(installFolder, "web.config")

    '    Dim settings As New XmlDocument
    '    settings.Load(configFilePath)
    '    Dim root As XmlNode = settings.DocumentElement

    '    Dim appNodes As XmlNodeList
    '    appNodes = root.SelectNodes("//appSettings/add")

    '    For Each xnode As XmlNode In appNodes
    '        If xnode.Attributes("key").Value = "SiteStandardURL" Then
    '            xnode.Attributes("value").Value = standardURL
    '        End If
    '        If xnode.Attributes("key").Value = "SiteSecureURL" Then
    '            xnode.Attributes("value").Value = secureURL
    '        End If
    '    Next

    '    Try
    '        settings.Save(configFilePath)
    '        result = True
    '    Catch iex As IOException
    '        result = False
    '        msg.ShowError(iex.Message)
    '        msg.Text += "<br> The system was unable to update the web.config file. This may be due to lack of permissions for the ASPNET account. You will need to manually update the connection string setting in your web.config file."
    '    Catch ex As Exception
    '        result = False
    '        msg.ShowException(ex)
    '        msg.Text += "<br> The system was unable to update the web.config file. This may be due to lack of permissions for the ASPNET account. You will need to manually update the connection string setting in your web.config file."
    '    End Try

    '    settings = Nothing

    '    Return result
    'End Function

    Protected Sub btnNewMasterKey_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewMasterKey.Click

        Dim keyLocation As String = HttpContext.Current.Server.MapPath("~/bin")
        Dim masterKeyLocation As String = WebAppSettings.EncryptionKeyLocation

        Dim manager As New BVSoftware.Cryptography.KeyManager(keyLocation, masterKeyLocation, String.Empty)
        manager.LoadKeyJsonFromDisk()
        If (manager.ReplaceMasterKey()) Then
            Application("EncryptionKeys") = manager.LoadKeyJsonFromDisk()
            Me.msg.ShowOk("Master Encryption Key has been Replaced")
        Else
            Me.msg.ShowWarning("Unable to replace master encryption key")
        End If

    End Sub

    Protected Sub btnReloadEncryptionKeys_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReloadEncryptionKeys.Click
        Dim keyLocation As String = HttpContext.Current.Server.MapPath("~/bin")
        Dim masterKeyLocation As String = WebAppSettings.EncryptionKeyLocation

        Dim manager As New BVSoftware.Cryptography.KeyManager(keyLocation, masterKeyLocation, String.Empty)
        Application("EncryptionKeys") = manager.LoadKeyJsonFromDisk()

        AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, _
                          BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success, _
                          "Encryption Keys Reloaded", _
                          "Encryption keys were reloaded from disk")

        Me.msg.ShowOk("Encryption keys reloaded!")
    End Sub

    Protected Sub btnNewKey_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewKey.Click

        Dim keyLocation As String = HttpContext.Current.Server.MapPath("~/bin")
        Dim masterKeyLocation As String = WebAppSettings.EncryptionKeyLocation

        Dim manager As New BVSoftware.Cryptography.KeyManager(keyLocation, masterKeyLocation, String.Empty)
        manager.LoadKeyJsonFromDisk()
        If (manager.GenerateNewKey()) Then
            Application("EncryptionKeys") = manager.LoadKeyJsonFromDisk()
            Me.msg.ShowOk("Encryption Key Generated")
            ReplaceOldKeys()
            AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, _
                          BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success, _
                          "New Encryption Key", _
                          "A new encryption keys was generated and old items were updated")
        Else
            Me.msg.ShowWarning("Unable to create new key")
        End If
    End Sub

    Protected Sub btnCheckForOldKeys_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCheckForOldKeys.Click
        ReplaceOldKeys()
    End Sub

    Private Sub ReplaceOldKeys()
        Dim totalCount As Integer = 0
        Dim oldPayments As Collection(Of Orders.OrderPayment) = Orders.OrderPayment.FindWithOldEncryption()
        If (oldPayments IsNot Nothing) Then
            totalCount = oldPayments.Count
            For Each op As Orders.OrderPayment In oldPayments
                Orders.OrderPayment.Update(op)
            Next
        End If

        Me.msg.ShowOk("Updated " & totalCount.ToString() & " old encrypted items")
        AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, _
                          BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success, _
                          "Encryption Key Update", _
                          "Old items were updated to the latest encryption key")
    End Sub

End Class
