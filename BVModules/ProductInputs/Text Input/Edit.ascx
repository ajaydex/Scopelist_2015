<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_ProductInputs_Text_Input_ProductInputEdit" %>
<asp:Label ID="Label1" runat="server" CssClass="errormessage" EnableViewState="False"></asp:Label>
<table>
    <tr>
        <td class="formlabel" style="height: 26px">
            Property Name</td>
        <td class="formfield" style="height: 26px; width: 276px;">
            <asp:TextBox ID="PropertyNameTextBox" runat="server" Width="215px"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel" style="height: 26px">
            Display Name</td>
        <td class="formfield" style="height: 26px; width: 276px;">
            <asp:TextBox ID="DisplayNameTextBox" runat="server" Width="215px"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel" style="height: 26px">
            Required Field?</td>
        <td class="formfield" style="height: 26px; width: 276px;">
            <asp:CheckBox ID="RequiredFieldCheckBox" runat="server" /></td>
    </tr>
    <tr>
        <td class="formlabel" style="height: 26px">
            Wrap Text?</td>
        <td class="formfield" style="height: 26px; width: 276px;">
            <asp:CheckBox ID="WrapTextCheckBox" runat="server" /></td>
    </tr>
    <tr>
        <td class="formlabel" style="height: 26px">
            Text Box Size</td>
        <td class="formfield" style="height: 26px; width: 276px;">
            <asp:TextBox ID="RowsTextBox" runat="server" Width="33px"></asp:TextBox> rows
        </td>
    </tr>
    <tr>
        <td class="formlabel" style="height: 26px"></td>
        <td class="formfield" style="height: 26px; width: 276px;">
            <asp:TextBox ID="ColumnsTextBox" runat="server" Width="33px"></asp:TextBox> columns
        </td>
    </tr>
    <tr>
        <td>
        </td>
        <td style="width: 276px">
            &nbsp;<asp:ImageButton ID="ChoiceInputCancelButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
            <asp:ImageButton ID="ChoiceInputContinueButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Continue.png" /></td>
    </tr>
</table>