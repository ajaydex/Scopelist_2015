Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Orders
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Order Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If
            Me.OrderLimiteQuantityField.Text = WebAppSettings.OrderLimitQuantity
            Me.ZeroDollarOrdersCheckBox.Checked = WebAppSettings.AllowZeroDollarOrders

            Me.LastOrderNumberField.Text = WebAppSettings.OrderNumberSeed
            Me.OrderSeedHighField.Text = WebAppSettings.OrderNumberStepHigh
            Me.OrderSeedLowField.Text = WebAppSettings.OrderNumberStepLow

            Me.ForceEmailCheckBox.Checked = WebAppSettings.ForceEmailAddressOnAnonymousCheckout
            Me.HideShippingAddressCheckBox.Checked = WebAppSettings.HideShippingAddressForNonShippingOrders
            Me.HideShippingControlsCheckBox.Checked = WebAppSettings.HideShippingControlsForNonShippingOrders

            Me.OrderNotificationEmailField.Text = WebAppSettings.OrderNotificationEmail

            If WebAppSettings.SendDropShipNotificationsThroughWebService Then
                Me.DropShipModeDropDownList.SelectedValue = "1"
            Else
                Me.DropShipModeDropDownList.SelectedValue = "0"
            End If

            Me.lblCartCleanupLastRun.Text = WebAppSettings.CartCleanupLastTimeRun.ToString
            Me.CartCleanupDaysOldField.Text = WebAppSettings.CartCleanupDaysOld
            Me.CartCleanupIntervalInHoursField.Text = WebAppSettings.CartCleanupIntervalInHours

            Me.RedirectToShoppingCartAfterItemIsAddedCheckBox.Checked = WebAppSettings.RedirectToCartAfterAddProduct
            Me.MergeCartItemsCheckBox.Checked = WebAppSettings.MergeCartItems
            Me.ItemAddedToCartTextBox.Text = WebAppSettings.ItemAddedToCartText
            Me.DisplayCartUpSellsCheckBox.Checked = WebAppSettings.DisplayUpSellsWhenAddingItemToCart
            Me.DisplayCartCrossSellsCheckBox.Checked = WebAppSettings.DisplayCrossSellsWhenAddingItemToCart
            Me.DisplayCrossSellsInShoppingCartCheckBox.Checked = WebAppSettings.DisplayCrossSellsInShoppingCart
            Me.DisplayShippingCalculatorInCartCheckBox.Checked = WebAppSettings.DisplayShippingCalculatorInShoppingCart
            Me.ForceSiteTermsCheckBox.Checked = WebAppSettings.DisplaySiteTermsToCustomerUponCheckout

            LoadCurrentCheckout()
        End If
    End Sub

    Private Sub LoadCurrentCheckout()
        Me.CheckoutField.DataSource = Content.ModuleController.FindCheckouts
        Me.CheckoutField.DataBind()

        Dim currentCheckout As String = WebAppSettings.CheckoutControl
        If CheckoutField.Items.FindByValue(currentCheckout) IsNot Nothing Then
            CheckoutField.Items.FindByValue(currentCheckout).Selected = True
            CheckoutField_IndexChanged(Nothing, Nothing)
        Else
            Me.btnCheckoutEdit.Visible = False
        End If
    End Sub

    Protected Sub CheckoutField_IndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles CheckoutField.SelectedIndexChanged
        Me.btnCheckoutEdit.Visible = Content.ModuleController.FindCheckoutEditors().Contains(Me.CheckoutField.SelectedValue)
    End Sub

    Protected Sub btnCheckoutEdit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCheckoutEdit.Click
        WebAppSettings.CheckoutControl = Me.CheckoutField.SelectedValue
        Response.Redirect("Checkout_Edit.aspx?checkout=" + Me.CheckoutField.SelectedValue)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        Me.MessageBox1.ClearMessage()
        If Me.Save() = True Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        WebAppSettings.CheckoutControl = Me.CheckoutField.SelectedValue
        WebAppSettings.OrderLimitQuantity = Integer.Parse(Me.OrderLimiteQuantityField.Text.Trim)
        WebAppSettings.AllowZeroDollarOrders = Me.ZeroDollarOrdersCheckBox.Checked

        WebAppSettings.OrderNumberSeed = Me.LastOrderNumberField.Text
        WebAppSettings.OrderNumberStepHigh = Me.OrderSeedHighField.Text
        WebAppSettings.OrderNumberStepLow = Me.OrderSeedLowField.Text

        WebAppSettings.ForceEmailAddressOnAnonymousCheckout = Me.ForceEmailCheckBox.Checked
        WebAppSettings.HideShippingAddressForNonShippingOrders = Me.HideShippingAddressCheckBox.Checked
        WebAppSettings.HideShippingControlsForNonShippingOrders = Me.HideShippingControlsCheckBox.Checked

        WebAppSettings.OrderNotificationEmail = Me.OrderNotificationEmailField.Text.Trim

        If Me.DropShipModeDropDownList.SelectedValue = "1" Then
            WebAppSettings.SendDropShipNotificationsThroughWebService = True
        Else
            WebAppSettings.SendDropShipNotificationsThroughWebService = False
        End If

        WebAppSettings.CartCleanupDaysOld = CInt(Me.CartCleanupDaysOldField.Text)
        WebAppSettings.CartCleanupIntervalInHours = CInt(Me.CartCleanupIntervalInHoursField.Text)

        WebAppSettings.RedirectToCartAfterAddProduct = Me.RedirectToShoppingCartAfterItemIsAddedCheckBox.Checked
        WebAppSettings.MergeCartItems = Me.MergeCartItemsCheckBox.Checked
        WebAppSettings.ItemAddedToCartText = Me.ItemAddedToCartTextBox.Text
        WebAppSettings.DisplayUpSellsWhenAddingItemToCart = Me.DisplayCartUpSellsCheckBox.Checked
        WebAppSettings.DisplayCrossSellsWhenAddingItemToCart = Me.DisplayCartCrossSellsCheckBox.Checked
        WebAppSettings.DisplayCrossSellsInShoppingCart = Me.DisplayCrossSellsInShoppingCartCheckBox.Checked
        WebAppSettings.DisplayShippingCalculatorInShoppingCart = Me.DisplayShippingCalculatorInCartCheckBox.Checked
        WebAppSettings.DisplaySiteTermsToCustomerUponCheckout = Me.ForceSiteTermsCheckBox.Checked
        result = True

        Return result
    End Function

    Private Sub TriggerCartCleanup()
        System.Threading.ThreadPool.QueueUserWorkItem(New System.Threading.WaitCallback(AddressOf BVSoftware.Bvc5.Core.Orders.Order.CleanupCarts))
    End Sub


    Protected Sub btnRunCleanup_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnRunCleanup.Click
        Me.MessageBox1.ClearMessage()
        TriggerCartCleanup()
        Me.MessageBox1.ShowOk("Clean up started!")
    End Sub

End Class
