<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_OrderTasks_Receive_Paypal_Express_Payments_edit" %>
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Step Name:</td>
    <td class="formfield"><asp:TextBox runat="server" ID="StepNameField" Columns="40"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Throw Errors on Failure?:</td>
    <td class="formfield"><asp:CheckBox ID="chkThrowErrors" runat="server" /></td>
</tr>
<tr>
    <td class="formlabel">Error Message for Customer:</td>
    <td class="formfield"><asp:TextBox ID="CustomerErrorMessageField" runat="server" Columns="40"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Set Order Status on Failure?:</td>
    <td class="formfield"><asp:CheckBox ID="chkSetStatusOnFail" runat="server" /></td>
</tr>
<tr>
    <td class="formlabel">Order Status On Failure:</td>
    <td class="formfield"><asp:DropdownList ID="FailStatusField" runat="server"></asp:DropdownList></td>
</tr>
<tr>
    <td class="formlabel"><asp:ImageButton ID="btnCancel" runat="server" CausesValidation="false" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield"><asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table>