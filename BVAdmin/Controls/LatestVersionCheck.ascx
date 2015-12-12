<%@ Control Language="VB" AutoEventWireup="false" CodeFile="LatestVersionCheck.ascx.vb" Inherits="BVAdmin_Controls_LatestVersionCheck" %>
<%@ OutputCache Duration="14400" Shared="true" VaryByParam="none" %>

<div class="block newVersion">
    <asp:Literal ID="litVersionCheck" runat="server"></asp:Literal>
    <asp:HyperLink ID="lnkDownload" runat="server" Visible="false" Text="Download Latest Version" NavigateUrl="http://www.bvcommerce.com/download" Target="_blank" CssClass="latestDownload"></asp:HyperLink>
</div>