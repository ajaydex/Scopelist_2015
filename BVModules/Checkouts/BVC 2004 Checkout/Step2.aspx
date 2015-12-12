<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Step2.aspx.vb" Inherits="BVModules_Checkouts_BVC_2004_Checkout_Step2" title="Checkout" %>

<%@ Register Src="../../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc5" %>

<%@ Register Src="../../Controls/Payment.ascx" TagName="Payment" TagPrefix="uc4" %>

<%@ Register Src="../../Controls/Shipping.ascx" TagName="Shipping" TagPrefix="uc3" %>

<%@ Register Src="../../Controls/GiftCertificates.ascx" TagName="GiftCertificates"
    TagPrefix="uc1" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../../Controls/CreditCardInput.ascx" TagName="CreditCardInput"
    TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
<h1>Step 2 of 3 - Shipping and Payment</h1>
<uc5:MessageBox ID="MessageBox1" runat="server" EnableViewState="false" />
<asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="errormessage" />
<div id="ShippingSection" runat="server">
    <h2>Shipping:</h2>
    <uc3:Shipping ID="Shipping" runat="server" TabIndex="100"/>    
</div>
<uc1:GiftCertificates ID="GiftCertificates1" runat="server" TabIndex="130" ShowTitle="true" />
<h2>Payment:</h2>
<uc4:Payment ID="Payment1" runat="server" TabIndex="175"/>
<asp:ImageButton ID="btnBack" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Previous.png" AlternateText="Previous" TabIndex="200"/>
<asp:ImageButton ID="btnNext" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/ReviewOrder.png" AlternateText="Review Order" TabIndex="201"/>
</asp:Content>

