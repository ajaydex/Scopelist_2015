Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Configuration_Shipping
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Shipping Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadHandlingSettings()
            LoadMethods()
            LoadProviders()
            LoadDimensionCalculators()
        End If
    End Sub

    Private Sub LoadMethods()
        Dim methods As Collection(Of Shipping.ShippingMethod)
        methods = Shipping.ShippingMethod.FindAll
        Me.GridView1.DataSource = methods
        Me.GridView1.DataBind()
    End Sub

    Private Sub LoadProviders()
        Me.lstProviders.ClearSelection()
        For Each p As Shipping.ShippingProvider In Shipping.AvailableProviders.Providers
            Me.lstProviders.Items.Add(New ListItem(p.Name, p.ProviderId))
        Next        
    End Sub

    Private Sub LoadHandlingSettings()
        Me.HandlingFeeAmountTextBox.Text = WebAppSettings.HandlingAmount.ToString("c")
        Me.HandlingRadioButtonList.SelectedIndex = WebAppSettings.HandlingType
        Me.NonShippingCheckBox.Checked = WebAppSettings.HandlingNonShipping
    End Sub

    Private Sub LoadDimensionCalculators()
        Me.ddlDimensionCalculator.ClearSelection()
        For Each dc As Shipping.DimensionCalculator In Shipping.ShippingGroup.AvailableDimensionCalculators
            Dim item As New ListItem(dc.Name, dc.CalculatorId)
            item.Selected = (item.Value = WebAppSettings.ShippingDimensionCalculator)
            Me.ddlDimensionCalculator.Items.Add(item)
        Next
    End Sub

    Private Sub NewMethod()
        Dim m As New Shipping.ShippingMethod
        m.ShippingProviderId = Me.lstProviders.SelectedValue
        m.Name = "New Shipping Method"
        If Shipping.ShippingMethod.Insert(m) = True Then
            Response.Redirect("Shipping_EditMethod.aspx?id=" & m.Bvin & "&doc=1")
        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
        Shipping.ShippingMethod.Delete(bvin)
        LoadMethods()
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("Shipping_EditMethod.aspx?id=" & bvin)
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        NewMethod()
    End Sub

    Protected Sub HandlingFeeAmountCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles HandlingFeeAmountCustomValidator.ServerValidate
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, Nothing) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        Response.Redirect("~/BVAdmin/Configuration/default.aspx")
    End Sub

    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveImageButton.Click
        WebAppSettings.HandlingAmount = Decimal.Parse(Me.HandlingFeeAmountTextBox.Text, System.Globalization.NumberStyles.Currency)
        WebAppSettings.HandlingType = Me.HandlingRadioButtonList.SelectedIndex
        WebAppSettings.HandlingNonShipping = Me.NonShippingCheckBox.Checked
        WebAppSettings.ShippingDimensionCalculator = Me.ddlDimensionCalculator.SelectedValue
        Me.MessageBox1.ShowOk("Settings saved successfully.")
    End Sub
End Class
