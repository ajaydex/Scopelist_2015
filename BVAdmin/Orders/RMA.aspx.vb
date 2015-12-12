Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Orders_RMA
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Returns"
        Me.CurrentTab = AdminTabType.Orders
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersEdit)
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        RMAGridView.PageSize = WebAppSettings.RowsPerPage
        If Not Page.IsPostBack Then
            BindRMAGridView()
        End If
    End Sub

    Private Sub BindRMAGridView()                
        RMAGridView.DataBind()
    End Sub

    Protected Sub ApproveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ApproveImageButton.Click
        If Page.IsValid() Then
            For Each row As GridViewRow In RMAGridView.Rows
                If DirectCast(row.FindControl("SelectedCheckBox"), CheckBox).Checked Then
                    Dim key As String = RMAGridView.DataKeys(row.RowIndex).Value
                    Dim rma As Orders.RMA = Orders.RMA.FindByBvin(key)
                    If rma IsNot Nothing Then
                        If rma.Status = Orders.RMAStatus.Pending Then
                            rma.Status = Orders.RMAStatus.Open
                            If Not Orders.RMA.Update(rma, True) Then
                                MessageBox.ShowError("An error occurred while trying to update the RMA, please try again later.")
                            Else
                                MessageBox.ShowOk("RMA was successfully approved.")
                            End If
                        End If
                    End If
                End If
            Next
            BindRMAGridView()
        End If
    End Sub

    Protected Sub CloseImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CloseImageButton.Click
        If Page.IsValid Then
            For Each row As GridViewRow In RMAGridView.Rows
                If DirectCast(row.FindControl("SelectedCheckBox"), CheckBox).Checked Then
                    Dim key As String = RMAGridView.DataKeys(row.RowIndex).Value
                    Dim rma As Orders.RMA = Orders.RMA.FindByBvin(key)
                    If rma IsNot Nothing Then
                        If rma.Status = Orders.RMAStatus.Open Then
                            rma.Status = Orders.RMAStatus.Closed
                            If Not Orders.RMA.Update(rma, True) Then
                                MessageBox.ShowError("An error occurred while trying to update the RMA, please try again later.")
                            Else
                                MessageBox.ShowOk("RMA was successfully closed.")
                            End If
                        End If
                    End If
                End If
            Next
            BindRMAGridView()
        End If
    End Sub

    Protected Sub StatusFilterDropDownList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles StatusFilterDropDownList.SelectedIndexChanged
        BindRMAGridView()
        If RMAGridView.PageIndex > (RMAGridView.PageCount - 1) Then
            RMAGridView.PageIndex = 0
            BindRMAGridView()
        End If
    End Sub

    Protected Sub RejectImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RejectImageButton.Click
        If Page.IsValid Then
            For Each row As GridViewRow In RMAGridView.Rows
                If DirectCast(row.FindControl("SelectedCheckBox"), CheckBox).Checked Then
                    Dim key As String = RMAGridView.DataKeys(row.RowIndex).Value
                    Dim rma As Orders.RMA = Orders.RMA.FindByBvin(key)
                    If rma IsNot Nothing Then
                        If rma.Status = Orders.RMAStatus.Pending Then
                            rma.Status = Orders.RMAStatus.Rejected
                            If Not Orders.RMA.Update(rma, True) Then
                                MessageBox.ShowError("An error occurred while trying to update the RMA, please try again later.")
                            Else
                                MessageBox.ShowOk("RMA was successfully rejected.")
                            End If
                        End If
                    End If
                End If
            Next
            BindRMAGridView()
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource1.Selecting
        If e.ExecutingSelectCount Then
            e.InputParameters("rowCount") = HttpContext.Current.Items("RowCount")
            HttpContext.Current.Items("RowCount") = Nothing
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If e.OutputParameters("RowCount") IsNot Nothing Then
            HttpContext.Current.Items("RowCount") = e.OutputParameters("RowCount")
        End If
    End Sub

    Protected Sub RMAGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles RMAGridView.RowDeleting
        Dim val As String = CStr(e.Keys(0))
        If Orders.RMA.Delete(val) Then
            MessageBox.ShowOk("RMA Deleted Successfully.")
        Else
            MessageBox.ShowError("Error Deleting RMA.")
        End If
        BindRMAGridView()
        e.Cancel = True
    End Sub
End Class
