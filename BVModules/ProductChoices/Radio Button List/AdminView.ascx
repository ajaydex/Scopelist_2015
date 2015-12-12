<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AdminView.ascx.vb" Inherits="BVModules_ProductChoices_Drop_Down_List_AdminView" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<table>
    <tr>
        <td style="vertical-align: top;"><asp:Label ID="InputLabel" runat="server" Text="Label"></asp:Label></td>
        <td><Anthem:RadioButtonList ID="ChoiceRadioButtonList" runat="server">
            </Anthem:RadioButtonList></td>
        <td><bvc5:BVRequiredFieldValidator ID="InputRequiredFieldValidator" runat="server" ControlToValidate="ChoiceRadioButtonList"
    ErrorMessage="Field Required" Enabled="false">*</bvc5:BVRequiredFieldValidator></td>
    </tr>
</table>