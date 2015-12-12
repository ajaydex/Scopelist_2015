<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_ContentBlocks_Category_Rotator_view" %>

<div class="block categoryrotator">
    <h6>Category Rotator</h6>
	<asp:Literal EnableViewState="false" ID="PreHtml" runat="server"></asp:Literal>
    
    <asp:HyperLink EnableViewState="false" ID="CategoryIconLink" CssClass="categoryIcon" runat="server"></asp:HyperLink>
    <asp:HyperLink EnableViewState="false" ID="CategoryLink" runat="server" CssClass="categoryName"></asp:HyperLink> 
       
	<asp:Literal EnableViewState="false" ID="PostHtml" runat="server"></asp:Literal>
</div>
