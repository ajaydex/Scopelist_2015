<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Shipping.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_Shipping" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<anthem:RadioButtonList ID="ShippingRatesList" runat="server" AutoCallBack="True" PostCallBackFunction="ShippingChanging(false)" PreCallBackFunction="ShippingChanging(true)"></anthem:RadioButtonList>

<anthem:Label ID="ShippingMessage" runat="server" Text=""></anthem:Label>

<asp:HyperLink ID="ShippingHyperLink" CssClass="shippingterms" runat="server" EnableViewState="false"> 
    
    <p class="smallText">View <asp:Literal ID="ShippingLiteral" runat="server">Shipping Terms and Conditions</asp:Literal></p>

</asp:HyperLink>