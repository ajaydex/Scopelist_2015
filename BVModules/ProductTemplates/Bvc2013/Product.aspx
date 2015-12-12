<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Product.aspx.vb" Inherits="BVModules_ProductTemplates_Bvc2013_Product" Title="Product Details" %>
<%@ Register Src="~/BVModules/Controls/OutOfStockDisplay.ascx" TagName="OutOfStockDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductMainImage.ascx" TagName="ProductMainImage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductTypeDisplay.ascx" TagName="ProductTypeDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/VolumeDiscounts.ascx" TagName="VolumeDiscounts" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddToCartButton.ascx" TagName="AddToCartButton" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddToWishlist.ascx" TagName="AddToWishlist" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/VariantsDisplay.ascx" TagName="VariantsDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/SuggestedItems.ascx" TagName="SuggestedItems" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/EmailThisPage.ascx" TagName="EmailThisPage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AdditionalImages.ascx" TagName="AdditionalImages" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/SingleProductDisplay.ascx" TagName="SingleProductDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/CrossSellDisplay.ascx" TagName="CrossSellDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductReviewDisplayInline.ascx" TagName="ProductReviewDisplayInline" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductRatingDisplay.ascx" TagName="ProductRatingDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/PrintThisPage.ascx" TagName="PrintThisPage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddThis.ascx" TagName="AddThis" TagPrefix="uc" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div itemscope itemtype="http://schema.org/WebPage">
        <uc:CategoryBreadCrumbTrail ID="CategoryBreadCrumbTrail1" IncludeHomepage="True" IncludeProductName="True" runat="server" />
    
        <div id="bvc2013productpage" itemscope itemtype="http://schema.org/Product">
            <meta itemprop="brand" id="metaBrand" runat="server"/>
            <meta itemprop="manufacturer" id="metaManufacturer" runat="server"/>
            <!--<meta itemprop="ItemCondition" content="NewCondition"/>-->
            
        	<h1><anthem:Label ID="lblName" itemprop="name" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label></h1>
            
        	<div class="clearfix">
                <div id="SocialSharing">
                    <uc:AddThis ID="AddThis" runat="server" />
                </div>
                <div id="ProductSKU">
                    <span class="ProductPropertyLabel">
                        <asp:Label ID="lblSKUTitle" runat="server" CssClass="ProductPropertyLabel">SKU:</asp:Label>
                    </span>
                    <anthem:Label ID="lblSku" itemprop="productID" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>
                </div>
                <div id="rating">
                    <uc:ProductRatingDisplay ID="ProductRatingDisplay" runat="server" />
                </div>
            </div>
                
            <hr class="pad20" />
                
            <div class="clearfix">
                <div id="imagecolumn" class="col2">
                    <div id="productimage">                
                        <uc:ProductMainImage ID="ProductMainImage1" runat="server" />
                        <uc:AdditionalImages ID="AdditionalImages" runat="server" />                
                    </div>
                    <div class="clearfix printMail">
                        <span>
                            <uc:EmailThisPage ID="EmailThisPage1" runat="server" />
                        </span>
                        <span>
                            <uc:PrintThisPage ID="PrintThisPage2" runat="server" />
                        </span>
                    </div>
                    <hr class="pad10" />
                </div>
                    
                <div id="contentcolumn" class="col4 last">
                    <uc:ContentColumnControl ID="PreContentColumn" runat="server" />
                        
                    <asp:ValidationSummary ID="valSummary" runat="server" CssClass="errormessage" ForeColor=" " EnableClientScript="True" DisplayMode="BulletList" ShowSummary="True"></asp:ValidationSummary>

                    <uc:OutOfStockDisplay ID="OutOfStockDisplay1" runat="server" />
                        
                    <div class="clearfix">
                        <div class="pricebox">
                            <div style="padding:20px;">
                                <anthem:Panel ID="pnlPrices" runat="server">
                                    <div id="Prices" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                                        <meta itemprop="priceCurrency" id="metaPriceCurrency" runat="server" />
                                        <meta itemprop="availability" id="metaAvailability" runat="server" />
                                        <table cellspacing="0" cellpadding="0">
                                            <tr id="trListPrice" runat="server">
                                                <td align="right">
                                                    <b><asp:Label ID="lblListPriceName" runat="server" CssClass="ProductPropertyLabel">List Price</asp:Label></b></td>
                                                <td>
                                                    <anthem:Label ID="lblListPrice" runat="server" CssClass="ListPrice" Text="$x.xx" AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                                            </tr>
                                            <tr class="yourPrice">
                                                <td align="right">
                                                    <b><asp:Label ID="lblSitePriceName" runat="server" CssClass="ProductPropertyLabel">Your Price</asp:Label></b></td>
                                                <td>
                                                    <anthem:Label ID="lblSitePrice" itemprop="price" runat="server" CssClass="SitePrice" Text="$x.xx" AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                                            </tr>
                                            <tr id="trSalePrice" class="salePrice" runat="server">
                                                <td align="right">
                                                    <b><asp:Label ID="lblSalePriceName" runat="server" CssClass="ProductPropertyLabel">Sale Price</asp:Label></b></td>
                                                <td>
                                                    <anthem:Label ID="lblSalePrice" itemprop="price" runat="server" CssClass="SalePrice" Text="$x.xx" AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                                            </tr>
                                            <tr id="trYouSave" class="youSave" runat="server">
                                                <td align="right"></td>
                                                <td>
                                                    <asp:Label ID="lblYouSaveLabel" runat="server" CssClass="ProductPropertyLabel">You Save</asp:Label> <anthem:Label ID="lblYouSave" runat="server" CssClass="YouSave" Text="$x.xx" AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                                            </tr>
                                        </table>
                                    </div>
                                </anthem:Panel>
                                    
                                <div id="ProductControls">
                                    <div id="ProductOptions">
                                        <uc:VariantsDisplay ID="VariantsDisplay" runat="server" />                    
                                    </div>
                                    
                                    <uc:VolumeDiscounts ID="VolumeDiscounts1" runat="server" />
                                        
                                    <anthem:Panel ID="InvalidChoiceCombinationPanel" runat="server">
                                        <ul class="errormessage">
                                            <li><asp:Label ID="lblProductCombinationInvalid" runat="server">This combination of options is not valid. Please select a different combination of options.</asp:Label></li>
                                        </ul>
                                    </anthem:Panel>

                                    <anthem:Panel ID="ProductControlsPanel" runat="server">
                                        <table cellspacing="0" cellpadding="0" class="quantityTable">
                                            <tr id="trQuantity" runat="server">
                                                <td>
                                                    <b><asp:Label ID="lblQuantity" runat="server" CssClass="ProductPropertyLabel">Quantity</asp:Label></b>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="QuantityField" TabIndex="5000" runat="server" CssClass="FormInput" Columns="5" MaxLength="4">1</asp:TextBox>
                                                </td>
                                                <td>
                                                    <bvc5:BVRequiredFieldValidator ID="valQty" runat="server" CssClass="errormessage" ForeColor=" " Display="Dynamic" ControlToValidate="QuantityField" EnableClientScript="True" ErrorMessage="Please Enter A Quantity">*</bvc5:BVRequiredFieldValidator>
                                                    <bvc5:BVRegularExpressionValidator ID="val2Qty" runat="server" CssClass="errormessage" ForeColor=" " Display="Dynamic" ControlToValidate="QuantityField" EnableClientScript="True" ErrorMessage="Quantity Must be between 1 and 9999" ValidationExpression="\d+|\d+\d+|\d+\d+\d+|\d+\d+\d+\d+"></bvc5:BVRegularExpressionValidator>
                                                </td>
                                            </tr>
                                        </table>
                                        <table border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td align="left" valign="top">
                                                    <uc:AddToCartButton ID="AddToCartButton1" runat="server" />
                                                    <uc:AddToWishlist ID="AddToWishlist1" runat="server" />                      
                                                </td>
                                                <td id="tdWishList" runat="server" align="left" valign="top">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <anthem:Label ID="ItemAddedToCartLabel" CssClass="AddedToCartMessage" runat="server" Text="Item has been added to cart." Visible="False" AutoUpdateAfterCallBack="true"></anthem:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </anthem:Panel>
                                </div> 
                            </div>
                        </div>
                            
                        <div id="ProductDescription">
                            <anthem:Label ID="lblDescription" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>
                                
                            <%-- Type Properties --%>
                            <div id="ProductTypes">
                                <uc:ProductTypeDisplay ID="ProductTypeDisplay1" runat="server"></uc:ProductTypeDisplay>                
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <hr />
            
            <%-- RECOMMENDED PRODUCTS --%>
            <uc:CrossSellDisplay ID="CrossSellDisplay" runat="server" DisplayDescriptions="true" RepeatColumns="5" RepeatDirection="Horizontal" RepeatLayout="Table" DisplayAddToCartButton="False" />
            
            <%-- Customers who purchased this item also purchased these items --%>
            <uc:SuggestedItems ID="SuggestedItems1" runat="server" />
            
            <hr />
            
            <uc:ProductReviewDisplayInline ID="ProductReviewDisplayInline2" runat="server" />
        </div>
        
        <uc:ContentColumnControl ID="PostContentColumn" runat="server" />
    </div>
</asp:Content>