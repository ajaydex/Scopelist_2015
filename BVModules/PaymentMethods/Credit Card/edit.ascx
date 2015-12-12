<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_PaymentMethods_Credit_Card_edit" %>
<h1>Credit Card Options</h1>
<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Capture Mode:</td>
    <td class="formfield"><asp:RadioButtonList runat="server" ID="lstCaptureMode">
    <asp:ListItem Text="Authorize at Checkout, Capture Funds Later" Value="1"></asp:ListItem>
    <asp:ListItem Selected="true" Text="Charge Full Amount at Checkout" Value="0"></asp:ListItem>
    </asp:RadioButtonList></td>
</tr>
<tr>
    <td class="formlabel">Security Code:</td>
    <td class="formfield"><asp:CheckBox ID="chkRequireCreditCardSecurityCode" runat="server" Text="Require CVV code during checkout?" /></td>
</tr>
<tr>
    <td class="formlabel">Credit Card Number:</td>
    <td class="formfield"><asp:CheckBox ID="DisplayFullCreditCardCheckBox" runat="server" Text="Display Full Credit Card Information In Admin Console?" /><br />
    (If this option is enabled your store will not be PCI Compliant)</td>
</tr>
<tr>
    <td colspan="2">&nbsp;</td>
</tr>
<tr>
    <td class="formlabel">Accepted Cards:</td>
    <td class="formfield">
        <asp:GridView ID="CreditCardGrid" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="code" ShowHeader="False" BorderWidth="0px" GridLines="None">
            <Columns>
                <asp:TemplateField><ItemTemplate><asp:CheckBox ID="chkActive" runat="server" /></ItemTemplate></asp:TemplateField>
                <asp:BoundField DataField="LongName" />
            </Columns>
        </asp:GridView>
    </td>
</tr>
<tr>
    <td colspan="2">&nbsp;</td>
</tr>
<tr>
    <td class="formlabel">Gateway:</td>
    <td class="formfield"><asp:DropDownList ID="lstGateway" runat="server">
        <asp:ListItem>- Select a Gateway -</asp:ListItem>
    </asp:DropDownList>&nbsp;<asp:ImageButton ID="btnOptions" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" AlternateText="Edit Gateway Options" /></td>
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