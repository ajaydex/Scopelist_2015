<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Header.ascx.vb" Inherits="BVModules_Themes_OpticAuthority_Header" %>
<%@ Register Src="~/BVModules/Controls/WaitingMessage.ascx" TagName="WaitingMessage"
    TagPrefix="uc4" %>
<%@ Register Src="~/BVModules/Controls/CartTotals.ascx" TagName="CartTotals" TagPrefix="uc3" %>
<%@ Register Src="~/BVModules/Controls/LoginMenu.ascx" TagName="LoginMenu" TagPrefix="uc2" %>
<%@ Register Src="~/BVModules/Controls/MainMenu.ascx" TagName="MainMenu" TagPrefix="uc1" %>
<%@ Register Src="~/BVModules/Controls/Search.ascx" TagName="Search" TagPrefix="uc4" %>
<%--<meta name="google-site-verification" content="zyl72deu8uljv4NixccSpjp9awyfHUBQmKVzWrvUd-s" />--%>
<!-- START OF HEADER -->
<!--LOGO PANEL START -->
<div class="header">
    <div class="top">
        <div class="logo">
            <asp:HyperLink ID="lnkStoreName" runat="server" Text="Print Book" NavigateUrl="~/Default.aspx"
                CssClass="logo" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/logo.jpg"
                ToolTip="logo"></asp:HyperLink>
        </div>
        <div class="search">
            <uc4:Search ID="SearchPanel" runat="server" />
        </div>
        <div class="request-price">
            <a href="#">
                <asp:ImageButton ID="imgRequestPrice" runat="server" PostBackUrl="~/contactus.aspx"
                    ImageUrl="~/front/request-price.jpg" AlternateText="Request a Price" />
            </a>
        </div>
        <div class="clr">
        </div>
    </div>
    <div class="menu-block">
        <uc1:MainMenu ID="MainMenu1" runat="server" LinksPerRow="7" MaximumLinks="7" />
        <div class="sub-menu">
            <div class="sub-menu-inner">
                <ul>
                    <li>
                        <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Default.aspx" /></li>
                    <li>
                        <asp:HyperLink ID="lnkMyAccount" runat="server" NavigateUrl="~/MyAccount_Orders.aspx" /></li>
                    <li>
                        <asp:HyperLink ID="lnkContactUs" runat="server" NavigateUrl="~/ContactUs.aspx" /></li>
                    <li>
                        <asp:HyperLink ID="lnkAboutUs" runat="server" NavigateUrl="/about-us.aspx" Text="About Us" />
                    </li>
                    <li>
                        <asp:HyperLink ID="lnkSearch" runat="server" NavigateUrl="~/search.aspx" Text="Search" /></li>
                    <li class="signin-sign-up-item">
                        <uc2:LoginMenu ID="LoginMenu1" ShowUserName="True" runat="server" />
                    </li>
                </ul>
                <div class="submenu-right">
                    <uc3:CartTotals ID="CartTotals1" runat="server" />
                    <asp:Literal ID="ltlWelcome" runat="server" Text="Welcome " Visible="false"></asp:Literal>
                    <asp:HyperLink ID="lnkUsername" runat="server" NavigateUrl="~/MyAccount_Orders.aspx"></asp:HyperLink>
                    <div class="clr">
                    </div>
                </div>
                <div class="clr">
                </div>
            </div>
        </div>
    </div>
    <!-- End of Header -->
    <uc4:WaitingMessage ID="WaitingMessage1" runat="server" />
</div>
