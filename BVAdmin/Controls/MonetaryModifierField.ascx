<%@ Control Language="VB" AutoEventWireup="false" CodeFile="MonetaryModifierField.ascx.vb" Inherits="BVAdmin_Controls_MonetaryModifierField" %>
<asp:TextBox ID="MonetaryTextBox" runat="server"></asp:TextBox>
<bvc5:BVCustomValidator ID="CustomValidator1" runat="server" ControlToValidate="MonetaryTextBox"
    Display="Dynamic" ErrorMessage="Must be a monetary value." CssClass="errormessage" ForeColor=" ">*</bvc5:BVCustomValidator>
<asp:DropDownList ID="MonetaryDropDownList" runat="server">
    <asp:ListItem Selected="True">Set To</asp:ListItem>
    <asp:ListItem>Increase By Amount</asp:ListItem>
    <asp:ListItem>Decrease By Amount</asp:ListItem>
    <asp:ListItem>Increase By Percent</asp:ListItem>
    <asp:ListItem>Decrease By Percent</asp:ListItem>
</asp:DropDownList>
