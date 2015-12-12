<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_CreditCardGateways_BV_Test_Gateway_edit" %>
<h1>BV Test Credit Card Gateway Options</h1>
<asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Authorize Fails:</td>
    <td class="formfield"><asp:CheckBox ID="chkAuthorizeFails" runat="server" /></td>
</tr>
<tr>
    <td class="formlabel">Capture Fails:</td>
    <td class="formfield"><asp:CheckBox ID="chkCaptureFails" runat="server" /></td>
</tr>
<tr>
    <td class="formlabel">Charge Fails:</td>
    <td class="formfield"><asp:CheckBox ID="chkChargeFails" runat="server" /></td>
</tr>
<tr>
    <td class="formlabel">Refund Fails:</td>
    <td class="formfield"><asp:CheckBox ID="chkRefundFails" runat="server" /></td>
</tr>
<tr>
    <td class="formlabel">Void Fails:</td>
    <td class="formfield"><asp:CheckBox ID="chkVoidFails" runat="server" /></td>
</tr>
<tr>
    <td class="formlabel">
        <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield">
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table></asp:Panel>