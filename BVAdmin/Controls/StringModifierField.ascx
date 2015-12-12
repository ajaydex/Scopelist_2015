<%@ Control Language="VB" AutoEventWireup="false" CodeFile="StringModifierField.ascx.vb" Inherits="BVAdmin_Controls_StringModifierField" %>
<asp:TextBox ID="StringTextBox" runat="server"></asp:TextBox>
<asp:DropDownList ID="StringDropDownList" runat="server">
    <asp:ListItem Selected="True">Set To</asp:ListItem>
    <asp:ListItem>Append To</asp:ListItem>
    <asp:ListItem>Remove From End</asp:ListItem>
</asp:DropDownList>
