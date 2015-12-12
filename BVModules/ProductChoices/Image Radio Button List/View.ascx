<%@ Control Language="VB" AutoEventWireup="false" CodeFile="View.ascx.vb" Inherits="BVModules_ProductChoices_DropDownList_ProductChoiceView" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<tr class="radiobuttonimagelist">
    <td class="choicelabel">
        <asp:Label ID="InputLabel" CssClass="choicelabel" runat="server" Text="Label"></asp:Label>
    </td>
    <td class="choicefield">
        <anthem:RadioButtonList ID="ChoiceList2" runat="server" AutoCallBack="true" AutoUpdateAfterCallBack="true"></anthem:RadioButtonList>
    </td>
    <td class="choiceerror">
        <bvc5:BVRequiredFieldValidator ID="InputRequiredFieldValidator" runat="server" ControlToValidate="ChoiceList2"
        ErrorMessage="Field Required" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator>
    </td>
</tr>