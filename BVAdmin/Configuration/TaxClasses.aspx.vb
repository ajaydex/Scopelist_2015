Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.Taxes.TaxClass

Partial Class BVAdmin_Configuration_TaxClasses
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Tax Class Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not Page.IsPostBack Then

            LoadTaxClasses()

        End If

    End Sub

    Private Sub btnAddNewRegion_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddNewRegion.Click
        msg.ClearMessage()
        Try
            Dim tc As New Taxes.TaxClass
            tc.DisplayName = Me.DisplayNameField.Text.Trim
            Taxes.TaxClass.SaveAsNew(tc)
            msg.ShowOk("Added: " & tc.DisplayName)
            tc = Nothing
            LoadTaxClasses()
            DisplayNameField.Text = ""
        Catch Ex As Exception
            msg.ShowException(Ex)
        End Try
    End Sub

    Sub LoadTaxClasses()
        Try
            dgTaxClasses.DataSource = Taxes.TaxClass.FindAll
            dgTaxClasses.DataBind()
        Catch Ex As Exception
            msg.ShowException(Ex)
        End Try
    End Sub

    Public Sub dgTaxClasses_Edit(ByVal Source As System.Object, ByVal E As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgTaxClasses.EditCommand
        dgTaxClasses.EditItemIndex = E.Item.ItemIndex
        LoadTaxClasses()
    End Sub

    Public Sub dgTaxClasses_Cancel(ByVal Source As System.Object, ByVal E As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgTaxClasses.CancelCommand
        dgTaxClasses.EditItemIndex = -1
        LoadTaxClasses()
    End Sub

    Public Sub dgTaxClasses_Update(ByVal Source As System.Object, ByVal E As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgTaxClasses.UpdateCommand
        Try
            Dim NewName As TextBox = E.Item.Cells(0).FindControl("DisplayNameUpdate")

            Dim bvin As String = dgTaxClasses.DataKeys(E.Item.ItemIndex)

            Dim tc As New Taxes.TaxClass

            tc = Taxes.TaxClass.FindByBvin(bvin)
            If tc IsNot Nothing Then
                tc.DisplayName = NewName.Text
                Taxes.TaxClass.Update(tc)
            End If
            tc = Nothing

            dgTaxClasses.EditItemIndex = -1
            LoadTaxClasses()
        Catch Ex As Exception
            msg.ShowException(Ex)
        End Try
    End Sub

    Public Sub dgTaxClasses_Delete(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgTaxClasses.DeleteCommand
        Dim editID As String = dgTaxClasses.DataKeys(e.Item.ItemIndex)
        Taxes.TaxClass.Delete(editID)
        LoadTaxClasses()
    End Sub


End Class
