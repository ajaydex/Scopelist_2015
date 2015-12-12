Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Shipping_US_Postal_Service_edit
    Inherits Content.BVShippingModule

    Private Const USPostalProviderID As String = "57262FBB-F4AB-4bea-AC54-CF38BDC8E83B"
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
        SharedSettingsManager.BlockId = USPostalProviderID
    End Sub

    Private Sub PopulateLists()
        Dim provider As Shipping.ShippingProvider = Shipping.AvailableProviders.FindProviderById(USPostalProviderID)
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
            Me.NameField.Text = "US Postal Service"
        End If

        Me.Diagnostics.Checked = SharedSettingsManager.GetBooleanSetting("diagnostics", False)

        If Me.lstServiceCode.Items.FindByValue(Me.SettingsManager.GetIntegerSetting("servicecode")) IsNot Nothing Then
            Me.lstServiceCode.ClearSelection()
            Me.lstServiceCode.Items.FindByValue(Me.SettingsManager.GetIntegerSetting("servicecode")).Selected = True
        End If
        AdjustmentDropDownList.SelectedValue = ShippingMethod.AdjustmentType
        If ShippingMethod.AdjustmentType = Shipping.ShippingMethodAdjustmentType.Amount Then
            AdjustmentTextBox.Text = String.Format("{0:c}", ShippingMethod.Adjustment)
        Else
            AdjustmentTextBox.Text = String.Format("{0:f}", ShippingMethod.Adjustment)
        End If

    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Name", Me.NameField.Text.Trim, "bvsoftware", "Shipping Method", "USPS")
        SettingsManager.SaveIntegerSetting("servicecode", Me.lstServiceCode.SelectedValue, "bvsoftware", "Shipping Method", "USPS")

        SharedSettingsManager.SaveBooleanSetting("diagnostics", Me.Diagnostics.Checked, "bvsoftware", "Shipping Method", "USPS")
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
