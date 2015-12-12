<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_OrderTasks_Apply_Minimum_Order_Amount_edit" %>
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Step Name:</td>
    <td class="formfield"><asp:TextBox runat="server" ID="StepNameField" Columns="40"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Minimum Order Amount:</td>
    <td class="formfield">
        <asp:TextBox runat="server" ID="MinimumOrderAmountTextBox" Columns="20"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Minimum Order Amount Required." CssClass="errormessage" ForeColor=" " Text="*" ControlToValidate="MinimumOrderAmountTextBox"></bvc5:BVRequiredFieldValidator>
        <bvc5:BVCustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Minimum Order Amount Must Be A Monetary Amount." CssClass="errormessage" ForeColor=" " Text="*" ControlToValidate="MinimumOrderAmountTextBox"></bvc5:BVCustomValidator>
    </td>
</tr>
<tr>
    <td class="formlabel">Error Message for Customer:</td>
    <td class="formfield">
        <asp:TextBox runat="server" ID="ErrorMessageTextBox" Columns="20"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Error Message Required." CssClass="errormessage" ForeColor=" " Text="*" ControlToValidate="ErrorMessageTextBox"></bvc5:BVRequiredFieldValidator>
    </td>
</tr>
<tr>
    <td class="formlabel"><asp:ImageButton ID="btnCancel" runat="server" CausesValidation="false" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield"><asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table>