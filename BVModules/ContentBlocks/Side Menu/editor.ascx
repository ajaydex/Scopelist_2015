<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Side_Menu_editor" %>


<div class="f-row">
    <div class="six columns">
        <h2>Modify/Create Link</h2>
        <asp:Panel id="pnlEditor" runat="server" DefaultButton="btnNew">
            <table border="0" cellspacing="0" cellpadding="3">
                <tr>
                    <td class="formlabel">Link Text:</td>
                    <td class="forminput"><asp:TextBox ID="LinkTextField" runat="Server" Columns="40"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="formlabel">Link Url:</td>
                    <td class="forminput"><asp:TextBox ID="LinkField" runat="Server" Columns="40"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="formlabel">Tool Tip:</td>
                    <td class="forminput"><asp:TextBox ID="AltTextField" runat="Server" Columns="40"></asp:TextBox></td>
                </tr>
            </table>
            <br />
            <asp:CheckBox ID="OpenInNewWindowField" runat="server" /> Open in New Window

            <br />
            <br />
            <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/CancelSmall.png" />
            &nbsp;
            <asp:ImageButton ID="btnNew" runat="Server" ImageUrl="~/BVAdmin/Images/buttons/New.png" />

            <asp:HiddenField ID="EditBvinField" runat="server" />
        </asp:Panel>
    </div>
    <div class="six columns">
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnOkay">    
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="0" GridLines="None" DataKeyNames="bvin" Width="100%">
                <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="Setting2" DataTextField="Setting1" HeaderText="Link"
                Target="_blank" />
                <asp:TemplateField>
                <ItemTemplate>
                <asp:ImageButton id="btnUp" runat="server" CommandName="Update" ImageUrl="~/BVAdmin/Images/buttons/up.png" AlternateText="Move Up" ></asp:ImageButton><br />
                <asp:ImageButton id="btnDown" runat="server" CommandName="Cancel" ImageUrl="~/BVAdmin/Images/buttons/down.png" AlternateText="Move Down" ></asp:ImageButton>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
                </asp:TemplateField>
                <asp:TemplateField>
                <ItemTemplate>
                <asp:ImageButton id="btnEdit" runat="server" CommandName="Edit" ImageUrl="~/BVAdmin/Images/buttons/Edit.png" AlternateText="Edit" ></asp:ImageButton><br />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="80px" />
                </asp:TemplateField>
                <asp:CommandField ButtonType="Image" DeleteImageUrl="~/BVAdmin/images/Buttons/X.png"
                ShowDeleteButton="True" >
                <ItemStyle HorizontalAlign="Center" Width="30px" />
                </asp:CommandField>
                </Columns>
                <RowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
    
        </asp:Panel>
    </div>
</div>

<hr />

<table border="0" cellspacing="0" cellpadding="3">
    <tr>
    <td class="formlabel">Menu Title:</td>
    <td class="forminput"><asp:TextBox ID="TitleField" runat="Server" Columns="30"></asp:TextBox>
    </td>
    </tr>
</table>
<br />
<asp:ImageButton ID="btnOkay" runat="server" ImageUrl="~/bvadmin/images/buttons/Ok.png" />  

<hr />



 

