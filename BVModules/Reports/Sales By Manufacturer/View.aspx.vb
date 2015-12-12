Imports System.Data

Imports BVSoftware.BVC5.Core


Partial Class BVModules_Reports_Sales_By_Manufacturer_View
    Inherits BaseAdminPage

    Dim qtyTotal As Integer = 0
    Dim grandTotal As Decimal = 0D

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Sales By Manufacturer"
        Me.CurrentTab = AdminTabType.Reports
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ReportsView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack() Then
            Me.ucDateRangeField.RangeType = BVSoftware.Bvc5.Core.Utilities.DateRangeType.ThisMonth
        End If
    End Sub

    Private Sub btnShow_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShow.Click
        Me.gvManufacturers.PageIndex = 0
        Me.bindGrid()
    End Sub

    Private Sub bindGrid()
        Me.ucMessageBox.ClearMessage()

        Dim dt As DataTable = Contacts.Manufacturer.FindTopSellingManufacturers(Me.ucDateRangeField.StartDate, Me.ucDateRangeField.EndDate)
        Me.gvManufacturers.DataSource = dt
        Me.gvManufacturers.DataBind()

        If dt.Rows.Count > 0 Then
            Me.lblResults.Text = String.Format("{0} Manufacturers were found.", dt.Rows.Count.ToString())
        Else
            Me.lblResults.Text = "No Manufacturers were found or the server timed out."
        End If
    End Sub

    Protected Sub gvProductTypes_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs) Handles gvManufacturers.RowDataBound
        Select Case e.Row.RowType
            Case DataControlRowType.DataRow
                Dim dr As DataRowView = CType(e.Row.DataItem, DataRowView)
                qtyTotal += Convert.ToDecimal(dr(1))
                grandTotal += Convert.ToDecimal(dr(2))

            Case DataControlRowType.Footer
                e.Row.Cells(1).Text = String.Format("<strong>{0}</strong>", qtyTotal.ToString("N0"))
                e.Row.Cells(2).Text = String.Format("<strong>{0}</strong>", grandTotal.ToString("C"))

        End Select
    End Sub

End Class