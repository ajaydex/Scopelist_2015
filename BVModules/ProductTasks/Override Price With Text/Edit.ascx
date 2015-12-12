<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_ProductTasks_Overrider_Price_With_Text_Edit" %>

<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Step Name:</td>
    <td class="formfield"><asp:TextBox runat="server" ID="StepNameField" Columns="40"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Override Product with this text:</td>
    <td class="formfield"><asp:TextBox runat="server" ID="MyTextField"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">&nbsp;</td>
    <td class="formfield"><asp:CheckBox runat="server" ID="chkAnonymous" Text="Only apply to anonymous users." /></td>
</tr>
<tr>
    <td class="formlabel"><asp:ImageButton ID="btnCancel" runat="server" CausesValidation="false" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield"><asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table>