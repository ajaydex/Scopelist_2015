<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_CreditCardGateways_BV_Manual_Gateway_edit" %>
<h1>BV Manual Credit Card Gateway Options</h1>
<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3" width="500">
<tr>
    <td class="formfield" colspan="2">This gateway returns &quot;TRUE&quot; for all operations. It is designed to be used when you wish to process credit cards using an offline terminal. All operations like Authorize, Capture and Charge update the payment status for an order but do not actually affect the credit card account.</td>
</tr>
<tr>
    <td class="formlabel">
        <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/OK.png" /></td>
    <td class="formfield">
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" Visible="false" /></td>
</tr>
</table></asp:Panel>