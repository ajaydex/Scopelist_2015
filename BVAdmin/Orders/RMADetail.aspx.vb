Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Orders_RMADetail
    Inherits BaseAdminPage

    Private rma As Orders.RMA

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Return Details"
        Me.CurrentTab = AdminTabType.Orders
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersEdit)
    End Sub

    Public Property RMABvin() As String
        Get
            Dim obj As String = ViewState("RMABvin")
            If obj IsNot Nothing Then
                Return CStr(obj)
            Else
                Return String.Empty
            End If
        End Get
        Set(ByVal value As String)
            ViewState("RMABvin") = value
        End Set
    End Property

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString("id") Is Nothing Then
                Response.Redirect("~/BVAdmin/Orders/RMA.aspx")
            Else
                Me.RMABvin = Request.QueryString("id")
                rma = Orders.RMA.FindByBvin(Me.RMABvin)               
                BindRMAInfo()
                BindRMAGridView()
            End If            
        End If

        rma = Orders.RMA.FindByBvin(Me.RMABvin)
        
        BindButtons()
    End Sub

    Protected Sub BindRMAGridView()
        rma = Orders.RMA.FindByBvin(Me.RMABvin)
        If rma.Bvin <> String.Empty Then
            Orders.RMA.Update(rma)
            RMAGridView.DataSource = rma.Items
            RMAGridView.DataBind()
        End If
    End Sub

    Protected Sub BindRMAInfo()
        StatusLabel.Text = rma.StatusText
        NameLabel.Text = rma.Name
        PhoneNumberLabel.Text = rma.PhoneNumber
        EmailAddressLabel.Text = rma.EmailAddress
        DateOfReturnLabel.Text = rma.DateOfReturn.ToString("d")
        CommentsLabel.Text = rma.Comments
    End Sub

    Protected Sub BindButtons()
        If rma.Bvin <> String.Empty Then
            If rma.Status = Orders.RMAStatus.Pending Then
                ApproveImageButton.Visible = True
                CloseImageButton.Visible = False
                ReopenImageButton.Visible = False
                RejectImageButton.Visible = True
            ElseIf rma.Status = Orders.RMAStatus.Open Then
                ApproveImageButton.Visible = False
                CloseImageButton.Visible = True
                ReopenImageButton.Visible = False
                RejectImageButton.Visible = False
            ElseIf rma.Status = Orders.RMAStatus.Closed Then
                ApproveImageButton.Visible = False
                CloseImageButton.Visible = False
                ReopenImageButton.Visible = True
                RejectImageButton.Visible = False
            ElseIf rma.Status = Orders.RMAStatus.Rejected Then
                ApproveImageButton.Visible = False
                CloseImageButton.Visible = False
                ReopenImageButton.Visible = False
                RejectImageButton.Visible = False
            End If
        End If
    End Sub

    Protected Sub ApproveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ApproveImageButton.Click
        ChangeRMAStatus(Orders.RMAStatus.Open)
    End Sub

    Protected Sub CloseImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CloseImageButton.Click
        ChangeRMAStatus(Orders.RMAStatus.Closed)
    End Sub

    Protected Sub ReopenImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ReopenImageButton.Click
        ChangeRMAStatus(Orders.RMAStatus.Open)
    End Sub

    Private Sub ChangeRMAStatus(ByVal status As Orders.RMAStatus)
        If rma.Bvin <> String.Empty Then
            rma.Status = status
            If Not Orders.RMA.Update(rma, True) Then
                MessageBox.ShowError("An error occurred while trying to update the return.")
            Else
                MessageBox.ShowOk("RMA status was successfully updated.")
            End If
            BindRMAInfo()
            BindButtons()
        End If
    End Sub

    Protected Sub ReceiveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ReceiveImageButton.Click
        If Page.IsValid Then
            For Each row As GridViewRow In RMAGridView.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    Dim key As String = RMAGridView.DataKeys(row.RowIndex).Value
                    Dim received As Integer = CInt(DirectCast(row.FindControl("QuantityTextBox"), TextBox).Text)
                    Dim returnToInventory As Boolean = DirectCast(row.FindControl("ReturnToInventoryCheckBox"), CheckBox).Checked
                    Dim RMAItem As Orders.RMAItem = Orders.RMAItem.FindByBvin(key)
                    If RMAItem IsNot Nothing Then                        
                        RMAItem.QuantityReceived += received                        
                        If Not Orders.RMAItem.Update(RMAItem) Then
                            MessageBox.ShowError("An error occurred while trying to update the return.")
                            Return
                        End If

                        ' Return to Inventory Here
                        If Not RMAItem.LineItem.ReturnQuantity(received, returnToInventory) Then
                            EventLog.LogEvent("Receive RMA Items", "Unable to return quantity of " & received & " of product " & RMAItem.Product.Bvin, Metrics.EventLogSeverity.Error)
                            MessageBox.ShowError("Item was successfully received, but an error occurred while trying to return your items to inventory. This item may not have inventory enabled.")
                            Return
                        Else
                            If Not Orders.LineItem.Update(RMAItem.LineItem) Then
                                MessageBox.ShowError("An error occurred while trying to mark the items as returned in the order")
                                Return
                            Else
                                MessageBox.ShowOk("Item(s) successfully received.")
                            End If

                            If returnToInventory Then
                                RMAItem.QuantityReturnedToInventory += received
                                If Not Orders.RMAItem.Update(RMAItem) Then
                                    MessageBox.ShowError("Item(s) were returned to inventory, but RMA was not successfully updated.")
                                Else
                                    MessageBox.ShowOk("Item(s) successfully returned to inventory.")
                                End If
                            End If
                        End If
                    Else
                        MessageBox.ShowError("An error occurred while trying to access the database")
                    End If
                End If
            Next
        End If
        BindRMAGridView()
    End Sub

    Protected Sub RejectImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RejectImageButton.Click
        ChangeRMAStatus(Orders.RMAStatus.Rejected)
    End Sub

    Protected Sub IsNumeric_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)
        If Decimal.TryParse(args.Value, Nothing) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub
End Class
