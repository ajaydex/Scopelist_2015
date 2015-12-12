<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Html_Rotator_editor" %>

<h2>Modify/Create HTML</h2>
<div class="f-row">
    <div class="six columns">
        <asp:Panel id="pnlEditor" runat="server" DefaultButton="btnNew">
            HTML
            <asp:TextBox ID="HtmlField" runat="Server" Columns="40" Rows="10" TextMode="MultiLine" Wrap="False"></asp:TextBox></td>
            <br /><br />
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
                    <asp:BoundField DataField="Setting1" HeaderText="HTML" NullDisplayText="No HTML" />
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
                    <asp:CommandField ButtonType="Image" DeleteImageUrl="~/BVAdmin/images/Buttons/X.png" ShowDeleteButton="True">
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
<asp:CheckBox ID="chkShowInOrder" CssClass="formlabel" Text="Rotate HTML in the order shown above" runat="server" />&nbsp;<br />
<br />
<asp:ImageButton ID="btnOkay" runat="server" ImageUrl="~/bvadmin/images/buttons/Ok.png" />
<hr /> 
