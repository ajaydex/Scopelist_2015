Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_AddressBook
    Inherits System.Web.UI.UserControl

    Public Event AddressSelected(ByVal addressType As String, ByVal address As Contacts.Address)

    Private _tabIndex As Integer = -1

    Public Property TabIndex() As Integer
        Get
            Return _tabIndex
        End Get
        Set(ByVal value As Integer)
            _tabIndex = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not SessionManager.IsUserAuthenticated Then
            Me.Visible = False
        Else
            Me.Visible = True
            If Not Page.IsPostBack Then
                'Me.AddressBookImageButton.ImageUrl = PersonalizationServices.GetThemedButton("AddressBook")
                Me.AddressBookImageButton.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-addressbook.png")
                If SessionManager.GetCurrentUserId <> String.Empty Then
                    Dim user As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
                    If user.Bvin <> String.Empty Then
                        If user.Addresses.Count > 0 Then
                            AddressGridView.DataSource = user.Addresses
                            AddressGridView.DataBind()
                        Else
                            Me.Visible = False
                        End If
                    End If
                End If

                If Me.TabIndex <> -1 Then
                    AddressBookImageButton.TabIndex = Me.TabIndex
                    Dim startIndex As Integer = Me.TabIndex + 1
                    For Each row As GridViewRow In AddressGridView.Rows
                        DirectCast(row.FindControl("BillToAddressImageButton"), ImageButton).TabIndex = startIndex
                        DirectCast(row.FindControl("ShipToAddressImageButton"), ImageButton).TabIndex = startIndex + 1
                        startIndex = startIndex + 2
                    Next
                End If
            End If
        End If
    End Sub

    Protected Sub AddressBookImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddressBookImageButton.Click
        AddressGridView.Visible = Not AddressGridView.Visible
        AddressGridView.UpdateAfterCallBack = True
    End Sub

    Protected Sub AddressGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles AddressGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem IsNot Nothing Then
                Dim address As Contacts.Address = DirectCast(e.Row.DataItem, Contacts.Address)
                Dim button As Anthem.ImageButton = DirectCast(e.Row.FindControl("BillToAddressImageButton"), Anthem.ImageButton)
                button.CommandArgument = address.Bvin
                button = DirectCast(e.Row.FindControl("BillToAddressImageButton"), Anthem.ImageButton)
                button.CommandArgument = address.Bvin
                'button.ImageUrl = PersonalizationServices.GetThemedButton("BillTo")

                Dim button2 As Anthem.ImageButton = DirectCast(e.Row.FindControl("ShipToAddressImageButton"), Anthem.ImageButton)
                button2.CommandArgument = address.Bvin
                button2 = DirectCast(e.Row.FindControl("ShipToAddressImageButton"), Anthem.ImageButton)
                button2.CommandArgument = address.Bvin
                'button2.ImageUrl = PersonalizationServices.GetThemedButton("ShipTo")

                Dim line As Label = DirectCast(e.Row.FindControl("lineone"), Label)
                line.Text = address.Line1

                line = DirectCast(e.Row.FindControl("linename"), Label)
                line.Text = address.FirstName + " " + address.MiddleInitial + " " + address.LastName
                line.Visible = True

                line = DirectCast(e.Row.FindControl("linetwo"), Label)
                If address.Line2.Trim() <> String.Empty Then
                    line.Text = address.Line2
                    line.Visible = True
                Else
                    line.Visible = False
                End If

                line = DirectCast(e.Row.FindControl("linethree"), Label)
                If address.Line3.Trim() <> String.Empty Then
                    line.Text = address.Line3
                    line.Visible = True
                Else
                    line.Visible = False
                End If

                line = DirectCast(e.Row.FindControl("linefour"), Label)
                line.Text = address.City + ", " + address.RegionName + " " + address.PostalCode
            End If
        End If
    End Sub

    Protected Sub AddressGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles AddressGridView.RowCommand
        Dim user As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
        If user.Bvin <> String.Empty Then
            If e.CommandName = "BillTo" Then
                For Each address As Contacts.Address In user.Addresses
                    If address.Bvin = e.CommandArgument Then
                        RaiseEvent AddressSelected("Billing", address)
                        Exit For
                    End If
                Next
                AddressGridView.Visible = Not AddressGridView.Visible
                AddressGridView.UpdateAfterCallBack = True
            ElseIf e.CommandName = "ShipTo" Then
                For Each address As Contacts.Address In user.Addresses
                    If address.Bvin = e.CommandArgument Then
                        RaiseEvent AddressSelected("Shipping", address)
                        Exit For
                    End If
                Next
                AddressGridView.Visible = Not AddressGridView.Visible
                AddressGridView.UpdateAfterCallBack = True
            End If
        End If
    End Sub
End Class
