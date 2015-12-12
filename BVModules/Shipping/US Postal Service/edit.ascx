<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_Shipping_US_Postal_Service_edit" %>
<h1>Edit Shipping Method - US Postal Service</h1>
<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3">
    <tr>
        <td class="formlabel">Name:</td>
        <td class="formfield"><asp:TextBox ID="NameField" runat="server" Width="300"></asp:TextBox></td>
    </tr>
    <%--<tr>
        <td class="formlabel">Account Number:</td>
        <td class="formfield"><asp:TextBox ID="AccountNumberField" runat="server" Width="300"></asp:TextBox></td>
    </tr>--%>
    <tr>
        <td class="formlabel">Service:</td>
        <td class="formfield"><asp:DropDownList ID="lstServiceCode" runat="server"></asp:DropDownList></td>
    </tr>
    <tr>
            <td colspan="2">
                <h2>
                    Global Provider Settings</h2>
            </td>
        </tr>       
        <tr>
            <td class="formlabel">Diagnostics Mode:</td>
            <td class="formfield"><asp:CheckBox ID="Diagnostics" runat="server" /></td>
        </tr>              
    <tr>
        <td colspan="2">
            <h2>
                Adjustments</h2>
        </td>
    </tr>
    <tr>
        <td class="formlabel">
            Adjust price by:
        </td>
        <td class="formfield">
            <asp:TextBox ID="AdjustmentTextBox" runat="server" Columns="5"></asp:TextBox>
            &nbsp;<bvc5:BVCustomValidator ID="CustomValidator1" runat="server" ControlToValidate="AdjustmentTextBox"
                ErrorMessage="Adjustment is not in the correct format.">*</bvc5:BVCustomValidator>
            <asp:DropDownList ID="AdjustmentDropDownList" runat="server">
                <asp:ListItem Selected="True" Value="1">Amount</asp:ListItem>
                <asp:ListItem Value="2">Percentage</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="formlabel">
            <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
        <td class="formfield">
            <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
    </tr>
</table></asp:Panel>