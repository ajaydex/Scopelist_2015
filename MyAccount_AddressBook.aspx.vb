Imports BVSoftware.Bvc5.Core.PersonalizationServices
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Partial Class myaccount_AddressBook
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("MyAccount.master")

        If SessionManager.IsUserAuthenticated = False Then
            Response.Redirect("login.aspx?ReturnURL=" & Server.UrlEncode("MyAccount_AddressBook.aspx"))
        End If

    End Sub

    Sub PageLoad(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        Utilities.WebForms.MakePageNonCacheable(Me)

        Dim ManualBreadCrumbTrial As BVModules_Controls_ManualBreadCrumbTrail = DirectCast(Me.Master.FindControl("ManualBreadCrumbTrail1"), BVModules_Controls_ManualBreadCrumbTrail)

        ManualBreadCrumbTrial.ClearTrail()
        ManualBreadCrumbTrial.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        ManualBreadCrumbTrial.AddLink(Content.SiteTerms.GetTerm("MyAccount"), "~/MyAccount_Orders.aspx")
        ManualBreadCrumbTrial.AddNonLink(Content.SiteTerms.GetTerm("AddressBook"))

        If Not Page.IsPostBack Then

            hfUserBvin.Value = SessionManager.GetCurrentUserId

            'comemnted by developer
            'Me.btnShippingAddressEdit.ImageUrl = PersonalizationServices.GetThemedButton("edit")
            Me.btnShippingAddressEdit.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-edit.png")
            'Me.btnBillingAddressEdit.ImageUrl = PersonalizationServices.GetThemedButton("edit")
            Me.btnBillingAddressEdit.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-edit.png")

            'AddNewButton.ImageUrl = GetThemedButton("New")
            AddNewButton.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-createnew.png")
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("AddressBook")
            Page.Title = Content.SiteTerms.GetTerm("AddressBook")
            LoadAddresses()

        End If

    End Sub

    Sub LoadAddresses()

        Dim u As Membership.UserAccount
        u = Membership.UserAccount.FindByBvin(Me.hfUserBvin.Value)
        If u IsNot Nothing Then

            Me.BillingAddressField.Text = u.BillingAddress.ToHtmlString
            Me.ShippingAddressField.Text = u.ShippingAddress.ToHtmlString

            If u.Addresses.Count < 1 Then
                lblItems.Text = "Your Address Book is empty."
            ElseIf u.Addresses.Count = 1 Then
                lblItems.Text = u.Addresses.Count & " address found"
                AddressList.DataSource = u.Addresses
                AddressList.DataBind()
            Else
                lblItems.Text = u.Addresses.Count & " addresses found"
                AddressList.DataSource = u.Addresses
                AddressList.DataBind()
            End If
        End If
        u = Nothing

    End Sub

    Private Sub AddNewButton_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddNewButton.Click
        Response.Redirect("MyAccount_AddressBook_New.aspx", True)
    End Sub

    Private Sub AddressList_EditCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles AddressList.EditCommand
        Dim editID As Integer = e.Item.ItemIndex
        Response.Redirect("myaccount_AddressBook_Edit.aspx?index=" & editID, True)
    End Sub

    Private Sub AddressList_DeleteCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles AddressList.DeleteCommand
        Dim editID As Integer = e.Item.ItemIndex
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.hfUserBvin.Value)
        If Not u Is Nothing Then
            If Not u.Addresses Is Nothing Then
                If editID <= (u.Addresses.Count - 1) Then
                    u.Addresses.RemoveAt(editID)
                    Membership.UserAccount.Update(u)
                End If
            End If
        End If
        'LoadAddresses()
        Response.Redirect("MyAccount_AddressBook.aspx")
    End Sub

    Private Sub AddressList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles AddressList.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim DeleteButton As System.Web.UI.WebControls.ImageButton
            Dim EditButton As System.Web.UI.WebControls.ImageButton
            Dim ShipTo As System.Web.UI.WebControls.ImageButton = e.Item.FindControl("ShipToImageButton")
            Dim BillTo As System.Web.UI.WebControls.ImageButton = e.Item.FindControl("BillToImageButton")

            ShipTo.CommandArgument = AddressList.DataKeys(e.Item.ItemIndex).ToString()
            BillTo.CommandArgument = ShipTo.CommandArgument

            DeleteButton = e.Item.FindControl("DeleteButton")
            EditButton = e.Item.FindControl("EditButton")
            'comemnted by developer
            If Not DeleteButton Is Nothing Then
                'DeleteButton.ImageUrl = GetThemedButton("Delete")
                DeleteButton.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-delete.png")
            End If
            If Not EditButton Is Nothing Then
                'EditButton.ImageUrl = GetThemedButton("Edit")
                EditButton.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-edit.png")
            End If

            If Not ShipTo Is Nothing Then
                'ShipTo.ImageUrl = GetThemedButton("ShipTo")
                ShipTo.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-shipto.png")
            End If
            If Not BillTo Is Nothing Then
                'BillTo.ImageUrl = GetThemedButton("BillTo")
                BillTo.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-billto.png")
            End If

            Dim AddressDisplay As System.Web.UI.WebControls.Literal
            AddressDisplay = e.Item.FindControl("AddressDisplay")
            If Not AddressDisplay Is Nothing Then
                AddressDisplay.Text = CType(e.Item.DataItem, Contacts.Address).ToHtmlString
            End If
        End If
    End Sub

    Protected Sub btnBillingAddressEdit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnBillingAddressEdit.Click
        Response.Redirect("myaccount_AddressBook_Edit.aspx?index=b")
    End Sub

    Protected Sub btnShippingAddressEdit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShippingAddressEdit.Click
        Response.Redirect("myaccount_AddressBook_Edit.aspx?index=s")
    End Sub

    Protected Sub AddressList_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles AddressList.ItemCommand
        If e.CommandName.ToUpper() = "BILLTO" Then
            Dim u As Membership.UserAccount
            u = Membership.UserAccount.FindByBvin(Me.hfUserBvin.Value)
            If u IsNot Nothing Then
                For Each item As Contacts.Address In u.Addresses
                    If item.Bvin = e.CommandArgument Then
                        u.BillingAddress = item
                        Membership.UserAccount.Update(u)
                        Exit For
                    End If
                Next
                LoadAddresses()
            End If
        ElseIf e.CommandName.ToUpper() = "SHIPTO" Then
            Dim u As Membership.UserAccount
            u = Membership.UserAccount.FindByBvin(Me.hfUserBvin.Value)
            If u IsNot Nothing Then
                For Each item As Contacts.Address In u.Addresses
                    If item.Bvin = e.CommandArgument Then
                        u.ShippingAddress = item
                        Membership.UserAccount.Update(u)
                        Exit For
                    End If
                Next
                LoadAddresses()
            End If
        End If
    End Sub
End Class
