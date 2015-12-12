<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CartTotals.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_CartTotals" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<span id="carttotals">
    <anthem:HyperLink ID="lnkCart" NavigateUrl="~/Cart.aspx" AutoUpdateAfterCallBack="true" runat="server">
        <i class="fa fa-shopping-cart"></i>
        <asp:Literal ID="litCart" runat="server" />
        <span id="items" class="hideforlowres"><anthem:Label runat="server" ID="lblItemCount" AutoUpdateAfterCallBack="true">1 Product</anthem:Label></span>
        <span id="subtotal" class="hideforlowres"><anthem:Label runat="server" ID="lblSubTotal" AutoUpdateAfterCallBack="true"></anthem:Label></span>
    </anthem:HyperLink>
</span>