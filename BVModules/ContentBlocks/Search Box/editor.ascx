<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Search_Box_editor" %>
<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
    <table border="0" cellspacing="0" cellpadding="3">
        <tr>
            <td class="formlabel">
                Title</td>
            <td class="formfield">
                <asp:TextBox ID="TitleField" runat="server" Columns="30"></asp:TextBox></td>
        </tr>     
        <tr>
            <td class="formlabel">
                <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/bvadmin/images/buttons/Cancel.png" /></td>
            <td class="formfield">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/bvadmin/images/buttons/SaveChanges.png" /></td>
        </tr>
    </table>
</asp:Panel>
