<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Sticky_Note_editor" %>

<asp:Panel id="pnlEditor" runat="server" DefaultButton="btnNew">
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="formlabel" colspan="2">
                <div runat="server" id="StickyNoteContainer" class="StickyNote">
                    <div style="padding: 10px;">
                        <asp:TextBox ID="ContentField" runat="Server" Columns="40" Rows="10" TextMode="MultiLine" Wrap="True"></asp:TextBox>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td class="formlabel">Height</td>
            <td class="forminput"><asp:TextBox runat="server" ID="HeightField" Text="150"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel">Color</td>
            <td class="forminput">
                <asp:DropDownList ID="lstColor" runat="server">
                <asp:ListItem>Blue</asp:ListItem>
                <asp:ListItem>Green</asp:ListItem>
                <asp:ListItem>Pink</asp:ListItem>
                <asp:ListItem>Yellow</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <br />
    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
    &nbsp;
    <asp:ImageButton ID="btnNew" runat="Server" ImageUrl="~/BVAdmin/Images/buttons/SaveChanges.png" />
    <hr />

    <asp:HiddenField ID="EditBvinField" runat="server" />
</asp:Panel>
