Imports BVSoftware.BVC5.Core
Imports System.Linq
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Orders_EditOrder
    Inherits BaseAdminPage

    Private _InputsAndModifiersLoaded As Boolean = False

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Dim val As Decimal = 0D
        PaymentAuthorizedField.Text = val.ToString("c")
        PaymentChargedField.Text = val.ToString("c")
        PaymentRefundedField.Text = val.ToString("c")
        PaymentDueField.Text = val.ToString("c")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.UserPicker1.MessageBox = MessageBox1
        InitializeAddresses()

        If Request.QueryString("id") IsNot Nothing Then
            Me.BvinField.Value = Request.QueryString("id")
        Else
            ' Show Error
        End If
        Dim o As Orders.Order = Orders.Order.FindByBvin(Me.BvinField.Value)

        If o IsNot Nothing Then
            ShippingAddressBook.UserID = o.UserID
            BillingAddressBook.UserID = o.UserID
        End If

        If Not Page.IsPostBack Then
            
            LoadOrder()

            LoadShippingMethodsForOrder(o)
            LoadSalesPeople(o)
        End If

        If EditLineBvin.Value <> String.Empty Then
            EditLineVariantsDisplay.Initialize(False)
            EditLineKitComponentsDisplay.Initialize(EditLineBvin.Value)
        End If

        If Me.AddProductSkuHiddenField.Value <> String.Empty Then
            VariantsDisplay1.Initialize(False)
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Me.AddProductSkuHiddenField.Value)
            AddNewKitComponentsDisplay.Initialize(p)
        End If

        If Page.IsPostBack Then
            If Not _InputsAndModifiersLoaded Then
                ViewUtilities.GetInputsAndModifiersForAdminLineItemDescription(Me.Page, ItemsGridView)
            End If
        End If
        ViewUtilities.DisplayKitInLineItem(Me.Page, ItemsGridView)
    End Sub

    Protected Sub ItemsGridView_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ItemsGridView.DataBound
        ViewUtilities.GetInputsAndModifiersForAdminLineItemDescription(Me.Page, ItemsGridView)
        ViewUtilities.DisplayKitInLineItem(Me.Page, ItemsGridView)
        _InputsAndModifiersLoaded = True

    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Order"
        Me.CurrentTab = AdminTabType.Orders
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersEdit)
    End Sub

