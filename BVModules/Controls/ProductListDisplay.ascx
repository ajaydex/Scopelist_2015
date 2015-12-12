<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ProductListDisplay.ascx.vb" Inherits="BVModules_Controls_ProductListDisplay" %>

<asp:Repeater ID="rpProductList" runat="server">
    <HeaderTemplate>
        <ol class="<%= Me.CssClass %>">
    </HeaderTemplate>
    
    <ItemTemplate>
        <li class="<%# If(Container.ItemIndex Mod 2 = 0, String.Empty, "alt") %>">
            <asp:HyperLink ID="lnkProduct" runat="server">
                <asp:Label ID="lblProductName" runat="server" /> - <asp:Label ID="lblProductPrice" runat="server" />
            </asp:HyperLink>
        </li>
    </ItemTemplate>
    
    <FooterTemplate>
        </ol>
    </FooterTemplate>
</asp:Repeater>