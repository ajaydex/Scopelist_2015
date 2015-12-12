Imports System.IO
Imports System.Data
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core.Content


Partial Class MyAccount_Orders
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property


    <ComponentModel.Browsable(True)> _
    Public Property ForceNoShoppingCartRedirection() As Boolean
        Get
            Dim obj As Object = ViewState("ForceNoShoppingCartRedirection")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("ForceNoShoppingCartRedirection") = value
        End Set
    End Property

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("MyAccount.master")

        If SessionManager.IsUserAuthenticated = False Then
            Response.Redirect("login.aspx?ReturnURL=" & Server.UrlEncode("MyAccount_Orders.aspx"))
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
        Dim ManualBreadCrumbTrial As BVModules_Controls_ManualBreadCrumbTrail = DirectCast(Me.Master.FindControl("ManualBreadCrumbTrail1"), BVModules_Controls_ManualBreadCrumbTrail)

        ManualBreadCrumbTrial.ClearTrail()
        ManualBreadCrumbTrial.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        ManualBreadCrumbTrial.AddLink(Content.SiteTerms.GetTerm("MyAccount"), "~/MyAccount_Orders.aspx")
        ManualBreadCrumbTrial.AddNonLink(Content.SiteTerms.GetTerm("OrderHistory"))

        If Not Page.IsPostBack Then
            Page.Title = Content.SiteTerms.GetTerm("OrderHistory")
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("OrderHistory")
            LoadOrders()
        End If

    End Sub

    Sub LoadOrders()


        Dim dtOrders As New Collection(Of Orders.Order)
        dtOrders = Orders.Order.FindByUser(SessionManager.GetCurrentUserId)

        Dim infoMessage As String = String.Empty

        If dtOrders.Count <> 0 Then
            'commented by developer
            If dtOrders.Count = 1 Then
                'lblItems.Text = dtOrders.Count & " Order Found"
                infoMessage = dtOrders.Count & " Order Found"
            Else
                'lblItems.Text = dtOrders.Count & " Orders Found"
                infoMessage = dtOrders.Count & " Order Found"
            End If
            dgOrders.Visible = True
            dgOrders.DataSource = dtOrders
            dgOrders.DataBind()
            msg.ShowMessage(infoMessage, DisplayMessageType.Information)
        Else
            'lblItems.Text = "No Orders Could Be Found.  <a href=""Default.aspx"" title=""" & WebAppSettings.SiteName & " Home Page"">Start Shopping</a> »"
            infoMessage = "No Orders Could Be Found.  <a href=""Default.aspx"" title=""" & WebAppSettings.SiteName & " Home Page"">Start Shopping</a> »"
            msg.ShowMessage(infoMessage, DisplayMessageType.Warning)
            dgOrders.Visible = False
        End If


    End Sub

    Private Sub dgOrders_Edit(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgOrders.EditCommand
        Dim orderID As String = dgOrders.DataKeys(e.Item.ItemIndex)
        Response.Redirect("Myaccount_Orders_Details.aspx?ID=" & orderID, True)
    End Sub

    Protected Sub dgOrders_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgOrders.ItemCommand
        If e.CommandName = "Reorder" Then
            Dim OrderID As String = e.CommandArgument.ToString

            If OrderID IsNot Nothing Then
                Dim oldOrder As Orders.Order

                oldOrder = Orders.Order.FindByBvin(OrderID)

                Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart

                oldOrder.CopyItemsTo(Basket)

                If (WebAppSettings.RedirectToCartAfterAddProduct) AndAlso (Not Me.ForceNoShoppingCartRedirection) Then
                    Response.Redirect("~/Cart.aspx")
                End If

            End If

        End If
    End Sub

    Private Sub dgOrders_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgOrders.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim DetailsButton As System.Web.UI.WebControls.ImageButton
            DetailsButton = e.Item.FindControl("DetailsButton")
            If Not DetailsButton Is Nothing Then
                DetailsButton.ImageUrl = PersonalizationServices.GetThemedButton("Details")
            End If

            Dim ReorderButton As System.Web.UI.WebControls.ImageButton
            ReorderButton = e.Item.FindControl("ReorderButton")
            If ReorderButton IsNot Nothing Then
                ReorderButton.ImageUrl = PersonalizationServices.GetThemedButton("CopyToCart")
            End If
        End If
    End Sub



End Class
