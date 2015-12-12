<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ProductGridDisplay.ascx.vb" Inherits="BVModules_Controls_ProductGridDisplay" %>
<%@ Register TagPrefix="uc" TagName="SingleProductDisplay" Src="~/BVModules/Controls/SingleProductDisplay.ascx" %>

<asp:Repeater ID="rpProductGrid" runat="server">
    <HeaderTemplate>
        <table class="<%= Me.CssClass %>" cellspacing="0">
    </HeaderTemplate>
    
    <ItemTemplate>
        <td>
            <uc:SingleProductDisplay ID="ucSingleProductDisplay" runat="server" />
        </td>
    </ItemTemplate>
    
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>