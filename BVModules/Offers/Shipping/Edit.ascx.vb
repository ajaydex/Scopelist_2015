Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Offers_Shipping_Edit
    Inherits OfferTemplate

    Public Enum AmountTypes
        Amount = 0
        Percentage = 1
    End Enum

    Private _shippingMethod As String = String.Empty
    Private _amount As Decimal = 0D
    Private _amountType As AmountTypes
    Private _orderQuantity As Integer = 0
    Private _orderTotal As Decimal = 0D

    Public Property ShippingMethod() As String
        Get
            Return _shippingMethod
        End Get
        Set(ByVal value As String)
            _shippingMethod = value
        End Set
    End Property
    Public Property Amount() As Decimal
        Get
            Return _amount
        End Get
        Set(ByVal value As Decimal)
            _amount = value
        End Set
    End Property
    Public Property AmountType() As AmountTypes
        Get
            Return _amountType
        End Get
        Set(ByVal value As AmountTypes)
            _amountType = value
        End Set
    End Property
    Public Property OrderQuantity() As Integer
        Get
            Return _orderQuantity
        End Get
        Set(ByVal value As Integer)
            _orderQuantity = value
        End Set
    End Property
    Public Property OrderTotal() As Decimal
        Get
            Return _orderTotal
        End Get
        Set(ByVal value As Decimal)
            _orderTotal = value
        End Set
    End Property

    Protected Sub InitializeForm()        
        ShippingMethodDropDownList.SelectedValue = ShippingMethod
        AmountTextBox.Text = Amount.ToString("c")
        OfferAmountTypeDropDownList.SelectedIndex = AmountType
        OrderQuantityTextBox.Text = OrderQuantity
        OrderTotalTextBox.Text = OrderTotal.ToString("c")
    End Sub

    Public Overrides Sub Save()
        SettingsManager.SaveSetting("ShippingMethod", ShippingMethodDropDownList.SelectedValue, "bvsoftware", "Offer", "Shipping")
        SettingsManager.SaveDecimalSetting("Amount", Decimal.Parse(AmountTextBox.Text, System.Globalization.NumberStyles.Currency), "bvsoftware", "Offer", "Shipping")
        SettingsManager.SaveIntegerSetting("AmountType", OfferAmountTypeDropDownList.SelectedIndex, "bvsoftware", "Offer", "Shipping")
        SettingsManager.SaveIntegerSetting("OrderQuantity", OrderQuantityTextBox.Text, "bvsoftware", "Offer", "Shipping")
        SettingsManager.SaveDecimalSetting("OrderTotal", Decimal.Parse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency), "bvsoftware", "Offer", "Shipping")

        Dim val As Decimal = 0
        If Decimal.TryParse(OrderTotalMaxTextBox.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            If val <= 0 Then
                val = Decimal.MaxValue
            End If
        Else
            val = Decimal.MaxValue
        End If
        SettingsManager.SaveDecimalSetting("OrderTotalMax", val, "bvsoftware", "Offer", "Shipping")

    End Sub

    Public Overrides Sub Initialize()
        BindShippingMethods()
        ShippingMethod = SettingsManager.GetSetting("ShippingMethod")
        AmountType = SettingsManager.GetIntegerSetting("AmountType")
        If AmountType = AmountTypes.Amount Then
            Amount = SettingsManager.GetDecimalSetting("Amount").ToString("c")
        Else
            Amount = SettingsManager.GetDecimalSetting("Amount").ToString("N")
        End If

        OrderQuantity = SettingsManager.GetIntegerSetting("OrderQuantity")
        If OrderQuantity = 0 Then
            OrderQuantity = 1
        End If
        OrderTotal = SettingsManager.GetDecimalSetting("OrderTotal").ToString("c")
        If OrderTotal = 0D Then
            OrderTotal = 0.01
        End If

        Dim orderTotalMax As Decimal = SettingsManager.GetDecimalSetting("OrderTotalMax")
        If orderTotalMax = Decimal.MaxValue OrElse orderTotalMax = 0 Then
            OrderTotalMaxTextBox.Text = String.Empty
        Else
            OrderTotalMaxTextBox.Text = orderTotalMax.ToString("c")
        End If

        InitializeForm()
    End Sub

    Protected Sub BindShippingMethods()
        ShippingMethodDropDownList.DataSource = Shipping.ShippingMethod.FindAll()
        ShippingMethodDropDownList.DataTextField = "Name"
        ShippingMethodDropDownList.DataValueField = "bvin"
        ShippingMethodDropDownList.DataBind()
        Dim item As New ListItem("All", "")
        ShippingMethodDropDownList.Items.Insert(0, item)
    End Sub

    Public Overrides Sub Cancel()

    End Sub

    Protected Sub IsMonetary_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles AmountCustomValidator.ServerValidate, OrderTotalCustomValidator.ServerValidate, OrderTotalMaxCustomValidator.ServerValidate
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, Nothing) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub OrderTotalMaxCustomValidator2_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles OrderTotalMaxCustomValidator2.ServerValidate
        Dim orderTotalMin As Decimal = 0
        Dim orderTotalMax As Decimal = 0

        If Decimal.TryParse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, orderTotalMin) Then
            If Decimal.TryParse(OrderTotalMaxTextBox.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, orderTotalMax) Then
                If orderTotalMax <= orderTotalMin Then
                    args.IsValid = False
                End If
            End If
        End If
    End Sub
End Class
