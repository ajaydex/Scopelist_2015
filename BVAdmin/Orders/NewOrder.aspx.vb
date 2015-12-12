Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Collections.Generic
Imports System.Linq

Partial Class BVAdmin_Orders_NewOrder
    Inherits BaseAdminPage

    Private _InputsAndModifiersLoaded As Boolean = False

    Dim o As Orders.Order

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        InitializeAddresses()

        ' Tag an id to the querystring to support back button
        If Request.QueryString("id") IsNot Nothing Then
            Me.BvinField.Value = Request.QueryString("id")
        Else
            o = New Orders.Order()
            Orders.Order.Insert(o)
            Response.Redirect(String.Format("NewOrder.aspx?id={0}&uid={1}", o.Bvin, Request.QueryString("uid")))
        End If

        If Me.BvinField.Value.Trim <> String.Empty Then
            o = Orders.Order.FindByBvin(Me.BvinField.Value)
        End If

        If Not Page.IsPostBack Then
            If Not String.IsNullOrEmpty(Request.QueryString("uid")) Then
                ' load user account from query string & populate fields
                Me.UserIdField.Value = Request.QueryString("uid")
                Dim args As New Controls.UserSelectedEventArgs()
                args.UserAccount = GetSelectedUserAccount()
                UserSelected(args)
            Else
                Me.EmailAddressTextBox.Text = o.UserEmail
                Me.BillToAddress.LoadFromAddress(o.BillingAddress)
                Me.ShipToAddress.LoadFromAddress(o.ShippingAddress)

                If Not String.IsNullOrEmpty(o.UserID) Then
                    ' load user account from order object
                    Me.UserIdField.Value = o.UserID

                    If Me.BillToAddress.FirstName = String.Empty Then
                        Me.BillToAddress.FirstName = o.User.FirstName
                    End If
                    If Me.BillToAddress.LastName = String.Empty Then
                        Me.BillToAddress.LastName = o.User.LastName
                    End If
                    If Me.ShipToAddress.FirstName = String.Empty Then
                        Me.ShipToAddress.FirstName = o.User.FirstName
                    End If
                    If Me.ShipToAddress.LastName = String.Empty Then
                        Me.ShipToAddress.LastName = o.User.LastName
                    End If

                    If Me.EmailAddressTextBox.Text = String.Empty Then
                        Me.EmailAddressTextBox.Text = o.User.Email
                    End If

                    ShippingAddressBook.UserID = o.UserID
                    BillingAddressBook.UserID = o.UserID
                    ShippingAddressBook.BindAddresses()
                    BillingAddressBook.BindAddresses()
                End If
            End If

            ' hide address book controls if no user selected
            If String.IsNullOrEmpty(Me.UserIdField.Value) Then
                BillingAddressBook.Visible = False
                ShippingAddressBook.Visible = True
            End If

            LoadOrder()
            LoadPaymentMethods()
            LoadShippingMethodsForOrder(o)
            LoadSalesPeople()
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

        Me.GiftCertificates1.OrderId = o.Bvin       ' without this we will be adding gift certificates to the current user (admin) cart

        ' Only load this on postback, and only do it if the grid view has not been databound; otherwise it will all be there twice.
        If Page.IsPostBack Then
            If Not _InputsAndModifiersLoaded Then
                ViewUtilities.GetInputsAndModifiersForAdminLineItemDescription(Me.Page, ItemsGridView)
            End If
        End If

        ViewUtilities.DisplayKitInLineItem(Me.Page, ItemsGridView)

        ShippingAddressBook.UserID = o.UserID
        BillingAddressBook.UserID = o.UserID
    End Sub

    Protected Sub GiftCertificates_CertificatesChanged() Handles GiftCertificates1.CertificatesChanged
        If Not String.IsNullOrEmpty(Me.BvinField.Value) Then
            o = Orders.Order.FindByBvin(Me.BvinField.Value)
        End If
        LoadOrder()
    End Sub

    Protected Sub ItemsGridView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ItemsGridView.DataBound
        ViewUtilities.GetInputsAndModifiersForAdminLineItemDescription(Me.Page, ItemsGridView)
        _InputsAndModifiersLoaded = True
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "New Order"
        Me.CurrentTab = AdminTabType.Orders
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersEdit)
    End Sub

