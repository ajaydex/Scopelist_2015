Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

' mostly copied from /BVAdmin/Orders/Default.ascx.vb
Partial Class BVModules_ImportExport_OrderExport_Export
    Inherits ImportExport.ExportTemplate

    Public Overrides Sub ApplyFormSettings(export As ImportExport.BaseExport)
        Dim orderExport As ImportExport.OrdersData.OrderExport = DirectCast(export, ImportExport.OrdersData.OrderExport)
        orderExport.Criteria = Me.GetCriteria()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            PopulateStatusCodes()
            LoadLastSearchValues()
        End If
    End Sub

    Private Sub LoadLastSearchValues()
        Me.FilterField.Text = SessionManager.AdminOrderSearchKeyword.Trim

        SetListToValue(Me.PaymentFilterField, SessionManager.AdminOrderSearchPaymentFilter)
        SetListToValue(Me.ShippingFilterField, SessionManager.AdminOrderSearchShippingFilter)
        SetListToValue(Me.StatusFilterField, SessionManager.AdminOrderSearchStatusFilter)
        Me.DateRangeField.RangeType = SessionManager.AdminOrderSearchDateRange
        If Me.DateRangeField.RangeType = Utilities.DateRangeType.Custom Then
            Me.DateRangeField.StartDate = SessionManager.AdminOrderSearchStartDate
            Me.DateRangeField.EndDate = SessionManager.AdminOrderSearchEndDate
        End If
    End Sub

    Private Sub PopulateStatusCodes()
        Dim any As New Orders.OrderStatusCode
        any.Bvin = String.Empty
        any.StatusName = "- Any -"

        Dim codes As Collection(Of Orders.OrderStatusCode) = Orders.OrderStatusCode.FindAll
        codes.Insert(0, any)

        Me.StatusFilterField.DataSource = codes
        Me.StatusFilterField.DataTextField = "StatusName"
        Me.StatusFilterField.DataValueField = "bvin"
        Me.StatusFilterField.DataBind()
    End Sub

    Private Function GetCriteria() As Orders.OrderSearchCriteria
        Dim c As New Orders.OrderSearchCriteria
        c.Keyword = Me.FilterField.Text.Trim
        c.KeywordIsExact = Me.KeywordIsExact.Checked
        c.StatusCode = Me.StatusFilterField.SelectedValue
        c.PaymentStatus = CType(Me.PaymentFilterField.SelectedValue, Integer)
        c.ShippingStatus = CType(Me.ShippingFilterField.SelectedValue, Integer)
        c.IsPlaced = Boolean.Parse(Me.IsPlaced.SelectedValue)
        c.StartDate = Me.DateRangeField.StartDate
        c.EndDate = Me.DateRangeField.EndDate

        Return c
    End Function

    Private Sub SetListToValue(ByVal l As DropDownList, ByVal value As String)
        If l IsNot Nothing Then
            If l.Items.FindByValue(value) IsNot Nothing Then
                l.ClearSelection()
                l.Items.FindByValue(value).Selected = True
            End If
        End If
    End Sub

End Class