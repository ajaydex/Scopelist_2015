<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SiteTermsAgreement.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_SiteTermsAgreement" %>

<asp:CheckBox ID="AgreeToTermsCheckBox" runat="server" />

<label for="ctl00_MainContentHolder_SiteTermsAgreement1_AgreeToTermsCheckBox">
    <asp:Literal ID="AgreeLiteral" runat="server"></asp:Literal>
    <asp:HyperLink ID="ShippingHyperLink" CssClass="viewSiteTerms" runat="server" EnableViewState="false">View <asp:Literal ID="ViewSiteTermsLiteral" runat="server">Terms And Conditions</asp:Literal></asp:HyperLink>

</label>