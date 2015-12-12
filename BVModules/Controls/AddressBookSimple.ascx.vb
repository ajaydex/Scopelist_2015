Imports BVSoftware.BVC5.Core

Partial Class BVModules_Controls_AddressBookSimple
    Inherits System.Web.UI.UserControl

    Public Event AddressSelected(ByVal addressType As String, ByVal address As Contacts.Address)

    Private _tabIndex As Integer = -1
    Private _addressType As String = String.Empty
    Private _addressFormat As String = String.Empty
    Private _userId As String = String.Empty

#Region " Properties "

    Public Property TabIndex() As Integer
        Get
            Return Me._tabIndex
        End Get
        Set(ByVal value As Integer)
            Me._tabIndex = value
        End Set
    End Property

    Public Property AddressType() As String
        Get
            Return Me._addressType
        End Get
        Set(ByVal value As String)
            Me._addressType = value
        End Set
    End Property

    Public Property AddressFormat() As String
        Get
            Return Me._addressFormat
        End Get
        Set(ByVal value As String)
            Me._addressFormat = value
        End Set
    End Property

    Public Property UserID() As String
        Get
            Return _userId
        End Get
        Set(value As String)
            _userId = value
        End Set
    End Property

#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Me.btnAddressBook.ImageUrl = PersonalizationServices.GetThemedButton("AddressBookDropdown")
            Me.btnAddressBook.AlternateText = Content.SiteTerms.GetTerm("AddressBook")
            BindAddresses()
        End If
    End Sub

    Public Sub BindAddresses()
        ' Auto-populate with information for logged in user only if we are not in the admin
        If String.IsNullOrEmpty(Me.UserID) AndAlso Not TypeOf Me.Page Is BaseAdminPage Then
            If SessionManager.IsUserAuthenticated() Then
                Me.UserID = SessionManager.GetCurrentUserId()
            End If
        End If

        If String.IsNullOrEmpty(Me.UserID) Then
            Me.Visible = False
        Else

            Me.Visible = False

            Me.rpAddressBook.Visible = False


            Dim user As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.UserID)
            If Not String.IsNullOrEmpty(user.Bvin) Then
                If user.Addresses.Count > 0 Then
                    Me.Visible = True

                    Me.rpAddressBook.DataSource = user.Addresses
                    Me.rpAddressBook.DataBind()
                End If
            End If

            Me.btnAddressBook.CssClass = If(Me.rpAddressBook.Visible, "addressBookButtonActive", "addressBookButton")
        End If
    End Sub

    Protected Sub btnAddressBook_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddressBook.Click
        Me.rpAddressBook.Visible = Not Me.rpAddressBook.Visible
        Me.rpAddressBook.UpdateAfterCallBack = True

        Me.btnAddressBook.CssClass = If(Me.rpAddressBook.Visible, "addressBookButtonActive", "addressBookButton")
    End Sub

    Protected Sub btnClose_Click(ByVal sender As Object, ByVal e As EventArgs)
        Me.btnAddressBook_Click(Nothing, Nothing)
    End Sub

    Protected Sub rpAddressBook_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles rpAddressBook.ItemDataBound
        Select Case e.Item.ItemType

            Case ListItemType.Item, ListItemType.AlternatingItem
                Dim address As Contacts.Address = CType(e.Item.DataItem, Contacts.Address)

                Dim lnkAddress As Anthem.LinkButton = CType(e.Item.FindControl("lnkAddress"), Anthem.LinkButton)
                If lnkAddress IsNot Nothing Then
                    lnkAddress.Text = FormatAddress(Me.AddressFormat, address)
                    lnkAddress.Attributes.Add("rel", e.Item.ItemIndex.ToString())  ' address.Bvin
                End If

            Case ListItemType.Footer
                Dim btnClose As Anthem.ImageButton = CType(e.Item.FindControl("btnClose"), Anthem.ImageButton)
                If btnClose IsNot Nothing Then
                    btnClose.ImageUrl = PersonalizationServices.GetThemedButton("x")
                End If

        End Select
    End Sub

    Protected Sub lnkAddress_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim u As Membership.UserAccount
        If String.IsNullOrEmpty(UserID) Then
            u = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
        Else
            u = Membership.UserAccount.FindByBvin(UserID)
        End If

        If u.Bvin <> String.Empty Then
            Dim lnkAddress As Anthem.LinkButton = CType(sender, Anthem.LinkButton)
            Dim addressIndex As Integer = Convert.ToInt32(lnkAddress.Attributes("rel"))
            RaiseEvent AddressSelected(Me.AddressType, u.Addresses(addressIndex))

            Me.btnAddressBook_Click(Nothing, Nothing)
        End If
    End Sub

    Private Function FormatAddress(ByVal addressFormat As String, ByVal address As Contacts.Address) As String
        If String.IsNullOrEmpty(addressFormat) Then
            If address IsNot Nothing Then
                Return address.ToHtmlString()
            Else
                Return String.Empty
            End If
        End If

        Dim sb As New StringBuilder(addressFormat)
        sb.Replace("[[City]]", address.City)
        sb.Replace("[[Company]]", address.Company)
        sb.Replace("[[CountryName]]", address.CountryName)
        sb.Replace("[[CountyName]]", address.CountyName)
        sb.Replace("[[Fax]]", address.Fax)
        sb.Replace("[[FirstName]]", address.FirstName)
        sb.Replace("[[LastName]]", address.LastName)
        sb.Replace("[[Line1]]", address.Line1)
        sb.Replace("[[Line2]]", address.Line2)
        sb.Replace("[[Line3]]", address.Line3)
        sb.Replace("[[MiddleInitial]]", address.MiddleInitial)
        sb.Replace("[[NickName]]", address.NickName)
        sb.Replace("[[Phone]]", address.Phone)
        sb.Replace("[[PostalCode]]", address.PostalCode)
        sb.Replace("[[RegionName]]", address.RegionName)
        sb.Replace("[[WebSiteUrl]]", address.WebSiteUrl)

        Return sb.ToString()
    End Function

End Class