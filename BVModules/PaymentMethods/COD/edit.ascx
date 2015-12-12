<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_PaymentMethods_COD_edit" %>
<h1>COD Payment Options</h1>
<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Payment Name:</td>
    <td class="formfield"><asp:TextBox ID="NameField" runat="server" Width="300"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Description:</td>
    <td class="formfield"><asp:TextBox ID="DescriptionField" runat="server" Width="300" Height="100px" TextMode="MultiLine" Wrap="true"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">
        <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield">
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table></asp:Panel>