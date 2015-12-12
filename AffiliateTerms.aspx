<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="AffiliateTerms.aspx.vb" Inherits="Terms" title="Affiliate Terms and Conditions" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="BvcPopupContentPlaceholder" Runat="Server">        
        <h1>
            <asp:Label ID="TitleLabel" runat="server" Text="Affiliate Terms and Conditions" />
        </h1>
        <div id="termsInfo" runat="server"></div>
</asp:Content>

