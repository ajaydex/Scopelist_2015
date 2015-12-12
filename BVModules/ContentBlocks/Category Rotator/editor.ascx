<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Category_Rotator_editor" %>
<%@ Register Src="~/BVAdmin/Controls/CategoryTreeView.ascx" TagName="CategoryTreeView" TagPrefix="uc" %>

<asp:Panel ID="pnlMain" DefaultButton="btnOk" runat="server">

<hr />
<table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
    <tr>
        <td style="width:40%;">
            <asp:GridView ID="CategoriesGridView" runat="server" DataKeyNames="bvin" AutoGenerateColumns="false" gridlines="none" Width="100%">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Category Name" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="btnUp" runat="server" CommandName="Update" ImageUrl="~/BVAdmin/Images/buttons/up.png"
                                AlternateText="Move Up"></asp:ImageButton><br />
                            <asp:ImageButton ID="btnDown" runat="server" CommandName="Cancel" ImageUrl="~/BVAdmin/Images/buttons/down.png"
                                AlternateText="Move Down"></asp:ImageButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Image" DeleteImageUrl="~/BVAdmin/images/Buttons/X.png"
                        ShowDeleteButton="True">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:CommandField>
                </Columns>
                <EmptyDataTemplate>
                    There are no selected categories.
                </EmptyDataTemplate>
                <RowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
        </td>        
        <td style="width:20%;text-align:center;">
            <asp:ImageButton ID="AddImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Add.png" />
        </td>
        <td style="width:40%;">
            <uc:CategoryTreeView ID="ucCategoryTreeView" ExpandSelectedCategories="true" IncludeHiddenCategories="true" runat="server" />
        </td>
    </tr>
</table>
<hr />
<table border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="formlabel" colspan="2">
            <asp:CheckBox ID="chkShowInOrder" CssClass="formlabel" Text="Rotate products in the order shown above"
                runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Pre-Html:</td>
        <td>
            <asp:TextBox ID="PreHtmlField" runat="server" Columns="40"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="formlabel">
            Post-Html:
        </td>
        <td>
            <asp:TextBox ID="PostHtmlField" runat="server" Columns="40"></asp:TextBox>
        </td>
    </tr>
</table>
<br />
<br />
<asp:ImageButton ID="btnOk" runat="server" ImageUrl="~/bvadmin/images/buttons/Savechanges.png" />
<hr />
</asp:Panel>
