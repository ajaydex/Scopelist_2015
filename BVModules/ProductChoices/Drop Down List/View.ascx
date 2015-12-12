<%@ Control Language="VB" AutoEventWireup="false" CodeFile="View.ascx.vb" Inherits="BVModules_ProductChoices_DropDownList_ProductChoiceView" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<tr class="dropdownlist">
    <td class="choicelabel"><asp:Label ID="InputLabel" runat="server" Text="Label"></asp:Label></td>
    <td class="choicefield"><anthem:DropDownList ID="ChoiceList" runat="server" AutoCallBack="true" AutoUpdateAfterCallBack="true"></anthem:DropDownList></td>
    <td class="choiceerror"><bvc5:BVRequiredFieldValidator ID="InputRequiredFieldValidator" runat="server" ControlToValidate="ChoiceList"
        ErrorMessage="Field Required" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator></td>
</tr>