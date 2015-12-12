<%@ Control Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_Top_Selling_Products_view" %>
<%@ Register TagPrefix="uc" TagName="ProductGridDisplay" Src="~/BVModules/Themes/Foundation4 Responsive/Controls/ProductGridDisplay.ascx" %>

<div class="block topSellers">
<asp:Literal ID="litPreContentHtml" runat="server" />
<asp:Literal id="litTitle" runat="server" />

<uc:ProductGridDisplay ID="ProductGridDisplay1" runat="server" />

<asp:Literal ID="litPostContentHtml" runat="server" />
</div>