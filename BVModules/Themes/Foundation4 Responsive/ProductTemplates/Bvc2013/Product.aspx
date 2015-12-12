<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Product.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ProductTemplates_Bvc2013_Responsive_Product" Title="Product Details" %>
<%@ Register Src="~/BVModules/Controls/OutOfStockDisplay.ascx" TagName="OutOfStockDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductMainImage.ascx" TagName="ProductMainImage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductTypeDisplay.ascx" TagName="ProductTypeDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/VolumeDiscounts.ascx" TagName="VolumeDiscounts" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddToCartButton.ascx" TagName="AddToCartButton" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddToWishlist.ascx" TagName="AddToWishlist" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/VariantsDisplay.ascx" TagName="VariantsDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Themes/Foundation4 Responsive/Controls/SuggestedItems.ascx" TagName="SuggestedItems" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/EmailThisPage.ascx" TagName="EmailThisPage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AdditionalImages.ascx" TagName="AdditionalImages" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/SingleProductDisplay.ascx" TagName="SingleProductDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/CrossSellDisplay.ascx" TagName="CrossSellDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/UpSellDisplay.ascx" TagName="UpSellDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductReviewDisplayInline.ascx" TagName="ProductReviewDisplayInline" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductRatingDisplay.ascx" TagName="ProductRatingDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/PrintThisPage.ascx" TagName="PrintThisPage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddThis.ascx" TagName="AddThis" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductNextPrevious.ascx" TagName="NextPrev" TagPrefix="uc" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div itemscope itemtype="http://schema.org/WebPage">
        
        <div id="productpage" itemscope itemtype="http://schema.org/Product">
            <meta itemprop="brand" id="metaBrand" runat="server"/>
            <meta itemprop="manufacturer" id="metaManufacturer" runat="server"/>
            <!--<meta itemprop="ItemCondition" content="NewCondition"/>-->

            <div class="row">
                <div class="large-10 columns">
                    <h1><anthem:Label ID="lblName" itemprop="name" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label></h1>
                </div>
                <div class="large-2 columns hideforlowres">
                    <uc:NextPrev ID="NextPrev" runat="server" />
                </div>
            </div>

            <div class="row">
                <div class="large-6 columns">
                    <div id="ProductSKU" class="smallText">
                        <span class="ProductPropertyLabel">
                            <asp:Label ID="lblSKUTitle" runat="server" CssClass="ProductPropertyLabel">SKU:</asp:Label>
                        </span>
                        <anthem:Label ID="lblSku" itemprop="productID" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>
                    </div>
                    <div id="rating" class="smallText">
                        <uc:ProductRatingDisplay ID="ProductRatingDisplay" runat="server" />
                    </div>
                </div>
                <div class="large-6 columns">
                    <div id="SocialSharing">
                        <uc:AddThis ID="AddThis" runat="server" />
                    </div>
                </div>
                <div class="large-12 columns">
                    <hr class="pad20" />
                </div>
            </div>

            <div class="row">
                <div class="large-6 column">
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
                </div>   
                <div class="large-6 column">
                    <uc:ContentColumnControl ID="PreContentColumn" runat="server" />
                        
                    <asp:ValidationSummary ID="valSummary" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server"  DisplayMode="BulletList" ForeColor="White" ShowSummary="True" HeaderText='<a href="#" class="close">&times;</a>'></asp:ValidationSummary>

                    <uc:OutOfStockDisplay ID="OutOfStockDisplay1" runat="server" />
                    
                    <anthem:Panel ID="pnlPrices" runat="server" cssclass="pricebox" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                        <meta itemprop="priceCurrency" id="metaPriceCurrency" runat="server" />
                        <meta itemprop="availability" id="metaAvailability" runat="server" />
                        <table cellspacing="0" cellpadding="0">
                            <tr id="trListPrice" runat="server">
                                <td class="labelCell">
                                    <b><asp:Label ID="lblListPriceName" runat="server" CssClass="ProductPropertyLabel">List Price</asp:Label></b>
                                </td>
                                <td>
                                    <anthem:Label ID="lblListPrice" runat="server" CssClass="ListPrice" Text="$x.xx" AutoUpdateAfterCallBack="true">$x.xx</anthem:Label>
                                </td>
                            </tr>
                            <tr class="yourPrice">
                                <td class="labelCell">
                                    <b><asp:Label ID="lblSitePriceName" runat="server" CssClass="ProductPropertyLabel">Your Price</asp:Label></b></td>
                                <td>
                                    <anthem:Label ID="lblSitePrice" itemprop="price" runat="server" CssClass="SitePrice" Text="$x.xx" AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                            </tr>
                            <tr id="trYouSave" runat="server">
                                <td class="labelCell">
                                    <b><asp:Label ID="lblYouSaveLabel" runat="server" CssClass="ProductPropertyLabel">You Save</asp:Label></b></td>
                                <td>
                                    <anthem:Label ID="lblYouSave" runat="server" CssClass="YouSave" Text="$x.xx" AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                            </tr>
                        </table>
                    </anthem:Panel>
                   
                    <uc:VariantsDisplay ID="VariantsDisplay" runat="server" />
                   
                    <uc:VolumeDiscounts ID="VolumeDiscounts1" runat="server" />
                                        
                    <anthem:Panel ID="InvalidChoiceCombinationPanel" runat="server">
                        <ul class="errormessage">
                            <li><asp:Label ID="lblProductCombinationInvalid" runat="server">This combination of options is not valid. Please select a different combination of options.</asp:Label></li>
                        </ul>
                    </anthem:Panel>

                    <anthem:Panel ID="ProductControlsPanel" runat="server" CssClass="productcontrolspanel highlight">
                        <table cellspacing="0" cellpadding="0">
                            <tr id="trQuantity" runat="server">
                                <td>
                                    <asp:Label ID="lblQuantity" runat="server" AssociatedControlID="QuantityField">Quantity</asp:Label>
                                    <asp:TextBox ID="QuantityField" TabIndex="5000" runat="server" MaxLength="4" Width="40px">1</asp:TextBox>
                                    <bvc5:BVRequiredFieldValidator ID="valQty" runat="server" Display="Dynamic" ControlToValidate="QuantityField" EnableClientScript="True" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please Enter A Quantity" >*</bvc5:BVRequiredFieldValidator>
                                    <bvc5:BVRegularExpressionValidator ID="val2Qty" runat="server" Display="Dynamic" ControlToValidate="QuantityField" EnableClientScript="True" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Quantity Must be between 1 and 9999" ValidationExpression="\d+|\d+\d+|\d+\d+\d+|\d+\d+\d+\d+"></bvc5:BVRegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc:AddToCartButton ID="AddToCartButton1" runat="server"  />
                                    <div id="tdWishList" runat="server">
                                        <uc:AddToWishlist ID="AddToWishlist1" runat="server" /> 
                                    </div> 
                                            
                                    <anthem:Label ID="ItemAddedToCartLabel" CssClass="AddedToCartMessage" runat="server" Text="Item has been added to cart." Visible="False" AutoUpdateAfterCallBack="true"></anthem:Label> 
                                </td>
                            </tr>
                        </table>
                    </anthem:Panel>
                   
                    <div id="ProductDescription">
                        <anthem:Label ID="lblDescription" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>
                                
                        <%-- Type Properties --%>
                        <div id="ProductTypes">
                            <uc:ProductTypeDisplay ID="ProductTypeDisplay1" runat="server"></uc:ProductTypeDisplay>
                        </div>
                    </div>
                </div> 
            </div>

            <div class="row">
                <div class="large-12 columns">
                    <hr class="pad20" />
                </div>
            </div>

            <%-- Cross Sells --%>
            <uc:CrossSellDisplay ID="CrossSellDisplay" runat="server"
				Title="Complimentary Products" 
				Columns="6"
                MaxItemsDisplayed="4" />
			
            <%-- Up Sells --%>
            <uc:UpSellDisplay ID="UpSellDisplay" runat="server" 
                Title="Perhaps You'd Prefer These" 
				Columns="6" 
                MaxItemsDisplayed="4" />
            
            <%-- Customers who purchased this item also purchased these items --%>
            <uc:SuggestedItems ID="SuggestedItems1" runat="server" 
                Title="People Who Bought This Also Bought" 
				Columns="6"
                MaxItemsDisplayed="4" />
            
            <hr />
            
            <uc:ProductReviewDisplayInline ID="ProductReviewDisplayInline2" runat="server" />

            <uc:ContentColumnControl ID="PostContentColumn" runat="server" />
        </div>
    </div>
</asp:Content>