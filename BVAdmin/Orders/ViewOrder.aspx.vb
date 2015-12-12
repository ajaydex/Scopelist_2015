Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Orders_ViewOrder
    Inherits BaseAdminPage

    Private _InputsAndModifiersLoaded As Boolean = False

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Dim val As Decimal = 0D
        PaymentAuthorizedField.Text = val.ToString("c")
        PaymentChargedField.Text = val.ToString("c")
        PaymentRefundedField.Text = val.ToString("c")
        PaymentDueField.Text = val.ToString("c")
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadTemplates()
            If Request.QueryString("id") <> Nothing Then
                BvinField.Value = Request.QueryString("id")
            Else
                ' Show Error
            End If
            LoadOrder()
        Else
            If Not _InputsAndModifiersLoaded Then
                ViewUtilities.GetInputsAndModifiersForAdminLineItemDescription(Me.Page, ItemsGridView)
            End If
        End If
        ViewUtilities.DisplayKitInLineItem(Me.Page, ItemsGridView)
    End Sub

    Protected Sub ItemsGridView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ItemsGridView.DataBound
        ViewUtilities.GetInputsAndModifiersForAdminLineItemDescription(Me.Page, ItemsGridView)
        _InputsAndModifiersLoaded = True
    End Sub

    Private Sub LoadTemplates()
        Me.lstEmailTemplate.Items.Clear()
        Dim templates As Collection(Of Content.EmailTemplate) = Content.EmailTemplate.FindAll()
        If templates IsNot Nothing Then
            For Each t As Content.EmailTemplate In templates
                Dim li As New ListItem
                li.Text = t.DisplayName
                li.Value = t.Bvin
                If t.Bvin = "fe64609d-db68-4cc8-a4d1-4debb1071050" Then
                    li.Selected = True
                End If
                Me.lstEmailTemplate.Items.Add(li)
            Next
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "View Order"
        Me.CurrentTab = AdminTabType.Orders
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersView)
    End Sub

    Private Sub LoadOrder()
        Dim bvin As String = Me.BvinField.Value.ToString
        Dim o As Orders.Order = Orders.Order.FindByBvin(bvin)
        If o IsNot Nothing Then
            If o.Bvin <> String.Empty Then
                PopulateFromOrder(o)

                ' disable functionality for shopping cart orders
                If Not o.IsPlaced Then
                    Me.ucOrderDetailsButtons.Visible = False
                    Me.tblOrderStatus.Visible = False
                    Me.btnRMA.Visible = False

                    Me.lnkPlaceOrder.Visible = True
                    Me.lnkPlaceOrder.NavigateUrl = String.Format("NewOrder.aspx?id={0}", o.Bvin)
                End If
            End If
        End If
    End Sub

    Private Sub PopulateFromOrder(ByVal o As Orders.Order)

        ' Header
        Me.OrderNumberField.Text = o.OrderNumber
        Me.TimeOfOrderField.Text = o.TimeOfOrder
        Me.lblSalesPerson.Text = If(String.IsNullOrEmpty(o.SalesPersonId), "None", Membership.UserAccount.FindByBvin(o.SalesPersonId).UserName)

        ' Status
        Me.StatusField.Text = o.FullOrderStatusDescription
        Me.lblCurrentStatus.Text = o.StatusName

        ' Billing
        Me.BillingAddressField.Text = o.BillingAddress.ToHtmlString

        'Email
        Me.EmailAddressField.Text = Utilities.MailServices.MailToLink(o.UserEmail, "Order " + o.OrderNumber, o.BillingAddress.FirstName + ",")

        ' Shipping (hide if the same as billing address)
        If o.ShippingAddress.IsEqualTo(o.BillingAddress) = True Then
            Me.pnlShipTo.Visible = False
        Else
            Me.pnlShipTo.Visible = True
            Me.ShippingAddressField.Text = o.ShippingAddress.ToHtmlString
        End If

        ' Payment
        Dim paySummary As Orders.OrderPaymentSummary = o.PaymentSummary
        Me.lblPaymentSummary.Text = paySummary.PaymentsSummary
        Me.PaymentAuthorizedField.Text = String.Format("{0:C}", paySummary.AmountAuthorized)
        Me.PaymentChargedField.Text = String.Format("{0:C}", paySummary.AmountCharged)
        Me.PaymentDueField.Text = String.Format("{0:C}", paySummary.AmountDue)
        Me.PaymentRefundedField.Text = String.Format("{0:C}", paySummary.AmountRefunded)

        'Items
        btnRMA.Visible = False      ' will be set to true when we find an item that has not yet been fully returned
        Me.ItemsGridView.DataSource = o.Items
        Me.ItemsGridView.DataBind()

        ' Instructions
        If o.Instructions.Trim.Length > 0 Then
            Me.pnlInstructions.Visible = True
            Me.InstructionsField.Text = o.Instructions.Replace(vbCrLf, vbNewLine).Replace(vbCr, vbNewLine).Replace(vbNewLine, "<br />")
        End If

        ' Totals
        If o.OrderDiscounts > 0 Then
            Me.SubTotalField.Text = "<span class=""MarkDownPrice"">" & String.Format("{0:c}", o.SubTotal) & "</span><br />"
            Me.SubTotalField.Text += String.Format("{0:c}", o.SubTotal - o.OrderDiscounts)
        Else
            Me.SubTotalField.Text = String.Format("{0:c}", o.SubTotal)
        End If

        Me.AdminDiscountsField.Text = String.Format("{0:c}", o.GetPostOrderAdjustments())

        If o.ShippingDiscounts > 0 Then
            Me.ShippingTotalField.Text = "<span class=""MarkDownPrice"">" & String.Format("{0:c}", o.ShippingTotal) & "</span><br />"
            Me.ShippingTotalField.Text += String.Format("{0:c}", o.ShippingTotal - o.ShippingDiscounts)
        Else
            Me.ShippingTotalField.Text = String.Format("{0:c}", o.ShippingTotal)
        End If
        Me.TaxTotalField.Text = String.Format("{0:c}", o.TaxTotal)
        Me.HandlingTotalField.Text = String.Format("{0:c}", o.HandlingTotal)
        Me.GrandTotalField.Text = String.Format("{0:c}", o.GrandTotal)

        ' Loyalty Points
        Dim lpos As New Membership.LoyaltyPointsOrderSummary(o)
        Me.LoyaltyPointsUsedCurrencyField.Text = "- " + lpos.UsedPointsCurrency.ToString("c")
        Me.LoyaltyPointsUsedField.Text = lpos.UsedPoints.ToString()
        Me.LoyaltyPointsEarnedField.Text = lpos.EarnedPoints.ToString()
        Me.LoyaltyPointsEarnedCurrencyField.Text = lpos.EarnedPointsCurrency.ToString("c")

        ' Gift Certificates
        GiftCertificateField.Text = "- " + o.PaymentSummary.GiftCardAmount.ToString("C")
        AmountDueField.Text = (o.GrandTotal - o.PaymentSummary.GiftCardAmount - lpos.UsedPointsCurrency).ToString("C")

        ' Coupons
        Me.CouponField.Text = String.Empty
        For i As Integer = 0 To o.Coupons.Count - 1
            Me.CouponField.Text += o.Coupons(i).CouponCode.Trim.ToUpper & "<br />"
        Next

        ' Notes
        Dim publicNotes As New Collection(Of Orders.OrderNote)
        Dim privateNotes As New Collection(Of Orders.OrderNote)
        For i As Integer = 0 To o.Notes.Count - 1
            If o.Notes(i).NoteType = Orders.OrderNoteType.Public Then
                publicNotes.Add(o.Notes(i))
            Else
                privateNotes.Add(o.Notes(i))
            End If
        Next
        Me.PublicNotesField.DataSource = publicNotes
        Me.PublicNotesField.DataBind()
        Me.PrivateNotesField.DataSource = privateNotes
        Me.PrivateNotesField.DataBind()

    End Sub

    Protected Sub ItemsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles ItemsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lineItem As Orders.LineItem = CType(e.Row.DataItem, Orders.LineItem)
            If lineItem IsNot Nothing Then

                Dim selectedCheckBox As CheckBox = CType(e.Row.FindControl("SelectedCheckBox"), CheckBox)
                If selectedCheckBox IsNot Nothing Then
                    Dim ReturnItems As Collection(Of Orders.RMAItem) = Orders.RMAItem.FindByLineItemBvin(lineItem.Bvin)
                    Dim quantityReturned As Integer = 0
                    For Each item As Orders.RMAItem In ReturnItems
                        quantityReturned += item.Quantity
                    Next

                    If quantityReturned >= lineItem.Quantity Then
                        selectedCheckBox.Visible = False
                    Else
                        selectedCheckBox.Visible = True
                        btnRMA.Visible = True
                    End If
                End If

                Dim SKUField As Label = e.Row.FindControl("SKUField")
                If SKUField IsNot Nothing Then
                    SKUField.Text = lineItem.ProductSku
                End If

                Dim description As Label = e.Row.FindControl("DescriptionField")
                If description IsNot Nothing Then
                    description.Text = lineItem.ProductName
                End If

                Dim ShippingStatusField As Label = e.Row.FindControl("ShippingStatusField")
                If ShippingStatusField IsNot Nothing Then
                    ShippingStatusField.Text = Utilities.EnumToString.OrderShippingStatus(lineItem.ShippingStatus)
                End If

                Dim lblGiftWrap As Literal = e.Row.FindControl("lblGiftWrap")
                Dim lblGiftWrapQty As Literal = e.Row.FindControl("lblGiftWrapQty")
                Dim lblGiftWrapPrice As Literal = e.Row.FindControl("lblGiftWrapPrice")
                If (lineItem.AssociatedProduct IsNot Nothing) Then
                    If lineItem.AssociatedProduct.GiftWrapAllowed = False Then
                        If lblGiftWrap IsNot Nothing Then
                            lblGiftWrap.Visible = False
                        End If
                    Else
                        If lblGiftWrapQty IsNot Nothing Then
                            lblGiftWrapQty.Text = String.Format("{0:#}", lineItem.GiftWrapCount)
                        End If
                        If lblGiftWrapPrice IsNot Nothing Then
                            lblGiftWrapPrice.Text = String.Format("<br/>{0:c}", lineItem.AssociatedProduct.GiftWrapPrice)
                        End If

                        'build gift wrap details
                        Dim details As New StringBuilder()
                        For Each item As Orders.GiftWrapDetails In lineItem.GiftWrapDetails
                            If item.GiftWrapEnabled = True Then
                                details.Append("To: " & item.ToField & "<br/>")
                                details.Append("From: " & item.FromField & "<br/>")
                                details.Append("Message: " & item.MessageField & "<br/>")
                                details.Append("<br/>")
                            End If
                        Next

                        Dim lblGiftWrapDetails As Literal = e.Row.FindControl("lblGiftWrapDetails")
                        If lblGiftWrapDetails IsNot Nothing Then
                            lblGiftWrapDetails.Text = details.ToString()
                        End If
                    End If
                Else
                    lblGiftWrap.Visible = False
                End If
            End If
        End If
    End Sub

    Protected Sub btnNewPublicNote_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewPublicNote.Click
        Me.MessageBox1.ClearMessage()
        If Me.NewPublicNoteField.Text.Trim.Length > 0 Then
            AddNote(Me.NewPublicNoteField.Text.Trim, Orders.OrderNoteType.Public)
        End If
        Me.NewPublicNoteField.Text = String.Empty
    End Sub

    Private Sub AddNote(ByVal message As String, ByVal noteType As Orders.OrderNoteType)
        Dim n As New Orders.OrderNote
        n.OrderID = Me.BvinField.Value
        n.NoteType = noteType
        n.Note = message
        Orders.OrderNote.Insert(n)
        LoadOrder()
    End Sub

    Protected Sub btnNewPrivateNote_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewPrivateNote.Click
        Me.MessageBox1.ClearMessage()
        If Me.NewPrivateNoteField.Text.Trim.Length > 0 Then
            AddNote(Me.NewPrivateNoteField.Text.Trim, Orders.OrderNoteType.Private)
        End If
        Me.NewPrivateNoteField.Text = String.Empty
    End Sub

    Protected Sub PublicNotesField_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles PublicNotesField.RowDeleting
        Me.MessageBox1.ClearMessage()
        Dim bvin As String = CType(PublicNotesField.DataKeys(e.RowIndex).Value, String)
        Orders.OrderNote.Delete(bvin)
        LoadOrder()
    End Sub

    Protected Sub PrivateNotesField_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles PrivateNotesField.RowDeleting
        Me.MessageBox1.ClearMessage()
        Dim bvin As String = CType(PrivateNotesField.DataKeys(e.RowIndex).Value, String)
        Orders.OrderNote.Delete(bvin)
        LoadOrder()
    End Sub

    Protected Sub btnPreviousStatus_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnPreviousStatus.Click
        Me.MessageBox1.ClearMessage()
        Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        If o IsNot Nothing Then
            o.MoveToPreviousStatus()
            LoadOrder()
        End If
    End Sub

    Protected Sub btnNextStatus_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNextStatus.Click
        Me.MessageBox1.ClearMessage()
        Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        If o IsNot Nothing Then
            o.MoveToNextStatus()
            LoadOrder()
        End If
    End Sub

    Protected Sub btnRMA_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnRMA.Click
        Me.MessageBox1.ClearMessage()
        Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))

        Dim lineItems As New StringBuilder()
        For Each row As GridViewRow In ItemsGridView.Rows
            Dim obj As Object = row.FindControl("SelectedCheckBox")
            If obj IsNot Nothing Then
                If DirectCast(obj, CheckBox).Checked Then
                    If String.IsNullOrEmpty(lineItems.ToString()) Then
                        lineItems.Append(ItemsGridView.DataKeys(row.RowIndex).Value)
                    Else
                        lineItems.Append("," + ItemsGridView.DataKeys(row.RowIndex).Value)
                    End If
                End If
            End If
        Next

        If String.IsNullOrEmpty(lineItems.ToString()) Then
            Me.MessageBox1.ShowError("At least one item must be selected.")
            Return
        End If

        Response.Redirect("~/RMA.aspx?orderId=" + HttpUtility.UrlEncode(o.Bvin) + "&lineItemIds=" + HttpUtility.UrlEncode(lineItems.ToString()))
    End Sub

    Protected Sub btnSendStatusEmail_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSendStatusEmail.Click
        Me.MessageBox1.ClearMessage()
        Dim o As Orders.Order = Orders.Order.FindByBvin(Me.BvinField.Value)
        If o IsNot Nothing Then
            If o.Bvin <> String.Empty Then
                Dim templateBvin As String = Me.lstEmailTemplate.SelectedValue
                If templateBvin = String.Empty Then
                    templateBvin = "fe64609d-db68-4cc8-a4d1-4debb1071050"
                End If

                If templateBvin = WebAppSettings.EmailTemplateGiftCard Then
                    Dim toEmail As String = o.UserEmail
                    If toEmail.Trim.Length > 0 Then
                        For Each lineitem As Orders.LineItem In o.Items
                            Dim gcs As Collection(Of Catalog.GiftCertificate) = Catalog.GiftCertificate.FindByLineItem(lineitem.Bvin)
                            For Each gc As Catalog.GiftCertificate In gcs
                                Dim t As Content.EmailTemplate = Content.EmailTemplate.FindByBvin(templateBvin)
                                Dim m As New System.Net.Mail.MailMessage
                                m = t.ConvertToMailMessage(t.From, gc, toEmail)
                                If m IsNot Nothing Then
                                    If Not Regex.IsMatch(m.Body, "\[\[.+\]\]") Then
                                        If Utilities.MailServices.SendMail(m) Then
                                            Me.MessageBox1.ShowOk("Email Sent!")
                                        Else
                                            Me.MessageBox1.ShowError("Message Send Failed.")
                                        End If
                                    Else                                        
                                        MessageBox1.ShowError("This Email Template Could Not Replace All Tags. E-mail Will Not Be Sent.")
                                    End If
                                Else
                                MessageBox1.ShowError("Message was not created successfully.")
                                End If
                            Next
                        Next
                    End If
                Else
                    Dim toEmail As String = o.UserEmail
                    If toEmail.Trim.Length > 0 Then
                        Dim t As Content.EmailTemplate = Content.EmailTemplate.FindByBvin(templateBvin)
                        Dim m As New System.Net.Mail.MailMessage
                        m = t.ConvertToMailMessage(t.From, toEmail, o)
                        If m IsNot Nothing Then
                            If Not Regex.IsMatch(m.Body, "\[\[.+\]\]") Then
                                If Utilities.MailServices.SendMail(m) Then
                                    Me.MessageBox1.ShowOk("Email Sent!")
                                Else
                                    Me.MessageBox1.ShowError("Message Send Failed.")
                                End If
                            Else
                                t = Content.EmailTemplate.FindByBvin(templateBvin)
                                Dim packages As Collection(Of Shipping.Package) = Shipping.Package.FindByOrderID(o.Bvin)
                                m = t.ConvertToMailMessage(t.From, toEmail, o, packages)
                                If Not Regex.IsMatch(m.Body, "\[\[.+\]\]") Then
                                    If Utilities.MailServices.SendMail(m) Then
                                        Me.MessageBox1.ShowOk("Email Sent!")
                                    Else
                                        Me.MessageBox1.ShowError("Message Send Failed.")
                                    End If
                                Else
                                    MessageBox1.ShowError("This Email Template Could Not Replace All Tags. E-mail Will Not Be Sent.")
                                End If
                            End If
                        Else
                            MessageBox1.ShowError("Message was not created successfully.")
                        End If
                    End If
                End If
            End If
        End If
        LoadOrder()
    End Sub
End Class