#Region " Loading Methods "

    Private Sub InitializeAddresses()

        Me.ShippingAddressEditor.RequireCompany = WebAppSettings.ShipAddressRequireCompany
        Me.ShippingAddressEditor.RequireFax = WebAppSettings.ShipAddressRequireFax
        Me.ShippingAddressEditor.RequireFirstName = WebAppSettings.ShipAddressRequireFirstName
        Me.ShippingAddressEditor.RequireLastName = WebAppSettings.ShipAddressRequireLastName
        Me.ShippingAddressEditor.RequirePhone = WebAppSettings.ShipAddressRequirePhone
        Me.ShippingAddressEditor.RequireWebSiteURL = WebAppSettings.ShipAddressRequireWebSiteURL
        Me.ShippingAddressEditor.ShowCompanyName = WebAppSettings.ShipAddressShowCompany
        Me.ShippingAddressEditor.ShowFaxNumber = WebAppSettings.ShipAddressShowFax
        Me.ShippingAddressEditor.ShowMiddleInitial = WebAppSettings.ShipAddressShowMiddleInitial
        Me.ShippingAddressEditor.ShowPhoneNumber = WebAppSettings.ShipAddressShowPhone
        Me.ShippingAddressEditor.ShowWebSiteURL = WebAppSettings.ShipAddressShowWebSiteURL
        Me.ShippingAddressEditor.ShowNickName = False
        Me.ShippingAddressEditor.ShowCounty = True

        Me.BillingAddressEditor.RequireCompany = WebAppSettings.BillAddressRequireCompany
        Me.BillingAddressEditor.RequireFax = WebAppSettings.BillAddressRequireFax
        Me.BillingAddressEditor.RequireFirstName = WebAppSettings.BillAddressRequireFirstName
        Me.BillingAddressEditor.RequireLastName = WebAppSettings.BillAddressRequireLastName
        Me.BillingAddressEditor.RequirePhone = WebAppSettings.BillAddressRequirePhone
        Me.BillingAddressEditor.RequireWebSiteURL = WebAppSettings.BillAddressRequireWebSiteURL
        Me.BillingAddressEditor.ShowCompanyName = WebAppSettings.BillAddressShowCompany
        Me.BillingAddressEditor.ShowFaxNumber = WebAppSettings.BillAddressShowFax
        Me.BillingAddressEditor.ShowMiddleInitial = WebAppSettings.BillAddressShowMiddleInitial
        Me.BillingAddressEditor.ShowPhoneNumber = WebAppSettings.BillAddressShowPhone
        Me.BillingAddressEditor.ShowWebSiteURL = WebAppSettings.BillAddressShowWebSiteUrl
        Me.BillingAddressEditor.ShowNickName = False
        Me.BillingAddressEditor.ShowCounty = True

    End Sub

    Private Sub LoadOrder()
        Dim bvin As String = Me.BvinField.Value.ToString
        Dim o As Orders.Order = Orders.Order.FindByBvin(bvin)
        'o.RecalculateProductPrices()                                'needed to apply modifier options to newly added line item of placed order
        'Orders.Order.Update(o)

        If o IsNot Nothing Then
            If o.Bvin <> String.Empty Then
                TaxExemptField.Checked = o.CustomPropertyExists("Develisys", "TaxExempt")
                CalculateTax(o)
                Orders.Order.Update(o)
                PopulateFromOrder(o)
            End If
        End If

        LoadShippingMethodsForOrder(o)
    End Sub

    Private Sub PopulateFromOrder(ByVal o As Orders.Order)
        ' Header
        Me.OrderNumberField.Text = o.OrderNumber

        ' Status
        Me.StatusField.Text = o.FullOrderStatusDescription
        Me.lblCurrentStatus.Text = o.StatusName

        ' Billing
        Me.BillingAddressEditor.LoadFromAddress(o.BillingAddress)

        'Email
        Me.UserEmailField.Text = o.UserEmail
        If o.UserID <> String.Empty Then
            If o.User IsNot Nothing Then
                If String.IsNullOrEmpty(o.UserEmail) Then
                    Me.UserEmailField.Text = o.User.Email
                End If

                Me.UserPicker1.UserName = o.User.UserName
                Me.UserIdField.Value = o.UserID
                ShippingAddressBook.UserID = o.UserID
                BillingAddressBook.UserID = o.UserID
                ShippingAddressBook.BindAddresses()
                BillingAddressBook.BindAddresses()
            End If
        End If

        ' Shipping
        Me.ShippingAddressEditor.LoadFromAddress(o.ShippingAddress)

        ' Payment
        Dim paySummary As Orders.OrderPaymentSummary = o.PaymentSummary
        Me.lblPaymentSummary.Text = paySummary.PaymentsSummary
        Me.PaymentAuthorizedField.Text = String.Format("{0:C}", paySummary.AmountAuthorized)
        Me.PaymentChargedField.Text = String.Format("{0:C}", paySummary.AmountCharged)
        Me.PaymentDueField.Text = String.Format("{0:C}", paySummary.AmountDue)
        Me.PaymentRefundedField.Text = String.Format("{0:C}", paySummary.AmountRefunded)

        'Items
        Me.ItemsGridView.DataSource = o.Items
        Me.ItemsGridView.DataBind()

        ' Instructions
        Me.InstructionsField.Text = o.Instructions

        ' Totals
        Me.SubTotalField.Text = String.Format("{0:c}", o.SubTotal)
        Me.OrderDiscountsField.Text = String.Format("{0:c}", o.OrderDiscounts)

        Me.ShippingTotalTextBox.Text = String.Format("{0:c}", o.ShippingTotal)
        'Me.lblShippingDescription.Text = o.ShippingMethodDisplayName
        Me.ShippingDiscountsField.Text = String.Format("{0:c}", o.ShippingDiscounts)
        Me.TaxTotalField.Text = String.Format("{0:c}", o.TaxTotal)
        Me.HandlingTotalField.Text = String.Format("{0:c}", o.HandlingTotal)
        Me.GrandTotalField.Text = String.Format("{0:c}", o.GrandTotal)

        ' Adjustments Field
        If o.CustomPropertyExists("bvsoftware", "postorderadjustment") Then
            Dim adjustment As Decimal = 0D
            Dim a As String = o.CustomPropertyGet("bvsoftware", "postorderadjustment")
            Dim amount As Decimal = 0D
            Decimal.TryParse(a, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, amount)
            Me.OrderDiscountAdjustments.Text = String.Format("{0:c}", amount)
        Else
            Me.OrderDiscountAdjustments.Text = String.Format("{0:c}", 0D)
        End If

        ' Coupons
        Me.lstCoupons.DataSource = o.Coupons
        Me.lstCoupons.DataBind()

    End Sub

    Protected Sub ItemsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles ItemsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lineItem As Orders.LineItem = CType(e.Row.DataItem, Orders.LineItem)
            If lineItem IsNot Nothing Then

                Dim SKUField As Label = e.Row.FindControl("SKUField")
                If SKUField IsNot Nothing Then
                    SKUField.Text = lineItem.ProductSku
                End If

                Dim description As Label = e.Row.FindControl("DescriptionField")
                If description IsNot Nothing Then
                    description.Text = lineItem.ProductName
                    If (lineItem.ProductShortDescription.Trim().Length > 0) Then
                        description.Text += "<br />" & lineItem.ProductShortDescription
                    End If
                End If

                'Only show the button if this product has variations or kit selections
                Dim btnEdit As ImageButton = e.Row.FindControl("btnEdit")
                Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(lineItem.ProductId)     'we need to load the full object to check for variants
                If product IsNot Nothing AndAlso Not String.IsNullOrEmpty(product.ParentId) Then
                    product = Catalog.InternalProduct.FindByBvin(product.ParentId)
                End If

                Dim kitHasOptions As Boolean = False
                If product IsNot Nothing AndAlso product.IsKit Then
                    Dim kc As Collection(Of Catalog.KitComponent) = Catalog.KitComponent.FindByGroupId(product.Groups(0).Bvin)
                    For Each component As Catalog.KitComponent In kc
                        If component.ComponentType <> Catalog.KitComponentType.IncludedHidden AndAlso component.ComponentType <> Catalog.KitComponentType.IncludedShown Then
                            kitHasOptions = True
                            Exit For
                        End If
                    Next
                End If

                If (product IsNot Nothing AndAlso product.ChoicesAndInputs.Count > 0) OrElse kitHasOptions Then
                    btnEdit.Visible = True
                Else
                    btnEdit.Visible = False
                End If
            End If
        End If
    End Sub

