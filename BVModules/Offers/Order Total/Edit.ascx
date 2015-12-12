<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_Offers_Order_Total_Edit" %>
<%@ Register Src="../../../BVAdmin/Controls/PercentAmountSelection.ascx" TagName="PercentAmountSelection"
    TagPrefix="uc2" %>
<%@ Register Src="../../../BVAdmin/Controls/ProductPicker.ascx" TagName="ProductPicker"
    TagPrefix="uc1" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>

<h2>Order Total</h2>
<table cellspacing="0" cellpadding="0" border="0" style="width:100%;" class="linedTable">
<tr>
    <td class="formlabel wide">
        Reduce Order Total By
    </td>
    <td class="formfield">
        <uc2:PercentAmountSelection ID="PercentAmountSelection" runat="server" />
    </td>        
</tr>
<tr>
    <td class="formlabel">
        If quantity ordered is >=</td>
    <td class="formfield">
        <asp:TextBox ID="OrderQuantityTextBox" runat="server"></asp:TextBox><bvc5:BVRegularExpressionValidator
            ID="OrderQuantityRegularExpressionValidator" runat="server" ErrorMessage="Quantity ordered must be a whole number greater than 1."
            ValidationExpression="[1-9]\d{0,49}" ControlToValidate="OrderQuantityTextBox">*</bvc5:BVRegularExpressionValidator></td>
</tr>
<tr>
    <td class="formlabel">
        and the order total is >=</td>
    <td class="formfield">
        <asp:TextBox ID="OrderTotalTextBox" runat="server"></asp:TextBox><bvc5:BVCustomValidator
            ID="OrderTotalCustomValidator" runat="server" ErrorMessage="Order amount must be a monetary amount."
            ControlToValidate="OrderTotalTextBox" >*</bvc5:BVCustomValidator></td>
</tr>
<tr>
    <td class="formlabel">
        and the order total is <=</td>
    <td class="formfield">
        <asp:TextBox ID="OrderTotalMaxTextBox" runat="server"></asp:TextBox><bvc5:BVCustomValidator
            ID="OrderTotalMaxCustomValidator" runat="server" ErrorMessage="Order amount must be a monetary amount."
            ControlToValidate="OrderTotalMaxTextBox" >*</bvc5:BVCustomValidator>
        <bvc5:BVCustomValidator ID="OrderTotalMaxCustomValidator2" runat="server" ErrorMessage="Max order total must be less than min order total."
            ControlToValidate="OrderTotalMaxTextBox" >*</bvc5:BVCustomValidator>        
    </td>
</tr>
</table>
