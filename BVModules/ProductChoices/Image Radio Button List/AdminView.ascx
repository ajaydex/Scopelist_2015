<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AdminView.ascx.vb" Inherits="BVModules_ProductChoices_Image_Radio_Button_List_AdminView" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<table>
    <tr class="radiobuttonimagelist">
        <td class="choicelabel">
            <asp:Label ID="InputLabel" runat="server" Text="Label"></asp:Label>
        </td>
        <td class="choicefield">
        <anthem:RadioButtonList AutoPostBack="true" AutoUpdateAfterCallBack="true" ID="ChoiceList2" runat="server"></anthem:RadioButtonList>
    </td>
    <td class="choiceerror">
        <bvc5:BVRequiredFieldValidator ID="InputRequiredFieldValidator" runat="server" ControlToValidate="ChoiceList2"
        ErrorMessage="Field Required" ForeColor=" " CssClass="errormessage" Enabled="false">*</bvc5:BVRequiredFieldValidator>
    </td>
    </tr>
</table>