#End Region

#Region " Menu Buttons "

    Protected Sub btnPreviousStatus_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnPreviousStatus.Click
        Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        If o IsNot Nothing Then
            o.MoveToPreviousStatus()
            SaveOrder(False, False)
            LoadOrder()
        End If
    End Sub

    Protected Sub btnNextStatus_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNextStatus.Click
        Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        If o IsNot Nothing Then
            o.MoveToNextStatus()
            SaveOrder(False, False)
            LoadOrder()
        End If
    End Sub

#End Region

    Protected Sub btnDelete_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDelete.Click

        Dim success As Boolean = False

        Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        Select Case o.ShippingStatus
            Case Orders.OrderShippingStatus.FullyShipped
                success = Orders.Order.Delete(o.Bvin)
            Case Orders.OrderShippingStatus.NonShipping
                success = Orders.Order.Delete(o.Bvin)
            Case Orders.OrderShippingStatus.PartiallyShipped
                Me.MessageBox1.ShowWarning("Partially shipped orders can't be deleted. Either unship or ship all items before deleting.")
            Case Orders.OrderShippingStatus.Unknown
                success = Orders.Order.DeleteWithInventoryReturn(o.Bvin)
            Case Orders.OrderShippingStatus.Unshipped
                success = Orders.Order.DeleteWithInventoryReturn(o.Bvin)
        End Select

        If success Then
            Response.Redirect("~/BVAdmin/Orders/Default.aspx")
        End If

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("ViewOrder.aspx?id=" & Me.BvinField.Value)
    End Sub

#Region " Saving "

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        Me.MessageBox1.ClearMessage()
        Dim saveResult As BVOperationResult = SaveOrder(False, True)
        If saveResult.Success Then
            RunOrderEditedWorkflow(saveResult)
        End If
        LoadOrder()
    End Sub

    Private Sub RunOrderEditedWorkflow(ByVal saveResult As BVOperationResult)
        Dim c As New BusinessRules.OrderTaskContext()
        c.UserId = SessionManager.GetCurrentUserId()
        c.Order = Orders.Order.FindByBvin(Me.BvinField.Value)
        If Not BusinessRules.Workflow.RunByBvin(c, WebAppSettings.WorkflowIdOrderEdited) Then
            For Each msg As BusinessRules.WorkflowMessage In c.Errors
                EventLog.LogEvent("Order Edited Workflow", msg.Description, Metrics.EventLogSeverity.Error)
            Next
            If Not String.IsNullOrEmpty(saveResult.Message) Then
                Me.MessageBox1.ShowError(saveResult.Message & " Error Occurred. Please see event log.")
            Else
                Me.MessageBox1.ShowError("Error Occurred. Please see event log.")
            End If
        Else
            If Not String.IsNullOrEmpty(saveResult.Message) Then
                Me.MessageBox1.ShowError(saveResult.Message)
            Else
                Me.MessageBox1.ShowOk("Changes Saved")
            End If
        End If
    End Sub

    Private Function SaveOrder(ByVal forceOfferCalculations As Boolean, ByVal requireValidOptions As Boolean) As BVOperationResult
        Dim result As New BVOperationResult(False, "")

        Dim o As Orders.Order = Orders.Order.FindByBvin(Me.BvinField.Value)
        If o Is Nothing Then
            result.Success = False
            result.Message = "Unable to reload order."
            MessageBox1.ShowError(result.Message)
            Return result
        End If


        Dim validateResult As BVOperationResult = ValidateOptions(o)
        If Not validateResult.Success Then
            Me.MessageBox1.ShowError(validateResult.Message)
        End If

        If validateResult.Success OrElse Not requireValidOptions Then
            TagOrderWithUser(o)
            o.UserEmail = Me.UserEmailField.Text
            o.Instructions = Me.InstructionsField.Text.Trim()
            o.SalesPersonId = Me.ddlSalesPerson.SelectedValue

            o.BillingAddress = Me.BillingAddressEditor.GetAsAddress
            o.SetShippingAddress(Me.ShippingAddressEditor.GetAsAddress)

            Dim modifyResult As BVOperationResult = ModifyQuantities(o)
            If Not modifyResult.Success Then
                result.Message = modifyResult.Message
            End If

            ' Apply Adjustments
            Dim adjustmentAmount As Decimal = 0D
            Decimal.TryParse(Me.OrderDiscountAdjustments.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, adjustmentAmount)
            o.CustomPropertySet("bvsoftware", "postorderadjustment", adjustmentAmount)

            ' Shipping Changes
            If Me.ShippingRatesList.Items.Count > 0 Then
                Dim r As Shipping.ShippingRate = FindSelectedRate(Me.ShippingRatesList.SelectedValue, o)
                o.ApplyShippingRate(r)
                Dim shippingAmount As Decimal = 0D
                If Decimal.TryParse(Me.ShippingTotalTextBox.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, shippingAmount) Then
                    o.ShippingTotal = shippingAmount
                End If
            End If

            If forceOfferCalculations Then
                o.RecalculatePlacedOrder()
            Else
                CalculateTax(o)
            End If

            result.Success = Orders.Order.Update(o)
        Else
            result = validateResult
        End If

        ' If we're returning validateResult, there's no need to show this again
        If Not result.Success AndAlso Not result Is validateResult Then
            MessageBox1.ShowError(result.Message)
        End If

        Return result
    End Function

    Private Function ModifyQuantities(ByVal o As Orders.Order) As BVOperationResult
        Dim result As New BVOperationResult(True, "")
        For i As Integer = 0 To Me.ItemsGridView.Rows.Count - 1
            If ItemsGridView.Rows(i).RowType = DataControlRowType.DataRow Then
                Dim qty As TextBox = ItemsGridView.Rows(i).FindControl("QtyField")
                If qty IsNot Nothing Then
                    Dim bvin As String = CType(ItemsGridView.DataKeys(ItemsGridView.Rows(i).RowIndex).Value, String)
                    Dim val As String = o.UpdateItemQuantity(bvin, qty.Text.Trim).Message
                    If val <> String.Empty Then
                        result.Success = False
                        result.Message = val
                    End If
                End If

                Dim price As TextBox = ItemsGridView.Rows(i).FindControl("PriceField")
                If price IsNot Nothing Then
                    If Decimal.TryParse(price.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, Nothing) Then
                        Dim bvin As String = CType(ItemsGridView.DataKeys(ItemsGridView.Rows(i).RowIndex).Value, String)
                        Dim val As String = o.SetItemAdminPrice(bvin, Decimal.Parse(price.Text, System.Globalization.NumberStyles.Currency)).Message
                        If val <> String.Empty Then
                            MessageBox1.ShowError(val)
                        End If
                    End If
                End If
            End If
        Next
        Return result
    End Function

