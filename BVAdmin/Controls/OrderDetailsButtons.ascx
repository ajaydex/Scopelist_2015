<%@ Control Language="VB" AutoEventWireup="false" CodeFile="OrderDetailsButtons.ascx.vb" Inherits="BVAdmin_Controls_OrderDetailsButtons" %>

<div class="buttonStack">
    <asp:HyperLink ID="lnkDetails" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/OrderDetails.png" AlternateText="View Order" />
    <asp:HyperLink ID="lnkPayment" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Payment.png" AlternateText="Payment" />
    <asp:HyperLink ID="lnkShipping" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Shipping.png" AlternateText="Shipping" />
    <asp:HyperLink ID="lnkEdit" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/EditOrder.png" AlternateText="Edit Order" />
    <asp:HyperLink ID="lnkPrint" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Print.png" AlternateText="Print" />
    <asp:HyperLink ID="lnkOrderManager" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/OrderManager.png" />
</div>