<%@ Page Title="Category" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Scopelist_Reticle_Detailed_List1_Category" %>

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
    <asp:Literal ID="startH2" runat="server" Text="<h2>" Visible="false"></asp:Literal>
    <asp:Label ID="lblTitle2" runat="Server"></asp:Label>
    <asp:Literal ID="endH2" runat="server" Text="</h2>" Visible="false"></asp:Literal>
    <uc4:CategorySortOrder ID="CategorySortOrder1" runat="server" />
    <uc3:Pager ID="Pager1" runat="server" />
    <asp:DataList ID="DataList1" runat="server" RepeatColumns="1" DataKeyField="bvin"
        EnableViewState="false" RepeatLayout="flow">
        <ItemTemplate>
            <div class="list-view">
                <div class="product-block float-l margin-rt">
                    <a id="recordimageanchor" runat="server" href="">
                        <img id="recordimage" runat="server" src="" alt="" />
                    </a>
                </div>
                <div class="extra-pic">
                    <a id="recorddescriptionanchor" runat="server" href="">
                        <asp:Literal ID="recordshortdescriptionfield" runat="server" Text=""></asp:Literal>
                    </a>
                    <ul class="pdf">
                        <asp:Literal ID="recordshortdescriptionfield3" runat="server"></asp:Literal>
                    </ul>
                </div>
                <div class="list-desc">
                    <h3>
                        <a id="recordnameanchor" runat="server" href=""></a>
                    </h3>
                    <strong><a id="recordsubtitleanchor" runat="server" href="" style="text-decoration: none;">
                    </a>
                        <br />
                        <a id="recordmpnanchor" runat="server" href="" style="color: #000000"></a></strong>
                    <br />
                    <strong>
                        <asp:Literal ID="reviewtitlefield" runat="server" Text=""></asp:Literal>
                    </strong>
                    <asp:Literal ID="ProductTypeChoice" runat="server"></asp:Literal>
                    <asp:Literal ID="recordshortdescriptionfield2" runat="server"></asp:Literal>
                </div>
                <div class="clr">
                </div>
                <div class="price-button-block">
                    <span class="float-l">Your Price: <span class="price">
                        <asp:Literal ID="ltlPrice" runat="server"></asp:Literal>
                    </span></span><span class="float-r">
                        <asp:ImageButton ID="AddToCartImageButton" runat="server" CommandName="AddToCart"
                            ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/add-to-cart-normal.png"
                            ToolTip="Add To Cart" />
                        <asp:ImageButton ID="DetailsImageButton" runat="server" Visible="false" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-view-detail.png"
                            ToolTip="View Details" />
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
