Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class MyAccount_WishList
    Inherits BaseStorePage

    Dim pricingWorkflow As BusinessRules.Workflow = Nothing

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected WithEvents AddToCartImageButton As System.Web.UI.WebControls.ImageButton

    Public Event AddToCartClicked(ByVal productId As String)

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
            Response.Redirect("login.aspx?ReturnURL=" & Server.UrlEncode("MyAccount_WishList.aspx"))
        End If

    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
        Me.ManualBreadCrumbTrail1.ClearTrail()
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("MyAccount"), "~/MyAccount_Orders.aspx")
        Me.ManualBreadCrumbTrail1.AddNonLink(Content.SiteTerms.GetTerm("WishList"))

        Dim li As Orders.LineItem = CType(Session(WebAppSettings.WishlistItemSessionKey), Orders.LineItem)
        If li IsNot Nothing Then
            If Catalog.WishList.AddItemToList(SessionManager.GetCurrentUserId, li) Then
                Session.Remove(WebAppSettings.WishlistItemSessionKey)
            End If
        End If

        If Not Page.IsPostBack Then

            Page.Title = Content.SiteTerms.GetTerm("WishList")
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("WishList")

            BindItems()
        End If
    End Sub

    Sub BindItems()
        pricingWorkflow = BusinessRules.Workflow.FindByName("Product Pricing")

        Dim w As New Collection(Of Catalog.WishList)
        Dim p As New Collection(Of Catalog.Product)

        w = Catalog.WishList.FindByUserBvin(SessionManager.GetCurrentUserId)

        'For Each item As Catalog.WishList In w
        '    Dim n As Catalog.Product = Catalog.InternalProduct.FindByBvin(item.ProductBvin)
        '    p.Add(n)
        'Next

        Me.GridView1.DataSource = w
        Me.GridView1.DataBind()
    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "AddToCart" Then

            Dim bvin As String = e.CommandArgument.ToString

            If Not String.IsNullOrEmpty(bvin) Then
                Dim wishlistItem As Catalog.WishList = Catalog.WishList.FindByBvin(bvin)
                Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(wishlistItem.ProductBvin)
                If p IsNot Nothing Then
                    If p.ChoiceCombinations.Count > 0 Then
                        Response.Redirect(p.ProductURL)
                        Catalog.WishList.RemoveItemFromList(bvin)
                    Else
                        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
                        Dim LineItem As New Orders.LineItem
                        LineItem.ProductId = wishlistItem.ProductBvin
                        If p.MinimumQty > wishlistItem.Quantity Then
                            LineItem.Quantity = p.MinimumQty
                        Else
                            LineItem.Quantity = wishlistItem.Quantity
                        End If

                        For Each item As Orders.LineItemInput In wishlistItem.Inputs
                            LineItem.Inputs.Add(item)
                        Next

                        For Each item As Orders.LineItemModifier In wishlistItem.Modifiers
                            LineItem.Modifiers.Add(item)
                        Next

                        Basket.AddItem(LineItem)

                        RaiseEvent AddToCartClicked(wishlistItem.ProductBvin)
                        Catalog.WishList.RemoveItemFromList(bvin)
                        If (WebAppSettings.RedirectToCartAfterAddProduct) AndAlso (Not Me.ForceNoShoppingCartRedirection) Then
                            Response.Redirect("~/Cart.aspx")
                        End If
                    End If
                End If
            End If

        End If

    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim deleteid As String = Me.GridView1.DataKeys(e.RowIndex).Value.ToString
        Catalog.WishList.RemoveItemFromList(deleteid)
        BindItems()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim DeleteButton As System.Web.UI.WebControls.ImageButton
            DeleteButton = e.Row.FindControl("DeleteButton")
            If Not DeleteButton Is Nothing Then
                DeleteButton.ImageUrl = PersonalizationServices.GetThemedButton("Delete")
            End If

            Dim AddToCartImageButton As ImageButton = e.Row.FindControl("AddToCartImageButton")
            If AddToCartImageButton IsNot Nothing Then
                AddToCartImageButton.ImageUrl = PersonalizationServices.GetThemedButton("AddToCart")
            End If

            Dim UpdateButton As ImageButton = e.Row.FindControl("UpdateButton")
            If UpdateButton IsNot Nothing Then
                UpdateButton.ImageUrl = PersonalizationServices.GetThemedButton("Update")
            End If

            Dim localWishList As Catalog.WishList = CType(e.Row.DataItem, Catalog.WishList)

            Dim localP As Catalog.Product = Catalog.InternalProduct.FindByBvin(localWishList.ProductBvin)

            ' SP3 - Declare Parent Product earlier for choices/input code later
            Dim parentProduct As Catalog.Product = Nothing
            If String.IsNullOrEmpty(localP.ParentId) = False Then
                parentProduct = Catalog.InternalProduct.FindByBvin(localP.ParentId)
            End If

            If localP IsNot Nothing Then
                Dim imgProduct As HyperLink = e.Row.FindControl("imgProduct")
                Dim lnkProduct As HyperLink = e.Row.FindControl("lnkProduct")
                Dim lnkProductPrice As HyperLink = e.Row.FindControl("lnkProductPrice")
                Dim litModifiers As Literal = e.Row.FindControl("litModifiers")
                If imgProduct IsNot Nothing Then
                    imgProduct.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(localP.ImageFileSmall, True))

                    If String.IsNullOrEmpty(localP.ParentId) Then
                        imgProduct.NavigateUrl = Utilities.UrlRewriter.BuildUrlForProduct(localP, Me.Page.Request)
                    Else
                        imgProduct.NavigateUrl = Utilities.UrlRewriter.BuildUrlForProduct(parentProduct, Me.Page.Request)
                    End If

                    If lnkProduct IsNot Nothing Then
                        lnkProduct.Text = localP.ProductName
                        lnkProduct.NavigateUrl = imgProduct.NavigateUrl
                    End If
                    If lnkProductPrice IsNot Nothing Then
                        lnkProductPrice.Text = localP.GetSitePriceForDisplay(localWishList.GetProductPriceAdjustment(), pricingWorkflow)
                        lnkProduct.NavigateUrl = imgProduct.NavigateUrl
                    End If

                    ' Service Pack 3 - Display Modifiers - Issue 1047 - Marcus
                    If litModifiers IsNot Nothing Then

                        Dim choiceCount As Integer = localP.ChoicesAndInputs.Count
                        If parentProduct IsNot Nothing Then
                            If parentProduct.ChoicesAndInputs.Count > 0 Then
                                choiceCount = parentProduct.ChoicesAndInputs.Count
                            End If
                        End If

                        If choiceCount > 0 Then
                            Dim sb As New StringBuilder()
                            sb.Append("<ul id=""wishlistmodifiers"">")
                            For Each modifier As Orders.LineItemModifier In localWishList.Modifiers
                                If modifier.DisplayToCustomer Then
                                    Dim pmo As Catalog.ProductModifierOption = Catalog.ProductModifierOption.FindByBvin(modifier.ModifierValue)
                                    If pmo IsNot Nothing AndAlso Not pmo.IsNull Then
                                        sb.Append("<li>")
                                        sb.Append(modifier.ModifierName & ": ")
                                        sb.Append(pmo.DisplayText)
                                        sb.Append("</li>")
                                    End If
                                End If
                            Next
                            For Each inp As Orders.LineItemInput In localWishList.Inputs
                                If inp.DisplayToCustomer AndAlso Not String.IsNullOrEmpty(inp.InputDisplayValue) Then
                                    sb.Append("<li>")
                                    sb.Append(inp.InputName & ": ")
                                    sb.Append(inp.InputDisplayValue)
                                    sb.Append("</li>")
                                End If
                            Next
                            sb.Append("</ul>")
                            litModifiers.Text = sb.ToString()
                        End If
                    End If

                End If
            End If
        End If

    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Dim updateId As String = Me.GridView1.DataKeys(e.RowIndex).Value.ToString
        Dim wishListItem As Catalog.WishList = Catalog.WishList.FindByBvin(updateId)
        If wishListItem IsNot Nothing Then
            Dim quantityTextBox As TextBox = CType(GridView1.Rows(e.RowIndex).FindControl("QuantityTextBox"), TextBox)
            If quantityTextBox IsNot Nothing Then
                Dim val As Integer = 0
                If Integer.TryParse(quantityTextBox.Text, val) Then
                    wishListItem.Quantity = val
                    If Catalog.WishList.UpdateItemInList(wishListItem) Then
                        MessageBox1.ShowOk(Content.SiteTerms.GetTerm("WishList") & " updated.")
                    Else
                        MessageBox1.ShowOk("Error updating " & Content.SiteTerms.GetTerm("WishList"))
                    End If
                End If
            End If
        End If
        BindItems()
    End Sub
End Class
