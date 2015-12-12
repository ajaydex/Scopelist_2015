<%@ Page Title="Category" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Scopelist_Grid_with_Subs_Category" %>

<%@ Register Src="~/BVModules/Controls/CategorySortOrder.ascx" TagName="CategorySortOrder"
    TagPrefix="uc4" %>
<%@ Register Src="~/BVModules/Controls/Pager.ascx" TagName="Pager" TagPrefix="uc3" %>
<%@ Register Src="~/BVModules/Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="uc1" %>
<%@ Register Src="~/BVModules/Controls/Search.ascx" TagName="Search" TagPrefix="uc17" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <style type="text/css">
        h2
        {
            background: none !important;
        }
    </style>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery("#subheading").addClass("subheadingstyles");
            jQuery('.nav-toggle').click(function () {
                //get collapse content selector
                var collapse_content_selector = jQuery(this).attr('rel');

                //make the collapse content to be shown or hide
                var toggle_switch = jQuery(this);
                jQuery(collapse_content_selector).toggle(function () {
                    if (jQuery(this).css('display') == 'none') {
                        toggle_switch.val('+Read More'); //change the button label to be 'Show'
                    } else {
                        toggle_switch.val('- Hide'); //change the button label to be 'Hide'
                    }
                });
            });
        });
    </script>
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
        <asp:Image runat="server" ID="BannerImage" />
    </div>
    <span id="spantitle" class="h2WithoutBackground">
        <asp:Literal ID="DescriptionLiteral" runat="server"></asp:Literal>
    </span>
    <div runat="server" id="ShowHideButton">
        <input type="button" class="nav-toggle" rel="#collapse1" value="+ Read More" />
    </div>
    <span id="collapse1" style="display: none">
        <asp:Literal ID="DescriptionLiteralHidden" runat="server"></asp:Literal>
    </span>
    <br />
    <h3 runat="server" id="header4">
        <asp:Label runat="server" ID="lblCategoriesTitle"></asp:Label></h3>
    <ul class="three-column">
        <asp:DataList ID="DataList2" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
            DataKeyField="bvin" Width="100%">
            <ItemTemplate>
                <li><a id="recordnameanchor" runat="server" href=""></a>
                    <div class="recordChildren">
                        <asp:Literal runat="server" ID="litRecord" EnableViewState="false"></asp:Literal>
                    </div>
                </li>
            </ItemTemplate>
        </asp:DataList>
    </ul>
    <div id="categorygridtemplate" runat="server">
        <asp:Literal ID="startH2" runat="server" Text="<h2 id='subheading'>" Visible="false"></asp:Literal>
        <asp:Label ID="lblTitle3" runat="Server"></asp:Label>
        <asp:Literal ID="endH2" runat="server" Text="</h2>" Visible="false"></asp:Literal>
        <uc4:CategorySortOrder ID="CategorySortOrder1" runat="server" />
        <uc3:Pager ID="Pager1" runat="server" />
        <asp:DataList ID="DataList1" runat="server" RepeatColumns="1" RepeatDirection="Horizontal"
            DataKeyField="bvin" Width="100%">
            <ItemTemplate>
                <div class="list-view">
                    <div class="product-block float-l margin-rt">
                        <a id="recordimageanchor" runat="server" href="">
                            <img id="ProductImage" runat="server" border="0" src="" alt="" /></a>
                    </div>
                    <br />
                    <asp:Label CssClass="stock" runat="server" ID="lblStockStatusList"></asp:Label>
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
                        <br />
                        <strong><a id="recordsubtitleanchor" runat="server" href="" style="text-decoration: none;">
                        </a>&nbsp;&nbsp;<a id="recordmpnanchor" runat="server" href="" style="color: #000000"></a></strong>
                        <br />
                        <strong>
                            <asp:Literal ID="reviewtitlefield" runat="server" Text=""></asp:Literal>
                        </strong>
                        <br />
                        <asp:Literal ID="ProductTypeChoice" runat="server"></asp:Literal>
                        <br />
                        <asp:Literal ID="recordshortdescriptionfield2" runat="server"></asp:Literal>
                    </div>
                    <div class="clr">
                    </div>
                    <div class="price-button-block">
                        <span class="float-l">Your Price: <span class="price">
                            <asp:Literal ID="ltlPrice" runat="server"></asp:Literal>
                        </span></span><span class="float-r">
                            <asp:HyperLink ID="lnkAddToCart" runat="server">                                          
                            </asp:HyperLink>
                        </span>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <uc3:Pager ID="Pager2" runat="server" />
    </div>
    <uc1:ContentColumnControl ID="PostContentColumn" runat="server" />
    <div class="productwrapbtm">
    </div>
    </div>
</asp:Content>
