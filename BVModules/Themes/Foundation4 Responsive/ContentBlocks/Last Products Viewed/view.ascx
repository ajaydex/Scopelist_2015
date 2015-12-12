<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_Last_Products_Viewed_view" %>
<%@ Register TagPrefix="uc" TagName="ProductGridDisplay" Src="~/BVModules/Themes/Foundation4 Responsive/Controls/ProductGridDisplay.ascx" %>

<div class="block lastProductsViewed">
<asp:Literal EnableViewState="false" ID="PreHtml" runat="server"></asp:Literal>
<div id="ProductGrid" runat="server" class="productgrid">
    <div class="decoratedblock">
        <div class="blockcontent">
            <h4><asp:Literal EnableViewState="false" ID="litTitle" runat="server"></asp:Literal></h4>
            <uc:ProductGridDisplay ID="ProductGridDisplay1" runat="server" />
        </div>
    </div>
</div>
<asp:Literal EnableViewState="false" ID="PostHtml" runat="server"></asp:Literal>
</div>