Imports BVSoftware.BVC5.Core

Partial Class BVAdmin_People_PriceGroups
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack() Then            
            BindGrids()
        End If
    End Sub

    Protected Sub BindGrids()
        PricingGroupsGridView.DataSource = Contacts.PriceGroup.FindAll()
        PricingGroupsGridView.DataBind()
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Price Groups"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveImageButton.Click
        For Each row As GridViewRow In PricingGroupsGridView.Rows
            Dim key As String = PricingGroupsGridView.DataKeys(row.RowIndex).Value
            Dim pricingGroup As Contacts.PriceGroup = Contacts.PriceGroup.FindByBvin(key)

            Dim NameTextBox As TextBox = DirectCast(row.FindControl("NameTextBox"), TextBox)
            Dim PricingTypeDropDownList As DropDownList = DirectCast(row.FindControl("PricingTypeDropDownList"), DropDownList)
            Dim AdjustmentAmountTextBox As TextBox = DirectCast(row.FindControl("AdjustmentAmountTextBox"), TextBox)

            Dim needToUpdate As Boolean = False
            If pricingGroup.Name <> NameTextBox.Text Then
                pricingGroup.Name = NameTextBox.Text
                needToUpdate = True
            End If

            If pricingGroup.PricingType <> PricingTypeDropDownList.SelectedValue Then
                pricingGroup.PricingType = PricingTypeDropDownList.SelectedValue
                needToUpdate = True
            End If

            If pricingGroup.AdjustmentAmount <> Decimal.Parse(AdjustmentAmountTextBox.Text, System.Globalization.NumberStyles.Currency) Then
                pricingGroup.AdjustmentAmount = Decimal.Parse(AdjustmentAmountTextBox.Text, System.Globalization.NumberStyles.Currency)
                needToUpdate = True
            End If

            If needToUpdate Then
                Contacts.PriceGroup.Update(pricingGroup)
            End If
        Next
        MessageBox1.ShowOk("Price groups updated")
    End Sub

    Protected Sub PricingGroupsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles PricingGroupsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem IsNot Nothing Then
                Dim pricingGroup As Contacts.PriceGroup = DirectCast(e.Row.DataItem, Contacts.PriceGroup)
                DirectCast(e.Row.FindControl("NameTextBox"), TextBox).Text = pricingGroup.Name
                DirectCast(e.Row.FindControl("PricingTypeDropDownList"), DropDownList).SelectedValue = pricingGroup.PricingType
                DirectCast(e.Row.FindControl("AdjustmentAmountTextBox"), TextBox).Text = pricingGroup.AdjustmentAmount.ToString("N")
            End If        
        End If        
    End Sub

    Protected Sub AddNewImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddNewImageButton.Click
        Dim pricingGroup As New Contacts.PriceGroup()
        pricingGroup.Name = "New Pricing Group"
        If Contacts.PriceGroup.Insert(pricingGroup) Then
            MessageBox1.ShowOk("New price group added")
        Else
            MessageBox1.ShowError("An error occurred while price group was being added.")
        End If
        BindGrids()
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        BindGrids()
        MessageBox1.ShowOk("Price group values have been reset")
    End Sub

    Protected Sub PricingGroupsGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles PricingGroupsGridView.RowDeleting
        Dim key As String = PricingGroupsGridView.DataKeys(e.RowIndex).Value
        If Contacts.PriceGroup.Delete(key) Then
            MessageBox1.ShowOk("Pricing group deleted")
        Else
            MessageBox1.ShowError("An error occurred while price group was being deleted")
        End If
        BindGrids()
    End Sub
End Class
