Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Orders_ShipOrder
    Inherits BaseAdminPage

    Private o As Orders.Order = New BVSoftware.Bvc5.Core.Orders.Order

    Private _InputsAndModifiersLoaded As Boolean = False

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            PopulateShippingProviders()
            LoadOrder()
        Else
            If Not _InputsAndModifiersLoaded Then
                ViewUtilities.GetInputsAndModifiersForAdminLineItemDescription(Me.Page, ItemsGridView)
            End If
        End If
    End Sub

    Private Sub LoadOrder()
        o = Orders.Order.FindByBvin(Request.QueryString("id"))
        If o IsNot Nothing Then
            Me.lblOrderNumber.Text = "Order " & o.OrderNumber & " "
            Me.StatusField.Text = o.FullOrderStatusDescription
            Me.lblCurrentStatus.Text = o.StatusName
            Me.ShippingAddressField.Text = o.ShippingAddress.ToHtmlString
            Me.ShippingTotalLabel.Text = o.ShippingTotal.ToString("c")

            Me.ItemsGridView.DataSource = o.Items
            Me.ItemsGridView.DataBind()

            Me.PackagesGridView.DataSource = o.FindShippedPackages
            Me.PackagesGridView.DataBind()

            Me.SuggestedPackagesGridView.DataSource = o.FindSuggestedPackages
            Me.SuggestedPackagesGridView.DataBind()

            Me.UserSelectedShippingMethod.Text = "User Selected Shipping Method: <b>" & o.ShippingMethodDisplayName & "</b>"

            'don't show controls if the order is non-shipping
            If Not o.HasShippingItems Then
                pnlShippingTable.Visible = False
            Else
                pnlShippingTable.Visible = True
            End If
            If Me.lstShippingProvider.Items.FindByValue(o.ShippingProviderId) IsNot Nothing Then
                Me.lstShippingProvider.ClearSelection()
                Me.lstShippingProvider.Items.FindByValue(o.ShippingProviderId).Selected = True
                LoadServiceCodes()
                Me.lstServiceCode.SelectedValue = o.ShippingProviderServiceCode
            End If
        End If
    End Sub

    Private Sub ReloadOrder(ByVal previousShippingStatus As Orders.OrderShippingStatus)
        o = Orders.Order.FindByBvin(Request.QueryString("id"))
        Dim context As New BusinessRules.OrderTaskContext
        context.Order = o
        context.UserId = o.UserID
        context.Inputs.Add("bvsoftware", "PreviousShippingStatus", previousShippingStatus.ToString())
        BusinessRules.Workflow.RunByBvin(context, WebAppSettings.WorkflowIdShippingChanged)
        LoadOrder()
    End Sub

    Private Sub PopulateShippingProviders()
        Me.lstShippingProvider.DataSource = Shipping.AvailableProviders.Providers
        Me.lstShippingProvider.DataTextField = "Name"
        Me.lstShippingProvider.DataValueField = "ProviderId"
        Me.lstShippingProvider.DataBind()
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Shipping"
        Me.CurrentTab = AdminTabType.Orders
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersEdit)
    End Sub

    Protected Sub btnPreviousStatus_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnPreviousStatus.Click
        Dim o2 As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        If o2 IsNot Nothing Then
            o2.MoveToPreviousStatus()
            LoadOrder()
        End If
    End Sub

    Protected Sub btnNextStatus_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNextStatus.Click
        Dim o2 As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        If o2 IsNot Nothing Then
            o2.MoveToNextStatus()
            LoadOrder()
        End If
    End Sub

    Protected Sub ItemsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles ItemsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lineItem As Orders.LineItem = CType(e.Row.DataItem, Orders.LineItem)
            If lineItem IsNot Nothing Then

                Dim SKUField As Label = e.Row.FindControl("SKUField")
                If SKUField IsNot Nothing Then
                    If lineItem.AssociatedProduct Is Nothing Then
                        SKUField.Text = lineItem.ProductSku
                    Else
                        SKUField.Text = lineItem.AssociatedProduct.Sku
                    End If
                End If

                Dim description As Label = e.Row.FindControl("DescriptionField")
                If description IsNot Nothing Then
                    If lineItem.AssociatedProduct Is Nothing Then
                        description.Text = lineItem.ProductName
                    Else
                        description.Text = lineItem.AssociatedProduct.ProductName
                    End If

                    If lineItem.AssociatedProduct IsNot Nothing Then
                        If lineItem.AssociatedProduct.NonShipping Then
                            description.Text &= "<br />Non-Shipping"
                        End If
                        If lineItem.AssociatedProduct.ShippingMode = Shipping.ShippingMode.ShipFromManufacturer Then
                            description.Text &= "<br />Ships From Manufacturer"
                        ElseIf lineItem.AssociatedProduct.ShippingMode = Shipping.ShippingMode.ShipFromVendor Then
                            description.Text &= "<br />Ships From Vendor"
                        End If
                        If lineItem.AssociatedProduct.ShipSeparately Then
                            description.Text &= "<br /> Ships Separately "
                        End If
                    End If                                        
                End If


                Dim QtyToShip As TextBox = e.Row.FindControl("QtyToShip")

                If QtyToShip IsNot Nothing Then
                    If lineItem.AssociatedProduct Is Nothing Then
                        QtyToShip.Visible = True
                    Else
                        If lineItem.AssociatedProduct.NonShipping Then
                            QtyToShip.Visible = False
                        Else
                            QtyToShip.Visible = True
                        End If
                    End If

                    Dim q As Integer = lineItem.Quantity - lineItem.QuantityShipped
                    If q > 0 Then
                        QtyToShip.Text = String.Format("{0:#}", q)
                    End If
                End If

                If lineItem.QuantityShipped > 0D Then
                    Dim shipped As Label = e.Row.FindControl("shipped")
                    If shipped IsNot Nothing Then
                        shipped.Text = String.Format("{0:#}", lineItem.QuantityShipped)
                    End If
                End If

            End If
        End If
    End Sub

    Protected Sub btnShipItems_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShipItems.Click
        ShipOrPackageItems(False)
    End Sub

    Protected Sub btnCreatePackage_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCreatePackage.Click
        ShipOrPackageItems(True)
    End Sub

    Private Sub ShipOrPackageItems(ByVal dontShip As Boolean)
        Dim order As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        Dim previousShippingStatus As Orders.OrderShippingStatus = order.ShippingStatus

        Dim serviceCode As String = String.Empty
        If Me.lstServiceCode.SelectedValue IsNot Nothing Then
            serviceCode = Me.lstServiceCode.SelectedValue
        End If

        Dim p As Shipping.Package = ShipItems(Me.TrackingNumberField.Text.Trim, Me.lstShippingProvider.SelectedValue, serviceCode, dontShip)
        ReloadOrder(previousShippingStatus)
    End Sub

    Private Function ShipItems(ByVal trackingNumber As String, ByVal serviceProvider As String, ByVal serviceCode As String, ByVal dontShip As Boolean) As Shipping.Package
        Dim p As New Shipping.Package

        p.ShipDate = DateTime.Now
        p.TrackingNumber = trackingNumber
        p.ShippingProviderId = serviceProvider
        p.ShippingProviderServiceCode = serviceCode
        For Each gvr As GridViewRow In Me.ItemsGridView.Rows
            If gvr.RowType = DataControlRowType.DataRow Then
                Dim li As Orders.LineItem = Orders.LineItem.FindByBvin(Me.ItemsGridView.DataKeys(gvr.RowIndex).Value.ToString)
                If li IsNot Nothing Then
                    Dim qty As Decimal = 0D
                    Dim QtyToShip As TextBox = gvr.FindControl("QtyToShip")
                    If QtyToShip IsNot Nothing Then
                        If Not Decimal.TryParse(QtyToShip.Text, qty) Then
                            qty = 0D
                        End If
                    End If

                    ' exclude non-shipping items - if we can't find the associated product, assume that it's a shipping product
                    If li.AssociatedProduct Is Nothing OrElse Not li.AssociatedProduct.NonShipping Then
                        p.Items.Add(New Shipping.PackageItem(li.ProductId, li.Bvin, qty))
                        p.Weight += li.GetSingleItemWeight() * qty
                    End If
                End If
            End If
        Next
        p.WeightUnits = WebAppSettings.SiteShippingWeightType

        ' if the package is empty, do not add it and do not ship it
        If p.Items.Count > 0 Then
            Dim basket As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
            basket.AddPackage(p)
            If Not dontShip Then
                p.Ship()
            End If
        End If

        Return p
    End Function

    Protected Sub PackagesGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles PackagesGridView.RowDataBound
        Dim p As Shipping.Package = CType(e.Row.DataItem, Shipping.Package)
        If p IsNot Nothing Then

            Dim provider As Shipping.ShippingProvider = Shipping.AvailableProviders.FindProviderById(p.ShippingProviderId)

            Dim serviceCodeName As String = String.Empty
            Dim serviceCodes As Collection(Of ListItem) = provider.ListServiceCodes()
            For Each item As ListItem In serviceCodes
                If item.Value = p.ShippingProviderServiceCode Then
                    serviceCodeName = item.Text
                End If
            Next


            Dim ShippedByField As Label = e.Row.FindControl("ShippedByField")
            If ShippedByField IsNot Nothing Then
                If provider IsNot Nothing Then
                    If serviceCodeName <> String.Empty Then
                        ShippedByField.Text = serviceCodeName
                    Else
                        ShippedByField.Text = provider.Name
                    End If
                End If
            End If

            Dim TrackingLink As HyperLink = e.Row.FindControl("TrackingLink")
            If TrackingLink IsNot Nothing Then
                If provider IsNot Nothing Then
                    If o IsNot Nothing AndAlso o.Bvin <> String.Empty Then
                        'Determine shipping provider from tracking number
                        'If provider.SupportsTracking() Then
                        Dim trackingUrl As String = provider.GetTrackingUrl(p.TrackingNumber)
                        If Not String.IsNullOrEmpty(trackingUrl) Then
                            TrackingLink.Text = "Track Package"
                            TrackingLink.NavigateUrl = trackingUrl
                        End If
                        'End If
                    End If
                End If
            End If

            Dim TrackingTextBox As TextBox = CType(e.Row.FindControl("TrackingNumberTextBox"), TextBox)
            If TrackingTextBox IsNot Nothing Then
                TrackingTextBox.Text = p.TrackingNumber
            End If

            Dim items As Label = e.Row.FindControl("items")
            If items IsNot Nothing Then
                items.Text = String.Empty
                For Each pi As Shipping.PackageItem In p.Items
                    If pi.Quantity > 0 Then
                        items.Text += pi.Quantity.ToString("#") & " - "
                        If o IsNot Nothing Then
                            For Each li As Orders.LineItem In o.Items
                                If li.Bvin = pi.LineItemBvin Then
                                    If li.AssociatedProduct Is Nothing Then
                                        items.Text += li.ProductSku & ": " & li.ProductName & "<br />"
                                    Else
                                        items.Text += li.AssociatedProduct.Sku & ": " & li.AssociatedProduct.ProductName & "<br />"
                                    End If

                                End If
                            Next
                        End If
                    End If
                Next
            End If

        End If
    End Sub

    Protected Sub PackagesGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles PackagesGridView.RowDeleting
        Dim order As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        Dim previousShippingStatus As Orders.OrderShippingStatus = order.ShippingStatus

        Dim bvin As String = PackagesGridView.DataKeys(e.RowIndex).Value
        Shipping.Package.Delete(bvin)
        ReloadOrder(previousShippingStatus)
    End Sub

    Protected Sub SuggestedPackagesGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles SuggestedPackagesGridView.RowDataBound
        Dim p As Shipping.Package = CType(e.Row.DataItem, Shipping.Package)
        If p IsNot Nothing Then

            Dim provider As Shipping.ShippingProvider = Shipping.AvailableProviders.FindProviderById(p.ShippingProviderId)

            Dim serviceCodeName As String = String.Empty
            Dim serviceCodes As Collection(Of ListItem) = provider.ListServiceCodes()
            For Each item As ListItem In serviceCodes
                If item.Value = p.ShippingProviderServiceCode Then
                    serviceCodeName = item.Text
                End If
            Next

            Dim ShippedByField As Label = e.Row.FindControl("ShippedByField")
            If ShippedByField IsNot Nothing Then
                If provider IsNot Nothing Then
                    If serviceCodeName <> String.Empty Then
                        ShippedByField.Text = serviceCodeName
                    Else
                        ShippedByField.Text = provider.Name
                    End If
                End If
            End If

            Dim items As Label = e.Row.FindControl("items")
            If items IsNot Nothing Then
                items.Text = String.Empty
                For Each pi As Shipping.PackageItem In p.Items
                    If pi.Quantity > 0 Then
                        items.Text += pi.Quantity.ToString("#") & " - "
                        If o IsNot Nothing Then
                            For Each li As Orders.LineItem In o.Items
                                If li.Bvin = pi.LineItemBvin Then
                                    If li.AssociatedProduct Is Nothing Then
                                        items.Text += li.ProductSku & "<br />"
                                    Else
                                        items.Text += li.AssociatedProduct.Sku & "<br />"
                                    End If
                                End If
                            Next
                        End If
                    End If
                Next
            End If

        End If
    End Sub

    Protected Sub SuggestedPackagesGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles SuggestedPackagesGridView.RowDeleting
        Dim order As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        Dim previousShippingStatus As Orders.OrderShippingStatus = order.ShippingStatus

        Dim bvin As String = SuggestedPackagesGridView.DataKeys(e.RowIndex).Value
        Shipping.Package.Delete(bvin)
        ReloadOrder(previousShippingStatus)
    End Sub

    Protected Sub SuggestedPackagesGridView_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles SuggestedPackagesGridView.RowEditing
        Dim order As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        Dim previousShippingStatus As Orders.OrderShippingStatus = order.ShippingStatus

        Dim bvin As String = CStr(Me.SuggestedPackagesGridView.DataKeys(e.NewEditIndex).Value)
        Dim p As Shipping.Package = Shipping.Package.FindByBvin(bvin)
        If p IsNot Nothing Then
            Dim TrackingNumber As TextBox = Me.SuggestedPackagesGridView.Rows(e.NewEditIndex).FindControl("TrackingNumber")
            If TrackingNumber IsNot Nothing Then
                p.TrackingNumber = TrackingNumber.Text.Trim
            End If
            p.ShipDate = DateTime.Now   ' set ship date to now rather than using date from when package was originally created
            p.Ship()
        End If
        ReloadOrder(previousShippingStatus)
    End Sub

    Protected Sub btnShipByUPS_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShipByUPS.Click        
        Dim order As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        Dim previousShippingStatus As Orders.OrderShippingStatus = order.ShippingStatus

        Dim serviceCode As String = String.Empty
        If Me.lstServiceCode.SelectedValue IsNot Nothing Then
            serviceCode = Me.lstServiceCode.SelectedValue
        End If

        Dim p As Shipping.Package
        If (Me.lstShippingProvider.SelectedValue = BVSoftware.BVC5.Shipping.Ups.UpsProvider.UPSProviderID) AndAlso (serviceCode <> String.Empty) Then
            p = ShipItems(String.Empty, BVSoftware.BVC5.Shipping.Ups.UpsProvider.UPSProviderID, serviceCode, True)
        Else
            p = ShipItems(String.Empty, BVSoftware.BVC5.Shipping.Ups.UpsProvider.UPSProviderID, WebAppSettings.ShippingUpsDefaultService, True)
        End If

        If p.Bvin <> String.Empty Then
            Response.Redirect("UpsOnlineTools_Ship.aspx?PackageId=" & p.Bvin & "&ReturnUrl=" & Server.UrlEncode(Page.ResolveClientUrl("~/BVAdmin/Orders/ShipOrder.aspx?id=" & p.OrderId)))
        Else
            ReloadOrder(previousShippingStatus)
        End If
    End Sub

    Protected Sub lstShippingProvider_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lstShippingProvider.SelectedIndexChanged
        LoadServiceCodes()
    End Sub

    Private Sub LoadServiceCodes()
        Me.lstServiceCode.Items.Clear()

        Dim p As Shipping.ShippingProvider = Shipping.AvailableProviders.FindProviderById(Me.lstShippingProvider.SelectedValue)
        If p IsNot Nothing Then
            For Each li As ListItem In p.ListServiceCodes
                Me.lstServiceCode.Items.Add(li)
            Next
        End If

        If Me.lstServiceCode.Items.Count > 0 Then
            Me.lstServiceCode.Visible = True
        Else
            Me.lstServiceCode.Visible = False
        End If

        Me.lstShippingProvider.UpdateAfterCallBack = True
        Me.lstServiceCode.UpdateAfterCallBack = True
    End Sub

    Protected Sub PackagesGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles PackagesGridView.RowCommand
        If e.CommandName = "TrackingNumberUpdate" Then
            If TypeOf e.CommandSource Is Control Then
                Dim row As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                Dim trackingNumberTextBox As TextBox = CType(row.FindControl("TrackingNumberTextBox"), TextBox)
                If trackingNumberTextBox IsNot Nothing Then
                    Dim package As Shipping.Package = Shipping.Package.FindByBvin(e.CommandArgument)
                    If Not String.IsNullOrEmpty(package.Bvin) Then
                        package.TrackingNumber = trackingNumberTextBox.Text
                        Shipping.Package.Update(package)
                    End If
                End If
            End If
        End If
        LoadOrder()
    End Sub

    Protected Sub SuggestedPackagesGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles SuggestedPackagesGridView.RowCommand
        If e.CommandName = "AddTrackingNumber" Then
            If TypeOf e.CommandSource Is Control Then
                Dim row As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                Dim trackingNumberTextBox As TextBox = CType(row.FindControl("TrackingNumber"), TextBox)
                If trackingNumberTextBox IsNot Nothing Then
                    Dim package As Shipping.Package = Shipping.Package.FindByBvin(e.CommandArgument)
                    If (package IsNot Nothing) AndAlso (Not String.IsNullOrEmpty(package.Bvin)) Then
                        package.TrackingNumber = trackingNumberTextBox.Text
                        Shipping.Package.Update(package)
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub ItemsGridView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ItemsGridView.DataBound
        ViewUtilities.GetInputsAndModifiersForAdminLineItemDescription(Me.Page, ItemsGridView)
        _InputsAndModifiersLoaded = True
    End Sub

End Class