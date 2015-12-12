<%@ Control Language="VB" AutoEventWireup="false" CodeFile="HtmlModifierField.ascx.vb" Inherits="BVAdmin_Controls_HtmlModifierField" %>
<%@ Register Src="HtmlEditor.ascx" TagName="HtmlEditor" TagPrefix="uc1" %>
<uc1:HtmlEditor ID="HtmlEditor" runat="server" />
<asp:DropDownList ID="HtmlDropDownList"
    runat="server">
    <asp:ListItem Selected="True">Set To</asp:ListItem>
    <asp:ListItem>Append To</asp:ListItem>
</asp:DropDownList>

