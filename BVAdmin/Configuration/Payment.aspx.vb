Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVAdmin_Configuration_Payment
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadMethods()
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Payment Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Private Sub LoadMethods()
        NoPaymentNeededTextBox.Text = WebAppSettings.PaymentNoPaymentNeededDescription
        PurchaseOrderNumberCheckBox.Checked = WebAppSettings.PaymentPurchaseOrderRequirePONumber
        Me.PaymentMethodsGrid.DataSource = Payment.AvailablePayments.Methods
        Me.PaymentMethodsGrid.DataBind()
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        WebAppSettings.PaymentNoPaymentNeededDescription = NoPaymentNeededTextBox.Text
        SaveChanges()
        LoadMethods()
        Me.MessageBox1.ShowOk("Settings saved successfully.")
    End Sub

    Private Sub SaveChanges()
        Dim newList As New Dictionary(Of String, String)
        For i As Integer = 0 To PaymentMethodsGrid.Rows.Count - 1

            Dim chkEnabled As CheckBox = PaymentMethodsGrid.Rows(i).FindControl("chkEnabled")
            If chkEnabled IsNot Nothing Then
                If chkEnabled.Checked Then
                    newList.Add(CStr(PaymentMethodsGrid.DataKeys(i).Value), String.Empty)
                End If
            End If

        Next
        WebAppSettings.PaymentMethodsEnabled = newList
        WebAppSettings.PaymentPurchaseOrderRequirePONumber = PurchaseOrderNumberCheckBox.Checked
    End Sub

    Protected Sub PaymentMethodsGrid_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles PaymentMethodsGrid.RowDataBound
        Dim m As Payment.PaymentMethod = CType(e.Row.DataItem, Payment.PaymentMethod)
        If m IsNot Nothing Then
            Dim chkEnabled As CheckBox = e.Row.FindControl("chkEnabled")
            If chkEnabled IsNot Nothing Then
                If WebAppSettings.PaymentMethodsEnabled.ContainsKey(m.MethodId) Then
                    chkEnabled.Checked = True
                Else
                    chkEnabled.Checked = False
                End If
            End If

            ' Check for Editor
            Dim btnEdit As ImageButton = e.Row.FindControl("btnEdit")
            If btnEdit IsNot Nothing Then
                btnEdit.Visible = False
                Dim editor As UserControl = Content.ModuleController.LoadPaymentMethodEditor(m.MethodName, Me.Page)
                If editor IsNot Nothing Then
                    If TypeOf editor Is Content.BVModule Then
                        btnEdit.Visible = True
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub PaymentMethodsGrid_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles PaymentMethodsGrid.RowEditing
        Dim bvin As String = Me.PaymentMethodsGrid.DataKeys(e.NewEditIndex).Value
        Response.Redirect("Payment_Edit.aspx?id=" & bvin)
    End Sub

End Class
