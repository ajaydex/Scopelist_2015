<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Product.master" AutoEventWireup="false" CodeFile="Product.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ProductTemplates_Bvc5ChoiceGrid_Product" Title="Product Details" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="~/BVModules/Controls/AdditionalImages.ascx" TagName="AdditionalImages" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductMainImage.ascx" TagName="ProductMainImage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductTypeDisplay.ascx" TagName="ProductTypeDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddToCartButton.ascx" TagName="AddToCartButton" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddToWishlist.ascx" TagName="AddToWishlist" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/VariantsGridDisplay.ascx" TagName="VariantsGridDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/SuggestedItems.ascx" TagName="SuggestedItems" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/CrossSellDisplay.ascx" TagName="CrossSellDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductReviewDisplayInline.ascx" TagName="ProductReviewDisplayInline" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddThis.ascx" TagName="AddThis" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductNextPrevious.ascx" TagName="NextPrev" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductRatingDisplay.ascx" TagName="ProductRatingDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/EmailThisPage.ascx" TagName="EmailThisPage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/PrintThisPage.ascx" TagName="PrintThisPage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/UpSellDisplay.ascx" TagName="UpSellDisplay" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">    
    <div id="productpage">
        <div class="row">
            <div class="large-12 columns">
                <h1><asp:Label ID="lblName" runat="server"></asp:Label></h1>
            </div>
        </div>
    
        <div class="row">
            <div class="large-6 columns">
                <div id="ProductSKU" class="smallText">
                    <span class="ProductPropertyLabel">
                        <asp:Label ID="lblSKUTitle" runat="server" CssClass="ProductPropertyLabel">SKU:</asp:Label>
                    </span>
                    <asp:Label ID="lblSku" runat="server"></asp:Label>
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

                <asp:ValidationSummary ID="ValidationSummary1" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server"  DisplayMode="BulletList" ForeColor="White" ShowSummary="True" HeaderText='<a href="#" class="close">&times;</a>'></asp:ValidationSummary>

                <div class="variantsdisplay">
                    <asp:Panel DefaultButton="AddToCartImageButton" runat="server">
                        <uc:VariantsGridDisplay ID="VariantsGridDisplay" runat="server" />
                    </asp:Panel>
                </div>

                <asp:Panel ID="ProductControlsPanel" runat="server" CssClass="productcontrolspanel highlight">
                    <asp:ImageButton ID="AddToCartImageButton" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/AddToCart.png" />
                    <asp:Label ID="ItemAddedToCartLabel" runat="server" Visible="False" CssClass="AddedToCartMessage" EnableViewState="false"></asp:Label> 
                </asp:Panel>

                <div id="ProductDescription">
                    <asp:Label ID="lblDescription" runat="server"></asp:Label>
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
</asp:Content>
