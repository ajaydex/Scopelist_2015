Imports BVSoftware.BVC5.Core
Imports System.Collections.ObjectModel

Partial Class RMA
    Inherits BaseStorePage

    Private _order As Orders.Order

    Private rma As Orders.RMA

    Protected Property Order() As Orders.Order
        Get
            Return _order
        End Get
        Set(ByVal value As Orders.Order)
            _order = value
        End Set
    End Property

    Protected Property OrderBvin() As String
        Get
            Dim obj As Object = ViewState("OrderBvin")
            If obj IsNot Nothing Then
                Return DirectCast(obj, String)
            Else
                Return String.Empty
            End If
        End Get
        Set(ByVal value As String)
            ViewState("OrderBvin") = value
        End Set
    End Property

    Protected Property LineItemIds() As Collection(Of String)
        Get
            Dim obj As Object = ViewState("RMABvin")
            If obj IsNot Nothing Then
                Return DirectCast(obj, Collection(Of String))
            Else
                Return Nothing
            End If
        End Get
        Set(ByVal value As Collection(Of String))
            ViewState("RMABvin") = value
        End Set
    End Property

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Service.master")
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Me.ManualBreadCrumbTrail1.ClearTrail()
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("CustomerService"), "~/ContactUs.aspx")
        Me.ManualBreadCrumbTrail1.AddNonLink(Content.SiteTerms.GetTerm("ReturnForm"))
        Me.SubmitReturnImageButton.ImageUrl = PersonalizationServices.GetThemedButton("Submit")

        If Not Page.IsPostBack() Then
            If Request.QueryString("OrderId") IsNot Nothing Then
                Me.OrderBvin = Request.QueryString("OrderId")
                Me.Order = Orders.Order.FindByBvin(Me.OrderBvin)
            Else
                Response.Redirect("~/default.aspx")
            End If

            If Request.QueryString("LineItemIds") IsNot Nothing Then
                Me.LineItemIds = New Collection(Of String)
                Dim strLineItemIds As String = Request.QueryString("LineItemIds")
                For Each strLineItemId As String In strLineItemIds.Split(",")
                    Me.LineItemIds.Add(strLineItemId)
                Next
            Else
                Response.Redirect("~/default.aspx")
            End If

            FillFormValues()
            BindRMAGridView()
        Else
            Me.Order = ViewState("Order")
        End If
    End Sub

    Protected Sub FillFormValues()
        If Me.Order IsNot Nothing Then
            Me.NameTextBox.Text = Me.Order.ShippingAddress.FirstName + " " + Me.Order.ShippingAddress.LastName
            Me.EmailTextBox.Text = Me.Order.User.Email
            Me.PhoneNumberTextBox.Text = Me.Order.ShippingAddress.Phone
        End If
    End Sub

    Protected Sub SaveFormValues()
        rma = New Orders.RMA()
        rma.OrderBvin = Me.Order.Bvin
        rma.Name = Me.NameTextBox.Text
        rma.PhoneNumber = Me.PhoneNumberTextBox.Text
        rma.EmailAddress = Me.EmailTextBox.Text
        rma.Comments = Me.CommentsTextBox.Text
        rma.Items = New Collection(Of Orders.RMAItem)
        For Each row As GridViewRow In RMAGridView.Rows
            Dim rmaItem As New Orders.RMAItem
            Dim lineItem As Orders.LineItem = Orders.LineItem.FindByBvin(DirectCast(row.FindControl("bvin"), HiddenField).Value)
            rmaItem.LineItemBvin = lineItem.Bvin
            rmaItem.ItemName = lineItem.ProductName
            rmaItem.ItemDescription = lineItem.ProductShortDescription
            rmaItem.Quantity = CType(DirectCast(row.FindControl("QuantityTextBox"), TextBox).Text, Integer)
            rmaItem.Reason = DirectCast(row.FindControl("ReasonDropDownList"), DropDownList).SelectedItem.Text
            rmaItem.Replace = (DirectCast(row.FindControl("ReplacementRadioButtonList"), RadioButtonList).SelectedValue = "1")
            rma.Items.Add(rmaItem)
        Next
    End Sub

    Protected Sub BindRMAGridView()
        If Me.LineItemIds IsNot Nothing Then
            RMAGridView.DataSource = Me.LineItemIds
            RMAGridView.DataBind()
        End If
    End Sub

    Protected Sub RMAGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles RMAGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lineItemId As String = CType(e.Row.DataItem, String)
            Dim lineItem As Orders.LineItem = Orders.LineItem.FindByBvin(lineItemId)

            DirectCast(e.Row.FindControl("QuantityTextBox"), TextBox).Text = "1"

            Dim ReturnItems As Collection(Of Orders.RMAItem) = Orders.RMAItem.FindByLineItemBvin(lineItem.Bvin)
            Dim quantityReturned As Integer = 0
            For Each item As Orders.RMAItem In ReturnItems
                quantityReturned += item.Quantity
            Next

            Dim quantityRangeValidator As Controls.BVRangeValidator = CType(e.Row.FindControl("QuantityRangeValidator"), Controls.BVRangeValidator)
            quantityRangeValidator.MinimumValue = "1"
            If lineItem.Bvin <> String.Empty Then
                quantityRangeValidator.MaximumValue = CType(lineItem.Quantity, Integer) - quantityReturned
            Else
                quantityRangeValidator.MaximumValue = "9999"
            End If
            quantityRangeValidator.ErrorMessage = String.Format("Quantity must be between {0} and {1}", quantityRangeValidator.MinimumValue, quantityRangeValidator.MaximumValue)

            DirectCast(e.Row.FindControl("ReplacementRadioButtonList"), RadioButtonList).SelectedValue = "0"
            DirectCast(e.Row.FindControl("litProductSku"), Literal).Text = lineItem.ProductSku
            DirectCast(e.Row.FindControl("litProductName"), Literal).Text = lineItem.ProductName
            DirectCast(e.Row.FindControl("bvin"), HiddenField).Value = lineItem.Bvin
        End If
    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        ViewState("Order") = Me.Order
    End Sub

    Protected Sub SubmitReturnImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SubmitReturnImageButton.Click
        If Page.IsValid Then
            If RMAGridView.Rows.Count = 0 Then
                MessageBox.ShowError("You must have at least one item to return")
            Else
                SaveFormValues()
                If WebAppSettings.AutomaticallyIssueRMANumbers Then
                    rma.Status = Orders.RMAStatus.Open
                Else
                    rma.Status = Orders.RMAStatus.Pending
                End If
                If Orders.RMA.Insert(rma) Then
                    Dim c As New BusinessRules.OrderTaskContext()
                    c.Order = rma.Order
                    c.Inputs.Add("bvsoftware", "rmaid", rma.Bvin)
                    If Not BusinessRules.Workflow.RunByBvin(c, WebAppSettings.WorkflowIdProcessNewReturn) Then
                        For Each item As BusinessRules.WorkflowMessage In c.GetCustomerVisibleErrors
                            MessageBox.ShowError(item.Description)
                        Next
                    End If

                    'set multiview to the "thank you" view
                    RMAMultiView.ActiveViewIndex = 1
                    If WebAppSettings.AutomaticallyIssueRMANumbers Then
                        RMANumberPanel.Visible = True
                        RMANumberLabel.Text = "Your RMA Number is " & BVSoftware.Web.Text.PadStringLeft(rma.Number.ToString(), 8, "0") & ". Please clearly display this number on the outside of the package you are returning."
                    Else
                        RMANumberPanel.Visible = False
                        RMANumberLabel.Text = "Someone will contact you shortly with your RMA Number."
                    End If
                Else
                    MessageBox.ShowError("An error occurred while trying to save RMA to the database. This RMA may have already been submitted.")
                End If
            End If
        End If
    End Sub
End Class
