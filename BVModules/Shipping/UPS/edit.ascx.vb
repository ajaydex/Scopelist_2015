Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Shipping_UPS_edit
    Inherits Content.BVShippingModule

    'Private SharedSettingsManager As New Datalayer.ComponentSettingsManager

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing("Canceled")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing(Me.NameField.Text.Trim)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'LoadSharedSettingsManager()
        If Not Page.IsPostBack Then            
            LoadData()
        End If
    End Sub

    'Private Sub LoadSharedSettingsManager()
    '    Dim m As Shipping.ShippingMethod = Shipping.ShippingMethod.FindByBvin(Me.BlockId)
    '    SharedSettingsManager.BlockId = m.ShippingProviderId
    'End Sub

    Private Sub LoadData()
        Me.NameField.Text = SettingsManager.GetSetting("Name")
        If Me.NameField.Text = String.Empty Then
            Me.NameField.Text = "UPS"
        End If
        Me.AccountNumberField.Text = WebAppSettings.ShippingUpsAccountNumber
        Dim shippingTypes As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("ShippingTypes")
        For Each item As ListItem In ShippingTypesCheckBoxList.Items
            Dim found As Boolean = False
            For Each shippingType As Content.ComponentSettingListItem In shippingTypes
                If String.Compare(item.Value, shippingType.Setting1, True) = 0 Then
                    found = True
                    Exit For
                End If
            Next
            item.Selected = found
        Next
        Me.ResidentialAddressCheckBox.Checked = WebAppSettings.ShippingUpsForceResidential
        Me.PickupTypeRadioButtonList.SelectedValue = WebAppSettings.ShippingUpsPickupType.ToString()

        Me.DefaultPackagingField.SelectedValue = WebAppSettings.ShippingUpsDefaultPackaging.ToString
        Me.DefaultPaymentField.SelectedValue = WebAppSettings.ShippingUpsDefaultPayment.ToString
        Me.DefaultServiceField.SelectedValue = WebAppSettings.ShippingUpsDefaultService.ToString

        If WebAppSettings.ShippingUpsLicense.Trim.Length > 0 Then
            Me.lnkRegister.Text = "Already Registered with UPS (click to register again)"
        Else
            Me.lnkRegister.Text = "Register with UPS to use Online Tools"
        End If

        AdjustmentDropDownList.SelectedValue = ShippingMethod.AdjustmentType
        If ShippingMethod.AdjustmentType = Shipping.ShippingMethodAdjustmentType.Amount Then
            AdjustmentTextBox.Text = String.Format("{0:c}", ShippingMethod.Adjustment)
        Else
            AdjustmentTextBox.Text = String.Format("{0:f}", ShippingMethod.Adjustment)
        End If

        Me.SkipDimensionsCheckBox.Checked = WebAppSettings.ShippingUpsSkipDimensions
        Me.chkDiagnostics.Checked = WebAppSettings.ShippingUPSDiagnostics
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Name", Me.NameField.Text.Trim, "bvsoftware", "Shipping Method", "UPS")
        WebAppSettings.ShippingUpsAccountNumber = Me.AccountNumberField.Text.Trim

        SettingsManager.DeleteSettingList("ShippingTypes")
        For Each item As ListItem In ShippingTypesCheckBoxList.Items
            If item.Selected Then
                Dim componentListItem As New Content.ComponentSettingListItem()
                componentListItem.Setting1 = item.Value
                SettingsManager.InsertSettingListItem("ShippingTypes", componentListItem, "bvsoftware", "Shipping Method", "UPS")
            End If
        Next        
        WebAppSettings.ShippingUpsForceResidential = Me.ResidentialAddressCheckBox.Checked
        WebAppSettings.ShippingUpsPickupType = Me.PickupTypeRadioButtonList.SelectedValue
        WebAppSettings.ShippingUpsDefaultService = Me.DefaultServiceField.SelectedValue
        WebAppSettings.ShippingUpsDefaultPackaging = Me.DefaultPackagingField.SelectedValue
        WebAppSettings.ShippingUpsDefaultPayment = Me.DefaultPaymentField.SelectedValue
        WebAppSettings.ShippingUpsSkipDimensions = Me.SkipDimensionsCheckBox.Checked
        WebAppSettings.ShippingUPSDiagnostics = Me.chkDiagnostics.Checked
        ShippingMethod.AdjustmentType = AdjustmentDropDownList.SelectedValue()
        ShippingMethod.Adjustment = Decimal.Parse(AdjustmentTextBox.Text, System.Globalization.NumberStyles.Currency)
    End Sub

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        Dim val As Decimal = 0D
        If Decimal.TryParse(AdjustmentTextBox.Text, System.Globalization.NumberStyles.Currency, System.Globalization.CultureInfo.CurrentCulture, val) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub
End Class
