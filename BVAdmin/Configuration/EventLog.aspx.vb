Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Collections.Generic

Partial Class BVAdmin_Configuration_EventLog
    Inherits BaseAdminPage

    Private pageNumber As Integer = 1
    Private pageSize As Integer = 100

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Audit Log"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)        
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadPageNumber()
            LoadMode()
            LoadEvents()
            AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Information, "Audit Log Viewed", "An administrator viewed the audit log.")
        End If
    End Sub

    Private Sub LoadPageNumber()
        Dim p As String = Request.QueryString("p")
        If (p Is Nothing) Then
            p = "1"
        End If
        Integer.TryParse(p, pageNumber)
        If (pageNumber < 1) Then
            pageNumber = 1
        End If
    End Sub
    Private Sub LoadMode()
        Dim m As String = Request.QueryString("m")
        If (m Is Nothing) Then
            m = String.Empty
        End If
        Me.lstFilter.ClearSelection()
        If (Me.lstFilter.Items.FindByValue(m) IsNot Nothing) Then
            Me.lstFilter.Items.FindByValue(m).Selected = True
        End If
    End Sub

    Sub LoadEvents()

        Dim totalCount As Long = 0
        Dim items As List(Of BVSoftware.Commerce.Metrics.AuditLogEntry) = New List(Of BVSoftware.Commerce.Metrics.AuditLogEntry)

        Select Case Me.lstFilter.SelectedItem.Value
            Case ""
                items = AuditLog.FindAllEntries(pageNumber, pageSize, totalCount)
            Case Else
                Dim code As Integer = 0
                Integer.TryParse(Me.lstFilter.SelectedItem.Value, code)
                Dim filter As BVSoftware.Commerce.Metrics.AuditLogSourceModule = BVSoftware.Commerce.Metrics.AuditLogSourceModule.System
                filter = CType(code, BVSoftware.Commerce.Metrics.AuditLogSourceModule)

                items = AuditLog.FindEntriesByFilter(filter, pageNumber, pageSize, totalCount)
        End Select

        RenderItems(items)
        RenderPager(totalCount)
    End Sub

    Private Sub ClearEventsButton_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ClearEventsButton.Click
        AuditLog.ClearOldEntries()
        AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, _
                           BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Information, _
                            "Audit Log Cleared", "Entries older than 1 year were cleared from the audit log.")
        Response.Redirect("EventLog.aspx")        
    End Sub

    Private Sub RenderItems(ByVal items As List(Of BVSoftware.Commerce.Metrics.AuditLogEntry))
        Dim sb As New StringBuilder()

        sb.Append("<table border=""0"" cellspacing=""0"" cellpadding=""0"" width=""100%"" class=""auditLogTable"">")

        sb.Append("<tr>")
        sb.Append("<th>Time (UTC)</th>")
        sb.Append("<th>Module</th>")
        sb.Append("<th>Description</th>")
        sb.Append("<th>Severity</th>")
        sb.Append("<th>User</th>")
        sb.Append("</tr>")

        For Each e As BVSoftware.Commerce.Metrics.AuditLogEntry In items
            sb.Append("<tr class=" & RenderSeverity(e.Severity) & ">")
            sb.Append("<td>" & e.TimeStampUtc.ToString & "</td>")
            sb.Append("<td>" & RenderModule(e.SourceModule) & "</td>")
            sb.Append("<td><a href=""#"" class=""popuplink"">" & e.ShortName & "</a>")
            sb.Append("<div style=""display:none"" class=""popup""><div class=""description"">" & e.Description & "</div>")
            sb.Append("<a href=""#"" class=""popupclose"">Close</a></div></td>")
            sb.Append("<td>" & RenderSeverity(e.Severity) & "</td>")
            If String.IsNullOrEmpty(e.UserId) Then
                sb.Append("<td>" & e.UserIdText & "</td>")
            Else
                sb.Append("<td><a href=""../People/Users_Edit.aspx?id=" & e.UserId & """>" & e.UserIdText & "</a></td>")
            End If
            sb.Append("</tr>")
        Next


        sb.Append("</table>")

        Me.litEvents.Text = sb.ToString()
    End Sub

    Private Sub RenderPager(ByVal count As Long)
        Dim sb As New StringBuilder()
        Dim m As String = Me.lstFilter.SelectedItem.Value

        Dim totalPages As Integer = BVSoftware.Web.Paging.TotalPages(count, pageSize)
        For i As Integer = 1 To totalPages
            If (i = pageNumber) Then
                sb.Append("<strong>" & i.ToString() & "</strong> | ")
            Else
                sb.Append("<a href=""EventLog.aspx?p=" & i.ToString() & "&m=" & m & """>" & i.ToString() & "</a> | ")
            End If
        Next

        Me.litPager.Text = sb.ToString()
    End Sub

    Protected Sub lstFilter_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lstFilter.SelectedIndexChanged
        Dim m As String = Me.lstFilter.SelectedItem.Value
        Response.Redirect("EventLog.aspx?m=" & m)
    End Sub

    Private Function RenderModule(ByVal m As BVSoftware.Commerce.Metrics.AuditLogSourceModule) As String        

        Select Case m
            Case BVSoftware.Commerce.Metrics.AuditLogSourceModule.Catalog
                Return "Catalog"
            Case BVSoftware.Commerce.Metrics.AuditLogSourceModule.General
                Return "General"
            Case BVSoftware.Commerce.Metrics.AuditLogSourceModule.Internal
                Return "BV Internal"
            Case BVSoftware.Commerce.Metrics.AuditLogSourceModule.Marketing
                Return "Marketing"
            Case BVSoftware.Commerce.Metrics.AuditLogSourceModule.Orders
                Return "Orders"
            Case BVSoftware.Commerce.Metrics.AuditLogSourceModule.Payment
                Return "Payment"
            Case BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins
                Return "Plug-Ins"
            Case BVSoftware.Commerce.Metrics.AuditLogSourceModule.Reporting
                Return "Reporting"
            Case BVSoftware.Commerce.Metrics.AuditLogSourceModule.System
                Return "System"
            Case BVSoftware.Commerce.Metrics.AuditLogSourceModule.Users
                Return "Users"
        End Select

        Return "Unknown"
    End Function

    Private Function RenderSeverity(ByVal s As BVSoftware.Commerce.Metrics.AuditLogEntrySeverity) As String
        Select Case s
            Case BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure
                Return "FAIL"
            Case BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Information
                Return "INFO"
            Case BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success
                Return "PASS"
            Case BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Warning
                Return "WARN"
        End Select

        Return "Unknown"
    End Function

End Class
