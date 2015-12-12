<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Footer.ascx.vb" Inherits="BVModules_Themes_Bvc5_Footer" %>
<%@ Register Src="../../Controls/CustomPagesDisplay.ascx" TagName="CustomPagesDisplay"
    TagPrefix="uc2" %>
<%@ Register Src="../../Controls/PoweredBy.ascx" TagName="PoweredBy" TagPrefix="uc1" %>
<div id="footer">
    <div id="footernavmenu">
        <ul>
            <li>
                <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Default.aspx"/></li>
            <li>
                <asp:HyperLink ID="lnkSearch" runat="server" NavigateUrl="~/Search.aspx"/></li>
            <li>
                <asp:HyperLink ID="lnkSiteMap" runat="server" NavigateUrl="~/Sitemap.aspx"/>
            </li>
        </ul>                
        <uc2:CustomPagesDisplay id="CustomPagesDisplay1" runat="server">
        </uc2:CustomPagesDisplay>
    </div>    
    <div id="footercopyright">
            Copyright 2005-2006 BV Software LLC</div>            
    <uc1:PoweredBy ID="PoweredBy1" runat="server" />
</div>
