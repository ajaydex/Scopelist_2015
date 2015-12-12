<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_PaymentMethods_Paypal_Express_Edit" %>
<h1>Paypal Express Options</h1>
<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
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
    <td class="formlabel">Capture Mode:</td>
    <td class="formfield"><asp:RadioButtonList runat="server" ID="lstCaptureMode">
    <asp:ListItem Text="Authorize at Checkout, Capture Funds Later" Value="1"></asp:ListItem>
    <asp:ListItem Selected="true" Text="Charge Full Amount at Checkout" Value="0"></asp:ListItem>
    </asp:RadioButtonList></td>
</tr>
<tr>
    <td class="formlabel">Checkout Page Name:</td>
    <td class="formfield">
        <asp:TextBox ID="CheckoutPageTextBox" runat="server"></asp:TextBox>
    </td>
</tr>
<tr>
    <td class="formlabel">Allow payments from unconfirmed addresses:</td>
    <td class="formfield">
        <asp:CheckBox ID="UnconfirmedAddressCheckBox" runat="server" />
    </td>
</tr>
<tr>
    <td class="formlabel">Paypal Monetary Format: <br />(Does not apply to Website Payments Pro,<br /> and needs to be in the same currency<br /> as your store.)</td>
    <td class="formfield"><asp:RadioButtonList runat="server" ID="PaypalMonetaryFormatRadioButtonList">
    <asp:ListItem Selected="true" Text="U.S. Dollars" Value="USD"></asp:ListItem>
    <asp:ListItem Text="British Pound" Value="GBP"></asp:ListItem>
    <asp:ListItem Text="New Taiwan Dollar" Value="TWD"></asp:ListItem>
    <asp:ListItem Text="Swedish Krona" Value="SEK"></asp:ListItem>
    <asp:ListItem Text="Singapore Dollar" Value="SGD"></asp:ListItem>
    <asp:ListItem Text="Euro" Value="EUR"></asp:ListItem>
    <asp:ListItem Text="Swiss Franc" Value="CHF"></asp:ListItem>
    <asp:ListItem Text="Australian Dollar" Value="AUD"></asp:ListItem>
    <asp:ListItem Text="Hong Kong Dollar" Value="HKD"></asp:ListItem>
    <asp:ListItem Text="Canadian Dollar" Value="CAD"></asp:ListItem>
    <asp:ListItem Text="Indian Rupee" Value="INR"></asp:ListItem>
    </asp:RadioButtonList></td>
</tr>
<tr>
    <td colspan="2">&nbsp;</td>
</tr>
<tr>
    <td class="formlabel">
        <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield">
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table></asp:Panel>
