<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_OrderTasks_Change_Order_Status_When_Payment_Removed_edit" %>
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Step Name:</td>
    <td class="formfield"><asp:TextBox runat="server" ID="StepNameField" Columns="40"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Status To Change Order To:</td>
    <td class="formfield">
        <asp:DropDownList ID="OrderStatusDropDownList" runat="server">
        </asp:DropDownList>
    </td>
</tr>
<tr>
    <td class="formlabel"><asp:ImageButton ID="btnCancel" runat="server" CausesValidation="false" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield"><asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table>