#End Region

#Region " User "

    Protected Sub UserPicker1_UserSelected(ByVal args As BVSoftware.Bvc5.Core.Controls.UserSelectedEventArgs) Handles UserPicker1.UserSelected
        Me.UserEmailField.Text = args.UserAccount.Email

        ShippingAddressBook.UserID = args.UserAccount.Bvin
        BillingAddressBook.UserID = args.UserAccount.Bvin
        ShippingAddressBook.BindAddresses()
        BillingAddressBook.BindAddresses()

        RecalculateProductPrices_Click(Nothing, Nothing) ' needed to recalculate product prices
    End Sub

    Private Sub TagOrderWithUser(ByVal o As Orders.Order)
        If Me.UserPicker1.UserName.Trim = String.Empty Then
            o.UserID = String.Empty
        Else
            Dim u As Membership.UserAccount = Membership.UserAccount.FindByUserName(UserPicker1.UserName)
            If u IsNot Nothing Then
                If u.Bvin <> String.Empty Then
                    Me.UserIdField.Value = u.Bvin
                    o.UserID = u.Bvin
                    Me.BillingAddressEditor.GetAsAddress.CopyTo(u.BillingAddress)
                    Me.ShippingAddressEditor.GetAsAddress.CopyTo(u.ShippingAddress)
                    Membership.UserAccount.Update(u)
                End If
            End If
        End If
    End Sub

    Protected Sub AddressSelected(ByVal addressType As String, ByVal address As Contacts.Address) Handles ShippingAddressBook.AddressSelected, BillingAddressBook.AddressSelected
        If String.Compare(addressType, "Billing", True) = 0 Then
            BillingAddressEditor.LoadFromAddress(address)
        ElseIf String.Compare(addressType, "Shipping", True) = 0 Then
            ShippingAddressEditor.LoadFromAddress(address)
        End If

        SaveOrder(False, False)
        Dim o As Orders.Order = Orders.Order.FindByBvin(Me.BvinField.Value)
        LoadShippingMethodsForOrder(o)
    End Sub

#End Region

#Region " Coupons "


    Protected Sub btnDeleteCoupon_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDeleteCoupon.Click
        SaveOrder(False, False)
        Dim o As Orders.Order = Orders.Order.FindByBvin(Me.BvinField.Value)
        If o IsNot Nothing Then
            For Each li As ListItem In Me.lstCoupons.Items
                If li.Selected = True Then
                    o.RemoveCouponCode(li.Text, True)
                End If
            Next
        End If
        LoadOrder()
    End Sub

    Protected Sub btnAddCoupon_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddCoupon.Click
        SaveOrder(False, False)
        Dim o As Orders.Order = Orders.Order.FindByBvin(Me.BvinField.Value)
        If o IsNot Nothing Then
            Dim result As BVOperationResult = o.AddCouponCode(Me.CouponField.Text.Trim.ToUpper, True, True)
            If result.Success = False Then
                Me.MessageBox1.ShowWarning(result.Message)
            End If
        End If
        LoadOrder()
    End Sub

