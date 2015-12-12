<%@ Control Language="VB" AutoEventWireup="false" CodeFile="adminview.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_Top_Selling_Products_adminview" %>
<%@ Register TagPrefix="uc" TagName="ProductGridDisplay" Src="~/BVModules/Controls/ProductGridDisplay.ascx" %>
<%@ Register TagPrefix="uc" TagName="ProductListDisplay" Src="~/BVModules/Controls/ProductListDisplay.ascx" %>
<%@ Register TagPrefix="uc" TagName="ProductTableDisplay" Src="~/BVModules/Controls/ProductTableDisplay.ascx" %>

<div class="block topSellers">


<h6>Top Selling Products</h6>
<asp:Literal ID="litPreContentHtml" runat="server" />
<h4 id="hTitle" runat="server" />
<uc:ProductGridDisplay ID="ucProductGridDisplay" runat="server" />
<uc:ProductListDisplay ID="ucProductListDisplay" runat="server" />
<uc:ProductTableDisplay ID="ucProductTableDisplay" runat="server" />
<asp:Literal ID="litPostContentHtml" runat="server" />
</div>