<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Image_Rotator_editor" %>

<div class="f-row">
    <div class="six columns">
        <h2>Modify/Create Image</h2>
        <asp:Panel id="pnlEditor" runat="server" DefaultButton="btnNew">
            <table border="0" cellspacing="0" cellpadding="3">
            <tr>
            <td class="formlabel">Image Url:</td>
            <td class="forminput"><asp:TextBox ID="ImageUrlField" runat="Server" Columns="20"></asp:TextBox>
            <a href="javascript:popUpWindow('?returnScript=SetImage&WebMode=1');"><asp:Image ID="imgSelect1" runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" /></a></td>
            </tr>
            <tr>
            <td class="formlabel">Link To:</td>
            <td class="forminput"><asp:TextBox ID="ImageLinkField" runat="Server" Columns="40"></asp:TextBox></td>
            </tr>
            <tr>
            <td class="formlabel">
            Tool Tip:</td>
            <td class="forminput"><asp:TextBox ID="AltTextField" runat="Server" Columns="40"></asp:TextBox></td>
            </tr>
            <tr>
            <td class="formlabel">Open in New Window:</td>
            <td class="forminput"><asp:CheckBox ID="chkOpenInNewWindow" runat="server" /></td>
            </tr>
            </table>
            <asp:HiddenField ID="EditBvinField" runat="server" />

            <br />
            <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/CancelSmall.png" />
            &nbsp;
            <asp:ImageButton ID="btnNew" runat="Server" ImageUrl="~/BVAdmin/Images/buttons/New.png" />
        </asp:Panel>
    </div>
    <div class="six columns">
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnOkay">    
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="3" GridLines="None" DataKeyNames="bvin" Width="400px">
            <Columns>
            <asp:ImageField DataImageUrlField="Setting1" HeaderText="Image" NullDisplayText="No Image">
            </asp:ImageField>
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

<asp:CheckBox ID="chkShowInOrder" CssClass="formlabel" Text="Rotate images in the order shown above" runat="server" />
<br />
<br />
<table border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td class="formlabel">Pre-Html:</td>
    <td class="forminput"><asp:TextBox id="PreHtmlField" runat="server" Columns="40"></asp:TextBox></td>
    </tr>
    <tr>
    <td class="formlabel">Post-Html:</td>
    <td class="forminput"><asp:TextBox id="PostHtmlField" runat="server" Columns="40"></asp:TextBox></td>
    </tr>
    <tr>
</table>   
<br />
<asp:ImageButton ID="btnOkay" runat="server" ImageUrl="~/bvadmin/images/buttons/Ok.png" />     
<hr />           

