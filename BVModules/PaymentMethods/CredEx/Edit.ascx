<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_PaymentMethods_CredEx_Edit" %>
<h1>CredEx Options</h1>
<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
<asp:ValidationSummary ID="ValidationSummary1" runat="server" />
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td colspan="2">
        <h2>General Settings</h2>
    </td>
</tr>
<tr>
    <td class="formlabel">Merchant Id:</td>
    <td class="formfield">
        <asp:TextBox ID="MerchantIdField" runat="server"></asp:TextBox>
    </td>
</tr>
<tr>
    <td class="formlabel">Merchant Key:</td>
    <td class="formfield">
        <asp:TextBox ID="MerchantKeyField" runat="server"></asp:TextBox>
    </td>
</tr>
<tr>
    <td class="formlabel">Product Id:</td>
    <td class="formfield">
        <asp:TextBox ID="ProductIdField" runat="server"></asp:TextBox>
    </td>
</tr>
<tr>
    <td class="formlabel">Test Mode:</td>
    <td class="formfield">
        <asp:CheckBox ID="TestModeField" runat="server" /> 
    </td>
</tr>
<tr>
    <td class="formlabel">Diagnostics Mode:</td>
    <td class="formfield">
        <asp:CheckBox ID="DiagnosticsModeField" runat="server" /> 
    </td>
</tr>
<tr>
    <td class="formlabel">
        <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield">
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table>
<asp:Panel ID="pnlTest" runat="server" Visible="false">
<hr />
<asp:label ID="lblMessage" runat="server" EnableViewState="false"></asp:label>
<h3>Send Sample Post Back for Testing</h3>
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Send:</td>
    <td class="formfield">
        <asp:DropDownList ID="lstResponse" runat="server">
            <asp:ListItem Value="Y" Text="Accepted"></asp:ListItem>
            <asp:ListItem Value="N" Text="Declined"></asp:ListItem>
        </asp:DropDownList>
    </td>
</tr>
<tr>
    <td class="formlabel">to Order Number:</td>
    <td class="formfield"><asp:TextBox ID="OrderNumberField" runat="server" Columns="10"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">
        &nbsp;</td>
    <td class="formfield">
        <asp:Button ID="btnSendTest" Text="Send Test Post Back" runat="server" />
    </td>
</tr>
</table>
</asp:Panel>

</asp:Panel>
