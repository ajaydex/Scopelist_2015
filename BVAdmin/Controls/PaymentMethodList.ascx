<%@ Control Language="VB" AutoEventWireup="false" CodeFile="PaymentMethodList.ascx.vb" Inherits="BVAdmin_Controls_PaymentMethodList" %>
<div class="PaymentMethodsList">
<asp:DropDownList AutoPostBack="true" ID="lstPaymentMethods" runat="server"></asp:DropDownList><br />
<asp:PlaceHolder runat="Server" ID="phOptions"></asp:PlaceHolder>
</div>