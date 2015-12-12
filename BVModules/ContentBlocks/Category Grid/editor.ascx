<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Category_Grid_editor" %>
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
        <td class="formlabel">Title</td>
        <td class="formfield">
            <asp:TextBox ID="txtTitle" Columns="40" ToolTip="Displays this text as a heading" runat="server" />
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
    <tr>
        <td class="formlabel">Columns</td>
        <td class="formfield">
            <asp:TextBox id="txtColumns" runat="server" Columns ="40"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Heading Tag</td>
        <td class="formfield">
            <asp:DropDownList ID="ddlHeadingTag" runat="server">
                <asp:ListItem Value="h1">&#60;h1&#62;</asp:ListItem>
                <asp:ListItem Value="h2">&#60;h2&#62;</asp:ListItem>
                <asp:ListItem Value="h3">&#60;h3&#62;</asp:ListItem>
                <asp:ListItem Value="h4">&#60;h4&#62;</asp:ListItem>
                <asp:ListItem Value="h5">&#60;h5&#62;</asp:ListItem>
                <asp:ListItem Value="h6">&#60;h6&#62;</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
</table>
<br />
<br />
<asp:ImageButton ID="btnOk" runat="server" ImageUrl="~/bvadmin/images/buttons/Savechanges.png" />
<hr />
</asp:Panel>
