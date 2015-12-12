Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.PersonalizationServices


Partial Class BVModules_Themes_Foundation4_Responsive_Pages_myaccount_AddressBook_Edit
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("MyAccount.master")

        If SessionManager.IsUserAuthenticated = False Then
            Response.Redirect("login.aspx?ReturnURL=" & Server.UrlEncode(Request.Url.PathAndQuery))
        End If

    End Sub

    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
        hfUserBvin.Value = SessionManager.GetCurrentUserId

        If Not Page.IsPostBack Then
            SaveButton.ImageUrl = GetThemedButton("SaveChanges")
            CancelButton.ImageUrl = GetThemedButton("Cancel")
            Page.Title = "Edit Address"
            Me.AddressControl1.SetFocus()
        End If

        If Not Page.IsPostBack Then
            Dim returnURL As String = ""
            If Not (Request.QueryString("ReturnURL") Is Nothing) Then
                ViewState("ReturnURL") = Request.QueryString("ReturnURL")
            End If

            If Request.QueryString("index") IsNot Nothing Then
                Select Case Request.QueryString("index")
                    Case "b"
                        LoadBilling()
                    Case "s"
                        LoadShipping()
                    Case Else
                        Dim editIndex As Integer = -1
                        editIndex = Convert.ToInt32(Request.Params("index"))
                        ViewState("EditIndex") = editIndex
                        LoadAddress(editIndex)
                End Select
            Else
                msg.ShowError("No Valid Edit ID was found. Please contact an administrator.")
            End If


        End If
    End Sub

    Private Sub PrepControls()
        AddressControl1.ShowMiddleInitial = (WebAppSettings.BillAddressShowMiddleInitial OrElse WebAppSettings.ShipAddressShowMiddleInitial)
        AddressControl1.ShowCompanyName = (WebAppSettings.BillAddressShowCompany OrElse WebAppSettings.ShipAddressShowCompany)
        AddressControl1.ShowPhoneNumber = (WebAppSettings.BillAddressShowPhone OrElse WebAppSettings.ShipAddressShowPhone)
        AddressControl1.ShowFaxNumber = (WebAppSettings.BillAddressShowFax OrElse WebAppSettings.ShipAddressShowFax)
        AddressControl1.ShowWebSiteURL = (WebAppSettings.BillAddressShowWebSiteUrl OrElse WebAppSettings.ShipAddressShowWebSiteURL)
    End Sub

    Private Sub LoadBilling()
        PrepControls()
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.hfUserBvin.Value)
        If Not u Is Nothing Then
            Me.AddressControl1.LoadFromAddress(u.BillingAddress)
        End If
    End Sub

    Private Sub LoadShipping()
        PrepControls()
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.hfUserBvin.Value)
        If Not u Is Nothing Then
            Me.AddressControl1.LoadFromAddress(u.ShippingAddress)
        End If
    End Sub

    Private Sub LoadAddress(ByVal index As Integer)
        PrepControls()
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.hfUserBvin.Value)
        If Not u Is Nothing Then
            If Not u.Addresses Is Nothing Then
                If u.Addresses.Count > index Then
                    Me.SaveButton.Visible = True
                    AddressControl1.LoadFromAddress(u.Addresses(index))
                Else
                    msg.ShowWarning("The requested address wasn't found in the collection.")
                    Me.SaveButton.Visible = False
                End If
            Else
                msg.ShowWarning("Address book couldn't be loaded.")
                Me.SaveButton.Visible = False
            End If
        End If
    End Sub

    Private Sub CancelButton_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelButton.Click
        If ViewState("ReturnURL") Is Nothing Then
            Response.Redirect("MyAccount_AddressBook.aspx", True)
        Else
            Response.Redirect(ViewState("ReturnURL"), True)
        End If
    End Sub

    Private Sub SaveButton_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveButton.Click
        If AddressControl1.Validate = True Then

            Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.hfUserBvin.Value)
            If Not u Is Nothing Then

                Select Case Request.QueryString("index")
                    Case "b"
                        AddressControl1.GetAsAddress.CopyTo(u.BillingAddress)
                        Membership.UserAccount.Update(u)
                        If ViewState("ReturnURL") Is Nothing Then
                            Response.Redirect("MyAccount_AddressBook.aspx", True)
                        Else
                            Response.Redirect(ViewState("ReturnURL"), True)
                        End If
                    Case "s"
                        AddressControl1.GetAsAddress.CopyTo(u.ShippingAddress)
                        Membership.UserAccount.Update(u)
                        If ViewState("ReturnURL") Is Nothing Then
                            Response.Redirect("MyAccount_AddressBook.aspx", True)
                        Else
                            Response.Redirect(ViewState("ReturnURL"), True)
                        End If
                    Case Else
                        Dim index As Integer = -1
                        index = CType(ViewState("EditIndex"), System.Int32)

                        If Not u.Addresses Is Nothing Then
                            If u.Addresses.Count > index Then
                                Dim b As Contacts.Address = AddressControl1.GetAsAddress
                                If Not b Is Nothing Then
                                    If b.CopyTo(u.Addresses(index)) = True Then
                                        Membership.UserAccount.Update(u)
                                        If ViewState("ReturnURL") Is Nothing Then
                                            Response.Redirect("MyAccount_AddressBook.aspx", True)
                                        Else
                                            Response.Redirect(ViewState("ReturnURL"), True)
                                        End If
                                    Else
                                        msg.ShowWarning("The address updated failed. Please try again.")
                                    End If
                                Else
                                    msg.ShowWarning("The address control failed to parse the address.")
                                End If
                            Else
                                msg.ShowWarning("The requested address wasn't found in the collection.")
                            End If
                        Else
                            msg.ShowError("Couldn't Load Address to Save")
                        End If

                End Select


            End If
        End If
    End Sub
End Class
