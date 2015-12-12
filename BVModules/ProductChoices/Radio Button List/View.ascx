<%@ Control Language="VB" AutoEventWireup="false" CodeFile="View.ascx.vb" Inherits="BVModules_ProductChoices_DropDownList_ProductChoiceView" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<tr class="radiobuttonnormallist">    
    <td class="choicelabel">
        <asp:Label ID="InputLabel" runat="server" Text="Label"></asp:Label>
    </td>
    <td class="choicefield">
        <anthem:RadioButtonList ID="ChoiceRadioButtonList" runat="server" AutoCallBack="true" AutoUpdateAfterCallBack="True" CssClass="rblist">
        </anthem:RadioButtonList>                           
    </td>    
    <td class="choiceerror">
        <bvc5:BVRequiredFieldValidator ID="InputRequiredFieldValidator" runat="server" ControlToValidate="ChoiceRadioButtonList"
            ErrorMessage="Field Required" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator>    
    </td>
</tr>