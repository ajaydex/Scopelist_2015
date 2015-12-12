<%@ Control Language="VB" AutoEventWireup="false" CodeFile="IntegerModifierField.ascx.vb" Inherits="BVAdmin_Controls_IntegerModifierField" %>
<asp:TextBox ID="IntegerTextBox" runat="server"></asp:TextBox>
<bvc5:BVRegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="IntegerTextBox"
    Display="Dynamic" ErrorMessage="Field must be numeric." ValidationExpression="\d{1,14}" CssClass="errormessage" ForeColor=" ">*</bvc5:BVRegularExpressionValidator>
<asp:DropDownList ID="IntegerDropDownList" runat="server">
    <asp:ListItem Selected="True">Set To</asp:ListItem>
    <asp:ListItem>Add To</asp:ListItem>
    <asp:ListItem>Subtract From</asp:ListItem>
</asp:DropDownList>
