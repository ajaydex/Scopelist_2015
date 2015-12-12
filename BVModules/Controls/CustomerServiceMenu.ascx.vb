Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_CustomerServiceMenu
    Inherits System.Web.UI.UserControl


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            'Me.TitleLabel.Text = Content.SiteTerms.GetTerm("CustomerService")
            'lstCustomerServiceMenu.InnerHtml = Nothing
            'lstCustomerServiceMenu.InnerHtml += "<li><A href=""contact.aspx"">" & Content.SiteTerms.GetTerm("ContactUs") & "</A></li>"
            'lstCustomerServiceMenu.InnerHtml += "<li><A href=""help.aspx"">" & Content.SiteTerms.GetTerm("Help") & "</A></li>"
            'lstCustomerServiceMenu.InnerHtml += "<li><A href=""privacy.aspx"">" & Content.SiteTerms.GetTerm("PrivacyPolicy") & "</A></li>"
            'lstCustomerServiceMenu.InnerHtml += "<li><A href=""terms.aspx"">" & Content.SiteTerms.GetTerm("TermsAndConditions") & "</A></li>"
            'lstCustomerServiceMenu.InnerHtml += "<li><A href=""myaccount_orders.aspx"">" & Content.SiteTerms.GetTerm("OrderHistory") & "</A></li>"
            'If WebAppSettings.AffiliateSignupAllowed Then
            '    'lstCustomerServiceMenu.InnerHtml += "<li><A href=""affiliate_intro.aspx"">" & Content.SiteTerms.GetTerm("AffiliateProgram") & "</A></li>"
            '    lstCustomerServiceMenu.InnerHtml += "<li><A href=""affiliate_intro.aspx"">Affiliate Program</A></li>"
            'End If
            'If WebAppSettings.GiftCertificatesAllowed Then
            '    'lstCustomerServiceMenu.InnerHtml += "<li><A href=""GiftCertificates.aspx"">" & Content.SiteTerms.GetTerm("GiftCertificates") & "</A></li>"
            '    lstCustomerServiceMenu.InnerHtml += "<li><A href=""GiftCertificate.aspx"">Gift Certificates</A></li>"
            'End If
            'If WebAppSettings.ReturnFormAllowed Then
            '    'lstCustomerServiceMenu.InnerHtml += "<li><A href=""ReturnForm.aspx"">" & Content.SiteTerms.GetTerm("ReturnRequests") & "</A></li>"
            '    lstCustomerServiceMenu.InnerHtml += "<li><A href=""ReturnForm.aspx"">Return Requests</A></li>"
            'End If

            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("CustomerService")
            lstCustomerServiceMenu.InnerHtml = Nothing
            lstCustomerServiceMenu.InnerHtml += "<li><A href=""contactus.aspx"">" & Content.SiteTerms.GetTerm("ContactUs") & "</A></li>"
            lstCustomerServiceMenu.InnerHtml += "<li><A href=""help.aspx"">" & Content.SiteTerms.GetTerm("Help") & "</A></li>"
            lstCustomerServiceMenu.InnerHtml += "<li><A href=""privacy.aspx"">" & Content.SiteTerms.GetTerm("PrivacyPolicy") & "</A></li>"
            lstCustomerServiceMenu.InnerHtml += "<li><A href=""terms.aspx"">" & Content.SiteTerms.GetTerm("TermsAndConditions") & "</A></li>"
            lstCustomerServiceMenu.InnerHtml += "<li><A href=""myaccount_orders.aspx"">" & Content.SiteTerms.GetTerm("OrderHistory") & "</A></li>"
            'If WebAppSettings.AffiliateSignupAllowed Then
            '    'lstCustomerServiceMenu.InnerHtml += "<li><A href=""affiliate_intro.aspx"">" & Content.SiteTerms.GetTerm("AffiliateProgram") & "</A></li>"
            '    lstCustomerServiceMenu.InnerHtml += "<li><A href=""affiliate_intro.aspx"">Affiliate Program</A></li>"
            'End If
            'If WebAppSettings.GiftCertificatesAllowed Then
            '    'lstCustomerServiceMenu.InnerHtml += "<li><A href=""GiftCertificates.aspx"">" & Content.SiteTerms.GetTerm("GiftCertificates") & "</A></li>"
            '    lstCustomerServiceMenu.InnerHtml += "<li><A href=""GiftCertificate.aspx"">Gift Certificates</A></li>"
            'End If
            'If WebAppSettings.ReturnFormAllowed Then
            '    'lstCustomerServiceMenu.InnerHtml += "<li><A href=""ReturnForm.aspx"">" & Content.SiteTerms.GetTerm("ReturnRequests") & "</A></li>"
            '    lstCustomerServiceMenu.InnerHtml += "<li><A href=""ReturnForm.aspx"">Return Requests</A></li>"
            'End If


        End If

    End Sub

End Class
