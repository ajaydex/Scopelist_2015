<%@ Page Title="Category" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Scopelist_Grid_with_Subs_New_Category" %>

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
        
        #spantitle > img
        {
            width: auto !important;
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
    <%--<h3 runat="server" id="header4">
        <asp:Label runat="server" ID="lblCategoriesTitle"></asp:Label></h3>--%>
    <div class="heading-h2">
        <asp:Literal ID="ltlSubHeadingStart" runat="server" Visible="false" Text="<h1>"></asp:Literal>
        <asp:Label ID="lblSubCategoriesHeading" runat="Server" CssClass="h1font" Visible="false"></asp:Label>
        <asp:Literal ID="ltlSubHeadingEnd" runat="server" Visible="false" Text="</h1>"></asp:Literal>
    </div>
    <ul class="three-column category_list">
        <asp:DataList ID="DataList2" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
            DataKeyField="bvin" Width="100%">
            <ItemTemplate>
                <li><a id="recordnameanchor" runat="server" href="">
                    <asp:Literal runat="server" ID="litRecord" EnableViewState="false"></asp:Literal>
                </a>
                    <div class="recordChildren">
                    </div>
                </li>
            </ItemTemplate>
        </asp:DataList>
    </ul>
    <uc1:ContentColumnControl ID="PostContentColumn" runat="server" />
    <div class="productwrapbtm">
    </div>
</asp:Content>
