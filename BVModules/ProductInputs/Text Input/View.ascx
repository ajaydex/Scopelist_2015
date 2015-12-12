<%@ Control Language="VB" AutoEventWireup="false" CodeFile="View.ascx.vb"
    Inherits="BVModules_ProductInputs_Text_Input_ProductInputView" %>
<tr class="textinput">
    <td class="choicelabel"><asp:Label ID="InputLabel" runat="server" Text="Label"></asp:Label></td>
    <td class="choicefield"><asp:TextBox ID="InputTextBox" runat="server" Rows="1"></asp:TextBox></td>
    <td class="choiceerror"><bvc5:BVRequiredFieldValidator ID="InputRequiredFieldValidator" runat="server" ControlToValidate="InputTextBox"
ErrorMessage="Field Required" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator></td>
</tr>

