<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_CreditCardGateways_Authorize_Net_Edit" %>
<h1>ACH Direct Options</h1>
<asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Merchant ID:</td>
    <td class="formfield"><asp:TextBox ID="UsernameField" runat="server" Columns="30"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Password:</td>
    <td class="formfield"><asp:TextBox ID="PasswordField" runat="server" Columns="30"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Service Url:</td>
    <td class="formfield"><asp:TextBox ID="LiveUrlField" runat="server" Columns="30"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Test Url:</td>
    <td class="formfield"><asp:TextBox ID="TestUrlField" runat="server" Columns="30"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Debug Mode:</td>
    <td class="formfield"><asp:CheckBox ID="chkDebugMode" runat="server" /></td>
</tr>
<tr>
    <td class="formlabel">Test Mode:</td>
    <td class="formfield"><asp:CheckBox ID="chkTestMode" runat="server" /></td>
</tr>
<tr>
    <td class="formlabel">
        <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield">
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table></asp:Panel>