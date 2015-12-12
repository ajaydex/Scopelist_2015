<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_ContentBlocks_Category_Rotator_view" %>
<div class="block categoryrotator">
<asp:Literal EnableViewState="false" ID="PreHtml" runat="server"></asp:Literal>
    <div class="decoratedblock">
        <div class="blockcontent">
        <asp:HyperLink EnableViewState="false" ID="CategoryIconLink" runat="server"></asp:HyperLink><br />
        <asp:HyperLink EnableViewState="false" ID="CategoryLink" runat="server"></asp:HyperLink>    
        </div>
    </div>
<asp:Literal EnableViewState="false" ID="PostHtml" runat="server"></asp:Literal>
</div>