<%@ Control Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_RSS_Feed_Viewer_view" %>

<div class="block RssFeedViewer">

    <asp:Panel ID="pnlTitle" runat="server">
        <h4><asp:Label ID="lblTitle" runat="server" Text=""></asp:Label></h4>
    </asp:Panel>

    <asp:Panel ID="pnlDescription" runat="server">
        <asp:Label ID="lblDescription" runat="server"></asp:Label>
    </asp:Panel>

    <asp:DataList ID="DataList1" runat="server">
        <ItemTemplate>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#Bind("Link") %>' Text='<%#Bind("Title") %>' CssClass="itemTitle"></asp:HyperLink>
            <asp:Label Visible="true" ID="Label1" runat="server" Text='<%#Bind("Description") %>' CssClass="itemDescription"></asp:Label>
        </ItemTemplate>
    </asp:DataList>

</div>
