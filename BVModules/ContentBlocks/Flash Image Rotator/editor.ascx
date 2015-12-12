<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Flash_Image_Rotator_editor" %>

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
            </table>
            <br />
            <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/CancelSmall.png" />
            &nbsp;
            <asp:ImageButton ID="btnNew" runat="Server" ImageUrl="~/BVAdmin/Images/buttons/New.png" />
            <asp:HiddenField ID="EditBvinField" runat="server" />
        </asp:Panel>
    </div>

    <div class="six columns">
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnOkay">    
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="3" GridLines="None" DataKeyNames="bvin" Width="400px">
                <Columns>
                    <asp:ImageField DataImageUrlField="Setting1" HeaderText="Image" NullDisplayText="No Image"></asp:ImageField>
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
                    <asp:CommandField ButtonType="Image" DeleteImageUrl="~/BVAdmin/images/Buttons/X.png" ShowDeleteButton="True" >
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

<table border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="formlabel">&nbsp;</td>
        <td class="forminput"><asp:CheckBox ID="chkShowInOrder" CssClass="formlabel" Text="Rotate images in the order shown above" runat="server" /></td>
    </tr>
    <tr>
        <td class="formlabel">&nbsp;</td>
        <td class="forminput"><asp:CheckBox ID="chkOpenInNewWindow" CssClass="formlabel" Text="Open links in new window" runat="server" /></td>
    </tr>
    <tr>
        <td class="formlabel">Pause for:</td>
        <td class="forminput"><asp:TextBox ID="PauseField" Columns="5" runat="server" >2</asp:TextBox> seconds</td>
    </tr>
    <tr>
        <td class="formlabel">Size:</td>
        <td class="forminput">w: <asp:TextBox id="WidthField" runat="server" Columns="5"></asp:TextBox> h: <asp:TextBox id="HeighField" runat="server" Columns="5"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel">Background Color:</td>
        <td class="forminput"><asp:TextBox id="BGColor" runat="server" Columns="40" Text="#ffffff"></asp:TextBox></td>
    </tr>
        <tr>
        <td class="formlabel">Pre-Html:</td>
        <td class="forminput"><asp:TextBox id="PreHtmlField" runat="server" Columns="40"></asp:TextBox></td>
    </tr>
        <tr>
        <td class="formlabel">Post-Html:</td>
        <td class="forminput"><asp:TextBox id="PostHtmlField" runat="server" Columns="40"></asp:TextBox></td>
    </tr>
</table>  
<hr />
<asp:ImageButton ID="btnOkay" runat="server" ImageUrl="~/bvadmin/images/buttons/Ok.png" />
<hr />                   
    
