<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_CreditCardGateways_BV_Protx_edit" %>
<h1>BV Protx Options</h1>
<asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3" style="width: 364px">
<tr>
    <td class="formlabel" colspan="2" align="center"></td>
</tr>
<tr>
    <td class="formlabel">
        Merchant Login:</td>
    <td class="formfield" style="width: 185px">
        <asp:TextBox ID="txtMerchantLogin" runat="server" ToolTip="Merchant Login ID is Required."></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMerchantLogin"
            ErrorMessage="Merchant Login Required">*</bvc5:BVRequiredFieldValidator></td>
</tr>
<tr>
    <td class="formlabel">
        Currency Code:</td>
    <td class="formfield" style="width: 185px">
        <asp:TextBox ID="txtCurrencyCode" runat="server" ToolTip="3 Digit Currency Code Required. Example: USD"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCurrencyCode"
            ErrorMessage="3 Digit Currency Code is Required (USD for example)">*</bvc5:BVRequiredFieldValidator></td>
</tr>
<tr>
    <td class="formlabel">
        Live URL:</td>
    <td class="formfield" style="width: 185px">
        <asp:TextBox ID="txtLiveURL" runat="server" ToolTip="This field is optional. If blank default values will be used."></asp:TextBox></td>
</tr>
    <tr>
        <td class="formlabel" style="height: 30px">
            Test URL:</td>
        <td class="formfield" style="width: 185px; height: 30px">
            <asp:TextBox ID="txtTestURL" runat="server" ToolTip="This field is optional. If blank default values will be used."></asp:TextBox></td>
    </tr>
<tr>
    <td class="formlabel">
        Test Mode:</td>
    <td class="formfield" style="width: 185px"><asp:CheckBox ID="chkTestMode" runat="server" ToolTip="Enable Gateways Test Mode" /></td>
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
        </td>
    </tr>
    <tr>
        <td align="center" class="formlabel" colspan="2" style="height: 25px">
            .</td>
    </tr>
</table></asp:Panel>
