Imports BVSoftware.Bvc5.Core
Imports System.Data
Imports System.Collections.ObjectModel

Partial Class BVModules_ContentBlocks_Order_Activity_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            LoadOrders()
        End If

    End Sub

    Private Sub LoadOrders()

        Dim s As String = String.Empty

        s = SettingsManager.GetSetting("Status")

        Select Case s
            Case "Payment"
                LoadPaymentStatus()
            Case "Shipping"
                LoadShippingStatus()
            Case "Other"
                LoadOtherStatus()
        End Select

    End Sub

    Public Sub LoadPaymentStatus()

        Dim c As New Orders.OrderSearchCriteria

        Dim v As String = String.Empty
        v = SettingsManager.GetSetting("Value")

        Me.Title.Text = "Last 10 Orders with Payment Status: " & v.ToString

        Select Case v
            Case "Unknown"
                c.PaymentStatus = Orders.OrderPaymentStatus.Unknown
            Case "Unpaid"
                c.PaymentStatus = Orders.OrderPaymentStatus.Unpaid
            Case "PartiallyPaid"
                c.PaymentStatus = Orders.OrderPaymentStatus.PartiallyPaid
            Case "Paid"
                c.PaymentStatus = Orders.OrderPaymentStatus.Paid
            Case "Overpaid"
                c.PaymentStatus = Orders.OrderPaymentStatus.Overpaid

        End Select

        Dim found As New Collection(Of Orders.Order)
        found = Orders.Order.FindByCriteria(c)

        Dim newFound As New Collection(Of Orders.Order)
        Dim i As Integer = 0

        If found.Count > 10 Then
            While i < 10
                newFound.Add(found.Item(i))
                i += 1
            End While
        Else
            Dim f As Integer = 0
            While f < found.Count
                newFound.Add(found.Item(f))
                f += 1
            End While
        End If

        Me.OrderActivityDataList.DataSource = newFound
        Me.OrderActivityDataList.DataBind()
        Me.OrderActivityDataList.RepeatDirection = SettingsManager.GetIntegerSetting("DisplayTypeRad")

        If SettingsManager.GetIntegerSetting("DisplayTypeRad") = 1 Then
            Me.OrderActivityDataList.RepeatColumns = 1
        Else
            Me.OrderActivityDataList.RepeatColumns = SettingsManager.GetIntegerSetting("GridColumnsField")
        End If

    End Sub

    Public Sub LoadShippingStatus()

        Dim c As New Orders.OrderSearchCriteria
        Dim v As String = String.Empty
        v = SettingsManager.GetSetting("Value")

        Me.Title.Text = "Last 10 Orders with Shipping Status: " & v.ToString

        Select Case v
            Case "Unknown"
                c.ShippingStatus = Orders.OrderShippingStatus.Unknown
            Case "Unshipped"
                c.ShippingStatus = Orders.OrderShippingStatus.Unshipped
            Case "PartiallyShipped"
                c.ShippingStatus = Orders.OrderShippingStatus.PartiallyShipped
            Case "FullyShipped"
                c.ShippingStatus = Orders.OrderShippingStatus.FullyShipped
            Case "NonShipping"
                c.ShippingStatus = Orders.OrderShippingStatus.NonShipping

        End Select

        Dim found As New Collection(Of Orders.Order)
        found = Orders.Order.FindByCriteria(c)

        Dim newFound As New Collection(Of Orders.Order)
        Dim i As Integer = 0

        If found.Count > 10 Then
            While i < 10
                newFound.Add(found.Item(i))
                i += 1
            End While
        Else
            Dim f As Integer = 0
            While f < found.Count
                newFound.Add(found.Item(f))
                f += 1
            End While
        End If

        Me.OrderActivityDataList.DataSource = newFound
        Me.OrderActivityDataList.DataBind()
        Me.OrderActivityDataList.RepeatDirection = SettingsManager.GetIntegerSetting("DisplayTypeRad")

        If SettingsManager.GetIntegerSetting("DisplayTypeRad") = 1 Then
            Me.OrderActivityDataList.RepeatColumns = 1
        Else
            Me.OrderActivityDataList.RepeatColumns = SettingsManager.GetIntegerSetting("GridColumnsField")
        End If

    End Sub

    Public Sub LoadOtherStatus()

        Dim c As New Orders.OrderSearchCriteria
        Dim v As String = SettingsManager.GetSetting("OtherStatusBvin")

        Dim o As Orders.OrderStatusCode = Orders.OrderStatusCode.FindByBvin(v)

        c.StatusCode = v

        Dim found As New Collection(Of Orders.Order)
        found = Orders.Order.FindByCriteria(c)

        If found.Count = 0 Then
            Me.Title.Text = "No Orders Found"
        Else
            Me.Title.Text = "Last 10 Orders with Status: " & o.StatusName
            Dim newFound As New Collection(Of Orders.Order)
            Dim i As Integer = 0

            If found.Count > 10 Then
                While i < 10
                    newFound.Add(found.Item(i))
                    i += 1
                End While
            Else
                Dim f As Integer = 0
                While f < found.Count
                    newFound.Add(found.Item(f))
                    f += 1
                End While
            End If


            Me.OrderActivityDataList.DataSource = newFound
            Me.OrderActivityDataList.DataBind()
            Me.OrderActivityDataList.RepeatDirection = SettingsManager.GetIntegerSetting("DisplayTypeRad")

            If SettingsManager.GetIntegerSetting("DisplayTypeRad") = 1 Then
                Me.OrderActivityDataList.RepeatColumns = 1
            Else
                Me.OrderActivityDataList.RepeatColumns = SettingsManager.GetIntegerSetting("GridColumnsField")
            End If

        End If

    End Sub

    Protected Sub OrderActivityDataList_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles OrderActivityDataList.ItemCommand
        If e.CommandName = "Go" Then
            Dim OrderID As String = e.CommandArgument.ToString
            Response.Redirect("~/BVAdmin/Orders/ViewOrder.aspx?id=" & OrderID & "")
        End If
    End Sub
End Class
