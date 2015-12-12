Imports BVSoftware.BVC5.Core

Partial Class BVModules_Shipping_By_Order_Total_Mixed_edit
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
            Me.NameField.Text = "By Order Total Mixed"
        End If
        'Me.chkIsExpress.Checked = ShippingMethod.IsExpress
    End Sub

    Private Sub LoadLevels()
        Dim levels As New Utilities.SortableCollection(Of Shipping.ShippingMethodMixedLevel)
        levels = GetLevelsFromSettings(Me.SettingsManager)
        levels.Sort("Level", Utilities.SortDirection.Ascending)
        Me.GridView1.DataSource = levels
        Me.GridView1.DataBind()
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Name", Me.NameField.Text.Trim, "bvsoftware", "Shipping Method", "Order Total Mixed")
        'ShippingMethod.IsExpress = Me.chkIsExpress.Checked
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Dim level As Decimal = 0        
        Dim fixed As Decimal = 0
        Dim percent As Decimal = 0

        Decimal.TryParse(Me.NewLevelField.Text, level)
        Decimal.TryParse(Me.NewAmountField.Text, fixed)
        Decimal.TryParse(Me.NewPercentageField.Text, percent)

        If level < 0 Then
            level = 0
        End If
        If fixed < 0 Then
            fixed = 0
        End If
        If percent < 0 Then
            percent = 0
        End If

        Dim l As New Shipping.ShippingMethodMixedLevel(level, fixed, percent)
        AddLevel(l)
    End Sub

    Private Sub AddLevel(ByVal l As Shipping.ShippingMethodMixedLevel)
        Dim levels As New Utilities.SortableCollection(Of Shipping.ShippingMethodMixedLevel)
        levels = GetLevelsFromSettings(Me.SettingsManager)

        Dim found As Boolean = False
        For Each sl As Shipping.ShippingMethodMixedLevel In levels
            If sl.Level = l.Level Then
                sl.FixedAmount = l.FixedAmount
                sl.Percentage = l.Percentage
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
        Dim levels As New Utilities.SortableCollection(Of Shipping.ShippingMethodMixedLevel)
        levels = GetLevelsFromSettings(Me.SettingsManager)
        For Each l As Shipping.ShippingMethodMixedLevel In levels
            If l.Bvin = bvin Then
                levels.Remove(l)
                Exit For
            End If
        Next
        SaveLevels(levels)
        LoadLevels()
    End Sub

    Private Function GetLevelsFromSettings(ByVal manager As Datalayer.ComponentSettingsManager) As Utilities.SortableCollection(Of Shipping.ShippingMethodMixedLevel)
        Dim result As New Utilities.SortableCollection(Of Shipping.ShippingMethodMixedLevel)

        Dim levelsdata As String = manager.GetSetting("Levels")
        result = Utilities.SortableCollection(Of Shipping.ShippingMethodMixedLevel).FromXml(levelsdata)

        Return result
    End Function

    Private Sub SaveLevels(ByVal levels As Utilities.SortableCollection(Of Shipping.ShippingMethodMixedLevel))
        Dim data As String = levels.ToXml
        SettingsManager.SaveSetting("Levels", data, "bvsoftware", "Shipping Method", "Order Total Mixed")
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
        RemoveLevel(bvin)
    End Sub

End Class
