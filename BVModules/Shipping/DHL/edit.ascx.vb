Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Linq

Partial Class BVModules_Shipping_DHL_edit
    Inherits Content.BVShippingModule

    Private Const DHLProviderID As String = "7e7ac8e5-6d0d-4f9a-9144-a77870521fb2"
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
        Dim provider As Shipping.ShippingProvider = Shipping.AvailableProviders.FindProviderById(DHLProviderID)
        If provider IsNot Nothing Then
            Dim dutiableCodes As Collection(Of System.Web.UI.WebControls.ListItem) = CType(provider, BVSoftware.Bvc5.Shipping.DHL.DHLProvider).ListDutiableServiceCodes()
            Dim nonDutiableCodes As Collection(Of System.Web.UI.WebControls.ListItem) = CType(provider, BVSoftware.Bvc5.Shipping.DHL.DHLProvider).ListNonDutiableServiceCodes()
            Me.chkDutiableServiceCode.Items.Clear()
            Me.chkNonDutiableServiceCode.Items.Clear()
            For Each li As ListItem In dutiableCodes
                chkDutiableServiceCode.Items.Add(li)
            Next
            For Each li As ListItem In nonDutiableCodes
                chkNonDutiableServiceCode.Items.Add(li)
            Next
        End If
    End Sub

    Private Sub LoadData()
        Me.NameField.Text = SettingsManager.GetSetting("Name")
        If Me.NameField.Text = String.Empty Then
            Me.NameField.Text = "New Shipping Method"
        End If

        Me.chkDutiableServiceCode.ClearSelection()
        Me.chkNonDutiableServiceCode.ClearSelection()
        Dim serviceCodes() As String = Me.SettingsManager.GetSetting("servicecode").Split(",")
        Dim dutiable As Boolean = Me.SettingsManager.GetBooleanSetting("dutiable")
        rblRateType.SelectedValue = If(dutiable, "1", "0")
        If dutiable Then
            chkDutiableServiceCode.Visible = True
            chkNonDutiableServiceCode.Visible = False
        Else
            chkDutiableServiceCode.Visible = False
            chkNonDutiableServiceCode.Visible = True
        End If
        Dim activeList As CheckBoxList = If(dutiable, chkDutiableServiceCode, chkNonDutiableServiceCode)
        For Each item As ListItem In activeList.Items
            If serviceCodes.Contains(item.Value) Then
                item.Selected = True
            End If
        Next

        If Me.lstPackaging.Items.FindByValue(Me.SharedSettingsManager.GetSetting("defaultPackaging")) IsNot Nothing Then
            Me.lstPackaging.ClearSelection()
            Me.lstPackaging.Items.FindByValue(Me.SharedSettingsManager.GetSetting("defaultPackaging")).Selected = True
        End If
        If Me.lstPackaging.Items.FindByValue(Me.SettingsManager.GetSetting("packaging")) IsNot Nothing Then
            Me.lstPackaging.ClearSelection()
            Me.lstPackaging.Items.FindByValue(Me.SettingsManager.GetSetting("packaging")).Selected = True
        End If

        Me.SiteIDField.Text = Me.SharedSettingsManager.GetSetting("siteID")
        Me.PasswordField.Text = Me.SharedSettingsManager.GetSetting("password")
        If Me.lstDefaultPackaging.Items.FindByValue(Me.SharedSettingsManager.GetSetting("defaultPackaging")) IsNot Nothing Then
            Me.lstDefaultPackaging.ClearSelection()
            Me.lstDefaultPackaging.Items.FindByValue(Me.SharedSettingsManager.GetSetting("defaultPackaging")).Selected = True
        End If
        Me.PaymentAccountNumberField.Text = Me.SharedSettingsManager.GetSetting("PaymentAccountNumber")

        Me.chkDiagnostics.Checked = Me.SharedSettingsManager.GetBooleanSetting("diagnostics")
        Me.chkTest.Checked = Me.SharedSettingsManager.GetBooleanSetting("test")

        AdjustmentDropDownList.SelectedValue = ShippingMethod.AdjustmentType
        If ShippingMethod.AdjustmentType = Shipping.ShippingMethodAdjustmentType.Amount Then
            AdjustmentTextBox.Text = String.Format("{0:c}", ShippingMethod.Adjustment)
        Else
            AdjustmentTextBox.Text = String.Format("{0:f}", ShippingMethod.Adjustment)
        End If
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Name", Me.NameField.Text.Trim, "develisys", "Shipping Method", "DHL")
        Dim serviceCodeStr As New StringBuilder()
        Dim activeList As CheckBoxList = If(rblRateType.SelectedValue = 1, chkDutiableServiceCode, chkNonDutiableServiceCode)
        For Each item As ListItem In activeList.Items
            If item.Selected Then
                If serviceCodeStr.Length > 0 Then
                    serviceCodeStr.Append(",")
                End If
                serviceCodeStr.Append(item.Value)
            End If
        Next
        SettingsManager.SaveSetting("servicecode", serviceCodeStr.ToString(), "develisys", "Shipping Method", "DHL")
        SettingsManager.SaveSetting("packaging", lstPackaging.SelectedValue, "develisys", "Shipping Method", "DHL")
        SettingsManager.SaveSetting("dutiable", rblRateType.SelectedValue, "develisys", "Shipping Method", "DHL")

        SharedSettingsManager.SaveSetting("siteID", SiteIDField.Text, "develisys", "Shipping Method", "DHL")
        SharedSettingsManager.SaveSetting("password", PasswordField.Text, "develisys", "Shipping Method", "DHL")
        SharedSettingsManager.SaveSetting("defaultPackaging", Me.lstDefaultPackaging.SelectedValue, "develisys", "Shipping Method", "DHL")
        SharedSettingsManager.SaveSetting("PaymentAccountNumber", Me.PaymentAccountNumberField.Text, "develisys", "Shipping Method", "DHL")
        SharedSettingsManager.SaveBooleanSetting("diagnostics", chkDiagnostics.Checked, "develisys", "Shipping Method", "DHL")
        SharedSettingsManager.SaveBooleanSetting("test", chkTest.Checked, "develisys", "Shipping Method", "DHL")

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

    Protected Sub rblRateType_SelectionChanged(ByVal sender As Object, ByVal e As EventArgs) Handles rblRateType.SelectedIndexChanged
        If rblRateType.SelectedValue = 0 Then
            chkNonDutiableServiceCode.Visible = True
            chkDutiableServiceCode.Visible = False
        Else
            chkDutiableServiceCode.Visible = True
            chkNonDutiableServiceCode.Visible = False
        End If
    End Sub
End Class
