Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVAdmin_People_users_edit_address
    Inherits BaseAdminPage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit User Address"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        SetEditorMode()

        If Not Page.IsPostBack Then

            SetSecurityModel()

            If Not Request.QueryString("UserID") Is Nothing Then
                Me.UserIDField.Value = Request.QueryString("UserID")
            End If

            If Request.QueryString("id") IsNot Nothing Then
                Select Case Request.QueryString("id")
                    Case "b"
                        LoadBilling()
                    Case "s"
                        LoadShipping()
                    Case Else
                        LoadAddressForUser(Request.QueryString("id"))
                End Select                
            Else
                Dim a As New Contacts.Address
                a.CountryBvin = WebAppSettings.SiteCountryBvin
                Me.AddressEditor1.LoadFromAddress(a)
            End If

        End If
    End Sub

    Private Sub SetSecurityModel()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = False Then
            Me.btnSave.Enabled = False
            Me.btnSave.Visible = False
        End If
    End Sub

    Private Sub SetEditorMode()
        AddressEditor1.RequireAddress = False
        AddressEditor1.RequireCity = False
        AddressEditor1.RequireCompany = False
        AddressEditor1.RequireFax = False
        AddressEditor1.RequireFirstName = False
        AddressEditor1.RequireLastName = False
        AddressEditor1.RequirePhone = False
        AddressEditor1.RequirePostalCode = False
        AddressEditor1.RequireRegion = False
        AddressEditor1.RequireWebSiteURL = False
        AddressEditor1.ShowCompanyName = True
        AddressEditor1.ShowFaxNumber = True
        AddressEditor1.ShowMiddleInitial = True
        AddressEditor1.ShowPhoneNumber = True
        AddressEditor1.ShowWebSiteURL = True
        AddressEditor1.ShowCounty = True
    End Sub

    Private Sub LoadAddressForUser(ByVal addressID As String)
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.UserIDField.Value)
        If Not u Is Nothing Then
            If Not u.Addresses Is Nothing Then
                For i As Integer = 0 To u.Addresses.Count - 1
                    If u.Addresses(i).Bvin = addressID Then
                        Me.AddressEditor1.LoadFromAddress(u.Addresses(i))
                    End If
                Next
            End If
        End If
        u = Nothing
    End Sub

    Private Sub LoadBilling()
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.UserIDField.Value)
        If Not u Is Nothing Then           
            Me.AddressEditor1.LoadFromAddress(u.BillingAddress)
        End If
        u = Nothing
    End Sub

    Private Sub LoadShipping()
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.UserIDField.Value)
        If Not u Is Nothing Then
            Me.AddressEditor1.LoadFromAddress(u.ShippingAddress)
        End If
        u = Nothing
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("users_edit.aspx?id=" & Me.UserIDField.Value)
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.AddressEditor1.Validate = True Then
            If SaveCurrentAddress() = True Then
                Response.Redirect("users_edit.aspx?id=" & Me.UserIDField.Value)
            Else
                ' throw error
            End If            
        End If
    End Sub

    Private Function SaveCurrentAddress() As Boolean
        Dim result As Boolean = False

        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.UserIDField.Value)
        If Not String.IsNullOrEmpty(u.Bvin) Then
            Dim temp As Contacts.Address = Me.AddressEditor1.GetAsAddress
            temp.Bvin = System.Guid.NewGuid().ToString()

            Dim addressId As String = Request.QueryString("id")
            Select Case addressId
                Case "b"
                    temp.CopyTo(u.BillingAddress)
                Case "s"
                    temp.CopyTo(u.ShippingAddress)
                Case Else
                    Dim addressFound As Boolean = False

                    If Not String.IsNullOrEmpty(addressId) Then
                        For i As Integer = 0 To u.Addresses.Count - 1
                            If u.Addresses(i).Bvin = addressId Then
                                addressFound = True
                                temp.CopyTo(u.Addresses(i))
                            End If
                        Next
                    End If

                    If addressFound = False Then
                        ' Add a new address
                        u.Addresses.Add(temp)
                    End If
            End Select


            Dim s As Membership.CreateUserStatus = Membership.CreateUserStatus.None
            result = Membership.UserAccount.Update(u, s)
        End If

        Return result
    End Function

End Class
