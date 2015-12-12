<%@ Page Title="Category" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Scopelist_Detailed_List_Category" %>

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
    <asp:Literal ID="startH2" runat="server" Visible="false" Text="<h2>"></asp:Literal>
    <asp:Label ID="lblTitle2" runat="Server"></asp:Label>
    <asp:Literal ID="endH2" runat="server" Visible="false" Text="</h2>"></asp:Literal>
    <uc4:CategorySortOrder ID="CategorySortOrder1" runat="server" />
    <uc3:Pager ID="Pager1" runat="server" />
    <asp:DataList ID="DataList1" runat="server" RepeatColumns="1" DataKeyField="bvin"
        EnableViewState="false" Width="100%">
        <ItemTemplate>
            <div class="list-view">
                <div class="product-block float-l margin-rt">
                    <a id="recordimageanchor" runat="server" href="">
                        <img id="recordimage" runat="server" src="" alt="" />
                    </a>
                </div>
                <div class="extra-pic">
                    <asp:Literal ID="recordshortdescriptionfield" runat="server" Text=""></asp:Literal>
                </div>
                <div class="list-desc">
                    <h3>
                        <a id="recordnameanchor" runat="server" href="" />
                    </h3>
                    <p>
                        <strong><a id="recordskuanchor" runat="server" href="" style="color: #000000" />
                        </strong>
                        <br />
                        <asp:Literal ID="ProductTypeChoice" runat="server"></asp:Literal>
                        <br />
                    </p>
                </div>
                <div class="clr">
                </div>
                <div class="price-button-block">
                    <span class="float-l">Your Price: <span class="price">
                        <asp:Literal ID="ltlPrice" runat="server"></asp:Literal>
                    </span></span><span class="float-r">
                        <asp:ImageButton ID="DetailsImageButton" runat="server" Visible="false" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-view-detail.png"
                            AlternateText="View Details" ToolTip="View Details" />
                        <asp:ImageButton ID="AddToCartImageButton" runat="server" CommandName="AddToCart"
                            ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/add-to-cart-normal.png"
                            AlternateText="Add To Cart" ToolTip="Add To Cart" />
                    </span>
                </div>
            </div>
            <p id="addedtocart" runat="server" visible="false" class="AddedToCartMessage">
            </p>
        </ItemTemplate>
    </asp:DataList>
    <uc3:Pager ID="Pager2" runat="server" />
    <uc1:ContentColumnControl ID="PostContentColumn" runat="server" />
</asp:Content>
