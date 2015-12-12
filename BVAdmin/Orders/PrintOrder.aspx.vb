Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Orders_PrintOrder
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadTemplates()
            LoadOrder()
            LoadMode()
        End If
    End Sub
    Private Sub LoadTemplates()
        Me.TemplateField.DataSource = Content.PrintTemplate.FindAll
        Me.TemplateField.DataTextField = "DisplayName"
        Me.TemplateField.DataValueField = "bvin"
        Me.TemplateField.DataBind()
    End Sub

    Private Sub LoadOrder()
        Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        If o IsNot Nothing Then
            'Me.lblCurrentStatus.Text = o.StatusName
        End If
    End Sub

    Private Sub SetTemplate(ByVal bvin As String)
        If Me.TemplateField.Items.FindByValue(bvin) IsNot Nothing Then
            Me.TemplateField.ClearSelection()
            Me.TemplateField.Items.FindByValue(bvin).Selected = True
        End If
    End Sub

    Private Sub LoadMode()
        If Request.QueryString("mode") IsNot Nothing Then
            Select Case Request.QueryString("mode")
                Case "pack"
                    SetTemplate(WebAppSettings.PrintTemplatePackingSlip)
                    Generate()
                Case "receipt"
                    SetTemplate(WebAppSettings.PrintTemplateAdminReceipt)
                    Generate()
                Case "invoice"
                    SetTemplate(WebAppSettings.PrintTemplateCustomerInvoice)
                    Generate()
                Case Else
                    SetTemplate(WebAppSettings.PrintTemplateCustomerInvoice)
                    Generate()
            End Select
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Print Order"
        Me.CurrentTab = AdminTabType.Orders
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersView)
    End Sub

    'Protected Sub btnPayment_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnPayment.Click
        'Response.Redirect("ReceivePayments.aspx?id=" & Request.QueryString("id"))
    'End Sub

    'Protected Sub btnShipping_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShipping.Click
        'Response.Redirect("ShipOrder.aspx?id=" & Request.QueryString("id"))
    'End Sub

    'Protected Sub btnPrint_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnPrint.Click
        'Response.Redirect("PrintOrder.aspx?id=" & Request.QueryString("id"))
    'End Sub

    'Protected Sub btnDetails_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDetails.Click
        'Response.Redirect("ViewOrder.aspx?id=" & Request.QueryString("id"))
    'End Sub

    'Protected Sub btnOkay_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOkay.Click
        'Response.Redirect("Default.aspx")
    'End Sub

    'Protected Sub btnPreviousStatus_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnPreviousStatus.Click
        'Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        'If o IsNot Nothing Then
            'o.MoveToPreviousStatus()
            'LoadOrder()
        'End If
    'End Sub

    'Protected Sub btnNextStatus_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNextStatus.Click
        'Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        'If o IsNot Nothing Then
            'o.MoveToNextStatus()
            'LoadOrder()
        'End If
    'End Sub

    Protected Sub btnGenerate_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGenerate.Click
        Generate()
    End Sub

    Protected Sub btnContinue_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnContinue.Click
        If Request.QueryString("id").Contains(",") = True Then
            Response.Redirect("default.aspx")
        Else
            Response.Redirect("ViewOrder.aspx?id=" & Request.QueryString("id"))
        End If
    End Sub

    'Protected Sub btnContinue2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnContinue2.Click
        'If Request.QueryString("id").Contains(",") = True Then
            'Response.Redirect("default.aspx")
        'Else
            'Response.Redirect("ViewOrder.aspx?id=" & Request.QueryString("id"))
        'End If
    'End Sub

    Private Sub Generate()
        Dim id As String = Request.QueryString("id")
        Dim os As String() = id.Split(",")
        Me.DataList1.DataSource = os
        Me.DataList1.DataBind()
    End Sub

    Protected Sub DataList1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList1.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
            Dim t As Content.PrintTemplate = Content.PrintTemplate.FindByBvin(Me.TemplateField.SelectedValue)
            If t IsNot Nothing Then
                Dim orderId As String = CStr(e.Item.DataItem)
                Dim o As Orders.Order = Orders.Order.FindByBvin(orderId)
                Dim litTemplate As Literal = e.Item.FindControl("litTemplate")
                If litTemplate IsNot Nothing Then
                    litTemplate.Text = t.ReplacedTemplate(o)
                End If
            End If
        End If
    End Sub

End Class
