Imports BVSoftware.BVC5.Core
Imports System.Collections.ObjectModel
Imports System.Linq
Imports System.Reflection

Partial Class BVModules_Themes_Foundation4_Responsive_Pages_Cart
    Inherits BaseStorePage

    Private _InputsAndModifiersLoaded As Boolean = False

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Cart.master")
        Me.PageTitle = "Shopping Cart"
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Utilities.WebForms.MakePageNonCacheable(Me)

        Me.btnContinueShopping.ImageUrl = PersonalizationServices.GetThemedButton("ContinueShopping")
        Me.btnUpdateQuantities.ImageUrl = PersonalizationServices.GetThemedButton("Update")
        Me.btnCheckout.ImageUrl = PersonalizationServices.GetThemedButton("Checkout")
        Me.btnAddCoupon.ImageUrl = PersonalizationServices.GetThemedButton("Go")

        Me.EstimateShipping1.Visible = (Not WebAppSettings.DisplayShippingCalculatorInShoppingCart)

        MessageBox1.ClearMessage()

        If Not Page.IsPostBack Then
            CheckForQuickAdd()
        End If

        LoadCart()
        If Page.IsPostBack Then
            If Not _InputsAndModifiersLoaded Then
                ViewUtilities.GetInputsAndModifiersForLineItemDescription(Me.Page, ItemGridView)
            End If
        End If
        'AddHandler CrossSellDisplay.AddToCartClicked, AddressOf Me.AddToCartClicked
    End Sub

    Protected Sub ItemGridView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ItemGridView.DataBound
        ViewUtilities.DisplayKitInLineItem(Me.Page, ItemGridView, True)
        ViewUtilities.GetInputsAndModifiersForLineItemDescription(Me.Page, ItemGridView)
        _InputsAndModifiersLoaded = True
    End Sub

    Public Sub CheckForQuickAdd()
        If Me.Request.QueryString("quickaddid") IsNot Nothing Then
            Dim bvin As String = Request.QueryString("quickaddid")
            Dim prod As Catalog.Product = Catalog.InternalProduct.FindByBvin(bvin)
            If prod IsNot Nothing Then
                Dim quantity As Integer = 1
                If Me.Request.QueryString("quickaddqty") IsNot Nothing Then
                    Dim val As Integer = 0
                    If Integer.TryParse(Request.QueryString("quickaddqty"), val) Then
                        quantity = val
                    End If
                End If
                Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
                If Basket.AddItem(bvin, quantity) Then
                    Orders.Order.Update(Basket)
                End If
            End If
        ElseIf Me.Request.QueryString("quickaddsku") IsNot Nothing Then
            Dim sku As String = Request.QueryString("quickaddsku")
            Dim prod As Catalog.Product = Catalog.InternalProduct.FindBySkuAll(sku)
            If prod IsNot Nothing Then
                Dim quantity As Integer = 1
                If Me.Request.QueryString("quickaddqty") IsNot Nothing Then
                    Dim val As Integer = 0
                    If Integer.TryParse(Request.QueryString("quickaddqty"), val) Then
                        quantity = val
                    End If
                End If
                Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
                If Basket.AddItem(prod.Bvin, quantity) Then
                    Orders.Order.Update(Basket)
                End If
            End If
        ElseIf Me.Request.QueryString("multi") IsNot Nothing Then
            Dim skus As String() = Request.QueryString("multi").Split(";")
            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
            Dim addedParts As Boolean = False

            For Each s As String In skus
                Dim skuparts As String() = s.Split(":")
                Dim newsku As String = skuparts(0)
                Dim bvin As String = String.Empty
                Dim p As Catalog.Product = Catalog.InternalProduct.FindBySkuAll(newsku)
                If p IsNot Nothing Then
                    If p.Bvin.Trim().Length > 0 Then
                        If p.IsKit Then
                            Me.MessageBox1.ShowWarning("The 'Multi' Parameter does not support kits at this time.")
                        Else
                            Dim qty As Integer = 1
                            If skuparts.Length > 1 Then
                                Integer.TryParse(skuparts(1), qty)
                            End If
                            If qty < 1 Then
                                qty = 1
                            End If
                            Basket.AddItem(p.Bvin, qty)
                            addedParts = True
                        End If
                    End If
                End If
            Next
            If addedParts Then
                Orders.Order.Update(Basket)
            End If
        End If
    End Sub

    Private Sub LoadCart()
        Dim Basket As Orders.Order = Nothing
        If Not String.IsNullOrEmpty(SessionManager.CurrentCartID) Then
            Basket = SessionManager.CurrentShoppingCart
        End If

        If (Basket Is Nothing OrElse Basket.Items Is Nothing) OrElse ((Basket.Items IsNot Nothing) AndAlso (Basket.Items.Count <= 0)) Then
            Me.lblempty.Text = "Your shopping cart is empty! <a href=""" & Page.ResolveUrl(GetKeepShoppingLocation()) & """>Keep Shopping</a> &gt;&gt;"
            Me.pnlWholeCart.Visible = False
        Else
            If Basket.TotalQuantity > 1 Then
                Me.lblcart.Text = " - " & Basket.TotalQuantity.ToString("#") & " Items"
            Else
                Me.lblcart.Text = " - " & Basket.TotalQuantity.ToString("#") & " Item"
            End If

            Me.pnlWholeCart.Visible = True

            Me.lblSubTotal.Text = String.Format("{0:c}", Basket.SubTotal)
            If Basket.OrderDiscounts > 0 Then
                Me.trDiscounts.Visible = True
                Me.lblDiscounts.Text = "-" & String.Format("{0:c}", Basket.OrderDiscounts)
                'Me.lblDiscounts.Text += "<br />" & String.Format("{0:c}", (Basket.SubTotal - Basket.OrderDiscounts))
            Else
                Me.trDiscounts.Visible = False
            End If
            'Me.lblGrandTotal.Text = String.Format("{0:c}", Basket.GrandTotal)

            Me.ItemGridView.DataSource = Basket.Items
            Me.ItemGridView.DataBind()

            If Basket.TotalQuantity <= 0 Then
                cartactioncheckout.Visible = False
            End If

            Me.CouponGrid.DataSource = Basket.Coupons
            Me.CouponGrid.DataBind()

            If Not Page.IsPostBack Then
                If WebAppSettings.DisplayCrossSellsInShoppingCart AndAlso (Basket.LastProductUpdatedOrAdded <> String.Empty) Then
                    Me.CrossSellDisplay.Product = Catalog.InternalProduct.FindByBvin(Basket.LastProductUpdatedOrAdded)
                    Me.CrossSellDisplay.DataBind()
                Else
                    Me.CrossSellDisplay.DataBind()
                End If
            End If
        End If
    End Sub

    Protected Sub btnContinueShopping_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnContinueShopping.Click
        MessageBox1.ClearMessage()
        Dim destination As String = GetKeepShoppingLocation()
        Response.Redirect(destination)
    End Sub

    Private Function GetKeepShoppingLocation() As String
        Dim result As String = "~"
        If SessionManager.CategoryLastId <> String.Empty Then
            Dim c As Catalog.Category = Catalog.Category.FindByBvin(SessionManager.CategoryLastId)
            If c IsNot Nothing Then
                If c.Bvin <> String.Empty Then
                    result = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, Catalog.Category.FindAllLight())
                End If
            End If
        End If
        Return result
    End Function


    Protected Sub ItemGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles ItemGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lineItem As Orders.LineItem = CType(e.Row.DataItem, Orders.LineItem)
            If lineItem IsNot Nothing Then

                Dim img As System.Web.UI.WebControls.Image = CType(e.Row.FindControl("imgProduct"), System.Web.UI.WebControls.Image)
                If img IsNot Nothing Then
                    If WebAppSettings.HideCartImages Then
                        img.Visible = False
                    Else
                        img.Visible = True

                        If (lineItem.AssociatedProduct IsNot Nothing) Then
                            img.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(lineItem.AssociatedProduct.ImageFileSmall, True))
                            img.AlternateText = HttpUtility.HtmlEncode(lineItem.AssociatedProduct.ImageFileSmallAlternateText)

                            ' Force Image Size
                            ViewUtilities.ForceImageSize(img, lineItem.AssociatedProduct.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)
                        End If
                    End If
                End If

                Dim description As LinkButton = CType(e.Row.FindControl("DescriptionLinkButton"), LinkButton)
                If description IsNot Nothing Then
                    If (lineItem.AssociatedProduct IsNot Nothing) Then
                        description.Text = "<span class=""cartproductname"">" & lineItem.AssociatedProduct.ProductName & "</span> <em class=""cartsku"">" & lineItem.AssociatedProduct.Sku & "</em>"
                    End If
                    description.CommandName = "EditProduct"
                    description.CommandArgument = lineItem.Bvin
                End If

                If WebAppSettings.InventoryMode = Catalog.StoreProductInventoryMode.ReserveOnOrder Then
                    If lineItem.AssociatedProduct IsNot Nothing Then
                        If lineItem.AssociatedProduct.IsKit Then
                            Dim ks As Catalog.KitSelections = lineItem.KitSelections
                            If lineItem.AssociatedProduct.IsKitOutOfStock(ks) Then
                                description.Text = description.Text & "<div class=""outofstock"">" & Content.SiteTerms.GetTerm("OutOfStockNoPurchase") & "</div>"
                                MessageBox1.ShowInformation(Content.SiteTerms.ReplaceTermVariable(Content.SiteTerms.GetTerm("CartOutOfStock"), "ProductName", lineItem.ProductName))
                            ElseIf lineItem.AssociatedProduct.IsKitLowStock(lineItem.Quantity, ks) Then
                                description.Text = description.Text & "<div class=""lowstock"">" & Content.SiteTerms.GetTerm("LowStockLineItem") & " Only " & lineItem.AssociatedProduct.KitQuantityAvailableForSale(ks).ToString("0") & " are available.</div>"
                                MessageBox1.ShowInformation(Content.SiteTerms.ReplaceTermVariable(Content.SiteTerms.GetTerm("CartNotEnoughQuantity"), "ProductName", lineItem.ProductName))
                            ElseIf lineItem.AssociatedProduct.IsKitBackordered(ks) Then
                                description.Text = description.Text & "<div class=""backordered"">" & Content.SiteTerms.GetTerm("OutOfStockAllowPurchase") & "</div>"
                            End If
                        Else
                            If lineItem.AssociatedProduct.IsOutOfStock Then
                                description.Text = description.Text & "<div class=""outofstock"">" & Content.SiteTerms.GetTerm("OutOfStockNoPurchase") & "</div>"
                                MessageBox1.ShowInformation(Content.SiteTerms.ReplaceTermVariable(Content.SiteTerms.GetTerm("CartOutOfStock"), "ProductName", lineItem.ProductName))
                            ElseIf lineItem.AssociatedProduct.IsLowStock(lineItem.Quantity) Then
                                description.Text = description.Text & "<div class=""lowstock"">" & Content.SiteTerms.GetTerm("LowStockLineItem") & " Only " & lineItem.AssociatedProduct.QuantityAvailableForSale.ToString("0") & " are available.</div>"
                                MessageBox1.ShowInformation(Content.SiteTerms.ReplaceTermVariable(Content.SiteTerms.GetTerm("CartNotEnoughQuantity"), "ProductName", lineItem.ProductName))
                            ElseIf lineItem.AssociatedProduct.IsBackordered Then
                                description.Text = description.Text & "<div class=""backordered"">" & Content.SiteTerms.GetTerm("OutOfStockAllowPurchase") & "</div>"
                            End If
                        End If
                    End If
                ElseIf WebAppSettings.InventoryMode = Catalog.StoreProductInventoryMode.ReserveAtCart Then
                    If lineItem.AssociatedProduct IsNot Nothing Then
                        If lineItem.AssociatedProduct.IsBackordered Then
                            description.Text = description.Text & "<div class=""backordered"">" & Content.SiteTerms.GetTerm("OutOfStockAllowPurchase") & "</div>"
                            MessageBox1.ShowInformation(Content.SiteTerms.GetTerm("CartBackOrdered"))
                        End If
                    End If
                End If

                Dim quantityChanged As String = lineItem.CustomPropertyGet("bvsoftware", "quantitychanged")
                If Not String.IsNullOrEmpty(quantityChanged) Then
                    description.Text = description.Text & "<div class=""quantitychanged"">" & Content.SiteTerms.GetTerm("QuantityChanged") & "</div>"
                    MessageBox1.ShowInformation(Content.SiteTerms.GetTerm("LineItemsChanged"))

                    If lineItem.CustomPropertyRemove("bvsoftware", "quantitychanged") Then
                        Orders.LineItem.Update(lineItem)
                    End If
                End If
                
                Dim btnDelete As ImageButton = e.Row.FindControl("btnDelete")
                If btnDelete IsNot Nothing Then
                    btnDelete.ImageUrl = PersonalizationServices.GetThemedButton("x")
                End If

                ' 5.4 Gift Wrap Code
                Dim btnGiftWrap As ImageButton = e.Row.FindControl("btnGiftWrap")
                Dim lblGiftWrap As Label = e.Row.FindControl("lblgiftwrap")
                Dim lblGiftWrapQty As Literal = e.Row.FindControl("lblgiftwrapqty")
                Dim lblgiftwrapprice As Literal = e.Row.FindControl("lblgiftwrapprice")
                Dim giftwrapdetails As HtmlControl = e.Row.FindControl("giftwrapdetails")

                If btnGiftWrap IsNot Nothing Then
                    btnGiftWrap.ImageUrl = PersonalizationServices.GetThemedButton("GiftWrapSmall")
                    btnGiftWrap.CommandArgument = lineItem.Bvin

                    ' don't show gift wrap button if product is not gift wrappable
                    If lineItem.AssociatedProduct.IsGiftCertificate OrElse ((WebAppSettings.GiftWrapAll = False) AndAlso (lineItem.AssociatedProduct.GiftWrapAllowed = False)) Then
                        btnGiftWrap.Visible = False
                        lblGiftWrap.Visible = False
                        lblGiftWrapQty.Visible = False
                        lblgiftwrapprice.Visible = False
                        giftwrapdetails.Visible = False
                    Else
                        btnGiftWrap.Visible = True
                        lblGiftWrap.Visible = True
                        lblGiftWrapQty.Visible = True
                        lblgiftwrapprice.Visible = True

                        If lblGiftWrapQty IsNot Nothing Then
                            lblGiftWrapQty.Text = lineItem.GiftWrapCount.ToString() & " - "
                        End If

                        If lblgiftwrapprice IsNot Nothing Then
                            If lineItem.AssociatedProduct.GiftWrapAllowed = False Then
                                ' Use global rate if wrapping is not specifically set on this product
                                lblgiftwrapprice.Text = String.Format("{0:c}", WebAppSettings.GiftWrapCharge) & " /each"
                            Else
                                lblgiftwrapprice.Text = String.Format("{0:c}", lineItem.AssociatedProduct.GiftWrapPrice) & " /each"
                            End If
                        End If

                        'build gift wrap details
                        Dim details As New StringBuilder()
                        For Each item As Orders.GiftWrapDetails In lineItem.GiftWrapDetails
                            If item.GiftWrapEnabled = True Then
                                details.Append("<div class=""giftwrapdetails"">")
                                details.Append("<strong>To:</strong> " & item.ToField & ", ")
                                details.Append("<strong>From:</strong> " & item.FromField & ", ")
                                details.Append("<strong>Message:</strong> " & item.MessageField)
                                details.Append("</div>")
                            End If
                        Next

                        Dim lblGiftWrapDetails As Literal = e.Row.FindControl("lblGiftWrapDetails")
                        If lblGiftWrapDetails IsNot Nothing Then
                            lblGiftWrapDetails.Text = details.ToString()
                        End If
                    End If
                End If
                ' End 5.4 Gift Wrap Code


                Dim totalLabel As Literal = e.Row.FindControl("TotalLabel")
                totalLabel.Text = lineItem.LineTotal.ToString("c")

                Dim totalWithoutDiscountsLabel As Literal = e.Row.FindControl("TotalWithoutDiscountsLabel")
                If lineItem.LineTotal <> lineItem.LineTotalWithoutDiscounts Then
                    totalWithoutDiscountsLabel.Visible = True
                    totalWithoutDiscountsLabel.Text = lineItem.LineTotalWithoutDiscounts.ToString("c")
                Else
                    totalWithoutDiscountsLabel.Visible = False
                End If
            End If
        End If
    End Sub

    Protected Sub ItemGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles ItemGridView.RowDeleting
        MessageBox1.ClearMessage()
        Dim bvin As String = CType(ItemGridView.DataKeys(e.RowIndex).Value, String)
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        If Basket IsNot Nothing Then
            Basket.RemoveItem(bvin)
            LoadCart()
        End If
    End Sub

    Protected Sub btnUpdateQuantities_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnUpdateQuantities.Click
        If Page.IsValid Then
            MessageBox1.ClearMessage()
            GetCurrentLineItemQuantities()
            LoadCart()
        End If
    End Sub

    Public Function GetCurrentLineItemQuantities() As Boolean
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        If Basket IsNot Nothing Then
            For i As Integer = 0 To ItemGridView.Rows.Count - 1
                If ItemGridView.Rows(i).RowType = DataControlRowType.DataRow Then
                    Dim QtyField As TextBox = ItemGridView.Rows(i).FindControl("QtyField")
                    If QtyField IsNot Nothing Then
                        Dim qty As Integer = Convert.ToInt32(QtyField.Text.Trim())
                        Dim bvin As String = CType(ItemGridView.DataKeys(ItemGridView.Rows(i).RowIndex).Value, String)

                        Dim item As Orders.LineItem = Basket.Items.First(Function(li) li.Bvin = bvin)
                        If item Is Nothing OrElse item.Quantity <> qty Then
                            Dim opResult As BVOperationResult = Basket.UpdateItemQuantity(bvin, qty)
                            If opResult.Message <> String.Empty Then
                                MessageBox1.ShowInformation(opResult.Message)
                            End If
                            If Not opResult.Success Then
                                Return False
                            End If
                        End If
                    End If
                End If
            Next

            Dim productQuantities As New Collections.Generic.Dictionary(Of String, Decimal)(Basket.Items.Count)
            For Each item As Orders.LineItem In Basket.Items
                If productQuantities.ContainsKey(item.ProductId) Then
                    productQuantities(item.ProductId) = productQuantities(item.ProductId) + item.Quantity
                Else
                    productQuantities.Add(item.ProductId, item.Quantity)
                End If
            Next

            'if this product is a child product, then we need to compare the minimum quantity against its parent
            For Each item As Orders.LineItem In Basket.Items
                If item.AssociatedProduct IsNot Nothing Then
                    Dim itemToCompare As Catalog.Product = Nothing
                    If String.IsNullOrEmpty(item.AssociatedProduct.ParentId) Then
                        itemToCompare = item.AssociatedProduct
                    Else
                        itemToCompare = Catalog.InternalProduct.FindByBvinLight(item.AssociatedProduct.ParentId)
                    End If
                    If itemToCompare.MinimumQty > productQuantities(item.ProductId) Then
                        Dim message As String = Content.SiteTerms.GetTerm("CartPageMinimumQuantityError")
                        message = Content.SiteTerms.ReplaceTermVariable(message, "productName", item.AssociatedProduct.ProductName)
                        message = Content.SiteTerms.ReplaceTermVariable(message, "quantity", itemToCompare.MinimumQty)
                        MessageBox1.ShowError(message)
                        Dim difference As Decimal = itemToCompare.MinimumQty - productQuantities(item.ProductId)
                        item.Quantity += difference
                        Orders.LineItem.Update(item)
                        Return False
                    End If
                End If
            Next
        End If
        Return True
    End Function

    Sub ForwardToCheckout()
        Dim c As New BusinessRules.OrderTaskContext()
        c.UserId = SessionManager.GetCurrentUserId
        c.Order = SessionManager.CurrentShoppingCart()
        If BusinessRules.Workflow.RunByBvin(c, WebAppSettings.WorkflowIdCheckoutSelected) Then
            Response.Redirect(PersonalizationServices.GetCheckoutUrl(c.UserId))
        Else
            Dim customerMessageFound As Boolean = False
            For Each msg As BusinessRules.WorkflowMessage In c.Errors
                EventLog.LogEvent(msg.Name, msg.Description, Metrics.EventLogSeverity.Error)
                If msg.CustomerVisible Then
                    customerMessageFound = True
                    MessageBox1.ShowError(msg.Description)
                End If
            Next
            If Not customerMessageFound Then
                EventLog.LogEvent("Checkout Selected Workflow", "Checkout failed but no errors were recorded.", Metrics.EventLogSeverity.Error)
                MessageBox1.ShowError("Checkout Failed. If problem continues, please contact customer support.")
            End If
        End If
    End Sub

    ' NOTE: required Product Inputs cannot be validated because the 'required' setting isn't a property of the ProductInput object
    Protected Function ValidateOptions() As Boolean
        Dim result As Boolean = True
        Dim errorSkus As New Collection(Of String)
        Dim errorBvins As New Collection(Of String)

        Dim o As Orders.Order = SessionManager.CurrentShoppingCart()
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
            Dim errorMessage As String = String.Format("Your cart contains the following SKU's that require you to select options: {0}", String.Join(", ", errorSkus.ToArray()))
            MessageBox1.ShowError(errorMessage)
            result = False

            ' highlight errant rows
            For i As Integer = 0 To ItemGridView.DataKeys.Count - 1
                Dim item As GridViewRow = ItemGridView.Rows(i)
                If errorBvins.Contains(ItemGridView.DataKeys(i).Value) Then
                    item.CssClass = "cartErrorRow"
                Else
                    item.CssClass = String.Empty
                End If
            Next
        End If

        Return result
    End Function

    Protected Sub btnCheckout_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCheckout.Click
        If Page.IsValid Then
            If GetCurrentLineItemQuantities() Then
                If CheckForStockOnItems() Then
                    If ValidateOptions() Then
                        MessageBox1.ClearMessage()
                        ForwardToCheckout()
                    End If
                End If
            Else
                LoadCart()
            End If
        End If
    End Sub

    Protected Function CheckForStockOnItems() As Boolean
        If WebAppSettings.InventoryMode = Catalog.StoreProductInventoryMode.ReserveOnOrder Then
            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
            Dim result As BVOperationResult = Basket.CheckForStockOnItems()
            If result.Success Then
                Return True
            Else
                MessageBox1.ShowError(result.Message)
                Return False
            End If
        End If
        Return True
    End Function

    Protected Sub btnAddCoupon_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddCoupon.Click
        MessageBox1.ClearMessage()
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        Dim couponResult As BVOperationResult = Basket.AddCouponCode(Me.CouponField.Text.Trim, True)
        If couponResult.Success = False Then
            MessageBox1.ShowError(couponResult.Message)
        Else
            Me.CouponField.Text = String.Empty
        End If
        LoadCart()

        ' Recalculate shipping rates in case free shipping coupon was 
        Dim o As Orders.Order = SessionManager.CurrentShoppingCart
        Dim ctr As Control = CType(CartShippingCalculator.FindControl("ucShipping"), Control)
        Dim t As Type = CType(CartShippingCalculator.FindControl("ucShipping"), Control).GetType()
        Dim method As MethodInfo = t.GetMethod("LoadShippingMethodsForOrder")
        method.Invoke(ctr, New Object() {o, o.ShippingAddress.PostalCode})
    End Sub

    Protected Sub CouponGrid_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles CouponGrid.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim btnDeleteCoupon As ImageButton = e.Row.FindControl("btnDeleteCoupon")
            If btnDeleteCoupon IsNot Nothing Then
                btnDeleteCoupon.ImageUrl = PersonalizationServices.GetThemedButton("x")
            End If
        End If
    End Sub

    Protected Sub CouponGrid_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles CouponGrid.RowDeleting
        Me.MessageBox1.ClearMessage()
        Dim code As String = String.Empty
        code = CStr(Me.CouponGrid.DataKeys(e.RowIndex).Value)
        If code <> String.Empty Then
            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
            Basket.RemoveCouponCode(code)
        End If
        LoadCart()
    End Sub

    Protected Sub AddToCartClicked(ByVal productId As String)
        LoadCart()
    End Sub

    Protected Sub ItemGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles ItemGridView.RowCommand
        If e.CommandName = "EditProduct" Then
            Dim lineItemBvin As String = e.CommandArgument
            Dim lineItem As Orders.LineItem = Orders.LineItem.FindByBvin(lineItemBvin)
            Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(lineItem.ProductId)
            If product.GlobalProduct.ParentId <> String.Empty Then
                product = Catalog.InternalProduct.FindByBvin(product.GlobalProduct.ParentId)
            End If

            If product IsNot Nothing Then
                Dim url As String = Utilities.UrlRewriter.BuildUrlForProduct(product, Me, "LineItemId=" & HttpUtility.UrlEncode(lineItemBvin))
                Response.Redirect(url)
            End If
        ElseIf e.CommandName = "GiftWrap" Then
            Dim lineItemBvin As String = e.CommandArgument
            Response.Redirect("GiftWrap.aspx?id=" & lineItemBvin)
        End If
    End Sub

    Public Sub PaypalExpressCheckoutClicked(ByVal args As PaypalExpressCheckoutArgs) Handles PaypalExpressCheckoutButton1.CheckoutButtonClicked
        GetCurrentLineItemQuantities()
        If Not CheckForStockOnItems() Then
            args.Failed = True
        Else
            If Not ValidateOptions() Then
                args.Failed = True
            Else
                args.Failed = False
            End If
        End If
    End Sub

    Public Sub WorkflowFailed(ByVal Message As String) Handles PaypalExpressCheckoutButton1.WorkflowFailed
        MessageBox1.ShowError(Message)
    End Sub

End Class