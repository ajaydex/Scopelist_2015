Imports BVSoftware.Bvc5.Core
Imports System.Linq
Imports System.Data.DataTableExtensions

Partial Class BVAdmin_Reports_Products
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Sales By Product"
        Me.CurrentTab = AdminTabType.Reports
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ReportsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadProducts()
        End If
    End Sub

    Protected Sub btnSkuFilter_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSkuFilter.Click
        LoadProducts()
    End Sub

    Private Sub LoadProducts()

        Dim s As String = Me.DateRangeField.StartDate
        Dim e As String = Me.DateRangeField.EndDate

        Dim t As Data.DataTable = Catalog.InternalProduct.FindTotalProductsOrderedAdmin(s, e)
        If txtSkuFilter.Text <> String.Empty Then
            Dim query = t.AsEnumerable().Where(Function(r) r("SKU").ToString().ToUpper().Contains(txtSkuFilter.Text.ToUpper()))
            If query IsNot Nothing AndAlso query.Count() > 0 Then
                t = query.CopyToDataTable()
            Else
                t = New Data.DataTable
            End If
        End If

        If t.Rows.Count = 0 Then
            Me.lblResults.Text = "No Products Found"
        ElseIf t.Rows.Count = 1 Then
            Me.lblResults.Text = t.Rows.Count & " product found"
        ElseIf t.Rows.Count > 1 Then
            Me.lblResults.Text = t.Rows.Count & " products found"
        End If

        Me.GridView1.DataSource = t
        Me.GridView1.DataBind()

    End Sub

    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        GridView1.PageIndex = e.NewPageIndex
        LoadProducts()
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("~/BVAdmin/Catalog/Products_Edit.aspx?id=" & bvin)
    End Sub

    Protected Sub DateRangeField_RangeTypeChanged(ByVal e As System.EventArgs) Handles DateRangeField.RangeTypeChanged
        If DateRangeField.RangeType <> Utilities.DateRangeType.Custom Then
            LoadProducts()
        End If

        If DateRangeField.RangeType = Utilities.DateRangeType.Custom Then
            btnShow.Visible = True
        End If
    End Sub

    Private Sub btnShow_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShow.Click
        GridView1.PageIndex = 0
        Dim sDate As String = Me.DateRangeField.StartDate
        Dim eDate As String = Me.DateRangeField.EndDate
        LoadProducts()
    End Sub

End Class