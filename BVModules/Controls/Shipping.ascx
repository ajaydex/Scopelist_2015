<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Shipping.ascx.vb" Inherits="BVModules_Controls_Shipping" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<div class="shippingPolicyDiv">
    <anthem:RadioButtonList ID="ShippingRatesList" runat="server" AutoCallBack="True"
        PostCallBackFunction="ShippingChanging(false)" PreCallBackFunction="ShippingChanging(true)">
    </anthem:RadioButtonList>
    <p style="padding-bottom: 11px;">
        <anthem:Label ID="ShippingMessage" runat="server" Text=""></anthem:Label>
        <span style="margin-top: 5px;">
            <asp:HyperLink ID="ShippingHyperLink" CssClass="shippingterms" runat="server" EnableViewState="false">
                <asp:Literal ID="ShippingLiteral" runat="server">Shipping Terms and Conditions</asp:Literal></asp:HyperLink>
        </span>
    </p>
</div>