#End Region

#Region " Shipping Changes "


    Private Sub LoadShippingMethodsForOrder(ByVal o As Orders.Order)
        ' Shipping Methods
        Me.ShippingRatesList.Items.Clear()

        If o.HasShippingItems = False Then
            Me.ShippingRatesList.Items.Add(New ListItem("No Shipping Required", "NOSHIPPING"))
        Else
            Dim Rates As Utilities.SortableCollection(Of Shipping.ShippingRate)
            Rates = o.FindAvailableShippingRates()
            SessionManager.LastEditorShippingRates = Rates
            Me.ShippingRatesList.AppendDataBoundItems = True
            Me.ShippingRatesList.Items.Add(New ListItem("-Select a shipping method-", String.Empty))
            Me.ShippingRatesList.DataTextField = "RateAndNameForDisplayNoDiscounts"
            Me.ShippingRatesList.DataValueField = "UniqueKey"
            Me.ShippingRatesList.DataSource = Rates
            Me.ShippingRatesList.DataBind()
        End If

        ' Set Current Shipping
        Dim currentKey As String = o.ShippingMethodUniqueKey
        If Me.ShippingRatesList.Items.FindByValue(currentKey) IsNot Nothing Then
            Me.ShippingRatesList.ClearSelection()
            Me.ShippingRatesList.Items.FindByValue(currentKey).Selected = True
        End If

    End Sub

    Private Function FindSelectedRate(ByVal uniqueKey As String, ByVal o As Orders.Order) As Shipping.ShippingRate
        Dim result As Shipping.ShippingRate = Nothing

        If o.HasShippingItems = False Then
            result = New Shipping.ShippingRate
            result.DisplayName = "No Shipping Required"
            result.ProviderId = "NOSHIPPING"
            result.ProviderServiceCode = "NOSHIPPING"
            result.Rate = 0D
            result.ShippingMethodId = "NOSHIPPING"
            result.UniqueKey = "NOSHIPPING"
        Else
            Dim rates As Utilities.SortableCollection(Of Shipping.ShippingRate) = SessionManager.LastEditorShippingRates
            If (rates Is Nothing) OrElse (rates.Count < 1) Then
                rates = o.FindAvailableShippingRates()
            End If

            For Each r As Shipping.ShippingRate In rates
                If r.UniqueKey = uniqueKey Then
                    result = r
                    Exit For
                End If
            Next
        End If

        Return result
    End Function

#End Region

