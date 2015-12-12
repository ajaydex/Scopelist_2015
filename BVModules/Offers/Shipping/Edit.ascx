<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_Offers_Shipping_Edit" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>

<h2>Shipping</h2>
<table cellspacing="0" cellpadding="0" border="0" class="linedTable">
    <tr>
        <td class="formlabel wide">Shipping Method</td>
        <td class="formfield">
            <asp:DropDownList ID="ShippingMethodDropDownList" runat="server">
            </asp:DropDownList></td>
    </tr>
    <tr>
        <td class="formlabel">By</td>
        <td class="formfield"><asp:TextBox ID="AmountTextBox" runat="server" Width="39px"></asp:TextBox><bvc5:BVRequiredFieldValidator
                ID="RequiredFieldValidator1" runat="server" ErrorMessage="You must enter an amount or percent." ControlToValidate="AmountTextBox">*</bvc5:BVRequiredFieldValidator>
            <bvc5:BVCustomValidator ID="AmountCustomValidator" runat="server" ControlToValidate="AmountTextBox"
                ErrorMessage="Amount or percent is not in the correct format." >*</bvc5:BVCustomValidator>
                <asp:DropDownList ID="OfferAmountTypeDropDownList" runat="server">
                    <asp:ListItem Selected="True">Percent</asp:ListItem>
                    <asp:ListItem>Amount</asp:ListItem>
            </asp:DropDownList></td>
    </tr>
    <tr>
        <td class="formlabel">
            If quantity ordered is >=</td>
        <td class="formfield">
            <asp:TextBox ID="OrderQuantityTextBox" runat="server"></asp:TextBox><bvc5:BVRegularExpressionValidator ID="OrderQuantityRegularExpressionValidator" runat="server" ErrorMessage="Quantity ordered must be a whole number greater than 1."
        ValidationExpression="[1-9]\d{0,49}" ControlToValidate="OrderQuantityTextBox">*</bvc5:BVRegularExpressionValidator></td>
    </tr>
    <tr>
        <td class="formlabel">
            and the order total is >=</td>
        <td class="formfield">
            <asp:TextBox ID="OrderTotalTextBox" runat="server"></asp:TextBox>
            <bvc5:BVCustomValidator ID="OrderTotalCustomValidator" runat="server" ErrorMessage="Order amount must be a monetary value." ControlToValidate="OrderTotalTextBox" >*</bvc5:BVCustomValidator>
        </td>
    </tr>
    <tr>
        <td class="formlabel">
            and the order total is <=</td>
        <td class="formfield">
            <asp:TextBox ID="OrderTotalMaxTextBox" runat="server"></asp:TextBox>
            <bvc5:BVCustomValidator ID="OrderTotalMaxCustomValidator" runat="server" ErrorMessage="Order amount must be a monetary amount."
                ControlToValidate="OrderTotalMaxTextBox" >*</bvc5:BVCustomValidator>
            <bvc5:BVCustomValidator ID="OrderTotalMaxCustomValidator2" runat="server" ErrorMessage="Max order total must be less than min order total."
                ControlToValidate="OrderTotalMaxTextBox" >*</bvc5:BVCustomValidator>        
        </td>
    </tr>
</table>