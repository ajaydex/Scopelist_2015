Imports BVSoftware.Bvc5.Core
Imports System.Data
Imports System.IO
Imports System.Text
Imports System

Partial Class BVAdmin_Configuration_VersionInfo
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "About"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Configuration
            Me.ToField.Text = TaskLoader.Brand.SupportEmail
            LoadVersionInfo()
        End If
    End Sub

    Private Sub LoadVersionInfo()
        Dim sb As New StringBuilder

        sb.Append("<ul class=""bulletList"">")


        Dim fileList As String()
        Dim sourcePath As String = Path.Combine(Request.PhysicalApplicationPath, "bin/")
        fileList = Directory.GetFiles(sourcePath)

        For i As Integer = 0 To fileList.Length - 1
            Try

                If Path.GetExtension(fileList(i)).ToLower = ".dll" Then
                    Dim ver As Diagnostics.FileVersionInfo
                    ver = Diagnostics.FileVersionInfo.GetVersionInfo(sourcePath & Path.GetFileName(fileList(i)))
                    If Not ver Is Nothing Then
                        sb.Append("<li>")
                        If ver.ProductVersion IsNot Nothing Then
                            sb.Append(BVSoftware.Web.Text.PadString(ver.ProductVersion, 20, "."))
                        Else
                            sb.Append(BVSoftware.Web.Text.PadString("No Version Info", 20, "."))
                        End If
                        sb.Append(Path.GetFileName(fileList(i)))
                        sb.Append("</li>")
                    End If
                End If
            Catch ex As Exception
                EventLog.LogEvent(ex)
            End Try
        Next

        sb.Append("</ul>")
        Me.lblVersion.Text = sb.ToString

        Me.lblApplicationVersion.Text = Utilities.EnumToString.Versions(Utilities.VersionHelper.GetCurrentCodeVersion())
        Me.lblDatabaseVersion.Text = Utilities.EnumToString.Versions(Utilities.VersionHelper.GetHighestSqlVersionNumber())

    End Sub

    Private Sub ImageButton1_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        msg.ClearMessage()
        SendVersionmail()
        msg.ShowOk("Mail Sent to " & Me.ToField.Text.Trim)
    End Sub

    Private Function SendVersionmail() As Boolean

        Try

            Dim sb As New StringBuilder

            sb.Append("Version Information Mail" & vbNewLine)
            sb.Append("====================================================" & vbNewLine)
            sb.Append(vbNewLine)
            sb.Append("Notes:" & vbNewLine)
            sb.Append(Me.NotesField.Text.Trim & vbNewLine)
            sb.Append(vbNewLine)
            Dim vinfo As String = Me.lblVersion.Text.Trim
            vinfo = vinfo.Replace("<ul>", "")
            vinfo = vinfo.Replace("<li>", "")
            vinfo = vinfo.Replace("</li>", vbNewLine)
            sb.Append(vinfo & vbNewLine)
            sb.Append(vbNewLine)
            If Me.chkIncludeURLs.Checked = True Then
                sb.Append("Site Standard URL = " & WebAppSettings.SiteStandardRoot & vbNewLine & vbNewLine)
                sb.Append("Site Secure URL = " & WebAppSettings.SiteSecureRoot & vbNewLine & vbNewLine)
                'sb.Append("Use SSL = " & WebAppSettings.UseSSL.ToString & vbNewLine & vbNewLine)
                sb.Append(vbNewLine)
            End If
            If Me.chkIncludeConnectionString.Checked = True Then
                sb.Append("ConnectionString = " & WebAppSettings.ConnectionString & vbNewLine)
                sb.Append(vbNewLine)
            End If
            If Me.chkIncludeWebAppSettings.Checked = True Then
                sb.Append(vbNewLine)
                sb.Append("Web App Settings" & vbNewLine)
                sb.Append("-------------------------------------------------------" & vbNewLine)
                Dim info As Data.DataTable = WebAppSettings.ToDataTable
                If Not info Is Nothing Then
                    For i As Integer = 0 To info.Rows.Count - 1
                        sb.Append(info.Rows(i).Item("SettingName") & " = " & info.Rows(i).Item("SettingValue") & vbNewLine)
                        sb.Append("-------------------------------" & vbNewLine)
                    Next
                End If
                info = Nothing
            End If

            Dim m As New System.Net.Mail.MailMessage(Me.FromField.Text, Me.ToField.Text)
            m.IsBodyHtml = False
            m.Subject = Me.SubjectField.Text.Trim
            m.Body = sb.ToString

            Return Utilities.MailServices.SendMail(m)
        Catch ex As Exception
            msg.ShowException(ex)
            EventLog.LogEvent(ex)
            Return False
        End Try

    End Function
End Class
