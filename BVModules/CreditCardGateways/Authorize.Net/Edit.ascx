<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_CreditCardGateways_Authorize_Net_Edit" %>
<h1>Authorize.Net Options</h1>
<asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Username:</td>
    <td class="formfield"><asp:TextBox ID="UsernameField" runat="server" Columns="30"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Transaction Key:</td>
    <td class="formfield"><asp:TextBox ID="PasswordField" runat="server" Columns="30"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Service Url:<br />
        (optional)</td>
    <td class="formfield"><asp:TextBox ID="LiveUrlField" runat="server" Columns="30"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Test Mode:</td>
    <td class="formfield"><asp:CheckBox ID="chkTestMode" runat="server" /></td>
</tr>
<tr>
    <td class="formlabel">Test Url:<br />
        (optional)</td>
    <td class="formfield"><asp:TextBox ID="TestUrlField" runat="server" Columns="30"></asp:TextBox></td>
</tr>
 <tr>
        <td class="formlabel"  style="width: 185px">
            Send Authorize.net Email to customer:
        </td>
        <td class="formfield">
            <asp:CheckBox ID="EmailCustomerCheckBox" runat="server" ToolTip="Have Authorize.net send an additional e-mail to customer" />
        </td>
    </tr>
    <tr>
        <td class="formlabel" style="height: 25px">
            Debug Mode:</td>
        <td class="formfield" style="width: 185px; height: 25px;">
            <asp:CheckBox ID="chkDebugMode" runat="server" ToolTip="Checking this will log the full gateway response in the Event Log" /></td>
    </tr>
<tr>
    <td class="formlabel">
        <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield">
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table></asp:Panel>