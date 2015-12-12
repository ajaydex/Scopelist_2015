<%@ Control Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_ContentBlocks_Product_Reviews_List_view" %>
<%@ Register TagPrefix="uc" TagName="ProductReviewsList" Src="~/BVModules/Controls/ProductReviewsList.ascx" %>

<div class="block productReviewList">
    <h6>Product Reviews List</h6>
    <asp:Literal ID="litPreContentHtml" runat="server" />
    <uc:ProductReviewsList ID="ucProductReviewsList" runat="server" />
    <asp:Literal ID="litPostContentHtml" runat="server" />
</div>