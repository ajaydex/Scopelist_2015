<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_CreditCardGateways_BV_PayFlowProNET_edit" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<h1>BV PayFlowPro .NET Options</h1>
<asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
    <table border="0" cellspacing="0" cellpadding="3" style="width: 364px">
    <tr>
        <td class="formlabel" colspan="2" align="center"></td>
    </tr>
        <tr>
            <td class="formlabel">
                Partner:</td>
            <td class="formfield" style="width: 185px">
                <asp:TextBox ID="txtMerchantVendor" runat="server" ToolTip="Merchant Login is Required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtMerchantVendor"
                    ErrorMessage="Merchant Vendor Required">*</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td class="formlabel">
                Vendor:</td>
            <td class="formfield" style="width: 185px">
                <asp:TextBox ID="txtMerchantLogin" runat="server" ToolTip="Merchant Login is Required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtMerchantLogin"
                    ErrorMessage="Merchant Login Required">*</asp:RequiredFieldValidator></td>
        </tr>
    <tr>
        <td class="formlabel">
            User:</td>
        <td class="formfield" style="width: 185px">
            <asp:TextBox ID="txtMerchantUser" runat="server" ToolTip="Merchant User is sometimes Required and if often the same as your Login."></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="formlabel" style="height: 30px">
            Merchant Password:</td>
        <td class="formfield" style="width: 185px; height: 30px;">
            <asp:TextBox ID="txtMerchantPassword" runat="server" ToolTip="Merchant Password is Required."></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMerchantPassword"
                ErrorMessage="Merchant Transaction Key Required">*</asp:RequiredFieldValidator></td>
    </tr>
    <%--
    <tr>
        <td class="formlabel" style="height: 30px">
            Cert Location:</td>
        <td class="formfield" style="width: 185px; height: 30px;">
            <asp:TextBox ID="txtCertLocation" runat="server" ToolTip="This is the full drive path to the certs folder. Ex: C:\inetpub\website\bin\certs"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCertLocation"
                ErrorMessage="Cert Location Required">*</asp:RequiredFieldValidator></td>
    </tr>
    --%>
    <tr>
        <td class="formlabel" style="height: 30px">
            Live URL:</td>
        <td class="formfield" style="width: 185px; height: 30px;">
            <asp:TextBox ID="txtLiveURL" runat="server" ToolTip="This field is optional. If blank default values will be used."></asp:TextBox>
            &nbsp;(optional)</td>
    </tr>
        <tr>
            <td class="formlabel" style="height: 30px">
                Test URL:</td>
            <td class="formfield" style="width: 185px; height: 30px">
                <asp:TextBox ID="txtTestURL" runat="server" ToolTip="This field is optional. If blank default values will be used."></asp:TextBox>
                &nbsp;(optional)</td>
        </tr>
        <tr>
            <td class="formlabel" style="height: 30px">
                Currency Code:</td>
            <td class="formfield" style="width: 185px; height: 30px">
                <asp:DropDownList ID="CurrencyCodeDropDownList" runat="server">
                    <asp:ListItem Text="Australian Dollar" Value="AUD"></asp:ListItem>
                    <asp:ListItem Text="Canadian Dollar" Value="CAD"></asp:ListItem>
                    <asp:ListItem Text="Czech Koruna" Value="CZK"></asp:ListItem>
                    <asp:ListItem Text="Danish Krone" Value="DKK"></asp:ListItem>
                    <asp:ListItem Text="Euro" Value="EUR"></asp:ListItem>
                    <asp:ListItem Text="Hong Kong Dollar" Value="HKD"></asp:ListItem>
                    <asp:ListItem Text="Hungarian Forint" Value="HUF"></asp:ListItem>
                    <asp:ListItem Text="Japanese Yen" Value="JPY"></asp:ListItem>
                    <asp:ListItem Text="New Zealand Dollar" Value="NZD"></asp:ListItem>
                    <asp:ListItem Text="Norwegian Krone" Value="NOK"></asp:ListItem>
                    <asp:ListItem Text="Polish Zloty" Value="PLN"></asp:ListItem>
                    <asp:ListItem Text="Pound Sterling" Value="GBP"></asp:ListItem>
                    <asp:ListItem Text="Singapore Dollar" Value="SGD"></asp:ListItem>
                    <asp:ListItem Text="Swedish Krona" Value="SEK"></asp:ListItem>
                    <asp:ListItem Text="Swiss Franc" Value="CHF"></asp:ListItem>
                    <asp:ListItem Text="U.S Dollar" Value="USD"></asp:ListItem>                    
                </asp:DropDownList>
            </td>
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
            </td>
        </tr>
        <tr>
            <td align="center" class="formlabel" colspan="2" style="height: 25px">
                .</td>
        </tr>
    </table>
</asp:Panel>