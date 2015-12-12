<%@ Control Language="VB" AutoEventWireup="false" CodeFile="DiscontinuedDisplay.ascx.vb"
    Inherits="BVModules_Controls_DiscontinuedDisplay" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<anthem:Panel ID="OutOfStockPanel" CssClass="outofstockdisplay" runat="server" AutoUpdateAfterCallBack="true">
    <span rel="gr:hasInventoryLevel"><span typeof="gr:QuantitativeValue"><span property="gr:hasMinValue"
        content="1">
        <asp:Literal ID="OutOfStockLiteral" runat="server"></asp:Literal>
    </span></span></span>
</anthem:Panel>
