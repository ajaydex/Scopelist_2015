<%@ Control Language="VB" AutoEventWireup="false" CodeFile="PaypalExpressCheckoutButton.ascx.vb" Inherits="BVModules_Controls_PaypalExpressCheckoutButton" %>
<asp:Panel ID="PaypalExpress" runat="server">
    <asp:ImageButton ID="PaypalImageButton" runat="server" AlternateText="Checkout with PayPal" ImageUrl="https://www.paypalobjects.com/webstatic/en_US/i/buttons/checkout-logo-medium.png" CausesValidation="false" />
    <asp:Panel ID="pnlSubText" runat="server">
        <asp:Label ID="PaypalExpressLabel" Text="Save time. Checkout securely. Pay without sharing your financial information." runat="server" />
    </asp:Panel>
</asp:Panel>