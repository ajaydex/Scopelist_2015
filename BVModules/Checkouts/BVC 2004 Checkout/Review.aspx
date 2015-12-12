<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Review.aspx.vb" Inherits="BVModules_Checkouts_BVC_2004_Checkout_Review" title="Checkout" %>

<%@ Register Src="../../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc4" %>

<%@ Register Src="../../Controls/SiteTermsAgreement.ascx" TagName="SiteTermsAgreement"
    TagPrefix="uc3" %>

<%@ Register Src="../../Controls/ViewOrder.ascx" TagName="ViewOrder" TagPrefix="uc2" %>

<%@ Register Src="../../Controls/StaticAddressDisplay.ascx" TagName="StaticAddressDisplay"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
<h1>Step 3 of 3 - Review Order</h1>
<uc4:MessageBox ID="MessageBox" runat="server" />
<asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="errormessage" />
    &nbsp;
<uc2:ViewOrder ID="ViewOrder1" runat="server" DisableNotesAndPayment="true" DisableReturns="true" DisableStatus="true" DisableOrderNumberDisplay="true" />
<h2>Special Instructions</h2>
<asp:TextBox ID="SpecialInstructions" TextMode="MultiLine" runat="server" Columns="80" Rows="3" Wrap="true"></asp:TextBox>
<div>
    <uc3:SiteTermsAgreement ID="SiteTermsAgreement1" runat="server" />
</div>
<asp:ImageButton ID="btnBack" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Previous.png" AlternateText="Previous" />
<asp:ImageButton ID="btnNext" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/PlaceOrder.png" AlternateText="Place Order" />
</asp:Content>

