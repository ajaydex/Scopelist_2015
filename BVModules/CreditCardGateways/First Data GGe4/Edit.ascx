<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_CreditCardGateways_First_Data_GGe4_Edit" %>

<h1>First Data GGe4 Options</h1>
<asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
    <table border="0" cellspacing="0" cellpadding="3">
    <tr>
        <td class="formlabel">Gateway ID:</td>
        <td class="formfield"><asp:TextBox ID="UsernameField" runat="server" Columns="30"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel">Password:</td>
        <td class="formfield"><asp:TextBox ID="PasswordField" runat="server" Columns="30"></asp:TextBox></td>
    </tr>
    <tr>
            <td class="formlabel" style="height: 25px">
                Debug Mode:</td>
            <td class="formfield" style="width: 185px; height: 25px;">
                <asp:CheckBox ID="chkDebugMode" runat="server" ToolTip="Checking this will log the full gateway response in the Audit Log" /></td>
        </tr>
        <tr>
            <td class="formlabel" style="height: 25px">
                Test Mode:</td>
            <td class="formfield" style="width: 185px; height: 25px;">
                <asp:CheckBox ID="chkTestMode" runat="server" ToolTip="Checking this will use the testing endpoint of the gateway (transaction will not actually be processed)" /></td>
        </tr>
    <tr>
        <td class="formlabel">
            <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
        <td class="formfield">
            <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
    </tr>
    </table>
</asp:Panel>