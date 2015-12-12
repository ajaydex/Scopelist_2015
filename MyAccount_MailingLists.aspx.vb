Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.Membership
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core.PersonalizationServices

Partial Class MyAccount_MailingLists
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("MyAccount.master")

        If SessionManager.IsUserAuthenticated = False Then
            Response.Redirect("login.aspx?ReturnURL=" & Server.UrlEncode("MyAccount_MailingLists.aspx"))
        End If

    End Sub

    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        Utilities.WebForms.MakePageNonCacheable(Me)

        Dim ManualBreadCrumbTrial As BVModules_Controls_ManualBreadCrumbTrail = DirectCast(Me.Master.FindControl("ManualBreadCrumbTrail1"), BVModules_Controls_ManualBreadCrumbTrail)

        ManualBreadCrumbTrial.ClearTrail()
        ManualBreadCrumbTrial.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        ManualBreadCrumbTrial.AddLink(Content.SiteTerms.GetTerm("MyAccount"), "~/MyAccount_Orders.aspx")
        ManualBreadCrumbTrial.AddNonLink(Content.SiteTerms.GetTerm("MailingList"))

        hfUserBvin.Value = SessionManager.GetCurrentUserId

        If Not Page.IsPostBack Then
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("MailingLists")
            Page.Title = Content.SiteTerms.GetTerm("MailingLists")
        End If

        If Not Page.IsPostBack Then
            LoadLists()
        End If
    End Sub

    Sub LoadLists()
        dgLists.DataSource = Contacts.MailingList.FindAllPublic
        dgLists.DataBind()
    End Sub

    Sub dgLists_ItemDataBound(ByVal sender As Object, ByVal e As DataGridItemEventArgs) Handles dgLists.ItemDataBound

        Dim thisUser As UserAccount = UserAccount.FindByBvin(Me.hfUserBvin.Value)


        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then

            Dim listID As String = dgLists.DataKeys(e.Item.ItemIndex).ToString

            Dim btnSub As ImageButton = e.Item.Cells(1).FindControl("SubscribeButton")
            Dim btnUnsub As ImageButton = e.Item.Cells(2).FindControl("UnsubscribeButton")

            If Not btnSub Is Nothing Then
                'btnSub.ImageUrl = GetThemedButton("Subscribe")
                btnSub.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-subscribe.png")
            End If
            If Not btnUnsub Is Nothing Then
                'btnUnsub.ImageUrl = GetThemedButton("Unsubscribe")

                btnUnsub.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-unsubscribe.png")
            End If

            If Contacts.MailingList.CheckMembership(listID, thisUser.Email) = True Then
                If Not btnSub Is Nothing Then
                    btnSub.Visible = False
                End If
                If Not btnUnsub Is Nothing Then
                    btnUnsub.Visible = True
                End If
            Else
                If Not btnSub Is Nothing Then
                    btnSub.Visible = True
                End If
                If Not btnUnsub Is Nothing Then
                    btnUnsub.Visible = False
                End If
            End If
        End If
    End Sub

    Sub dgLists_Edit(ByVal sender As Object, ByVal e As DataGridCommandEventArgs) Handles dgLists.EditCommand

        Dim thisUser As UserAccount = UserAccount.FindByBvin(Me.hfUserBvin.Value)

        Dim listID As String = dgLists.DataKeys(e.Item.ItemIndex).ToString
        Dim mm As New Contacts.MailingListMember
        mm.FirstName = thisUser.FirstName
        mm.LastName = thisUser.LastName
        mm.EmailAddress = thisUser.Email
        mm.ListId = listID
        Contacts.MailingListMember.Insert(mm)
        LoadLists()

    End Sub

    Sub dgLists_Delete(ByVal sender As Object, ByVal e As DataGridCommandEventArgs) Handles dgLists.DeleteCommand

        Dim thisUser As UserAccount = UserAccount.FindByBvin(Me.hfUserBvin.Value)
        Dim listID As String = dgLists.DataKeys(e.Item.ItemIndex).ToString

        Contacts.MailingListMember.DeleteByEmail(thisUser.Email, listID)
        LoadLists()
    End Sub


End Class
