<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AdminView.ascx.vb" Inherits="BVModules_ProductChoices_Drop_Down_List_AdminView" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<table>
    <tr>
        <td><asp:Label ID="InputLabel" runat="server" Text="Label"></asp:Label></td>
        <td><anthem:DropDownList ID="ChoiceList" runat="server"></anthem:DropDownList></td>
        <td><bvc5:BVRequiredFieldValidator ID="InputRequiredFieldValidator" runat="server" ControlToValidate="ChoiceList"
    ErrorMessage="Field Required" Enabled="false">*</bvc5:BVRequiredFieldValidator></td>
    </tr>
</table>