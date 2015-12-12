<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_ContentBlocks_Image_Rotator_view" %>

<div class="block imageRotator">
    <asp:Literal EnableViewState="false" ID="PreHtml" runat="server"></asp:Literal>
    
    <asp:HyperLink EnableViewState="false" ID="lnkMain" runat="server" NavigateUrl=""></asp:HyperLink>
    
    <asp:Literal EnableViewState="false" ID="PostHtml" runat="server"></asp:Literal>
</div>