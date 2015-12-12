<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_ProductInputs_Text_Input_ProductInputEdit" %>
<table>
    <tr>
        <td class="formlabel">
            Name</td>
        <td class="formfield">
            <asp:TextBox ID="PropertyNameTextBox" runat="server" Width="215px"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel">
            Html</td>
        <td class="formfield">
            <asp:TextBox ID="HtmlTextBox" runat="server" Width="400px" TextMode="MultiLine" Rows="10"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
        </td>
        <td style="width: 276px">
            &nbsp;<asp:ImageButton ID="ChoiceInputCancelButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
            <asp:ImageButton ID="ChoiceInputContinueButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Continue.png" /></td>
    </tr>
</table>