#Region " Loading Methods "

    Private Sub InitializeAddresses()

        Me.ShipToAddress.RequireCompany = WebAppSettings.ShipAddressRequireCompany
        Me.ShipToAddress.RequireFax = WebAppSettings.ShipAddressRequireFax
        Me.ShipToAddress.RequireFirstName = WebAppSettings.ShipAddressRequireFirstName
        Me.ShipToAddress.RequireLastName = WebAppSettings.ShipAddressRequireLastName
        Me.ShipToAddress.RequirePhone = WebAppSettings.ShipAddressRequirePhone
        Me.ShipToAddress.RequireWebSiteURL = WebAppSettings.ShipAddressRequireWebSiteURL
        Me.ShipToAddress.ShowCompanyName = WebAppSettings.ShipAddressShowCompany
        Me.ShipToAddress.ShowFaxNumber = WebAppSettings.ShipAddressShowFax
        Me.ShipToAddress.ShowMiddleInitial = WebAppSettings.ShipAddressShowMiddleInitial
        Me.ShipToAddress.ShowPhoneNumber = WebAppSettings.ShipAddressShowPhone
        Me.ShipToAddress.ShowWebSiteURL = WebAppSettings.ShipAddressShowWebSiteURL
        Me.ShipToAddress.ShowNickName = False

        Me.BillToAddress.RequireCompany = WebAppSettings.BillAddressRequireCompany
        Me.BillToAddress.RequireFax = WebAppSettings.BillAddressRequireFax
        Me.BillToAddress.RequireFirstName = WebAppSettings.BillAddressRequireFirstName
        Me.BillToAddress.RequireLastName = WebAppSettings.BillAddressRequireLastName
        Me.BillToAddress.RequirePhone = WebAppSettings.BillAddressRequirePhone
        Me.BillToAddress.RequireWebSiteURL = WebAppSettings.BillAddressRequireWebSiteURL
        Me.BillToAddress.ShowCompanyName = WebAppSettings.BillAddressShowCompany
        Me.BillToAddress.ShowFaxNumber = WebAppSettings.BillAddressShowFax
        Me.BillToAddress.ShowMiddleInitial = WebAppSettings.BillAddressShowMiddleInitial
        Me.BillToAddress.ShowPhoneNumber = WebAppSettings.BillAddressShowPhone
        Me.BillToAddress.ShowWebSiteURL = WebAppSettings.BillAddressShowWebSiteUrl
        Me.BillToAddress.ShowNickName = False
    End Sub

    Protected Sub chkBillToSame_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkBillToSame.CheckedChanged
        If chkBillToSame.Checked = True Then
            Me.BillToAddress.LoadFromAddress(Me.ShipToAddress.GetAsAddress)
            Me.pnlBillTo.Visible = False
        Else
            Me.pnlBillTo.Visible = True
        End If
        ClearShipping()
    End Sub

    Private Sub LoadOrder(ByVal bvin As String)
        o = Orders.Order.FindByBvin(bvin)
        LoadOrder()
    End Sub

    Private Sub LoadOrder()

        ' Status
        Me.StatusField.Text = o.FullOrderStatusDescription
        'Me.StatusField.Text += "<br />BVIN: " & o.Bvin

        'Items
        Me.ItemsGridView.DataSource = o.Items
        Me.ItemsGridView.DataBind()

        ' Totals
        If o.OrderDiscounts > 0 Then
            Me.SubTotalField.Text = "<span class=""MarkDownPrice"">" & String.Format("{0:c}", o.SubTotal) & "</span><br />"
            Me.SubTotalField.Text += String.Format("{0:c}", o.SubTotal - o.OrderDiscounts)

        Else
            Me.SubTotalField.Text = String.Format("{0:c}", o.SubTotal)
        End If
        Me.SubTotalField2.Text = Me.SubTotalField.Text

        Me.ShippingTotalField.Text = String.Format("{0:c}", o.ShippingTotal)
        Me.ShippingDiscountField.Text = (-o.ShippingDiscounts).ToString("C")


        Me.TaxTotalField.Text = String.Format("{0:c}", o.TaxTotal)
        Me.HandlingTotalField.Text = String.Format("{0:c}", o.HandlingTotal)
        Me.GrandTotalField.Text = String.Format("{0:c}", o.GrandTotal)

        If o.Items.Count > 0 Then
            Me.btnUpdateQuantities.Visible = True
        Else
            Me.btnUpdateQuantities.Visible = False
        End If

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

        ' Tax exempt
        Me.TaxExemptField.Checked = o.CustomPropertyExists("Develisys", "TaxExempt")

        Me.CouponGrid.DataSource = o.Coupons
        Me.CouponGrid.DataBind()

        LoadGiftCertificatesAndLoyaltyPoints(o)
    End Sub

    Protected Sub ItemGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles ItemsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lineItem As Orders.LineItem = CType(e.Row.DataItem, Orders.LineItem)
            If lineItem IsNot Nothing Then
                Dim description As Label = e.Row.FindControl("lblDescription")
                If description IsNot Nothing Then
                    If (lineItem.AssociatedProduct IsNot Nothing) Then
                        description.Text = lineItem.AssociatedProduct.Sku & "<br />" & lineItem.AssociatedProduct.ProductName
                    End If
                    If (lineItem.ProductShortDescription.Trim().Length > 0) Then
                        description.Text += "<br />" & lineItem.ProductShortDescription
                    End If
                End If

                'Only show the button if this product has variations or kit selections
                Dim btnEdit As ImageButton = e.Row.FindControl("btnEdit")
                Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(lineItem.ProductId)     'we need to load the full object to check for variants
                If Not String.IsNullOrEmpty(product.ParentId) Then
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

    Protected Sub LoadGiftCertificatesAndLoyaltyPoints(ByVal o As Orders.Order)
        Dim amountToPay As Decimal = o.GrandTotal

        If WebAppSettings.LoyaltyPointsEnabled Then
            ' re-add the user to the order in the event of a workflow step failure (e.g. credit card authorization failure)
            If String.IsNullOrEmpty(o.UserID) Then
                o.UserID = Me.UserIdField.Value
            End If

            Dim lpos As New Membership.LoyaltyPointsOrderSummary(o)

            If Not String.IsNullOrEmpty(o.UserID) Then  ' can't use SessionManager.IsUserAuthenticated because an admin user is placing an order for another user
                Me.trLoyaltyPointsEarned.Visible = True

                If lpos.AvailablePointsCurrency > 0 AndAlso amountToPay > 0 Then
                    Me.trLoyaltyPointsUsed.Visible = True

                    Me.LoyaltyPointsUsedField.Text = lpos.UsedPoints.ToString()
                    Me.LoyaltyPointsUsedCurrencyField.Text = (-1 * lpos.UsedPointsCurrency).ToString("c")

                    amountToPay -= lpos.UsedPointsCurrency
                Else
                    Me.trLoyaltyPointsUsed.Visible = False
                End If
            Else
                Me.trLoyaltyPointsUsed.Visible = False
                Me.trLoyaltyPointsEarned.Visible = False
            End If

            Me.LoyaltyPointsEarnedField.Text = lpos.EarnedPoints.ToString()
            Me.LoyaltyPointsEarnedCurrencyField.Text = lpos.EarnedPointsCurrency.ToString("c")

            Orders.Order.Update(o)  ' save order with new LoyaltyPointsDebit calculations
        Else
            Me.trLoyaltyPointsUsed.Visible = False
            Me.trLoyaltyPointsEarned.Visible = False
        End If

        ' subtract gift certificate(s)
        Dim amountAfterLoyaltyDeduction As Decimal = amountToPay
        If amountToPay > 0 Then
            If o.GiftCertificates.Count > 0 Then
                Dim giftCertificateAmount As Decimal = o.GetGiftCertificates().Sum(Function(gc) gc.CurrentAmount)
                If giftCertificateAmount > 0 Then
                    amountToPay -= giftCertificateAmount

                    If amountToPay < 0 Then
                        amountToPay = 0
                        giftCertificateAmount = amountAfterLoyaltyDeduction
                    End If

                    Me.GiftCertificateField.Text = (-1 * giftCertificateAmount).ToString("c")
                    Me.trGiftCertificateRow.Visible = True
                Else
                    Me.trGiftCertificateRow.Visible = False
                End If
            Else
                Me.trGiftCertificateRow.Visible = False
            End If
        Else
            'the entire order is covered by the loyalty points, so remove the gift certificates from the order
            o.GiftCertificates.Clear()
            SaveInfoToOrder(False, False)
            GiftCertificates1.BindGiftCertificatesGrid()
            Me.trGiftCertificateRow.Visible = False
        End If

        Me.AmountDueField.Text = amountToPay.ToString("c")
    End Sub

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
        'SaveInfoToOrder(False, False)

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
                        If ValidateInventory(p, Me.NewProductQuantity.Text.Trim) Then
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
                                            LoadOrder(o.Bvin)
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
                                    Me.MessageBox1.ShowOk("Product Added!")
                                    NewSkuField.Text = String.Empty
                                    ClearShipping()
                                Else
                                    Me.MessageBox1.ShowError("Product was not added correctly. Unknown Error")
                                End If
                            End If
                        End If
                    End If
                End If
            Else
                ' The Product is nothing - probably because a non-existent SKU
                Me.MessageBox1.ShowWarning("That product could not be located. Please check SKU.")
            End If
        End If

        LoadOrder(o.Bvin)

    End Sub

    ' NOTE: required Product Inputs cannot be validated because the 'required' setting isn't a property of the ProductInput object
    Protected Function ValidateOptions(ByVal o As Orders.Order) As Boolean
        Dim result As Boolean = True
        Dim errorSkus As New Collection(Of String)
        Dim errorBvins As New Collection(Of String)

        If o Is Nothing Then
            Return False
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
            Dim errorMessage As String = String.Format("This order contains the following SKU's that require you to select options: {0}", String.Join(", ", errorSkus.ToArray()))
            MessageBox1.ShowError(errorMessage)
            result = False
        End If

        Return result
    End Function

    Protected Sub btnAddProductBySku_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddProductBySku.Click
        If (String.IsNullOrEmpty(Me.NewSkuField.Text.Trim())) AndAlso (Me.pnlProductPicker.Visible) Then
            If Me.ProductPicker1.SelectedProducts.Count > 0 Then
                Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Me.ProductPicker1.SelectedProducts(0))
                If p IsNot Nothing Then
                    Me.NewSkuField.Text = p.Sku
                End If
                AddProductBySku()
                Me.pnlProductPicker.Visible = False
            End If
        Else
            AddProductBySku()
            Me.pnlProductPicker.Visible = False
        End If
    End Sub

    Protected Sub btnUpdateQuantities_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnUpdateQuantities.Click
        Me.MessageBox1.ClearMessage()
        'SaveInfoToOrder(False, False)

        For i As Integer = 0 To Me.ItemsGridView.Rows.Count - 1
            If ItemsGridView.Rows(i).RowType = DataControlRowType.DataRow Then
                Dim qty As TextBox = ItemsGridView.Rows(i).FindControl("QtyField")
                If qty IsNot Nothing Then
                    Dim bvin As String = CType(ItemsGridView.DataKeys(ItemsGridView.Rows(i).RowIndex).Value, String)
                    If ValidateInventoryForLineItem(bvin, qty.Text.Trim) Then
                        Dim val As String = o.UpdateItemQuantity(bvin, qty.Text.Trim).Message
                        If val <> String.Empty Then
                            MessageBox1.ShowError(val)
                        End If
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

        ClearShipping()
        LoadOrder()

    End Sub

    Protected Sub ItemGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles ItemsGridView.RowDeleting
        Me.MessageBox1.ClearMessage()
        Dim bvin As String = CType(ItemsGridView.DataKeys(e.RowIndex).Value, String)
        o.RemoveItem(bvin)
        ClearShipping()
        LoadOrder()
    End Sub

    Private Sub LoadPaymentMethods()
        Dim enabledMethods As Collection(Of Payment.PaymentMethod) = Payment.AvailablePayments.EnabledMethods()
        Dim preSelectMethod = (enabledMethods.Where(Function(pm) pm.MethodId <> WebAppSettings.PaymentIdCash).Count = 1 + If(Me.GiftCertificates1.Visible, 1, 0) + If(WebAppSettings.LoyaltyPointsEnabled, 1, 0))

        For Each m As Payment.PaymentMethod In enabledMethods
            Select Case m.MethodId
                Case WebAppSettings.PaymentIdCheck
                    Me.lblCheckDescription.Text = WebAppSettings.PaymentCheckDescription
                    Me.rowCheck.Visible = True
                    Me.rbCheck.Checked = preSelectMethod
                Case WebAppSettings.PaymentIdCreditCard
                    Me.rowCreditCard.Visible = True
                    Me.rbCreditCard.Checked = preSelectMethod
                Case WebAppSettings.PaymentIdTelephone
                    Me.lblTelephoneDescription.Text = WebAppSettings.PaymentTelephoneDescription
                    Me.rowTelephone.Visible = True
                    Me.rbTelephone.Checked = preSelectMethod
                Case WebAppSettings.PaymentIdPurchaseOrder
                    Me.lblPurchaseOrderDescription.Text = WebAppSettings.PaymentPurchaseOrderDescription
                    Me.trPurchaseOrder.Visible = True
                    Me.rbPurchaseOrder.Checked = preSelectMethod
                Case WebAppSettings.PaymentIdCashOnDelivery
                    Me.lblCOD.Text = WebAppSettings.PaymentCODDescription
                    Me.trCOD.Visible = True
                    Me.rbCOD.Checked = preSelectMethod
                Case Else
                    ' do nothing
            End Select

        Next

    End Sub

    Private Function SaveInfoToOrder(ByVal savePaymentData As Boolean, ByVal updateShippingRate As Boolean) As Boolean
        Dim result As Boolean = True

        If o IsNot Nothing Then
            If Me.chkBillToSame.Checked = True Then
                Me.BillToAddress.LoadFromAddress(Me.ShipToAddress.GetAsAddress)
            End If

            ' Save Information to Basket in Case Save as Order Fails
            o.BillingAddress = Me.BillToAddress.GetAsAddress
            o.SetShippingAddress(Me.ShipToAddress.GetAsAddress)
            TagOrderWithUser()

            o.UserEmail = Me.EmailAddressTextBox.Text
            o.Instructions = Me.InstructionsField.Text
            o.SalesPersonId = Me.ddlSalesPerson.SelectedValue

            ' Save Shipping Selection
            Dim r As Shipping.ShippingRate = FindSelectedRate(Me.ShippingRatesList.SelectedValue, o)
            o.ApplyShippingRate(r)
            Dim shippingAmount As Decimal = 0D
            If Not updateShippingRate AndAlso Decimal.TryParse(ShippingTotalField.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, shippingAmount) Then
                o.ShippingTotal = shippingAmount
            End If

            If savePaymentData Then
                ' Save Payment Information
                SavePaymentInfo(o)
            End If

            ' Apply Adjustments
            Dim adjustmentAmount As Decimal = 0D
            Decimal.TryParse(Me.OrderDiscountAdjustments.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, adjustmentAmount)
            o.CustomPropertySet("bvsoftware", "postorderadjustment", adjustmentAmount)

            ' Apply tax exemption
            CalculateTax()

            If Orders.Order.Update(o) = False Then
                result = False
            End If

        Else
            result = False
        End If

        Return result
    End Function

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
        Me.MessageBox1.ClearMessage()

        If Me.ValidateSelections() AndAlso Me.ValidateOptions(o) Then
            If o IsNot Nothing Then
                SaveInfoToOrder(True, False)

                ' InstructionsField is now saved to o.Instructions in the SaveInfoToOrder function
                ''we can't put this in "SaveInfoToOrder" because
                ''that is called multiple times on the page
                'Dim note As New Orders.OrderNote()
                'note.Note = InstructionsField.Text
                'note.NoteType = Orders.OrderNoteType.Private
                'o.AddNote(note)

                ' Save as Order
                Dim c As New BusinessRules.OrderTaskContext
                c.UserId = String.Empty
                ' Use currently selected user for process new order context
                Dim u As Membership.UserAccount = GetSelectedUserAccount()
                If u IsNot Nothing Then
                    If u.Bvin <> String.Empty Then
                        c.UserId = u.Bvin
                        o.UserID = u.Bvin
                    End If
                End If
                c.Order = o

                CalculateTax()

                If WebAppSettings.LoyaltyPointsEnabled Then
                    ' tag order to receive loyalty points
                    o.CustomPropertySet("Develisys", "ValidForLoyaltyPoints", Boolean.TrueString)

                    Dim pointsUsedCurrency As Decimal = 0D
                    If Decimal.TryParse(o.CustomPropertyGet("Develisys", "LoyaltyPointsDebitCurrency"), pointsUsedCurrency) AndAlso pointsUsedCurrency > 0 Then
                        Dim op As New Orders.OrderPayment()
                        op.PaymentMethodName = New Payment.Method.LoyaltyPoints().MethodName
                        op.PaymentMethodId = New Payment.Method.LoyaltyPoints().MethodId
                        op.OrderID = o.Bvin

                        If Not o.AddPayment(op) Then
                            AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Payment, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, "Loyalty Points", "Unable to save loyalty points payment to order")
                        End If
                    End If
                End If

                If BusinessRules.Workflow.RunByName(c, "Process New Order") Then
                    Dim current As Membership.UserAccount = SessionManager.GetCurrentUser()
                    If (current Is Nothing) Then
                        current = New Membership.UserAccount()
                    End If

                    AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Orders, _
                                       BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success, _
                                        "Order created by admin", "Order " & o.OrderNumber & " was created by " & current.Email & ".")

                    Response.Redirect("ViewOrder.aspx?id=" & o.Bvin)
                Else
                    ' Show Errors   
                    Dim errorString As String = String.Empty
                    For i As Integer = 0 To c.Errors.Count - 1
                        errorString += c.Errors(i).Description & "<br />"
                    Next
                    If errorString.Length > 0 Then
                        Me.MessageBox1.ShowWarning(errorString)
                    End If
                End If
            End If
        End If
    End Sub

    Private Function ValidateSelections() As Boolean
        Dim result As Boolean = True

        If ((Me.ShippingRatesList.SelectedValue Is Nothing) OrElse (Me.ShippingRatesList.SelectedIndex = -1) Or (Me.ShippingRatesList.SelectedValue = String.Empty)) Then
            MessageBox1.ShowWarning("Please Select a Shipping Method")
            result = False
        End If

        Dim paymentFound As Boolean = False

        If Me.rbCreditCard.Checked = True Then
            paymentFound = True
            If Me.CreditCardInput1.Validate = False Then
                For Each item As String In Me.CreditCardInput1.ValidateErrors
                    Me.MessageBox1.ShowWarning(item)
                Next
                result = False
            End If
        End If
        If Me.rbCheck.Checked = True Then
            paymentFound = True
        End If
        If Me.rbTelephone.Checked = True Then
            paymentFound = True
        End If
        If Me.rbPurchaseOrder.Checked = True Then
            paymentFound = True
        End If
        If Me.rbCOD.Checked = True Then
            paymentFound = True
        End If

        If paymentFound = False Then
            Me.MessageBox1.ShowWarning("Please select a Payment Method")
            result = False
        End If

        Return result
    End Function

    Private Function GetSelectedUserAccount() As Membership.UserAccount
        Dim result As Membership.UserAccount = Nothing

        If Not String.IsNullOrEmpty(Me.UserIdField.Value) Then
            result = Membership.UserAccount.FindByBvin(Me.UserIdField.Value)
        End If

        Return result
    End Function

    Private Sub TagOrderWithUser()
        TagOrderWithUser(GetSelectedUserAccount())
    End Sub

    Private Sub TagOrderWithUser(ByVal account As Membership.UserAccount)
        Dim u As Membership.UserAccount = account
        If u IsNot Nothing Then
            If u.Bvin <> String.Empty Then
                Me.UserIdField.Value = u.Bvin
                o.UserID = u.Bvin
                Me.BillToAddress.GetAsAddress.CopyTo(u.BillingAddress)
                Me.ShipToAddress.GetAsAddress.CopyTo(u.ShippingAddress)
                Membership.UserAccount.Update(u)
            End If
        End If
    End Sub

    Private Sub SavePaymentInfo(ByVal o As Orders.Order)
        o.Payments.Clear()
        Dim found As Boolean = False
        Dim p As New Orders.OrderPayment
        p.OrderID = o.Bvin
        p.AuditDate = DateTime.Now

        If Me.rbCreditCard.Checked = True Then
            found = True
            p.PaymentMethodName = "Credit Card"
            p.PaymentMethodId = WebAppSettings.PaymentIdCreditCard
            Me.CreditCardInput1.CopyToPayment(p)
        End If

        If (found = False) AndAlso (Me.rbCheck.Checked = True) Then
            found = True
            p.PaymentMethodName = WebAppSettings.PaymentCheckName
            p.PaymentMethodId = WebAppSettings.PaymentIdCheck
        End If

        If (found = False) AndAlso (Me.rbTelephone.Checked = True) Then
            found = True
            p.PaymentMethodName = WebAppSettings.PaymentTelephoneName
            p.PaymentMethodId = WebAppSettings.PaymentIdTelephone
        End If

        If (found = False) AndAlso (Me.rbPurchaseOrder.Checked = True) Then
            found = True
            p.PaymentMethodName = WebAppSettings.PaymentPurchaseOrderName
            p.PaymentMethodId = WebAppSettings.PaymentIdPurchaseOrder
            p.PurchaseOrderNumber = Me.PurchaseOrderField.Text.Trim
        End If

        If (found = False) AndAlso (Me.rbCOD.Checked = True) Then
            found = True
            p.PaymentMethodName = WebAppSettings.PaymentCODName
            p.PaymentMethodId = WebAppSettings.PaymentIdCashOnDelivery
        End If

        If found Then
            o.AddPayment(p)
        End If

        If o.GiftCertificates.Count > 0 Then
            For Each item As String In o.GiftCertificates
                p = New Orders.OrderPayment()
                p.OrderID = o.Bvin
                p.AuditDate = DateTime.Now
                p.GiftCertificateNumber = item
                p.PaymentMethodName = "Gift Certificate"
                p.PaymentMethodId = WebAppSettings.PaymentIdGiftCertificate
                o.AddPayment(p)
            Next
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
            Dim rates As Utilities.SortableCollection(Of Shipping.ShippingRate) = SessionManager.LastShippingRates
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

    Private Sub LoadShippingMethodsForOrder(ByVal o As Orders.Order)
        ' Shipping Methods
        Me.ShippingRatesList.Items.Clear()

        If o.HasShippingItems = False Then
            Me.ShippingRatesList.Items.Add(New ListItem("No Shipping Required", "NOSHIPPING"))
        Else
            Dim Rates As Utilities.SortableCollection(Of Shipping.ShippingRate)
            Rates = o.FindAvailableShippingRates()
            SessionManager.LastShippingRates = Rates
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

    Private Sub ClearShipping()
        Dim selectedValue As String = Me.ShippingRatesList.SelectedValue
        Me.ShippingRatesList.ClearSelection()
        Me.ShippingRatesList.Items.Clear()
        LoadShippingMethodsForOrder(o)

        If Me.ShippingRatesList.Items.FindByValue(selectedValue) IsNot Nothing Then
            Me.ShippingRatesList.SelectedValue = selectedValue
        End If
        If Me.ShippingRatesList.SelectedValue IsNot Nothing Then
            SaveInfoToOrder(False, ViewState("ShippingChanged") Is Nothing)
            LoadOrder()
        Else
            LoadGiftCertificatesAndLoyaltyPoints(o)
        End If
    End Sub

    Protected Sub btnAddCoupon_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddCoupon.Click
        SaveInfoToOrder(False, False)
        MessageBox1.ClearMessage()
        Dim couponResult As BVOperationResult = o.AddCouponCode(Me.CouponField.Text.Trim, True)
        If couponResult.Success = False Then
            MessageBox1.ShowError(couponResult.Message)
        End If
        LoadOrder()
        LoadShippingMethodsForOrder(o)
    End Sub

    Protected Sub CouponGrid_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles CouponGrid.RowDeleting
        SaveInfoToOrder(False, False)
        Me.MessageBox1.ClearMessage()
        Dim code As String = String.Empty
        code = CStr(Me.CouponGrid.DataKeys(e.RowIndex).Value)
        If code <> String.Empty Then
            o.RemoveCouponCode(code)
        End If
        LoadOrder()
        LoadShippingMethodsForOrder(o)
    End Sub

    Protected Sub UserSelected(ByVal args As Controls.UserSelectedEventArgs)
        Me.UserIdField.Value = args.UserAccount.Bvin

        o.UserID = args.UserAccount.Bvin
        Orders.Order.Update(o)
        Me.LoadOrder(o.Bvin)     ' needed to recalculate product prices

        Me.BillToAddress.LoadFromAddress(args.UserAccount.BillingAddress)
        Me.ShipToAddress.LoadFromAddress(args.UserAccount.ShippingAddress)
        If Me.BillToAddress.FirstName = String.Empty Then
            Me.BillToAddress.FirstName = args.UserAccount.FirstName
        End If
        If Me.BillToAddress.LastName = String.Empty Then
            Me.BillToAddress.LastName = args.UserAccount.LastName
        End If
        If Me.ShipToAddress.FirstName = String.Empty Then
            Me.ShipToAddress.FirstName = args.UserAccount.FirstName
        End If
        If Me.ShipToAddress.LastName = String.Empty Then
            Me.ShipToAddress.LastName = args.UserAccount.LastName
        End If

        Me.EmailAddressTextBox.Text = args.UserAccount.Email

        ShippingAddressBook.UserID = o.UserID
        BillingAddressBook.UserID = o.UserID
        ShippingAddressBook.BindAddresses()
        BillingAddressBook.BindAddresses()

        o.SetShippingAddress(Me.ShipToAddress.GetAsAddress())
        o.BillingAddress = Me.BillToAddress.GetAsAddress()
        ClearShipping()
    End Sub
    Protected Sub AddressSelected(ByVal addressType As String, ByVal address As Contacts.Address) Handles ShippingAddressBook.AddressSelected, BillingAddressBook.AddressSelected
        If String.Compare(addressType, "Billing", True) = 0 Then
            BillToAddress.LoadFromAddress(address)
        ElseIf String.Compare(addressType, "Shipping", True) = 0 Then
            ShipToAddress.LoadFromAddress(address)
        End If

        SaveInfoToOrder(False, False)
        ClearShipping()
        LoadOrder()
    End Sub
    Protected Sub btnCloseVariants_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCloseVariants.Click
        Me.MessageBox1.ClearMessage()
        Me.pnlProductChoices.Visible = False
    End Sub

    Protected Sub btnAddVariant_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddVariant.Click
        Me.MessageBox1.ClearMessage()

        Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Me.AddProductSkuHiddenField.Value)

        If p IsNot Nothing Then
            If p.IsKit Then
                If Not Me.AddNewKitComponentsDisplay.IsValid Then
                    Me.MessageBox1.ShowWarning("Please make all kit selections first.")
                Else
                    Dim li As New Orders.LineItem()
                    li.ProductId = p.Bvin
                    li.Quantity = CDec(Me.NewProductQuantity.Text.Trim)
                    AddNewKitComponentsDisplay.WriteToLineItem(li)

                    If o.AddItem(li) Then
                        Me.AddProductSkuHiddenField.Value = String.Empty
                        Me.BvinField.Value = o.Bvin
                        Me.MessageBox1.ShowOk("Product added!")
                    Else
                        Me.MessageBox1.ShowError("Product was not added.")
                    End If
                    Me.pnlProductChoices.Visible = False
                End If
            Else
                p = Me.VariantsDisplay1.GetSelectedProduct(Nothing)
                If Not VariantsDisplay1.IsValidCombination Then
                    Me.MessageBox1.ShowError("This is not a valid combination")
                Else
                    If Me.VariantsDisplay1.IsValid Then
                        If p IsNot Nothing Then

                            If ValidateInventory(p, Me.NewProductQuantity.Text.Trim) Then
                                Dim li As New Orders.LineItem()
                                li.ProductId = p.Bvin
                                li.Quantity = CDec(Me.NewProductQuantity.Text.Trim)
                                VariantsDisplay1.WriteValuesToLineItem(li)
                                If (p IsNot Nothing) AndAlso (o.AddItem(li)) Then
                                    Me.AddProductSkuHiddenField.Value = String.Empty
                                    Me.BvinField.Value = o.Bvin
                                    'LoadOrder(o.Bvin)
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
        End If

        ClearShipping()
        LoadOrder()
    End Sub

    Protected Function ValidateInventoryForLineItem(ByVal lineItemBvin As String, ByVal qty As String) As Boolean
        Dim result As Boolean = True
        Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(lineItemBvin)
        If p IsNot Nothing Then
            result = ValidateInventory(p, qty)
        End If
        Return result
    End Function

    Protected Function ValidateInventory(ByVal p As Catalog.Product, ByVal qty As String) As Boolean
        Dim result As Boolean = True

        Dim quantity As Decimal = 1
        Decimal.TryParse(qty, quantity)
        If quantity < 1 Then
            Return True
        End If

        Dim inv As Catalog.ProductInventory = Catalog.ProductInventory.FindByProductId(p.Bvin, p.TrackInventory)
        If inv.Bvin <> String.Empty Then
            If inv.QuantityAvailableForSale >= quantity Then
                result = True
            Else
                result = False

                ' Quantity is less but inventory settings may allow back orders
                If inv.Status = Catalog.ProductInventoryStatus.Available Then
                    result = True
                End If

                If result = False Then
                    MessageBox1.ShowWarning("Only " & inv.QuantityAvailableForSale.ToString() & " of the item " & p.Sku & " are available for purchase. Please adjust your requested amount.")
                End If
            End If
        End If

        Return result
    End Function

