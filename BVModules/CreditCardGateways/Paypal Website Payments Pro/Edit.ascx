<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_CreditCardGateways_Authorize_Net_Edit" %>
<h1>Paypal Website Payments Pro Options</h1>
<asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Username:</td>
    <td class="formfield">
        <asp:TextBox ID="UsernameTextBox" runat="server"></asp:TextBox>
    </td>
</tr>
<tr>
    <td class="formlabel">Password:</td>
    <td class="formfield">
        <asp:TextBox ID="PasswordTextBox" runat="server"></asp:TextBox>
    </td>
</tr>
<tr>
    <td class="formlabel">Signature:</td>
    <td class="formfield">
        <asp:TextBox ID="SignatureTextBox" runat="server"></asp:TextBox>
    </td>
</tr>
<tr>
    <td class="formlabel">Paypal Mode:</td>
    <td class="formfield"><asp:RadioButtonList runat="server" ID="ModeRadioButtonList">
    <asp:ListItem Selected="true" Text="Test" Value="Sandbox"></asp:ListItem>
    <asp:ListItem Text="Production" Value="Live"></asp:ListItem>    
    </asp:RadioButtonList></td>
</tr>
<tr>
    <td class="formlabel">
        <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield">
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table></asp:Panel>