Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Shipping_By_Order_Total_edit
    Inherits Content.BVShippingModule

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing("Canceled")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing(Me.NameField.Text.Trim)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
            LoadLevels()
        End If
    End Sub

    Private Sub LoadData()
        Me.NameField.Text = SettingsManager.GetSetting("Name")
        If Me.NameField.Text = String.Empty Then
            Me.NameField.Text = "By Order Total"
        End If

        AdjustmentDropDownList.SelectedValue = ShippingMethod.AdjustmentType
        If ShippingMethod.AdjustmentType = Shipping.ShippingMethodAdjustmentType.Amount Then
            AdjustmentTextBox.Text = String.Format("{0:c}", ShippingMethod.Adjustment)
        Else
            AdjustmentTextBox.Text = String.Format("{0:f}", ShippingMethod.Adjustment)
        End If
    End Sub

    Private Sub LoadLevels()
        Dim levels As New Utilities.SortableCollection(Of Shipping.ShippingMethodLevel)
        levels = GetLevelsFromSettings(Me.SettingsManager)
        levels.Sort("Level", Utilities.SortDirection.Ascending)
        Me.GridView1.DataSource = levels
        Me.GridView1.DataBind()
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Name", Me.NameField.Text.Trim, "bvsoftware", "Shipping Method", "Order Total")
        ShippingMethod.AdjustmentType = AdjustmentDropDownList.SelectedValue()
        ShippingMethod.Adjustment = Decimal.Parse(AdjustmentTextBox.Text, System.Globalization.NumberStyles.Currency)
    End Sub


    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Dim l As New Shipping.ShippingMethodLevel(Me.NewLevelField.Text.Trim, Me.NewAmountField.Text.Trim)
        AddLevel(l)
    End Sub

    Private Sub AddLevel(ByVal l As Shipping.ShippingMethodLevel)
        Dim levels As New Utilities.SortableCollection(Of Shipping.ShippingMethodLevel)
        levels = GetLevelsFromSettings(Me.SettingsManager)

        Dim found As Boolean = False
        For Each sl As Shipping.ShippingMethodLevel In levels
            If sl.Level = l.Level Then
                sl.Amount = l.Amount
                found = True
                Exit For
            End If
        Next

        If found = False Then
            levels.Add(l)
        End If

        SaveLevels(levels)
        LoadLevels()
    End Sub

    Private Sub RemoveLevel(ByVal bvin As String)
        Dim levels As New Utilities.SortableCollection(Of Shipping.ShippingMethodLevel)
        levels = GetLevelsFromSettings(Me.SettingsManager)
        For Each l As Shipping.ShippingMethodLevel In levels
            If l.Bvin = bvin Then
                levels.Remove(l)
                Exit For
            End If
        Next
        SaveLevels(levels)
        LoadLevels()
    End Sub

    Private Function GetLevelsFromSettings(ByVal manager As Datalayer.ComponentSettingsManager) As Utilities.SortableCollection(Of Shipping.ShippingMethodLevel)
        Dim result As New Utilities.SortableCollection(Of Shipping.ShippingMethodLevel)

        Dim levelsdata As String = manager.GetSetting("Levels")
        result = Utilities.SortableCollection(Of Shipping.ShippingMethodLevel).FromXml(levelsdata)

        Return result
    End Function

    Private Sub SaveLevels(ByVal levels As Utilities.SortableCollection(Of Shipping.ShippingMethodLevel))
        Dim data As String = levels.ToXml
        SettingsManager.SaveSetting("Levels", data, "bvsoftware", "Shipping Method", "Order Total")
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
        RemoveLevel(bvin)
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
