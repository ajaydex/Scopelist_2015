Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_ViewOrder
    Inherits UserControl

    Private _InputsAndModifiersLoaded As Boolean = False

    Private _DisableReturns As Boolean = False
    Private _DisableNotesAndPayment As Boolean = False
    Private _DisableStatus As Boolean = False
    Private _DisableOrderNumberDisplay As Boolean = False

    Public Property DisableReturns() As Boolean
        Get
            Return _DisableReturns
        End Get
        Set(ByVal value As Boolean)
            _DisableReturns = value
        End Set
    End Property
    Public Property DisableNotesAndPayment() As Boolean
        Get
            Return _DisableNotesAndPayment
        End Get
        Set(ByVal value As Boolean)
            _DisableNotesAndPayment = value
        End Set
    End Property
    Public Property DisableStatus() As Boolean
        Get
            Return _DisableStatus
        End Get
        Set(ByVal value As Boolean)
            _DisableStatus = value
        End Set
    End Property
    Public Property DisableOrderNumberDisplay() As Boolean
        Get
            Return _DisableOrderNumberDisplay
        End Get
        Set(ByVal value As Boolean)
            _DisableOrderNumberDisplay = value
        End Set
    End Property

    Public Property OrderBvin() As String
        Get
            Dim obj As Object = ViewState("OrderBvin")
            If obj IsNot Nothing Then
                Return CStr(obj)
            Else
                Return String.Empty
            End If
        End Get
        Set(ByVal value As String)
            ViewState("OrderBvin") = value
        End Set
    End Property

    Private _order As Orders.Order = Nothing
    Public Property Order() As Orders.Order
        Get
            Return _order
        End Get
        Set(ByVal value As Orders.Order)
            _order = value
        End Set
    End Property

    Public Sub LoadOrder()
        Dim bvin As String = Me.OrderBvin

        Dim o As Orders.Order = Orders.Order.FindByBvin(bvin)

        If o IsNot Nothing Then
            If o.Bvin <> String.Empty Then
                Me.Order = o
                PopulateFromOrder(o)
            End If
        End If
    End Sub

    Public Event ThrowError(ByVal message As String)

    Private Sub PopulateFromOrder(ByVal o As Orders.Order)

        If DisableOrderNumberDisplay Then
            Me.OrderNumberHeader.Visible = False
        Else
            ' Header
            Me.OrderNumberField.Text = o.OrderNumber
            Me.OrderNumberHeader.Visible = True
        End If


        ' Status
        If _DisableStatus = True Then
            Me.StatusField.Text = String.Empty
        Else
            Me.StatusField.Text = o.FullOrderStatusDescription
            'Me.lblCurrentStatus.Text = o.StatusName
        End If

        ' Billing
        Me.BillingAddressField.Text = o.BillingAddress.ToHtmlString

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
        Me.PaymentTotalField.Text = String.Format("{0:C}", paySummary.AmountCharged)
        Me.PaymentChargedField.Text = String.Format("{0:C}", paySummary.AmountCharged - paySummary.GiftCardAmount)
        Me.GiftCardAmountLabel.Text = String.Format("{0:C}", paySummary.GiftCardAmount)
        Me.PaymentDueField.Text = String.Format("{0:C}", paySummary.AmountDue)
        Me.PaymentRefundedField.Text = String.Format("{0:C}", paySummary.AmountRefunded)

        'Items
        ReturnItemsImageButton.Visible = False      ' will be set to true when we find a non-returned item
        itemsToReturnText.Visible = False           ' will be set to true when we find a non-returned item
        Me.ItemsGridView.DataSource = o.Items
        Me.ItemsGridView.DataBind()

        ' Instructions
        If o.Instructions.Trim.Length > 0 Then
            Me.pnlInstructions.Visible = True
            Me.InstructionsField.Text = o.Instructions
        End If

        ' Totals
        If o.OrderDiscounts > 0 Then
            Me.SubTotalField.Text = "<span class=""MarkDownPrice"">" & String.Format("{0:c}", o.SubTotal) & "</span><br />"
            Me.DiscountedSubTotalLabel.Text = String.Format("{0:c}", o.SubTotal - o.OrderDiscounts)
            Me.DiscountsLabel.Text = String.Format("{0:c}", o.OrderDiscounts)
            Me.DiscountedSubTotalRow.Visible = True
            Me.DiscountsRow.Visible = True
        Else
            Me.SubTotalField.Text = String.Format("{0:c}", o.SubTotal)
            Me.DiscountedSubTotalRow.Visible = False
            Me.DiscountsRow.Visible = False
        End If

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
        If lpos.UsedPoints > 0 Then
            Me.LoyaltyPointsUsedCurrencyField.Text = "- " + lpos.UsedPointsCurrency.ToString("c")
            Me.LoyaltyPointsUsedField.Text = lpos.UsedPoints.ToString()
        Else
            Me.trLoyaltyPointsUsed.Visible = False
        End If
        If lpos.EarnedPoints > 0 Then
            Me.LoyaltyPointsEarnedField.Text = lpos.EarnedPoints.ToString()
            Me.LoyaltyPointsEarnedCurrencyField.Text = lpos.EarnedPointsCurrency.ToString("c")
        Else
            Me.trLoyaltyPointsEarned.Visible = False
        End If

        Me.AmountDueField.Text = (o.GrandTotal - o.PaymentSummary.GiftCardAmount - lpos.UsedPointsCurrency).ToString("C")

        ' Gift Certificates
        If o.GiftCertificates.Count > 0 Then
            GiftCertificateField.Text = "- " + o.PaymentSummary.GiftCardAmount.ToString("C")
        Else
            Me.trGiftCertificateRow.Visible = False
        End If

        ' Coupons
        Me.CouponField.Text = String.Empty
        For i As Integer = 0 To o.Coupons.Count - 1
            Me.CouponField.Text += o.Coupons(i).CouponCode.Trim.ToUpper & "<br />"
        Next

        ' Notes
        Dim publicNotes As New Collection(Of Orders.OrderNote)
        For i As Integer = 0 To o.Notes.Count - 1
            If o.Notes(i).NoteType = Orders.OrderNoteType.Public Then
                publicNotes.Add(o.Notes(i))
            End If
        Next
        Me.PublicNotesField.DataSource = publicNotes
        Me.PublicNotesField.DataBind()

        If _DisableReturns = True Then
            Me.pnlReturn.Visible = False
            Me.ItemsGridView.Columns(0).Visible = False
        End If

        If _DisableNotesAndPayment = True Then
            Me.trNotes.Visible = False
        End If

        'Packages
        Dim packages As Collection(Of Shipping.Package) = o.FindShippedPackages()
        If packages.Count > 0 Then
            packagesdiv.Visible = True
            PackagesGridView.DataSource = packages
            PackagesGridView.DataBind()
        Else
            packagesdiv.Visible = False
        End If

        'Gift Certificates
        Dim giftCertificates As Collection(Of Catalog.GiftCertificate) = o.GetGiftCertificates()
        GiftCertificatesGridView.DataSource = giftCertificates
        GiftCertificatesGridView.DataBind()

        'Payments
        PONumberLabel.Visible = False
        For Each OrderPayment As Orders.OrderPayment In o.Payments
            If OrderPayment.PaymentMethodId = WebAppSettings.PaymentIdPurchaseOrder Then
                PONumberLabel.Visible = True
                For Each method As Payment.PaymentMethod In BVSoftware.BVC5.Core.Payment.AvailablePayments.Methods
                    If method.MethodId = WebAppSettings.PaymentIdPurchaseOrder Then
                        PONumberLabel.Text = method.MethodName & ":"
                    End If
                Next
                PONumberLabel.Text &= " " & OrderPayment.PurchaseOrderNumber
            End If
        Next
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
                        ReturnItemsImageButton.Visible = True
                        itemsToReturnText.Visible = True
                    End If
                End If

                Dim lblGiftWrap As Literal = e.Row.FindControl("lblGiftWrap")
                Dim lblGiftWrapQty As Literal = e.Row.FindControl("lblGiftWrapQty")
                Dim lblGiftWrapPrice As Literal = e.Row.FindControl("lblGiftWrapPrice")

                Dim wrapAllowed As Boolean = False
                If (lineItem.AssociatedProduct IsNot Nothing) Then
                    wrapAllowed = lineItem.AssociatedProduct.GiftWrapAllowed
                End If

                If wrapAllowed = False Then
                    If lblGiftWrap IsNot Nothing Then
                        lblGiftWrap.Visible = False
                    End If
                Else
                    If lblGiftWrapQty IsNot Nothing Then
                        lblGiftWrapQty.Text = lineItem.GiftWrapCount.ToString() & " - "
                    End If

                    If lblGiftWrapPrice IsNot Nothing Then
                        lblGiftWrapPrice.Text = String.Format("{0:c}", lineItem.AssociatedProduct.GiftWrapPrice) & " /each"
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

                Dim SKUField As Label = e.Row.FindControl("SKUField")
                Dim description As Label = e.Row.FindControl("DescriptionField")
                If lineItem.AssociatedProduct IsNot Nothing Then
                    If SKUField IsNot Nothing Then
                        SKUField.Text = lineItem.AssociatedProduct.Sku
                    End If

                    If description IsNot Nothing Then
                        description.Text = lineItem.AssociatedProduct.ProductName
                    End If
                Else
                    If SKUField IsNot Nothing Then
                        SKUField.Text = lineItem.ProductSku
                    End If

                    If description IsNot Nothing Then
                        description.Text = lineItem.ProductName
                    End If
                End If

                Dim ShippingStatusField As Label = e.Row.FindControl("ShippingStatusField")
                If ShippingStatusField IsNot Nothing Then
                    ShippingStatusField.Text = Utilities.EnumToString.OrderShippingStatus(lineItem.ShippingStatus)
                End If

            End If
        End If
    End Sub

    Protected Sub ReturnItemsImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ReturnItemsImageButton.Click
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
            RaiseEvent ThrowError("At least one item must be selected.")
            returnErrorLabel.Text = "At least one item must be selected."
            Return
        End If

        Response.Redirect("~/RMA.aspx?orderId=" + HttpUtility.UrlEncode(Me.OrderBvin) + "&lineItemIds=" + HttpUtility.UrlEncode(lineItems.ToString()))
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Dim val As Decimal = 0D
        PaymentTotalField.Text = val.ToString("c")
        PaymentChargedField.Text = val.ToString("c")
        PaymentRefundedField.Text = val.ToString("c")
        PaymentDueField.Text = val.ToString("c")
        GiftCardAmountLabel.Text = val.ToString("c")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ViewUtilities.DisplayKitInLineItem(Me.Page, ItemsGridView)
        If Not Page.IsPostBack Then
            Me.ReturnItemsImageButton.ImageUrl = PersonalizationServices.GetThemedButton("ReturnItems")
        Else
            If Not _InputsAndModifiersLoaded Then
                ViewUtilities.GetInputsAndModifiersForLineItemDescription(Me.Page, ItemsGridView)
            End If
        End If
    End Sub

    Protected Sub PackagesGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles PackagesGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem IsNot Nothing Then
                Dim val As Shipping.Package = DirectCast(e.Row.DataItem, Shipping.Package)
                DirectCast(e.Row.FindControl("ShippedDateLabel"), Label).Text = val.ShipDate.ToString("d")
                If val.TrackingNumber.Trim <> String.Empty Then
                    For Each item As Shipping.ShippingProvider In Shipping.AvailableProviders.Providers
                        If item.ProviderId = val.ShippingProviderId Then
                            Dim trackingNumberHyperLink As HyperLink = DirectCast(e.Row.FindControl("TrackingNumberHyperLink"), HyperLink)
                            trackingNumberHyperLink.Text = val.TrackingNumber
                            trackingNumberHyperLink.NavigateUrl = item.GetTrackingUrl(val.TrackingNumber)
                        End If
                    Next
                End If
            End If
        End If
    End Sub

    Protected Sub ItemsGridView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ItemsGridView.DataBound
        ViewUtilities.GetInputsAndModifiersForLineItemDescription(Me.Page, ItemsGridView)
        _InputsAndModifiersLoaded = True
    End Sub
End Class