#Region " Find User Code "

    Protected Sub btnFindUsers_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFindUsers.Click
        Me.viewFindUsers.ActiveViewIndex = "0"
        ToggleUserTabActiveState(sender)
    End Sub

    Protected Sub btnNewUsers_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewUsers.Click
        Me.viewFindUsers.ActiveViewIndex = "1"
        ToggleUserTabActiveState(sender)
    End Sub

    Protected Sub btnFindOrders_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFindOrders.Click
        Me.viewFindUsers.ActiveViewIndex = "2"
        ToggleUserTabActiveState(sender)
    End Sub

    Private Sub ToggleUserTabActiveState(ByVal tab As LinkButton)
        Me.btnFindUsers.CssClass = String.Empty
        Me.btnNewUsers.CssClass = String.Empty
        Me.btnFindOrders.CssClass = String.Empty

        tab.CssClass = "active"
    End Sub

    Protected Sub btnGoFindOrder_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGoFindOrder.Click
        Me.lblFindOrderMessage.Text = String.Empty

        Dim c As New Orders.OrderSearchCriteria()
        c.OrderNumber = Me.FindOrderNumberField.Text.Trim()
        c.IsPlaced = True
        c.StartDate = DateTime.Now.AddYears(-5)
        c.EndDate = DateTime.Now.AddYears(1)

        Dim found As Boolean = False

        Dim results As Collection(Of Orders.Order) = Orders.Order.FindByCriteria(c)
        If results IsNot Nothing Then
            If results.Count > 0 Then
                found = True
                Dim args As New BVSoftware.Bvc5.Core.Controls.UserSelectedEventArgs()
                args.UserAccount = Membership.UserAccount.FindByBvin(results(0).UserID)
                Me.UserSelected(args)
            End If
        End If

        If Not found Then
            Me.lblFindOrderMessage.Text = "<span class=""errormessage"">That order was not found</span>"
        End If
    End Sub

    Protected Sub btnNewUserSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewUserSave.Click
        Me.lblNewUserMessage.Text = String.Empty
        Dim u As New Membership.UserAccount
        u.UserName = Me.NewUserEmailField.Text.Trim()
        u.Email = Me.NewUserEmailField.Text.Trim()
        u.FirstName = Me.NewUserFirstNameField.Text.Trim()
        u.LastName = Me.NewUserLastNameField.Text.Trim()
        u.Password = Membership.UserAccount.GeneratePassword(12)
        u.PasswordFormat = WebAppSettings.PasswordDefaultEncryption
        Dim createResult As New Membership.CreateUserStatus
        If Membership.UserAccount.Insert(u, createResult) = True Then

            Dim args As New BVSoftware.Bvc5.Core.Controls.UserSelectedEventArgs()
            args.UserAccount = Membership.UserAccount.FindByBvin(u.Bvin)
            Me.UserSelected(args)
        Else
            Select Case createResult
                Case Membership.CreateUserStatus.DuplicateUsername
                    Me.lblNewUserMessage.Text = "<span class=""errormessage"">The username " & Me.NewUserEmailField.Text.Trim & " already exists. Please select another email address.</span>"
                Case Membership.CreateUserStatus.InvalidPassword
                    Me.lblNewUserMessage.Text = "<span class=""errormessage"">Unable to create this account. Invalid Password</span>"
                Case Else
                    Me.lblNewUserMessage.Text = "<span class=""errormessage"">Unable to create this account. Unknown Error.</span>"
            End Select
        End If
    End Sub

    Protected Sub btnFindUser_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFindUser.Click
        Me.lblNewUserMessage.Text = String.Empty
        Me.GridView1.Visible = False

        Dim c As New Membership.UserSearchCriteria()
        If Me.FindUserEmailField.Text.Trim().Length > 0 Then
            c.Email = Me.FindUserEmailField.Text.Trim()
        End If
        If Me.FindUserFirstNameField.Text.Trim().Length > 0 Then
            c.FirstName = Me.FindUserFirstNameField.Text.Trim()
        End If
        If Me.FindUserLastNameField.Text.Trim().Length > 0 Then
            c.LastName = Me.FindUserLastNameField.Text.Trim()
        End If

        Dim total As Integer = 0

        Dim found = False
        Dim users As Collection(Of Membership.UserAccount) = Membership.UserAccount.FindByCriteria(c, 0, 50, total)
        If users IsNot Nothing Then
            If users.Count > 0 Then
                found = True

                If users.Count = 1 Then
                    Me.lblFindUserMessage.Text = "<span class=""successmessage"">User " & users(0).Email & " Found and Selected</span>"
                    Dim args As New BVSoftware.Bvc5.Core.Controls.UserSelectedEventArgs()
                    args.UserAccount = users(0)
                    Me.UserSelected(args)
                Else
                    Me.lblFindUserMessage.Text = "<span class=""successmessage"">Found " & total.ToString() & " matching users.</span>"
                    Me.GridView1.Visible = True
                    Me.GridView1.DataSource = users
                    Me.GridView1.DataBind()
                End If
            End If
        End If

        If Not found Then
            Me.lblFindUserMessage.Text = "<span class=""errormessage"">No matching users were found.</span>"
        End If
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CStr(GridView1.DataKeys(e.NewEditIndex).Value)
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(bvin)
        Dim args As New BVSoftware.Bvc5.Core.Controls.UserSelectedEventArgs()
        args.UserAccount = u
        Me.UserSelected(args)
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
                    If Not EditLineVariantsDisplay.IsValidCombination Then
                        Me.MessageBox1.ShowError("This is not a valid combination")
                    Else
                        If Me.EditLineVariantsDisplay.IsValid Then
                            If prod IsNot Nothing Then
                                li.ProductId = prod.Bvin
                            End If
                            Me.EditLineVariantsDisplay.WriteValuesToLineItem(li)
                            valid = True
                        End If
                    End If
                End If
                If valid Then
                    If Orders.LineItem.Update(li) Then
                        Me.MessageBox1.ShowOk("Line Item Updated")
                        o = Orders.Order.FindByBvin(li.OrderBvin)
                        LoadOrder()

                        Me.EditLineBvin.Value = String.Empty
                        Me.pnlEditLineItem.Visible = False
                        Me.pnlAdd.Visible = True

                        ClearShipping()
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

                If li.KitSelections IsNot Nothing Then
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

    Protected Sub CustomValues_Changed(ByVal sender As Object, ByVal e As EventArgs) Handles TaxExemptField.CheckedChanged, OrderDiscountAdjustments.TextChanged
        SaveInfoToOrder(False, False)
        LoadOrder()
    End Sub

    Protected Sub ShippingTotalField_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ShippingTotalField.TextChanged
        ViewState("ShippingChanged") = "1"
        SaveInfoToOrder(False, False)
        LoadOrder()
    End Sub

    Protected Sub ShippingRatesList_SelectionChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ShippingRatesList.SelectedIndexChanged
        ViewState("ShippingChanged") = Nothing
        SaveInfoToOrder(False, True)
        CalculateTax()
        LoadOrder()
    End Sub

    Protected Sub AddressEditor_AddressChanged() Handles ShipToAddress.AddressChanged
        SaveInfoToOrder(False, False)
        ClearShipping()
        LoadOrder()
    End Sub

    Private Sub CalculateTax()
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

    Private Sub LoadSalesPeople()
        Me.ddlSalesPerson.DataSource = Membership.UserAccount.FindAllSalesPeople()
        Me.ddlSalesPerson.AppendDataBoundItems = True
        Me.ddlSalesPerson.Items.Add(New ListItem("- None -", ""))
        Me.ddlSalesPerson.DataValueField = "bvin"
        Me.ddlSalesPerson.DataTextField = "UserName"
        Me.ddlSalesPerson.DataBind()

        If String.IsNullOrEmpty(o.SalesPersonId) Then
            ' pre-select current user if they're a sales person
            Dim adminUser As Membership.UserAccount = SessionManager.GetCurrentUser()
            If adminUser.IsSalesPerson Then
                Me.ddlSalesPerson.SelectedValue = adminUser.Bvin
            End If
        Else
            Me.ddlSalesPerson.SelectedValue = o.SalesPersonId
        End If
    End Sub

End Class