<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_OrderTasks_Log_Message_edit" %>
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Message:</td>
    <td class="formfield"><asp:TextBox runat="server" ID="MessageField" Columns="40"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel"><asp:ImageButton ID="btnCancel" runat="server" CausesValidation="false" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield"><asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table>