Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.PersonalizationServices


Partial Class myaccount_AddressBook_New
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("MyAccount.master")

        If SessionManager.IsUserAuthenticated = False Then
            Response.Redirect("login.aspx?ReturnURL=" & Server.UrlEncode("MyAccount_AddressBook_New.aspx"))
        End If


    End Sub

    Sub PageLoad(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
        hfUserBvin.Value = SessionManager.GetCurrentUserId

        Dim ManualBreadCrumbTrial As BVModules_Controls_ManualBreadCrumbTrail = DirectCast(Me.Master.FindControl("ManualBreadCrumbTrail1"), BVModules_Controls_ManualBreadCrumbTrail)

        ManualBreadCrumbTrial.ClearTrail()
        ManualBreadCrumbTrial.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        ManualBreadCrumbTrial.AddLink(Content.SiteTerms.GetTerm("MyAccount"), "~/MyAccount_Orders.aspx")
        ManualBreadCrumbTrial.AddNonLink(Content.SiteTerms.GetTerm("CreateNewAddress"))

        If Not Page.IsPostBack Then
            'SaveButton.ImageUrl = GetThemedButton("SaveChanges")
            'CancelButton.ImageUrl = GetThemedButton("Cancel")
            Page.Title = "New Address"
        End If

        If Not Page.IsPostBack Then
            Dim returnURL As String = ""
            If Not (Request.Params("ReturnURL") Is Nothing) Then
                ViewState("ReturnURL") = Request.Params("ReturnURL")
            End If
        End If

        AddressControl1.ShowMiddleInitial = (WebAppSettings.BillAddressShowMiddleInitial OrElse WebAppSettings.ShipAddressShowMiddleInitial)
        AddressControl1.ShowCompanyName = (WebAppSettings.BillAddressShowCompany OrElse WebAppSettings.ShipAddressShowCompany)
        AddressControl1.ShowPhoneNumber = (WebAppSettings.BillAddressShowPhone OrElse WebAppSettings.ShipAddressShowPhone)
        AddressControl1.ShowFaxNumber = (WebAppSettings.BillAddressShowFax OrElse WebAppSettings.ShipAddressShowFax)
        AddressControl1.ShowWebSiteURL = (WebAppSettings.BillAddressShowWebSiteUrl OrElse WebAppSettings.ShipAddressShowWebSiteURL)
    End Sub

    Private Sub CancelButton_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelButton.Click
        Response.Redirect("MyAccount_AddressBook.aspx", True)
    End Sub

    Private Sub SaveButton_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveButton.Click
        If AddressControl1.Validate = True Then
            Dim a As Contacts.Address
            a = AddressControl1.GetAsAddress
            If Not a Is Nothing Then
                Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.hfUserBvin.Value)
                If Not u Is Nothing Then
                    u.Addresses.Add(a)
                    'BVC2004Store.UpdateCurrentUser(u)
                    Membership.UserAccount.Update(u)
                End If
            End If
            a = Nothing

            If ViewState("ReturnURL") Is Nothing Then
                Response.Redirect("MyAccount_AddressBook.aspx", True)
            Else
                Response.Redirect(ViewState("ReturnURL"), True)
            End If
        End If

    End Sub

End Class
