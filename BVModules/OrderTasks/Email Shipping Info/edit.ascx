<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_OrderTasks_Email_Shipping_Info_edit" %>
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Step Name:</td>
    <td class="formfield"><asp:TextBox runat="server" ID="StepNameField" Columns="40"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Use Template:</td>
    <td class="formfield"><asp:DropDownList ID="EmailTemplateField" runat="server"></asp:DropDownList></td>
</tr>
<tr>
    <td class="formlabel">Email To:</td>
    <td class="formfield"><asp:DropDownList id="EmailToField" runat="server" AutoPostBack="true">
    <asp:ListItem Text="To Customer" Value="Customer"></asp:ListItem>
    <asp:ListItem Text="To Admin" Value="Admin"></asp:ListItem>
    <asp:ListItem Text="Custom" Value="Custom"></asp:ListItem>
    </asp:DropDownList> <asp:TextBox ID="CustomToField" runat="server" Columns="40" Visible="false"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel"><asp:ImageButton ID="btnCancel" runat="server" CausesValidation="false" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield"><asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table>