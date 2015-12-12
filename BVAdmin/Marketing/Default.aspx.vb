Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Catalog_Discounts
    Inherits BaseAdminPage

    Protected Property LastPriority() As Integer
        Get
            Dim obj As Object = ViewState("LastPriority")
            If obj IsNot Nothing Then
                Return CInt(obj)
            Else
                Return -1
            End If
        End Get
        Set(ByVal value As Integer)
            ViewState("LastPriority") = value
        End Set
    End Property

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Offers"
        Me.CurrentTab = AdminTabType.Marketing
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.MarketingView)
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            BindOffersGridView()
            BindOfferTypeDropDownList()
            InitializeErrorMessages()
        End If
    End Sub

    Protected Sub InitializeErrorMessages()
        MessageBox1.ClearMessage()
        MessageBox2.ClearMessage()
    End Sub

    Protected Function GetCurrentOffers() As BusinessEntityList(Of Marketing.Offer)
        Dim offers As BusinessEntityList(Of Marketing.Offer) = Marketing.Offer.GetAllOffers()
        Dim index As Integer = 0
        While index < offers.Count
            If offers(index).Priority <> LastPriority Then
                LastPriority = offers(index).Priority
                Dim offer As New Marketing.Offer
                offer.Name = "Separator"
                offer.Priority = LastPriority
                offers.Insert(index, offer)
                index += 1
            End If
            index += 1
        End While
        Return offers
    End Function

    Protected Sub BindOffersGridView()
        OffersGridView.DataSource = GetCurrentOffers()
        OffersGridView.DataKeyNames = New String() {"bvin"}
        OffersGridView.DataBind()
    End Sub

    Protected Sub BindOfferTypeDropDownList()
        OfferTypeDropDownList.DataSource = Marketing.Offer.GetOfferTypes()
        OfferTypeDropDownList.DataBind()
    End Sub

    Protected Sub OffersGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles OffersGridView.RowDeleting
        If Marketing.Offer.Delete(OffersGridView.DataKeys(e.RowIndex).Value) Then
            MessageBox1.ShowOk("Offer successfully deleted from the database.")
            BindOffersGridView()
        Else
            MessageBox1.ShowError("An error occurred while deleting the offer from the database.")
        End If
    End Sub

    Protected Sub NewOfferImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles NewOfferImageButton.Click
        Response.Redirect("~/BVAdmin/Marketing/OffersEdit.aspx?type=" + Server.UrlEncode(OfferTypeDropDownList.SelectedValue))
    End Sub

    Protected Sub OffersGridView_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles OffersGridView.RowEditing
        Response.Redirect("~/BVAdmin/Marketing/OffersEdit.aspx?id=" + Server.UrlEncode(OffersGridView.DataKeys(e.NewEditIndex).Value))
    End Sub

    Protected Sub OffersGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles OffersGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem IsNot Nothing Then
                'Dim offersTable As Table = CType(OffersGridView.Controls(0), Table)
                Dim offer As Marketing.Offer = DirectCast(e.Row.DataItem, Marketing.Offer)
                If offer.Name = "Separator" Then
                    Dim cell As New TableCell()
                    cell.ColumnSpan = e.Row.Cells.Count
                    cell.Text = "Priority: " + CStr(offer.Priority)
                    e.Row.Cells.Clear()                    
                    e.Row.Cells.Add(cell)
                    e.Row.RowType = DataControlRowType.Separator
                    e.Row.ControlStyle.CssClass = "separator"
                Else

                    Dim enableImageButton As ImageButton = DirectCast(e.Row.Cells(6).FindControl("EnableImageButton"), ImageButton)
                    Dim disableImageButton As ImageButton = DirectCast(e.Row.Cells(6).FindControl("DisableImageButton"), ImageButton)
                    If offer.Enabled Then
                        enableImageButton.Visible = False
                        disableImageButton.Visible = True
                        disableImageButton.CommandArgument = offer.Bvin
                    Else
                        enableImageButton.Visible = True
                        enableImageButton.CommandArgument = offer.Bvin
                        disableImageButton.Visible = False
                    End If

                    DirectCast(e.Row.Cells(8).FindControl("MoveUpImageButton"), ImageButton).CommandArgument = offer.Bvin
                    DirectCast(e.Row.Cells(8).FindControl("MoveDownImageButton"), ImageButton).CommandArgument = offer.Bvin

                    Dim statusImage As Image = DirectCast(e.Row.Cells(0).FindControl("StatusImage"), Image)
                    If offer.IsExpired Then
                        statusImage.ImageUrl = "~/BVAdmin/Images/SalesStatus/Expired.gif"
                        statusImage.AlternateText = "Expired"
                        statusImage.Attributes.Add("title", "Expired")
                    ElseIf offer.IsPending Then
                        statusImage.ImageUrl = "~/BVAdmin/Images/SalesStatus/Pending.gif"
                        statusImage.AlternateText = "Pending"
                        statusImage.Attributes.Add("title", "Pending")
                    ElseIf offer.Enabled Then
                        statusImage.ImageUrl = "~/BVAdmin/Images/SalesStatus/Enabled.gif"
                        statusImage.AlternateText = "Enabled"
                        statusImage.Attributes.Add("title", "Enabled")
                    ElseIf Not offer.Enabled Then
                        statusImage.ImageUrl = "~/BVAdmin/Images/SalesStatus/Disabled.gif"
                        statusImage.AlternateText = "Disabled"
                        statusImage.Attributes.Add("title", "Disabled")
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub OffersGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles OffersGridView.RowCommand
        If e.CommandName = "Enable" Then
            Dim offer As Marketing.Offer = Marketing.Offer.FindByBvin(e.CommandArgument)
            offer.Enabled = True
            If Not offer.Commit() Then
                MessageBox1.ShowError("An error occurred while trying to save the offer to the database.")
            End If
            BindOffersGridView()
        ElseIf e.CommandName = "Disable" Then
            Dim offer As Marketing.Offer = Marketing.Offer.FindByBvin(e.CommandArgument)
            offer.Enabled = False
            If Not offer.Commit() Then
                MessageBox1.ShowError("An error occurred while trying to save the offer to the database.")
            End If
            BindOffersGridView()
        ElseIf (e.CommandName = "MoveUp") Then
            Dim offers As Marketing.OfferList = GetCurrentOffers()
            If offers.MoveDown(e.CommandArgument) Then
                If Not offers.Commit() Then
                    MessageBox1.ShowError("An error occurred while trying to update the order.")
                End If
            End If
            BindOffersGridView()
        ElseIf e.CommandName = "MoveDown" Then
            Dim offers As BusinessEntityList(Of Marketing.Offer) = GetCurrentOffers()
            If offers.MoveUp(e.CommandArgument) Then
                If Not offers.Commit() Then
                    MessageBox1.ShowError("An error occurred while trying to update the order.")
                End If
            End If
            BindOffersGridView()
        End If
    End Sub
End Class
