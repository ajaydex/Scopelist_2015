<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SiteTermsAgreement.ascx.vb" Inherits="BVModules_Controls_SiteTermsAgreement" %>

<asp:CheckBox ID="AgreeToTermsCheckBox" runat="server" /><label><asp:Literal ID="AgreeLiteral" runat="server"></asp:Literal></label>
<div><asp:HyperLink ID="ShippingHyperLink" CssClass="viewSiteTerms" runat="server" EnableViewState="false">View <asp:Literal ID="ViewSiteTermsLiteral" runat="server">Terms And Conditions</asp:Literal></asp:HyperLink></div>