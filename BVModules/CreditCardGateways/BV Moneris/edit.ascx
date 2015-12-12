<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_CreditCardGateways_BV_Moneris_edit" %>
<h1>BV Moneris (Canadian) Options</h1>
<asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3" style="width: 364px">
<tr>
    <td class="formlabel" colspan="2" align="center"></td>
</tr>
<tr>
    <td class="formlabel">
        Host:</td>
    <td class="formfield" style="width: 185px">
        <asp:TextBox ID="txtHost" runat="server" ToolTip="Host name Required."></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtHost"
            ErrorMessage="Host name Required">*</bvc5:BVRequiredFieldValidator></td>
</tr>
<tr>
    <td class="formlabel" style="height: 30px">
        Store Id:</td>
    <td class="formfield" style="width: 185px; height: 30px;">
        <asp:TextBox ID="txtStoreId" runat="server" ToolTip='Store Id is Required.'></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtStoreId"
            ErrorMessage="Store Id is required">*</bvc5:BVRequiredFieldValidator></td>
</tr>
    <tr>
        <td class="formlabel">
            API Token:</td>
        <td class="formfield" style="width: 185px">
            <asp:TextBox ID="txtAPIToken" runat="server" ToolTip="API Token is required"></asp:TextBox>
            <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAPIToken"
                ErrorMessage="API Token is required">*</bvc5:BVRequiredFieldValidator></td>
    </tr>
<tr>
        <td class="formlabel" style="height: 25px">
            Enable CVV:</td>
        <td class="formfield" style="width: 185px; height: 25px">
            <asp:CheckBox ID="chkCVV" runat="server" ToolTip="Checking this will enable cvv code transactions" /></td>
    </tr>
    <tr>
        <td class="formlabel" style="height: 25px">
            Debug Mode:</td>
        <td class="formfield" style="width: 185px; height: 25px">
            <asp:CheckBox ID="chkDebugMode" runat="server" ToolTip="Checking this will log the full gateway response in the Event Log" /></td>
    </tr>
    <tr>
        <td class="formlabel" style="height: 25px">
        </td>
        <td class="formfield" style="width: 185px; height: 25px;">
        </td>
    </tr>
    <tr>
        <td align="center" class="formlabel" style="height: 25px">
        <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
        <td align="center" class="formfield" style="width: 185px; height: 25px">
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
    </tr>
    <tr>
        <td align="center" class="formlabel" colspan="2" style="height: 25px">
            .</td>
    </tr>
</table></asp:Panel>
