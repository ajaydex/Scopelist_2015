﻿<%@ Page Title="Product Details" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Product.aspx.vb" Inherits="BVModules_ProductTemplates_Demo_Binoculars_Product" %>

<%@ Register Src="~/BVModules/Controls/DiscontinuedDisplay.ascx" TagName="DiscontinuedDisplay"
    TagPrefix="uc15" %>
<%@ Register Src="../../Controls/ProductMainImage.ascx" TagName="ProductMainImage"
    TagPrefix="uc14" %>
<%@ Register Src="../../Controls/ProductTypeDisplay.ascx" TagName="ProductTypeDisplay"
    TagPrefix="uc13" %>
<%@ Register Src="../../Controls/VolumeDiscounts.ascx" TagName="VolumeDiscounts"
    TagPrefix="uc12" %>
<%@ Register Src="../../Controls/AddToCartButton.ascx" TagName="AddToCartButton"
    TagPrefix="uc11" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc10" %>
<%@ Register Src="../../Controls/AddToWishlist.ascx" TagName="AddToWishlist" TagPrefix="uc9" %>
<%@ Register Src="../../Controls/VariantsDisplay.ascx" TagName="VariantsDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../../Controls/SuggestedItems.ascx" TagName="SuggestedItems" TagPrefix="uc8" %>
<%@ Register Src="../../Controls/EmailThisPage.ascx" TagName="EmailThisPage" TagPrefix="uc7" %>
<%@ Register Src="../../Controls/AdditionalImages.ascx" TagName="AdditionalImages"
    TagPrefix="uc6" %>
<%@ Register Src="../../Controls/SingleProductDisplay.ascx" TagName="SingleProductDisplay"
    TagPrefix="uc5" %>
<%@ Register Src="../../Controls/CrossSellDisplay.ascx" TagName="CrossSellDisplay"
    TagPrefix="uc4" %>
<%@ Register Src="../../Controls/ProductReviewDisplay.ascx" TagName="ProductReviewDisplay"
    TagPrefix="uc3" %>
<%@ Register Src="../../Controls/RelatedItems.ascx" TagName="RelatedItems" TagPrefix="uc2" %>
<%@ Register Src="../../Controls/PrintThisPage.ascx" TagName="PrintThisPage" TagPrefix="uc1" %>
<%@ Register Src="../../Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail"
    TagPrefix="ucc2" %>
<%@ Register Src="../../Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="ucc1" %>
<%@ Register Src="../../Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail"
    TagPrefix="uc22" %>
