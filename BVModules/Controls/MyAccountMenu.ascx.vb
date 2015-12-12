Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_MyAccountMenu
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            'Me.TitleLabel.Text = Content.SiteTerms.GetTerm("MyAccount")
            lstMyAccountMenu.InnerHtml = Nothing
            lstMyAccountMenu.InnerHtml += "<li><A href=""MyAccount_AddressBook.aspx"">" & Content.SiteTerms.GetTerm("AddressBook") & "</A></li>"
            If Contacts.Affiliate.FindEnabledByUserId(SessionManager.GetCurrentUserId).Count > 0 Then
                lstMyAccountMenu.InnerHtml += "<li><A href=""MyAccount_AffiliateReport.aspx"">" & Content.SiteTerms.GetTerm("AffiliateReport") & "</A></li>"
            End If
            lstMyAccountMenu.InnerHtml += "<li><A href=""MyAccount_WishList.aspx"">" & Content.SiteTerms.GetTerm("WishList") & "</A></li>"
            lstMyAccountMenu.InnerHtml += "<li><A href=""MyAccount_Orders.aspx"">" & Content.SiteTerms.GetTerm("OrderHistory") & "</A></li>"
            If WebAppSettings.AllowPersonalizedThemes = True Then
                lstMyAccountMenu.InnerHtml += "<li><A href=""MyAccount_Themes.aspx"">" & Content.SiteTerms.GetTerm("Themes") & "</A></li>"
            End If
            lstMyAccountMenu.InnerHtml += "<li><A href=""MyAccount_MailingLists.aspx"">" & Content.SiteTerms.GetTerm("MailingLists") & "</A></li>"
            lstMyAccountMenu.InnerHtml += "<li><A href=""MyAccount_ChangeEmail.aspx"">" & Content.SiteTerms.GetTerm("ChangeEmail") & "</A></li>"
            lstMyAccountMenu.InnerHtml += "<li><A href=""MyAccount_ChangePassword.aspx"">" & Content.SiteTerms.GetTerm("ChangePassword") & "</A></li>"
        End If

    End Sub

End Class
