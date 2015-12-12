<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ProductTableDisplay.ascx.vb" Inherits="BVModules_Controls_ProductTableDisplay" %>
<%@ Register TagPrefix="uc" TagName="AddToCartButtonRemote" Src="~/BVModules/Controls/AddToCartButtonRemote.ascx" %>

<asp:Repeater ID="rpProductTable" runat="server">
    <HeaderTemplate>
        <table class="<%= Me.CssClass %>" cellspacing="0">
            <tr>
                <th><%-- image --%></th>
                <th>Product</th>
                <th>Price</th>
                <th><%-- add to cart --%></th>
            </tr>
    </HeaderTemplate>
    
    <ItemTemplate>
        <tr class="singleProductDisplayRow <%# If(Container.ItemIndex Mod 2 = 0, String.Empty, "alt") %>">
            <td>
                <asp:HyperLink ID="lnkImage" runat="server" />
                <asp:Image ID="imgNewBadge" runat="server" />
            </td>
            <td>
                <asp:Label ID="lblSku" runat="server" />
                <asp:HyperLink ID="lnkProductName" runat="server" />
                <asp:Literal ID="litShortDescription" runat="server" />
            </td>
            <td><asp:Label ID="lblSitePrice" runat="server" /></td>
            <td><uc:AddToCartButtonRemote ID="ucAddToCartButtonRemote" runat="server" /></td>
        </tr>
    </ItemTemplate>
    
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>