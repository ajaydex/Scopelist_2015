Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Shipping_FedEx_edit
    Inherits Content.BVShippingModule

    Private Const FedExProviderID As String = "43CF0D39-4E2D-4f9d-AF65-87EDF5FF84EA"
    Private SharedSettingsManager As New Datalayer.ComponentSettingsManager

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing("Canceled")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing(Me.NameField.Text.Trim)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadSharedSettingsManager()
        If Not Page.IsPostBack Then
            PopulateLists()
            LoadData()
        End If
    End Sub

    Private Sub LoadSharedSettingsManager()
        Dim m As Shipping.ShippingMethod = Shipping.ShippingMethod.FindByBvin(Me.BlockId)
        SharedSettingsManager.BlockId = m.ShippingProviderId
    End Sub

    Private Sub PopulateLists()
        Dim provider As Shipping.ShippingProvider = Shipping.AvailableProviders.FindProviderById(FedExProviderID)
        If provider IsNot Nothing Then
            Dim codes As Collection(Of System.Web.UI.WebControls.ListItem) = provider.ListServiceCodes()
            Me.lstServiceCode.Items.Clear()
            For Each li As ListItem In codes
                Me.lstServiceCode.Items.Add(li)
            Next
        End If
    End Sub

    Private Sub LoadData()
        Me.NameField.Text = SettingsManager.GetSetting("Name")
        If Me.NameField.Text = String.Empty Then
            Me.NameField.Text = "FedEx"
        End If

        If Me.lstServiceCode.Items.FindByValue(Me.SettingsManager.GetIntegerSetting("servicecode")) IsNot Nothing Then
            Me.lstServiceCode.ClearSelection()
            Me.lstServiceCode.Items.FindByValue(Me.SettingsManager.GetIntegerSetting("servicecode")).Selected = True
        End If

        If Me.lstPackaging.Items.FindByValue(WebAppSettings.ShippingFedExDefaultPackaging) IsNot Nothing Then
            Me.lstPackaging.ClearSelection()
            Me.lstPackaging.Items.FindByValue(WebAppSettings.ShippingFedExDefaultPackaging).Selected = True
        End If
        If Me.lstPackaging.Items.FindByValue(Me.SettingsManager.GetIntegerSetting("packaging")) IsNot Nothing Then
            Me.lstPackaging.ClearSelection()
            Me.lstPackaging.Items.FindByValue(Me.SettingsManager.GetIntegerSetting("packaging")).Selected = True
        End If

        Me.KeyField.Text = WebAppSettings.GetStringSetting("ShippingFedExKey")
        Me.PasswordField.Text = WebAppSettings.GetStringSetting("ShippingFedExPassword")
        Me.AccountNumberField.Text = WebAppSettings.ShippingFedExAccountNumber
        Me.MeterNumberField.Text = WebAppSettings.ShippingFedExMeterNumber
        If Me.lstDefaultPackaging.Items.FindByValue(WebAppSettings.ShippingFedExDefaultPackaging) IsNot Nothing Then
            Me.lstDefaultPackaging.ClearSelection()
            Me.lstDefaultPackaging.Items.FindByValue(WebAppSettings.ShippingFedExDefaultPackaging).Selected = True
        End If
        Me.chkListRates.Checked = WebAppSettings.ShippingFedExUseListRates
        If Me.lstDropOffType.Items.FindByValue(WebAppSettings.ShippingFedExDropOffType) IsNot Nothing Then
            Me.lstDropOffType.ClearSelection()
            Me.lstDropOffType.Items.FindByValue(WebAppSettings.ShippingFedExDropOffType).Selected = True
        End If
        Me.chkResidential.Checked = WebAppSettings.ShippingFedExForceResidentialRates

        Me.chkDiagnostics.Checked = WebAppSettings.ShippingFedExDiagnostics

        AdjustmentDropDownList.SelectedValue = ShippingMethod.AdjustmentType
        If ShippingMethod.AdjustmentType = Shipping.ShippingMethodAdjustmentType.Amount Then
            AdjustmentTextBox.Text = String.Format("{0:c}", ShippingMethod.Adjustment)
        Else
            AdjustmentTextBox.Text = String.Format("{0:f}", ShippingMethod.Adjustment)
        End If
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Name", Me.NameField.Text.Trim, "bvsoftware", "Shipping Method", "Fedex")
        SettingsManager.SaveIntegerSetting("servicecode", Me.lstServiceCode.SelectedValue, "bvsoftware", "Shipping Method", "Fedex")
        SettingsManager.SaveIntegerSetting("packaging", Me.lstPackaging.SelectedValue, "bvsoftware", "Shipping Method", "Fedex")

        WebAppSettings.UpdateStringSetting("ShippingFedExKey", Me.KeyField.Text.Trim())
        WebAppSettings.UpdateStringSetting("ShippingFedExPassword", Me.PasswordField.Text.Trim())
        WebAppSettings.ShippingFedExAccountNumber = Me.AccountNumberField.Text.Trim
        WebAppSettings.ShippingFedExMeterNumber = Me.MeterNumberField.Text.Trim
        WebAppSettings.ShippingFedExDefaultPackaging = Me.lstDefaultPackaging.SelectedValue
        WebAppSettings.ShippingFedExDropOffType = Me.lstDropOffType.SelectedValue
        WebAppSettings.ShippingFedExForceResidentialRates = Me.chkResidential.Checked
        WebAppSettings.ShippingFedExUseListRates = Me.chkListRates.Checked
        WebAppSettings.ShippingFedExDiagnostics = Me.chkDiagnostics.Checked

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
