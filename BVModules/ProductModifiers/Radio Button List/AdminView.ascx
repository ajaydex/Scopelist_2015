<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AdminView.ascx.vb" Inherits="BVModules_ProductModifiers_Drop_Down_List_AdminView" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<table>
    <tr>
        <td style="vertical-align: top;"><asp:Label ID="InputLabel" runat="server" Text="Label"></asp:Label></td>
        <td><Anthem:RadioButtonList ID="ModifierRadioButtonList" runat="server">
            </Anthem:RadioButtonList></td>
        <td><bvc5:BVRequiredFieldValidator ID="InputRequiredFieldValidator" runat="server" ControlToValidate="ModifierRadioButtonList"
    ErrorMessage="Field Required" Enabled="false">*</bvc5:BVRequiredFieldValidator></td>
    </tr>
</table>