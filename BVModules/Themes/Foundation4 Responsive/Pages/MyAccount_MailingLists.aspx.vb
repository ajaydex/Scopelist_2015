Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.Membership
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core.PersonalizationServices

Partial Class BVModules_Themes_Foundation4_Responsive_Pages_MailingLists
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

    Protected Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        Utilities.WebForms.MakePageNonCacheable(Me)

        hfUserBvin.Value = SessionManager.GetCurrentUserId

        If Not Page.IsPostBack Then
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("MailingLists")
            Page.Title = Content.SiteTerms.GetTerm("MailingLists")
        End If

        If Not Page.IsPostBack Then
            LoadLists()
        End If
    End Sub

    Protected Sub LoadLists()
        mailingListRepeater.DataSource = Contacts.MailingList.FindAllPublic
        mailingListRepeater.DataBind()
    End Sub

    Protected Sub mailingListRepeater_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles mailingListRepeater.ItemDataBound

        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim thisUser As UserAccount = UserAccount.FindByBvin(Me.hfUserBvin.Value)

            Dim list As Contacts.MailingList = CType(e.Item.DataItem, Contacts.MailingList)
            Dim listID As String = list.Bvin

            Dim listIDField As HiddenField = CType(e.Item.FindControl("listID"), HiddenField)
            listIDField.Value = listID

            Dim name As Literal = CType(e.Item.FindControl("name"), Literal)
            name.Text = list.Name

            Dim btnSub As ImageButton = e.Item.FindControl("SubscribeButton")
            Dim btnUnsub As ImageButton = e.Item.FindControl("UnsubscribeButton")

            If Not btnSub Is Nothing Then
                btnSub.ImageUrl = GetThemedButton("Subscribe")
            End If
            If Not btnUnsub Is Nothing Then
                btnUnsub.ImageUrl = GetThemedButton("Unsubscribe")
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

    Protected Sub mailingListRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles mailingListRepeater.ItemCommand

        Dim thisUser As UserAccount = UserAccount.FindByBvin(Me.hfUserBvin.Value)
        Dim listIDField As HiddenField = CType(e.Item.FindControl("listID"), HiddenField)

        If e.CommandName = "Subscribe" Then
            Dim listID As String = listIDField.Value
            Dim mm As New Contacts.MailingListMember
            mm.FirstName = thisUser.FirstName
            mm.LastName = thisUser.LastName
            mm.EmailAddress = thisUser.Email
            mm.ListId = listID
            Contacts.MailingListMember.Insert(mm)
            LoadLists()
        ElseIf e.CommandName = "Unsubscribe" Then
            Dim listID As String = listIDField.Value
            Contacts.MailingListMember.DeleteByEmail(thisUser.Email, listID)
            LoadLists()
        End If

    End Sub

End Class
