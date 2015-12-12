<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AdminView.ascx.vb" Inherits="BVModules_ProductModifiers_Image_Radio_Button_List_AdminView" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<table>
    <tr class="radiobuttonimagelist">
        <td class="choicelabel">
            <asp:Label ID="InputLabel" runat="server" Text="Label"></asp:Label>
        </td>
        <td class="choicefield">
            <anthem:RadioButtonList ID="ModifierList" runat="server" AutoCallBack="true" AutoUpdateAfterCallBack="true"></anthem:RadioButtonList>
        </td>
        <td class="choiceerror">
            <bvc5:BVRequiredFieldValidator ID="InputRequiredFieldValidator" runat="server" ControlToValidate="ModifierList" ErrorMessage="Field Required" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator>
        </td>
    </tr>
</table>