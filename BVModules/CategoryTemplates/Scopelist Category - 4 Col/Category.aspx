﻿<%@ Page Title="Category" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Scopelist_Category___4_Col_category" %>

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
        ul.product_list li a p
        {
            color: #000;
            text-align: center;
            padding-bottom: 5px;
        }
        
        h2
        {
            background: none !important;
        }
        
        .landing_product_f
        {
            width: 950px;
            display: block;
            clear: both;
            overflow: hidden;
            text-align: left !important;
        }
        .landing_product_f li img
        {
            width: 88%;
            display: block;
        }
        .landing_product_f li
        {
            width: 204px;
            min-height: 280px !important;
            display: inline-block;
            margin: 6px;
            border: 1px solid #e1dfd6;
            background-color: #fff;
        }
        .landing_product_f li span
        {
            width: auto;
            display: block;
            background-color: #f2f2f2;
            padding: 10px;
            font-size: 14px;
            line-height: 18px;
            color: #515044;
        }
        .landing_product_f li span em
        {
            font-style: normal;
            color: #c02400;
            background-color: transparent;
        }
        .footer_panel
        {
            background-color: #393833;
            padding: 20px 0;
        }
        .big-column
        {
            width: 100% !important;
        }
        .left-block
        {
            display: none;
        }
        .landing_product_f li
        {
            background: none !important;
            min-height: 270px;
            padding: 8px !important;
        }
        .landing_product_f li img
        {
            height: 155px; /*margin: 20px;*/
            width: 190px;
            margin: 0 auto;
        }
        .landing_product_f li a strong
        {
            padding-bottom: 10px;
            margin-bottom: 4px;
        }
        .landing_product_f li a p
        {
            color: #000 !important;
            padding-bottom: 5px;
            border-bottom: 1px dotted #393e40;
        }
        .fath-cate-logo-mark
        {
            display: block;
            clear: both;
            overflow: hidden;
        }
        .fath-cate-logo-mark span.left
        {
            float: left;
            background: none;
        }
        .fath-cate-logo-mark span.right
        {
            float: right;
            background: none;
        }
        .fath-cate-logo-mark img
        {
            width: 100% !important;
            height: auto !important;
            clear: both;
            cursor: pointer;
        }
        
        .landing_product_f li span
        {
            background-color: none !important;
            color: #515044;
            display: block;
            font-size: 14px;
            line-height: 18px;
            padding: 5px;
            vertical-align: bottom;
            width: auto;
        }
        .mao-view
        {
            display: block;
            overflow: hidden;
            padding-top: 7px;
        }
        .mao-view a
        {
            text-align: center;
            background: #a4a19c;
            line-height: 20px;
            color: #fff;
            line-height: 25px;
            padding: 0 8px;
            float: right;
        }
        .mao-view p
        {
            float: left;
            font-size: 18px;
            color: #cc0000;
            display: block;
            line-height: 22px;
            padding-bottom: 0;
        }
        .landing_product_f .mao-view a:hover
        {
            background: #cc0022;
            color: #fff !important;
        }
        .clearfix
        {
            clear: both;
            display: block;
        }
        
        a.customButton
        {
            background: #BC1122 url(/BVAdmin/Images/edit-icon.png) no-repeat center center;
            color: #fff;
            text-decoration: none;
            padding: 5px 10px;
            -webkit-border-radius: 0 0 5px 5px;
            -moz-border-radius: 0 0 5px 5px;
            border-radius: 0 0 5px 5px;
            vertical-align: middle;
            display: inline-block;
            position: absolute;
            top: 0;
            right: 10px;
            opacity: .8;
            font-weight: bold;
            text-indent: -999px;
            width: 15px;
            overflow: hidden;
        }
        a.customButton:hover
        {
            opacity: 1;
        }
        
        .postContentColumn, .preContentColumn
        {
            position: relative;
        }
        
        
        ul.category_list li
        {
            border: 1px solid #dddcda;
            margin-left: 8px;
            padding-bottom: 10px !important;
            padding: 5px !important;
            width: 210px !important;
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
    <h1>
        <span>
            <asp:Label ID="lblTitle" runat="Server"></asp:Label>
        </span>
    </h1>
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
    <div class="heading-h2">
        <asp:Literal ID="ltlSubHeadingStart" runat="server" Visible="false" Text="<h1>"></asp:Literal>
        <asp:Label ID="lblSubCategoriesHeading" runat="Server" CssClass="h1font" Visible="false"></asp:Label>
        <asp:Literal ID="ltlSubHeadingEnd" runat="server" Visible="false" Text="</h1>"></asp:Literal>
    </div>
    <ul class="three-column category_list">
        <asp:DataList ID="DataList2" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
            DataKeyField="bvin" Width="100%">
            <ItemTemplate>
                <li>
                    <asp:Image runat="server" ID="imgCategoryLogo" align="right" Width="42" Height="42" />
                    <a id="recordnameanchor" runat="server" class="CatImageLink"><a id="CatTitle" runat="server"
                        class="CatName" /></a>
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
