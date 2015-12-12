<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_CreditCardGateways_Qbms_Edit" %>
<h1>QBMS Options</h1>
<asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Login:</td>
    <td class="formfield"><asp:TextBox ID="LoginField" runat="server" Columns="30"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Ticket:<br />
        </td>
    <td class="formfield"><asp:TextBox ID="TicketField" runat="server" Columns="30"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Type:</td>
    <td class="formfield">
        <asp:DropDownList ID="TypeDropDown" runat="server">
            <asp:ListItem Value="0">Desktop</asp:ListItem>
            <asp:ListItem Value="1">Hosted</asp:ListItem>
        </asp:DropDownList>
    </td>
</tr>

 <tr>
        <td class="formlabel"  style="width: 185px">
            Test Mode:
        </td>
        <td class="formfield">
            <asp:CheckBox ID="TestModeCheckBox" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel" style="height: 25px">
            Debug Mode:</td>
        <td class="formfield" style="width: 185px; height: 25px;">
            <asp:CheckBox ID="DebugModeCheckBox" runat="server" ToolTip="Checking this will log the full gateway response in the Event Log" /></td>
    </tr>
<tr>
    <td class="formlabel">
        <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield">
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table></asp:Panel>