<%@ Register Src="~/BVModules/Controls/Search.ascx" TagName="Search" TagPrefix="uc17" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div id="fb-root">
    </div>
    <script>        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&appId=231924500206605&version=v2.0";
            fjs.parentNode.insertBefore(js, fjs);
        } (document, 'script', 'facebook-jssdk'));</script>
    <style type="text/css">
        .outofstockdisplay
        {
            float: right;
        }
    </style>
    <div class="breadcrumb">
        <ucc2:CategoryBreadCrumbTrail ID="CategoryBreadCrumbTrail1" runat="server" />
        <%--<uc17:Search ID="SearchPanel" runat="server" />--%>
    </div>
    <ucc1:ContentColumnControl ID="PreContentColumn" runat="server" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error_list" />
    <div xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:gr="http://purl.org/goodrelations/v1#"
        xmlns:v="http://rdf.data-vocabulary.org/#" typeof="gr:Offering" id="product_det-blk">
        <meta property="gr:site_name" id="metaSiteName" runat="server" />
        <meta property="gr:type" content="product" />
        <meta property="gr:url" id="metaUrl" runat="server" />
        <div class="prod_action">
            <div style="width: 955px; margin-left: 0px; background-color: #dddddd; padding-left: 4px;
                padding-bottom: 8px; padding-top: 8px;">
                <p style='color: #ff0000; font-size: 150%; font-weight: bold'>
                    Product Is No Longer Available</p>
                <br />
                <p style='text-align: left;'>
                    <asp:Label ID="lblDiscontinued" runat="server" Style="font-weight: bold;" />
                    is no longer available. Please call us at (877) 741-5532 and our knowledgeable staff
                    will help you select an appropriate replacement!</p>
            </div>
            <h1 property="gr:name">
                <anthem:Label ID="lblName2" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label></h1>
            <div class="product-block-small">
                <div class="pic_panel zoom" id="ex1" style="position: relative; overflow: hidden;">
                    <uc14:ProductMainImage ID="ProductMainImage1" runat="server" ImageWidth="303" ImageHeight="213" />
                    <a href="#" class="plus">
                        <img alt="" src="~/BVModules/Themes/Scopelist/ScopelistImages/plus-icon.jpg" class="icon-zoom"
                            runat="server" id="plusIcon" /></a>
                </div>
                <div class="clr">
                </div>
                <div class="social-share">
                    <div class="float-l">
                        <uc6:AdditionalImages ID="AdditionalImages" runat="server" />
                        <uc7:EmailThisPage ID="EmailThisPage1" runat="server" />
                        <uc1:PrintThisPage ID="PrintThisPage2" runat="server" />
                    </div>
                    <div class="clr">
                    </div>
                </div>
            </div>
            <div class="small-product-right">
                <uc8:VariantsDisplay ID="VariantsDisplay" runat="server" />
                <h2 class="normal-h2 lblsubnameproduct">
                    <anthem:Label ID="lblName3" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label></h2>
                <p>
                    <asp:Label ID="lblSKUTitle" runat="server" CssClass="ProductPropertyLabel" Style="min-width: 82px">SKU:</asp:Label>
                    <anthem:Label ID="lblSku" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>
                    <br />
                    <b>
                        <asp:Literal runat="server" ID="lSubtitle"></asp:Literal></b>
                </p>
                <span class="pr_right_blk"><span rel="gr:hasInventoryLevel"><span typeof="gr:QuantitativeValue">
                    <span property="gr:hasMinValue" content="1">
                        <meta content=" Stock is available" />
                    </span></span></span></span>
                <anthem:Panel ID="ProductControlsPanel" runat="server">
                    <anthem:Panel ID="pnlPrices" runat="server" rel="gr:hasPriceSpecification">
                        <div class="price-qty-button">
                            <span typeof="gr:UnitPriceSpecification"><span property="gr:hasCurrencyValue" id="currencyValueForListPrice"
                                runat="server"><span runat="server" id="trListPrice" class="price-qty-button">
                                    <div class="detailpage-price">
                                        <asp:Label ID="lblListPriceName" runat="server">List Price</asp:Label>
                                        <span class="price">
                                            <anthem:Label ID="lblListPrice" runat="server" Text="$x.xx" AutoUpdateAfterCallBack="true">$x.xx</anthem:Label>
                                            <</span>
                                    </div>
                                </span></span><span property="gr:hasCurrencyValue" id="currencyValueForSitePrice"
                                    runat="server"><span class="detailpage-price">
                                        <asp:Label ID="lblSitePriceName" runat="server">Your Price</asp:Label>
                                        <span class="price">
                                            <anthem:Label ID="lblSitePrice" runat="server" Text="$x.xx" AutoUpdateAfterCallBack="true">$x.xx</anthem:Label>
                                        </span></span></span><span property="gr:hasCurrency" content="USD"></span>
                            </span>
                            <uc11:AddToCartButton ID="AddToCartButton1" runat="server" />
                            <uc15:DiscontinuedDisplay ID="OutOfStockDisplay1" runat="server" class="float-r" />
                            <div id="trQuantity" runat="server" class="qty-detailpage float-r">
                                <asp:Label ID="lblQuantity" runat="server" CssClass="ProductPropertyLabel">Qty</asp:Label>
                                <asp:TextBox ID="QuantityField" TabIndex="5000" runat="server" CssClass="qty-field"
                                    Columns="5" MaxLength="4">1</asp:TextBox><bvc5:BVRequiredFieldValidator ID="valQty"
                                        runat="server" CssClass="errormessage" ForeColor=" " Display="None" ControlToValidate="QuantityField"
                                        EnableClientScript="True" ErrorMessage="Please Enter A Quantity">*</bvc5:BVRequiredFieldValidator>
                                <bvc5:BVRegularExpressionValidator ID="val2Qty" runat="server" CssClass="errormessage"
                                    ForeColor=" " Display="None" ControlToValidate="QuantityField" EnableClientScript="True"
                                    ErrorMessage="Quantity Must be between 1 and 9999" ValidationExpression="\d+|\d+\d+|\d+\d+\d+|\d+\d+\d+\d+"></bvc5:BVRegularExpressionValidator>
                            </div>
                            <div class="clr">
                            </div>
                        </div>
                    </anthem:Panel>
                    <div class="share-addwishlist">
                        <script type="text/javascript">                            !function (d, s, id) { var js, fjs = d.getElementsByTagName(s)[0]; if (!d.getElementById(id)) { js = d.createElement(s); js.id = id; js.src = "https://platform.twitter.com/widgets.js"; fjs.parentNode.insertBefore(js, fjs); } } (document, "script", "twitter-wjs");</script>
                        <script language="javascript" type="text/javascript">
                    //<![CDATA[
                            //Place this tag where you want the +1 button to render.
                            var srcUrl = '<%= HTTPUtility.UrlEncode("http://www.scopelist.com" & BVSoftware.Bvc5.Core.Utilities.UrlRewriter.BuildUrlForProduct(LocalProduct, Me, String.Empty)) %>';

                            document.write('<div class="gplusone">');
                            document.write('<div class="g-plusone" data-size="medium"  data-href="' + srcUrl + '">');
                            document.write('</div>');
                            document.write('</div>');

                            document.write('<div class="facebook"> ');

                            var srcurl = '<%= "http://www.facebook.com/plugins/like.php?href=" & HTTPUtility.UrlEncode("http://www.scopelist.com" & BVSoftware.Bvc5.Core.Utilities.UrlRewriter.BuildUrlForProduct(LocalProduct, Me, String.Empty))   & "&amp;layout=button_count&amp;show_faces=false&amp;font=trebuchet ms&amp;width:100px&amp;" %>';
                            document.write('<a href="#">');
                            document.write("<iframe src='" + srcurl + "' scrolling='no' frameborder='0' style='border: none; overflow: hidden; width: 100px; height: 25px;'></iframe>");
                            document.write("</a>");
                            document.write('</div>');

                            var srcUrlForTwitter = '<%= "http://www.scopelist.com" &  BVSoftware.Bvc5.Core.Utilities.UrlRewriter.BuildUrlForProduct(LocalProduct, Me, String.Empty) %>';

                            document.write('<a href="https://twitter.com/share" class="twitter-share-button" data-url="' + srcUrlForTwitter + '" data-via="Scopelist"  data-show-count="true"  data-size="small"');
                            document.write('data-lang="en">Tweet</a>');

                    //]]>
                        </script>
                        <span id="tdWishList" runat="server">
                            <uc9:AddToWishlist ID="AddToWishlist1" runat="server" />
                        </span>
                    </div>
                    <br />
                    <div class="description">
                        <uc13:ProductTypeDisplay ID="ProductTypeDisplay1" runat="server"></uc13:ProductTypeDisplay>
                    </div>
                </anthem:Panel>
                <ul class="cart_link">
                    <li>
                        <asp:Literal ID="AmazonBuyLink" runat="server"></asp:Literal>
                    </li>
                    <li>
                        <anthem:Label ID="ItemAddedToCartLabel" CssClass="AddedToCartMessage" runat="server"
                            Text="Item has been added to cart." Visible="False" AutoUpdateAfterCallBack="true"></anthem:Label>
                    </li>
                </ul>
                <uc12:VolumeDiscounts ID="VolumeDiscounts1" runat="server" />
            </div>
            <div class="clr">
            </div>
            <div runat="server" id="dvfreedombanner" class="freedom_banner">
                <a runat="server" id="lnkReadMore" class="readmore">Make An Offer</a>
            </div>
            <div id="tab_holder">
                <ul class="tabs" property="gr:description">
                    <li>
                        <h3>
                            <a href="#">Product Description</a></h3>
                    </li>
                    <li>
                        <h3>
                            <a class="last" href="#">Customer Review</a></h3>
                    </li>
                </ul>
                <div class="tab_info">
                    <div class="tab">
                        <h3>
                            <anthem:Label ID="lblname1" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>
                        </h3>
                        <anthem:Label ID="lblDescription" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>
                    </div>
                    <div class="tab">
                        <uc3:ProductReviewDisplay ID="ProductReviewDisplay2" runat="server" />
                    </div>
                </div>
                <script type="text/javascript">
                    // perform JavaScript after the document is scriptable.
                    $(function () {
                        // setup ul.tabs to work as tabs for each div directly under div.panes
                        $("ul.tabs").tabs("div.tab_info > div.tab");
                    });
                </script>
            </div>
            <div class="text_panel">
                <uc2:RelatedItems ID="RelatedItems2" runat="server" />
                <uc4:CrossSellDisplay ID="CrossSellDisplay" runat="server" DisplayDescriptions="true"
                    RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Table" DisplayMode="Wide"
                    DisplayAddToCartButton="true" />
                <uc8:SuggestedItems ID="SuggestedItems1" runat="server" />
            </div>
            <ucc1:ContentColumnControl ID="PostContentColumn" runat="server" />
            <br />
            <script language="javascript" type="text/javascript">
            //<![CDATA[

                //            var srcUrl = '<%= "http://www.scopelist.com" & BVSoftware.Bvc5.Core.Utilities.UrlRewriter.BuildUrlForProduct(LocalProduct, Me, String.Empty)%>';

                //            document.write('<div class="fb-comments" data-href="' + srcUrl + '"  data-numposts="5" data-colorscheme="light" data-width="955">');
                //            document.write('</div>');
            //]]>        </script>
        </div>
</asp:Content>
