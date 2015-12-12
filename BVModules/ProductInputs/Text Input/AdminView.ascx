<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AdminView.ascx.vb"
    Inherits="BVModules_ProductInputs_Text_Input_ProductInputView" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<table>
    <tr>
        <td><asp:Label ID="InputLabel" runat="server" Text="Label"></asp:Label></td>
        <td><anthem:TextBox ID="InputTextBox" runat="server" Rows="1"></anthem:TextBox></td>
        <td><bvc5:BVRequiredFieldValidator ID="InputRequiredFieldValidator" runat="server" ControlToValidate="InputTextBox"
    ErrorMessage="Field Required" Enabled="False">*</bvc5:BVRequiredFieldValidator></td>
    </tr>
</table>




