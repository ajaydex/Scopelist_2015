Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core
Imports System.IO

Partial Class BVModules_ContentBlocks_Order_Activity_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            Me.PreHtmlField.Text = SettingsManager.GetSetting("PreHtml")
            Me.PostHtmlField.Text = SettingsManager.GetSetting("PostHtml")
            Me.GridColumnsField.Text = SettingsManager.GetIntegerSetting("GridColumnsField")
            Me.DisplayTypeRad.SelectedValue = SettingsManager.GetIntegerSetting("DisplayTypeRad")

            If SettingsManager.GetSetting("Status").ToString.Length > 0 Then

                Dim s As String = SettingsManager.GetSetting("Status").ToString
                Dim v As String = SettingsManager.GetSetting("Value").ToString

                Me.lblStatus.Text = s & " > "
                Me.lblValue.Text = v

                If s.ToString.ToLower = "payment" Then
                    Me.ddlStatus.SelectedValue = 1
                ElseIf s.ToString.ToLower = "shipping" Then
                    Me.ddlStatus.SelectedValue = 2
                Else
                    Me.ddlStatus.SelectedValue = 3
                End If

            End If
            PopulateStatusCodes()
        End If

    End Sub

    Protected Sub btnOkay_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOkay.Click
        SettingsManager.SaveSetting("PreHtml", Me.PreHtmlField.Text.Trim, "bvsoftware", "Content Block", "Order Activity")
        SettingsManager.SaveSetting("PostHtml", Me.PostHtmlField.Text.Trim, "bvsoftware", "Content Block", "Order Activity")
        SettingsManager.SaveIntegerSetting("GridColumnsField", Me.GridColumnsField.Text.Trim, "bvsoftware", "Content Block", "Order Activity")
        SettingsManager.SaveIntegerSetting("DisplayTypeRad", Me.DisplayTypeRad.SelectedValue, "bvsoftware", "Content Block", "Order Activity")
        SettingsManager.SaveSetting("Status", Me.ddlStatus.SelectedItem.Text.Trim, "bvsoftware", "Content Block", "Order Activity")
        SettingsManager.SaveSetting("Value", Me.RadioButtonList1.SelectedItem.Text.ToString, "bvsoftware", "Content Block", "Order Activity")

        If ddlStatus.SelectedItem.Text = "Other" Then
            SettingsManager.SaveSetting("OtherStatusBvin", Me.RadioButtonList1.SelectedItem.Value.ToString, "bvsoftware", "Content Block", "Order Activity")
        Else
            SettingsManager.SaveSetting("OtherStatusBvin", "", "bvsoftware", "Content Block", "Order Activity")
        End If

        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("~/BVAdmin/Content/Columns.aspx")
    End Sub

    Private Sub PopulateStatusCodes()

        Select Case ddlStatus.SelectedValue
            Case 1
                LoadPaymentStatus()
            Case 2
                LoadShippingStatus()
            Case 3
                LoadOtherStatus()
        End Select

    End Sub

    Private Sub LoadPaymentStatus()

        Dim i As Integer
        For i = 0 To Me.RadioButtonList1.Items.Count - 1
            Me.RadioButtonList1.Items.Clear()
        Next

        Dim p As Array = Nothing

        p = System.Enum.GetNames(GetType(Orders.OrderPaymentStatus))

        For Each s As String In p
            Me.RadioButtonList1.Items.Add(s)
        Next

        If Me.RadioButtonList1.Items.Count > 0 Then
            Dim s As String = SettingsManager.GetSetting("Value").ToString
            If s = "Unknown" Then
                Me.RadioButtonList1.SelectedValue = "Unknown"
            ElseIf s = "Unpaid" Then
                Me.RadioButtonList1.SelectedValue = "Unpaid"
            ElseIf s = "PartiallyPaid" Then
                Me.RadioButtonList1.SelectedValue = "PartiallyPaid"
            ElseIf s = "Paid" Then
                Me.RadioButtonList1.SelectedValue = "Paid"
            ElseIf s = "Overpaid" Then
                Me.RadioButtonList1.SelectedValue = "Overpaid"
            Else
                Me.RadioButtonList1.Items(0).Selected = True
            End If
        End If

    End Sub

    Private Sub LoadShippingStatus()

        Dim i As Integer
        For i = 0 To Me.RadioButtonList1.Items.Count - 1
            Me.RadioButtonList1.Items.Clear()
        Next

        Dim p As Array = Nothing

        p = System.Enum.GetNames(GetType(Orders.OrderShippingStatus))

        For Each s As String In p
            Me.RadioButtonList1.Items.Add(s)
        Next

        If Me.RadioButtonList1.Items.Count > 0 Then
            Dim s As String = SettingsManager.GetSetting("Value").ToString.ToLower
            If s = "UnKnown" Then
                Me.RadioButtonList1.SelectedValue = "UnKnown"
            ElseIf s = "Unshipped" Then
                Me.RadioButtonList1.SelectedValue = "Unshipped"
            ElseIf s = "PartiallyShipped" Then
                Me.RadioButtonList1.SelectedValue = "PartiallyShipped"
            ElseIf s = "FullyShipped" Then
                Me.RadioButtonList1.SelectedValue = "FullyShipped"
            ElseIf s = "NonShipping" Then
                Me.RadioButtonList1.SelectedValue = "NonShipping"
            Else
                Me.RadioButtonList1.Items(0).Selected = True
            End If
        End If


    End Sub

    Private Sub LoadOtherStatus()

        Dim codes As Collection(Of Orders.OrderStatusCode) = Orders.OrderStatusCode.FindAll

        Me.RadioButtonList1.DataSource = codes
        Me.RadioButtonList1.DataTextField = "StatusName"
        Me.RadioButtonList1.DataValueField = "bvin"
        Me.RadioButtonList1.DataBind()

        If Me.RadioButtonList1.Items.Count > 0 Then
            Dim s As String = SettingsManager.GetSetting("OtherStatusBvin").ToString
            If s.Length > 0 Then
                Me.RadioButtonList1.SelectedValue = s
            Else
                Me.RadioButtonList1.SelectedIndex() = 0
            End If
        End If


    End Sub

    Protected Sub ddlStatus_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStatus.SelectedIndexChanged
        PopulateStatusCodes()
    End Sub

End Class
