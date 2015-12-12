<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CategoryPicker.ascx.vb" Inherits="BVAdmin_Controls_CategoryPicker" %>

<asp:Panel ID="Panel1" runat="server" ScrollBars="Horizontal">
    <asp:GridView ID="CategoriesGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" Width="100%" GridLines="none">
        <Columns>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox ID="chkSelectAll" CssClass="selectAll" runat="server" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelected" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Text" HeaderText="Name" />
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
</asp:Panel>
