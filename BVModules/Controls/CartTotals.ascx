<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CartTotals.ascx.vb" Inherits="BVModules_Controls_CartTotals" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%--<div id="carttotals" runat="server">
    <span id="items">
        <anthem:Label runat="server" ID="lblItemCount" AutoUpdateAfterCallBack="true">1 Product</anthem:Label></span>&nbsp;<span
            id="subtotal"><anthem:Label runat="server" ID="lblSubTotal" AutoUpdateAfterCallBack="true"></anthem:Label></span></div>--%>
<div id="carttotals" runat="server" style="display: inline">
    <div class="top-cart">
        <a href="#">
            <asp:ImageButton PostBackUrl="~/Cart.aspx" ID="CartImage" runat="server" AlternateText="icon-cart"
                ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/icon-cart.png" />
        </a>
        <%-- Edit by ven because added link to the label --%>
        <a href='<%=Page.ResolveUrl("~/Cart.aspx")%>' target="_parent ">
            <anthem:Label runat="server" ID="lblItemCount" AutoUpdateAfterCallBack="true">0 </anthem:Label></a>
        , total:
        <asp:HyperLink ID="lnkCart" runat="server" NavigateUrl="~/Cart.aspx" Target="_parent">
            <anthem:Label runat="server" ID="lblSubTotal" AutoUpdateAfterCallBack="true"></anthem:Label>
        </asp:HyperLink>
    </div>
</div>
