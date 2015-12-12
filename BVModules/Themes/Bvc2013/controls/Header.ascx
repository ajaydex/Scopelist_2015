<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Header.ascx.vb" Inherits="BVModules_Themes_Bvc2013_Header" %>
<%@ Register Src="~/BVModules/Controls/WaitingMessage.ascx" TagName="WaitingMessage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/CartTotals.ascx" TagName="CartTotals" TagPrefix="uc" %>
<%@ Register Src="LoginMenu.ascx" TagName="LoginMenu" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/Search.ascx" TagName="Search" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/MainMenu.ascx" TagName="MainMenu" TagPrefix="uc" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<uc:WaitingMessage ID="WaitingMessage1" runat="server" />

<div class="preHeader">
	<div class="container">
        <ul id="headernavmenu">
            <li><uc:LoginMenu ID="LoginMenu1" ShowUserName="False" runat="server" /></li>
            <li><asp:HyperLink ID="lnkMyAccount" CssClass="lnkAccount" runat="server" NavigateUrl="~/MyAccount_Orders.aspx" /></li>
            <li><asp:HyperLink ID="lnkContactUs" CssClass="lnkService" runat="server" NavigateUrl="~/ContactUs.aspx" /></li>
        </ul>
    </div>
</div>

<div id="header" class="clearfix">
	
	<div class="container">
        <asp:HyperLink ID="lnkStoreName" runat="server" NavigateUrl="~/" cssclass="logo"></asp:HyperLink>
        
        <div class="phone">
        	Call 1-800-777-1234
        </div>
        
        <div id="minicart">
            <asp:HyperLink ID="lnkCart" CssClass="lnkCart" runat="server" NavigateUrl="~/Cart.aspx" />
            <uc:CartTotals ID="CartTotals1" runat="server" />
        </div>
        <div id="headercategorymenu">
        	<div class="nav">
        		<uc:MainMenu ID="MainMenu1" LinksPerRow="7" MaximumLinks="7" runat="server" />
            </div>
            <div class="search">
        		<uc:Search runat="server" />
            </div>
        </div>
    </div>
</div>