<%@ Page Title="Category" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Scopelist_Reticle_Grid_with_Subs_Category" %>

<%@ Register Src="~/BVModules/Controls/CategorySortOrder.ascx" TagName="CategorySortOrder"
    TagPrefix="uc4" %>
<%@ Register Src="~/BVModules/Controls/Pager.ascx" TagName="Pager" TagPrefix="uc3" %>
<%@ Register Src="~/BVModules/Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="uc1" %>
<%@ Register Src="~/BVModules/Controls/Search.ascx" TagName="Search" TagPrefix="uc17" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div class="breadcrumb">
        <uc2:CategoryBreadCrumbTrail ID="CategoryBreadCrumbTrail1" IncludeHomepage="True"
            IncludeProductName="True" runat="server" />
    </div>
    <div class="heading-h2">
        <asp:Literal ID="startH1" runat="server" Visible="false" Text="<h1>"></asp:Literal>
        <asp:Label ID="lblTitle" runat="Server" CssClass="h1font"></asp:Label>
        <asp:Literal ID="endH1" runat="server" Visible="false" Text="</h1>"></asp:Literal>
    </div>
    <uc1:ContentColumnControl ID="PreContentColumn" runat="server" />
    <div id="categorybanner">
        <asp:Image runat="server" ID="BannerImage" /></div>
    <asp:Literal ID="DescriptionLiteral" runat="server"></asp:Literal>
    <asp:DataList ID="DataList2" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
        DataKeyField="bvin" CssClass="grid-view">
        <ItemTemplate>
            <div class="scroller" style="text-align: center;">
                <a id="recordimageanchor" runat="server" href="">
                    <img id="recordimageimg" runat="server" src="" border="0" alt="" />
                </a>
            </div>
            <div class="info">
                <p>
                    <a id="recordnameanchor" runat="server" href=""></a>
                </p>
            </div>
            <div class="recordChildren">
                <asp:Literal runat="server" ID="litRecord" EnableViewState="false"></asp:Literal>
            </div>
            </li>
        </ItemTemplate>
    </asp:DataList>
    <asp:Literal ID="startH2" runat="server" Text="<h2>" Visible="false"></asp:Literal>
    <asp:Label ID="lblTitle2" runat="Server"></asp:Label>
    <asp:Literal ID="endH2" runat="server" Text="</h2>" Visible="false"></asp:Literal>
    <uc4:CategorySortOrder ID="CategorySortOrder1" runat="server" />
    <uc3:Pager ID="Pager1" runat="server" />
    <asp:DataList ID="DataList1" runat="server" RepeatColumns="1" RepeatDirection="Horizontal"
        DataKeyField="bvin" Width="100%">
        <ItemTemplate>
            <div class="list-view">
                <div class="product-block float-l margin-rt">
                    <a id="ImageAnchor" runat="server" href="">
                        <img id="ProductImage" runat="server" border="0" src="" alt="" /></a>
                </div>
                <div class="extra-pic">
                    <asp:Literal ID="recordshortdescriptionfield" runat="server"></asp:Literal>
                </div>
                <div class="list-desc">
                    <h3>
                        <a id="NameAnchor" runat="server" href=""></a>
                    </h3>
                    <strong><a id="SkuAnchor" runat="server" href=""></a></strong>
                    <asp:Literal ID="ProductTypeChoice" runat="server"></asp:Literal>
                </div>
                <div class="clr">
                </div>
                <div class="price-button-block">
                    <span class="float-l">Your Price: <span class="price">
                        <asp:Literal ID="ltlPrice" runat="server"></asp:Literal>
                    </span></span><span class="float-r">
                        <asp:ImageButton ID="AddToCartImageButton" runat="server" CommandName="AddToCart"
                            AlternateText="Add to Cart" CommandArgument='<%# Eval("bvin") %>' ToolTip="Add To Cart"
                            ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/add-to-cart-normal.png" />
                        <asp:ImageButton ID="DetailsImageButton" runat="server" Visible="false" ToolTip="View Details"
                            AlternateText="View Details" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-view-detail.png" />
                    </span>
                </div>
            </div>
            <p id="addedtocart" runat="server" visible="false" class="AddedToCartMessage">
            </p>
        </ItemTemplate>
        <AlternatingItemStyle CssClass="alt" />
    </asp:DataList>
    <uc3:Pager ID="Pager2" runat="server" />
    <uc1:ContentColumnControl ID="PostContentColumn" runat="server" />
</asp:Content>
