<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_CreditCardGateways_BV_LinkPoint_BASIC_edit" %>
<h1>BV LinkPoint BASIC Options</h1>
<asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3" style="width: 364px">
<tr>
    <td class="formlabel" colspan="2" align="center"></td>
</tr>
<tr>
    <td class="formlabel">
        Store Name:</td>
    <td class="formfield" style="width: 185px">
        <asp:TextBox ID="UsernameField" runat="server" ToolTip="Store Name Required."></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UsernameField"
            ErrorMessage="Store Name Required">*</bvc5:BVRequiredFieldValidator></td>
</tr>
<tr>
    <td class="formlabel">
        Referrer Url:</td>
    <td class="formfield" style="width: 185px">
        <asp:TextBox ID="PasswordField" runat="server" ToolTip="Referrer URL Required"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="PasswordField"
            ErrorMessage="Referrer Url Required">*</bvc5:BVRequiredFieldValidator></td>
</tr>
<tr>
    <td class="formlabel">
        Live URL:</td>
    <td class="formfield" style="width: 185px">
        <asp:TextBox ID="LiveUrlField" runat="server" ToolTip="This field is optional. If blank default values will be used."></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">
        Test URL:</td>
    <td class="formfield" style="width: 185px">
        <asp:TextBox ID="TestUrlField" runat="server" ToolTip="This field is optional. If blank default values will be used."></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">
        Test Mode:</td>
    <td class="formfield" style="width: 185px">
        <asp:CheckBox ID="chkTest" runat="server" /></td>
</tr>    
    <tr>
        <td class="formlabel" style="height: 25px">
            Debug Mode:</td>
        <td class="formfield" style="width: 185px; height: 25px;">
            <asp:CheckBox ID="chkDebug" runat="server" /></td>
    </tr>
    <tr>
        <td align="center" class="formlabel" style="height: 25px">
        <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
        <td align="center" class="formfield" style="width: 185px; height: 25px">
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
    </tr>
</table></asp:Panel>