#Region " Add Product Form "

    Protected Sub btnBrowseProducts_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnBrowseProducts.Click
        Me.MessageBox1.ClearMessage()
        Me.pnlProductPicker.Visible = Not Me.pnlProductPicker.Visible
        If Me.NewSkuField.Text.Trim.Length > 0 Then
            If Me.pnlProductPicker.Visible = True Then
                Me.ProductPicker1.Keyword = Me.NewSkuField.Text
                Me.ProductPicker1.LoadSearch()
            End If
        End If
    End Sub

    Protected Sub btnProductPickerCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnProductPickerCancel.Click
        Me.MessageBox1.ClearMessage()
        Me.pnlProductPicker.Visible = False
    End Sub

    Protected Sub btnProductPickerOkay_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnProductPickerOkay.Click
        Me.MessageBox1.ClearMessage()
        If Me.ProductPicker1.SelectedProducts.Count > 0 Then
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Me.ProductPicker1.SelectedProducts(0))
            If p IsNot Nothing Then
                Me.NewSkuField.Text = p.Sku
            End If
            AddProductBySku()
            Me.pnlProductPicker.Visible = False
        Else
            Me.MessageBox1.ShowWarning("Please select a product first.")
        End If
    End Sub

    Private Sub AddProductBySku()
        Me.MessageBox1.ClearMessage()
        Me.pnlProductChoices.Visible = False

        If Me.NewSkuField.Text.Trim.Length < 1 Then
            Me.MessageBox1.ShowWarning("Please enter a sku first.")
        Else
            Dim p As Catalog.Product = Catalog.InternalProduct.FindBySku(Me.NewSkuField.Text.Trim)
            If p IsNot Nothing Then

                ' Accept Child Skus and switch to parent automatically
                If p.ParentId.Trim().Length > 0 Then
                    p = Catalog.InternalProduct.FindByBvin(p.ParentId)
                End If

                If (p.Sku = String.Empty) OrElse (p.Saved = False) Then
                    Me.MessageBox1.ShowWarning("That product could not be located. Please check SKU.")
                Else
                    If p.ChoicesAndInputs.Count > 0 Then
                        Me.pnlProductChoices.Visible = True
                        Me.AddProductSkuHiddenField.Value = p.Bvin
                        Me.VariantsDisplay1.BaseProduct = p
                        Me.AddLineVariantsDisplayContainer.Visible = True
                        Me.AddNewKitComponentsDisplay.Initialize(p)         'We are re-initializing the kit display so that it will disappear as this product is not a kit

                    Else
                        'If ValidateInventory(p, Me.NewProductQuantity.Text.Trim) Then
                        Dim o As Orders.Order = Orders.Order.FindByBvin(Me.BvinField.Value)
                        If p.IsKit Then

                            'Determine if there are any options for this kit
                            Dim kc As Collection(Of Catalog.KitComponent) = Catalog.KitComponent.FindByGroupId(p.Groups(0).Bvin)
                            Dim hasOptions As Boolean = False
                            For Each component As Catalog.KitComponent In kc
                                If component.ComponentType <> Catalog.KitComponentType.IncludedHidden AndAlso component.ComponentType <> Catalog.KitComponentType.IncludedShown Then
                                    hasOptions = True
                                    Exit For
                                End If
                            Next

                            If hasOptions Then
                                'Kit has options, so allow user to select options before adding it
                                Me.pnlProductChoices.Visible = True
                                Me.AddProductSkuHiddenField.Value = p.Bvin
                                Me.AddNewKitComponentsDisplay.Initialize(p)

                                'Hide variants display container (we don't have any modifiers/options/choices)
                                Me.AddLineVariantsDisplayContainer.Visible = False
                            Else
                                'Kit does not have options; add to cart immediately
                                Dim li As New Orders.LineItem()
                                li.ProductId = p.Bvin
                                li.Quantity = Me.NewProductQuantity.Text.Trim
                                li.KitSelections = Services.KitService.GetKitDefaultSelections(p)
                                li.BasePrice = p.GetCurrentPrice(o.UserID, 0, li)
                                Try
                                    If o.AddItem(li) = True Then
                                        Me.BvinField.Value = o.Bvin
                                        LoadOrder()
                                        Me.MessageBox1.ShowOk("Product Added!")
                                        NewSkuField.Text = String.Empty
                                    Else
                                        Me.MessageBox1.ShowError("Kit was not added correctly. Unknown Error")
                                    End If
                                Catch ex As Exception
                                    Me.MessageBox1.ShowError("Kit was not added correctly. Error: " + ex.ToString())
                                End Try
                            End If

                        Else
                            If o.AddItem(p.Bvin, CDec(Me.NewProductQuantity.Text.Trim)) = True Then
                                Me.BvinField.Value = o.Bvin
                                LoadOrder()
                                Me.MessageBox1.ShowOk("Product Added!")
                                NewSkuField.Text = String.Empty
                            Else
                                Me.MessageBox1.ShowError("Product was not added correctly. Unknown Error")
                            End If
                        End If
                        'End If
                    End If
                End If
            Else
                ' The Product is nothing - probably because a non-existent SKU
                Me.MessageBox1.ShowWarning("That product could not be located. Please check SKU.")
            End If
        End If
        LoadOrder()
    End Sub

    Protected Sub btnAddProductBySku_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddProductBySku.Click
        AddProductBySku()
    End Sub

    Protected Sub btnCloseVariants_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCloseVariants.Click
        Me.MessageBox1.ClearMessage()
        Me.AddProductSkuHiddenField.Value = String.Empty
        Me.pnlProductChoices.Visible = False
    End Sub

    Protected Sub btnAddVariant_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddVariant.Click
        Me.MessageBox1.ClearMessage()

        Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(Me.AddProductSkuHiddenField.Value)
        If product IsNot Nothing Then
            If product.IsKit Then
                If Not Me.AddNewKitComponentsDisplay.IsValid Then
                    Me.MessageBox1.ShowWarning("Please make all kit selections first.")
                Else
                    Dim li As New Orders.LineItem()
                    li.ProductId = product.Bvin
                    li.Quantity = CDec(Me.NewProductQuantity.Text.Trim)
                    AddNewKitComponentsDisplay.WriteToLineItem(li)

                    Dim o As Orders.Order = Orders.Order.FindByBvin(Me.BvinField.Value)
                    If o.AddItem(li) Then
                        Me.AddProductSkuHiddenField.Value = String.Empty
                        Me.BvinField.Value = o.Bvin
                        LoadOrder()
                        Me.MessageBox1.ShowOk("Product added!")
                    Else
                        Me.MessageBox1.ShowError("Product was not added.")
                    End If
                    Me.pnlProductChoices.Visible = False
                End If
            Else
                Dim p As Catalog.Product = Me.VariantsDisplay1.GetSelectedProduct(Nothing)
                If Not VariantsDisplay1.IsValidCombination Then
                    Me.MessageBox1.ShowError("This is not a valid combination")
                Else
                    If Me.VariantsDisplay1.IsValid Then
                        If p IsNot Nothing Then
                            Dim li As New Orders.LineItem()
                            li.ProductId = p.Bvin
                            li.Quantity = CDec(Me.NewProductQuantity.Text.Trim)
                            VariantsDisplay1.WriteValuesToLineItem(li)
                            Dim o As Orders.Order = Orders.Order.FindByBvin(Me.BvinField.Value)
                            If (p IsNot Nothing) AndAlso (o.AddItem(li)) Then
                                Me.AddProductSkuHiddenField.Value = String.Empty
                                Me.BvinField.Value = o.Bvin
                                LoadOrder()
                                Me.MessageBox1.ShowOk("Product Added!")
                            Else
                                Me.MessageBox1.ShowError("Product was not added correctly. Unknown Error")
                            End If
                            Me.pnlProductChoices.Visible = False
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    ' NOTE: required Product Inputs cannot be validated because the 'required' setting isn't a property of the ProductInput object
    Protected Function ValidateOptions(ByVal o As Orders.Order) As BVOperationResult
        Dim result As New BVOperationResult(False, "")
        Dim errorSkus As New Collection(Of String)
        Dim errorBvins As New Collection(Of String)

        If o Is Nothing Then
            result.Success = False
            result.Message = "Order could not be found."
            Return result
        End If

        For Each li As Orders.LineItem In o.Items
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(li.ProductId)
            Dim parentP As Catalog.Product = p
            If Not String.IsNullOrEmpty(p.ParentId) Then
                parentP = Catalog.InternalProduct.FindByBvin(p.ParentId)
            End If

            ' make sure that choices have been made
            If p.Bvin = parentP.Bvin AndAlso parentP.ChoiceCombinations.Count > 0 Then
                errorSkus.Add(li.ProductSku)
                errorBvins.Add(li.Bvin)
            Else
                ' make sure that required modifiers have been chosen
                For Each cib As Catalog.ProductChoiceInputBase In parentP.ChoicesAndInputs
                    If TypeOf (cib) Is Catalog.ProductModifier Then
                        Dim modifier As Catalog.ProductModifier = CType(cib, Catalog.ProductModifier)
                        If modifier.Required Then
                            Dim lim As Orders.LineItemModifier = li.Modifiers.FirstOrDefault(Function(m) m.ModifierBvin = modifier.Bvin)
                            If lim Is Nothing OrElse String.IsNullOrEmpty(lim.Bvin) OrElse modifier.ModifierOptions.Any(Function(m) m.IsNull AndAlso m.Bvin = lim.ModifierValue) Then
                                errorSkus.Add(li.ProductSku)
                                errorBvins.Add(li.Bvin)
                                Exit For
                            End If
                        End If
                    End If
                Next
            End If
        Next

        If errorSkus.Count > 0 Then
            Dim errorMessage As String = String.Format("Your order contains the following SKU's that require you to select options: {0}", String.Join(", ", errorSkus.ToArray()))
            result.Success = False
            result.Message = errorMessage
        Else
            result.Success = True
        End If

        Return result
    End Function

