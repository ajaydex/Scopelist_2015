Imports BVSoftware.Bvc5.Core
Imports System.Data

Partial Class BVAdmin_Reports_SearchKeywords
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            RunReport()
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Keyword Searches"
        Me.CurrentTab = AdminTabType.Reports
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ReportsView)
    End Sub

    Private Sub RunReport()

        Dim reportData As System.Data.DataTable = Metrics.SearchQuery.FindQueryCountReport()

        AddPercentages(reportData)

        Me.GridView1.DataSource = reportData
        Me.GridView1.DataBind()
    End Sub

    Private Sub AddPercentages(ByRef dt As DataTable)
        If dt IsNot Nothing Then
            dt.Columns.Add(New DataColumn("Percentage", Type.GetType("System.Decimal")))

            Dim totalSearches As Integer = 0
            For i As Integer = 0 To dt.Rows.Count - 1
                totalSearches = totalSearches + CType(dt.Rows(i).Item("QueryCount"), Integer)
            Next

            For k As Integer = 0 To dt.Rows.Count - 1
                Dim percent As Decimal = (CType(dt.Rows(k).Item("QueryCount"), Decimal) / CType(totalSearches, Decimal)) * 100D
                dt.Rows(k).Item("Percentage") = Math.Round(percent, 2)
            Next
        End If
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim percent As Decimal = e.Row.Cells(2).Text.TrimEnd("%".ToCharArray)
            '= e.Row.DataItem Eval("QueryCount")
            Dim imgBar As System.Web.UI.WebControls.Image
            imgBar = e.Row.FindControl("imgBar")
            If imgBar IsNot Nothing Then
                imgBar.AlternateText = percent.ToString & "%"
                Dim w As Integer = CType(Math.Floor(percent), Integer) * 3
                If w < 1 Then
                    w = 1
                End If
                imgBar.Width = w
            End If
        End If
    End Sub

    Protected Sub btnReset_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnReset.Click
        Metrics.SearchQuery.DeleteAll()
        RunReport()
    End Sub

End Class
