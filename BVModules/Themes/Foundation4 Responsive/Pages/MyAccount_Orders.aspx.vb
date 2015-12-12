Imports System.IO
Imports System.Data
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel


Partial Class BVModules_Themes_Foundation4_Responsive_Pages_MyAccount_Orders
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

        If Not Page.IsPostBack Then
            Page.Title = Content.SiteTerms.GetTerm("OrderHistory")
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("OrderHistory")
            LoadOrders()
        End If

    End Sub

    Sub LoadOrders()
        Dim dtOrders As Collection(Of Orders.Order) = Orders.Order.FindByUser(SessionManager.GetCurrentUserId)

        If dtOrders.Count > 0 Then
            If dtOrders.Count = 1 Then
                lblItems.Text = dtOrders.Count & " Order Found"
            Else
                lblItems.Text = dtOrders.Count & " Orders Found"
            End If

            Me.rpOrders.DataSource = dtOrders
            Me.rpOrders.DataBind()
        Else
            lblItems.Text = "No Orders Could Be Found.  <a href=""Default.aspx"" title=""" & WebAppSettings.SiteName & " Home Page"">Start Shopping</a> »"
        End If

    End Sub

    Private Sub rpOrders_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles rpOrders.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim o As Orders.Order = CType(e.Item.DataItem, Orders.Order)

            Dim lblOrderNumber As Label = CType(e.Item.FindControl("lblOrderNumber"), Label)
            If lblOrderNumber IsNot Nothing Then
                lblOrderNumber.Text = o.OrderNumber
            End If

            Dim lblGrandTotal As Label = CType(e.Item.FindControl("lblGrandTotal"), Label)
            If lblGrandTotal IsNot Nothing Then
                lblGrandTotal.Text = o.GrandTotal.ToString("c")
            End If

            Dim lblTimeOfOrder As Label = CType(e.Item.FindControl("lblTimeOfOrder"), Label)
            If lblTimeOfOrder IsNot Nothing Then
                lblTimeOfOrder.Text = o.TimeOfOrder.ToString()
            End If

            Dim lnkDetails As HyperLink = CType(e.Item.FindControl("lnkDetails"), HyperLink)
            If lnkDetails IsNot Nothing Then
                lnkDetails.ImageUrl = PersonalizationServices.GetThemedButton("Details")
                lnkDetails.NavigateUrl = "~/MyAccount_Orders_Details.aspx?id=" + o.Bvin
            End If

            Dim btnReorder As ImageButton = CType(e.Item.FindControl("btnReorder"), ImageButton)
            If btnReorder IsNot Nothing Then
                btnReorder.CommandArgument = o.Bvin
                btnReorder.ImageUrl = PersonalizationServices.GetThemedButton("CopyToCart")
            End If
        End If
    End Sub

    Protected Sub rpOrders_ItemCommand(ByVal source As Object, ByVal e As RepeaterCommandEventArgs) Handles rpOrders.ItemCommand
        Dim o As Orders.Order = Orders.Order.FindByBvin(e.CommandArgument.ToString())

        If e.CommandName = "Reorder" Then
            o.CopyItemsTo(SessionManager.CurrentShoppingCart())

            If WebAppSettings.RedirectToCartAfterAddProduct AndAlso Not Me.ForceNoShoppingCartRedirection Then
                Response.Redirect("~/Cart.aspx")
            End If
        End If
    End Sub

End Class