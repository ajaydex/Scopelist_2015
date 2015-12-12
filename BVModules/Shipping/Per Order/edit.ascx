<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_Shipping_Per_Order_edit" %>
<h1>Edit Shipping Method - Per Order</h1>
<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3">
    <tr>
        <td class="formlabel">Name:</td>
        <td class="formfield"><asp:TextBox ID="NameField" runat="server" Width="300"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel">Amount per Order:</td>
        <td class="formfield"><asp:TextBox ID="AmountField" runat="server" Width="300"></asp:TextBox></td>
    </tr>
    <tr>
        <td colspan="2">
            <h2>
                Adjustments</h2>
        </td>
    </tr>
    <tr>
        <td class="formlabel">
            Adjust price by:
        </td>
        <td class="formfield">
            <asp:TextBox ID="AdjustmentTextBox" runat="server" Columns="5"></asp:TextBox>
            &nbsp;<bvc5:BVCustomValidator ID="CustomValidator1" runat="server" ControlToValidate="AdjustmentTextBox"
                ErrorMessage="Adjustment is not in the correct format.">*</bvc5:BVCustomValidator>
            <asp:DropDownList ID="AdjustmentDropDownList" runat="server">
                <asp:ListItem Selected="True" Value="1">Amount</asp:ListItem>
                <asp:ListItem Value="2">Percentage</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="formlabel">
            <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
        <td class="formfield">
            <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
    </tr>
</table></asp:Panel>