#End Region

#Region " Product Editing "

    Protected Sub ItemGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles ItemsGridView.RowDeleting
        Me.MessageBox1.ClearMessage()
        Dim bvin As String = CType(ItemsGridView.DataKeys(e.RowIndex).Value, String)
        SaveOrder(False, False)
        Dim o As Orders.Order = Orders.Order.FindByBvin(Me.BvinField.Value)
        o.RemoveItem(bvin)
        LoadOrder()
    End Sub

#End Region

#Region " Line Editing "


    Protected Sub btnCancelLineEdit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancelLineEdit.Click
        Me.MessageBox1.ClearMessage()

        Me.EditLineBvin.Value = String.Empty
        Me.pnlEditLineItem.Visible = False
        Me.pnlAdd.Visible = True
    End Sub

    Protected Sub btnSaveLineEdit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveLineEdit.Click
        Me.MessageBox1.ClearMessage()

        Dim li As Orders.LineItem = Orders.LineItem.FindByBvin(Me.EditLineBvin.Value)
        If li IsNot Nothing Then
            If li.Bvin <> String.Empty Then
                Dim valid As Boolean = False
                If li.KitSelections IsNot Nothing Then
                    If Not Me.EditLineKitComponentsDisplay.IsValid Then
                        Me.MessageBox1.ShowWarning("Please make all kit selections first.")
                    Else
                        Me.EditLineKitComponentsDisplay.WriteToLineItem(li)
                        valid = True
                    End If
                    
                Else
                    Dim prod As Catalog.Product = Me.EditLineVariantsDisplay.GetSelectedProduct(Nothing)
                    If Not Me.EditLineVariantsDisplay.IsValidCombination Then
                        Me.MessageBox1.ShowError("This is not a valid combination")
                    Else
                        If Me.EditLineVariantsDisplay.IsValid Then
                            If prod IsNot Nothing Then
                                li.ProductId = prod.Bvin
                            End If
                            Me.EditLineVariantsDisplay.WriteValuesToLineItem(li)
                            Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
                            li.SetBasePrice(o.UserID)       ' force to recalculate with modifiers

                            valid = True
                        End If
                    End If
                End If
                If valid Then
                    If Orders.LineItem.Update(li) Then
                        Me.MessageBox1.ShowOk("Line Item Updated")
                        LoadOrder()

                        Me.EditLineBvin.Value = String.Empty
                        Me.pnlEditLineItem.Visible = False
                        Me.pnlAdd.Visible = True
                    End If
                End If
            End If
        End If


    End Sub

    Protected Sub ItemsGridView_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles ItemsGridView.RowUpdating
        Me.MessageBox1.ClearMessage()

        Dim bvin As String = String.Empty
        bvin = ItemsGridView.DataKeys(e.RowIndex).Value.ToString
        If bvin <> String.Empty Then
            Dim li As Orders.LineItem = Orders.LineItem.FindByBvin(bvin)
            If li IsNot Nothing Then
                Me.pnlAdd.Visible = False
                Me.pnlEditLineItem.Visible = True
                Me.EditLineBvin.Value = li.Bvin
                PopulateLineEditor(li.Bvin)

                'Me.EditLineKitComponentsDisplay.LoadFromLineItem(li)
                If li.KitSelections IsNot Nothing Then 'AndAlso Not li.KitSelections.IsEmpty Then
                    Me.EditLineVariantsDisplayContainer.Visible = False
                    Me.EditLineKitComponentsDisplay.LoadFromLineItem(li)
                Else
                    Me.EditLineVariantsDisplay.LoadFromLineItem(li)
                    Me.EditLineVariantsDisplayContainer.Visible = True
                End If
            End If
        Else
            Me.MessageBox1.ShowWarning("Unable to get line item ID for editing")
        End If
    End Sub

    Public Sub PopulateLineEditor()
        PopulateLineEditor(Me.EditLineBvin.Value)
    End Sub

    Public Sub PopulateLineEditor(ByVal lineBvin As String)
        If lineBvin <> String.Empty Then
            Dim li As Orders.LineItem = Orders.LineItem.FindByBvin(lineBvin)
            If li IsNot Nothing Then
                If li.Bvin <> String.Empty Then
                    Me.EditLineVariantsDisplay.BaseProduct = Catalog.InternalProduct.FindByBvin(li.ProductId)
                End If
            End If
        End If
    End Sub

