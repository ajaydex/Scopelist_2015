<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Header.ascx.vb" Inherits="BVModules_Themes_Bvc5_Header" %>
<%@ Register Src="~/BVModules/Controls/WaitingMessage.ascx" TagName="WaitingMessage" TagPrefix="uc4" %>
<%@ Register Src="../../Controls/CartTotals.ascx" TagName="CartTotals" TagPrefix="uc3" %>
<%@ Register Src="../../Controls/LoginMenu.ascx" TagName="LoginMenu" TagPrefix="uc2" %>
<%@ Register Src="../../Controls/MainMenu.ascx" TagName="MainMenu" TagPrefix="uc1" %>
<div id="header">
    <div>
        <div id="headernavmenu">
            <ul>
                <li>
                    <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Default.aspx" TabIndex="20" /></li>
                <li>
                    <uc2:LoginMenu ID="LoginMenu1" showUserName="True" runat="server" TabIndex="21" />
                </li>
                <li>
                    <asp:HyperLink ID="lnkMyAccount" runat="server" NavigateUrl="~/MyAccount_Orders.aspx" TabIndex="30" />
                </li>
                <li>
                    <asp:HyperLink ID="lnkContactUs" runat="server" NavigateUrl="~/ContactUs.aspx" TabIndex="31"/>
                </li>
                <li>
                    <asp:HyperLink ID="lnkSearch" runat="server" NavigateUrl="~/Search.aspx"  TabIndex="32" /></li>
                <li>
                    <asp:HyperLink ID="lnkCart" runat="server" NavigateUrl="~/Cart.aspx" TabIndex="33" /><br />
                    <uc3:CartTotals ID="CartTotals1" runat="server"/>
                </li>
            </ul>
        </div>
    </div>
    <div id="headermainmenu">
        <uc1:MainMenu ID="MainMenu1" LinksPerRow="7" MaximumLinks="14" runat="server" TabIndex="34" />
    </div>
    <uc4:WaitingMessage ID="WaitingMessage1" runat="server" />        
</div>
