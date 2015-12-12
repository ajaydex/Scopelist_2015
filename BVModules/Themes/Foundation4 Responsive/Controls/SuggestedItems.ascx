<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SuggestedItems.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_SuggestedItems" %>
<%@ Register Src="~/BVModules/Themes/Foundation4 Responsive/Controls/ProductGridDisplay.ascx" TagName="ProductGridDisplay" TagPrefix="uc" %>

<asp:Panel ID="SuggestedItemsPanel" runat="server">
    
    <h2><asp:Label ID="TitleLabel" runat="server" Text="Others also purchased"></asp:Label></h2>

    <uc:ProductGridDisplay ID="ProductGridDisplay" runat="server" />
    
</asp:Panel>