<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Header.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_Header" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="LoginMenu.ascx" TagName="LoginMenu" TagPrefix="uc" %>
<%@ Register Src="Search.ascx" TagName="Search" TagPrefix="uc" %>
<%@ Register Src="CartTotals.ascx" TagName="CartTotals" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail" TagPrefix="uc" %>

<div class="preheader">
    <div class="row ">
	    <div class="large-12 columns">
        	<asp:HyperLink ID="lnkStoreName2" runat="server" CssClass="logo hideforhighres" />
    	    <ul id="headernavmenu" class="clearfix smallText">
                <li><uc:LoginMenu ID="LoginMenu1" ShowUserName="False" runat="server" /></li>
                <li><asp:HyperLink ID="lnkMyAccount" CssClass="lnkAccount" NavigateUrl="~/MyAccount_Orders.aspx" EnableViewState="false" runat="server" /></li>
                <li><asp:HyperLink ID="lnkContactUs" CssClass="lnkService" NavigateUrl="~/ContactUs.aspx" EnableViewState="false" runat="server" /></li>
                <li><asp:Hyperlink ID="lnkWishlist" NavigateUrl="~/MyAccount_WishList.aspx" EnableViewState="false" runat="server" /></li>
                <li>
                    <span class="minicart">
                        <uc:CartTotals ID="CartTotals1" runat="server" />
                    </span>
                </li>
            </ul>
        </div>
    </div>
</div>

<div class="header">
    <div class="row">
	    <div class="large-3 columns hideforlowres">
    	    <asp:HyperLink ID="lnkStoreName" runat="server" CssClass="logo" />
        </div>
        
        <div class="large-4 columns">
            <uc:Search runat="server" />
        </div>

        <div class="large-5 columns text-right">
            <span class="phone">
                <i class="fa fa-phone-square"></i> <strong><%= BVSoftware.BVC5.Core.WebAppSettings.SiteShippingAddress.Phone%></strong>
                <span class="hideforlowres">
                    <a class="webicon facebook small" href="#">Facebook</a>
                    <a class="webicon twitter small" href="#">Twitter</a>
                    <a class="webicon pinterest small" href="#">Pinterest</a>
                    <a class="webicon youtube small" href="#">YouTube</a>
                </span>
            </span>
        </div>
    </div>
</div>

<div class="navwrapper">
    <div class="row">
        <div class="large-12 columns">
            <nav class="top-bar">
                <ul class="title-area">
                    <li class="name"></li>
                    <li class="toggle-topbar menu-icon"><a href="#"><span>Menu <i class="fa fa-bars"></i></span></a></li>
                </ul>

                <section class="top-bar-section">
                    <uc:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="Nav" />
                </section>
            </nav>
        </div>
    </div>
</div>

<div class="breadcrumbwrapper">
    <div class="row">
        <div class="large-12 columns">
            <uc:CategoryBreadCrumbTrail ID="CategoryBreadCrumbTrail1" IncludeHomepage="True" IncludeProductName="True" runat="server" />
        </div>
    </div>
</div>