#End Region

    Protected Sub ShippingTotalBVCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles ShippingTotalBVCustomValidator.ServerValidate
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, Nothing) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub RecalculateOffersLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles RecalculateOffersLinkButton.Click
        Dim saveResult As BVOperationResult = SaveOrder(True, False)
        If saveResult.Success Then
            RunOrderEditedWorkflow(saveResult)
        End If
        LoadOrder()
    End Sub

    Protected Sub RecalculateProductPrices_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles RecalculateProductPrices.Click
        Dim saveResult As BVOperationResult = SaveOrder(True, False)
        If saveResult.Success Then
            Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
            o.RecalculateProductPrices()
            Orders.Order.Update(o)
        End If
        LoadOrder()
    End Sub

    Protected Sub TaxExemptField_CheckChanged(ByVal sender As Object, ByVal e As EventArgs) Handles TaxExemptField.CheckedChanged, OrderDiscountAdjustments.TextChanged
        SaveOrder(False, False)
        LoadOrder()
    End Sub

    Protected Sub ShippingTotalTextBox_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ShippingTotalTextBox.TextChanged
        SaveOrder(True, False)     ' shipping discount offers must be recalculated
        LoadOrder()
    End Sub

    Protected Sub ShippingRatesList_SelectionChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ShippingRatesList.SelectedIndexChanged
        If Not String.IsNullOrEmpty(Me.ShippingRatesList.SelectedValue) Then
            Dim o As Orders.Order = Orders.Order.FindByBvin(Me.BvinField.Value)
            Dim rate As Shipping.ShippingRate = FindSelectedRate(Me.ShippingRatesList.SelectedValue, o)
            Me.ShippingTotalTextBox.Text = rate.Rate.ToString("C")
            SaveOrder(True, False)
            LoadOrder()
        End If
    End Sub

    Protected Sub AddressEditor_AddressChanged() Handles ShippingAddressEditor.AddressChanged
        SaveOrder(False, False)
        Dim o As Orders.Order = Orders.Order.FindByBvin(Me.BvinField.Value)
        LoadShippingMethodsForOrder(o)
    End Sub

    Private Sub CalculateTax(ByVal o As Orders.Order)
        o.CalculateTax()
        If TaxExemptField.Checked Then
            o.TaxTotal = 0
            o.CalculateGrandTotalOnly(False, False)
            o.CustomPropertySet("Develisys", "TaxExempt", "1")
            Orders.Order.Update(o)
        Else
            o.CustomPropertyRemove("Develisys", "TaxExempt")
            Orders.Order.Update(o)
        End If
    End Sub

    Private Sub LoadSalesPeople(ByVal o As Orders.Order)
        Me.ddlSalesPerson.DataSource = Membership.UserAccount.FindAllSalesPeople()
        Me.ddlSalesPerson.AppendDataBoundItems = True
        Me.ddlSalesPerson.Items.Add(New ListItem("- None -", ""))
        Me.ddlSalesPerson.DataValueField = "bvin"
        Me.ddlSalesPerson.DataTextField = "UserName"
        Me.ddlSalesPerson.DataBind()

        Me.ddlSalesPerson.SelectedValue = o.SalesPersonId

        ' disable editing of sales person if user isn't an admin
        Dim adminUserBvin As String = SessionManager.GetCurrentUserId()
        If Not (adminUserBvin = "30" OrElse Membership.Role.FindByUserId(SessionManager.GetCurrentUserId()).Any(Function(r) r.Bvin = WebAppSettings.AdministratorsRoleId)) Then
            Me.ddlSalesPerson.Enabled = False
        End If
    End Sub

End Class