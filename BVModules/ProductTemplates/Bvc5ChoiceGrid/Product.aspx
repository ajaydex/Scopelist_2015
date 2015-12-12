<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Product.master" AutoEventWireup="false"
    CodeFile="Product.aspx.vb" Inherits="BVModules_ProductTemplates_Bvc5ChoiceGrid_Product"
    Title="Product Details" %>

<%@ Register Src="../../Controls/AdditionalImages.ascx" TagName="AdditionalImages"
    TagPrefix="uc11" %>

<%@ Register Src="../../Controls/OutOfStockDisplay.ascx" TagName="OutOfStockDisplay"
    TagPrefix="uc10" %>
<%@ Register Src="../../Controls/ProductMainImage.ascx" TagName="ProductMainImage"
    TagPrefix="uc9" %>
<%@ Register Src="../../Controls/ProductTypeDisplay.ascx" TagName="ProductTypeDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../../Controls/VolumeDiscounts.ascx" TagName="VolumeDiscounts"
    TagPrefix="uc7" %>
<%@ Register Src="../../Controls/AddToCartButton.ascx" TagName="AddToCartButton"
    TagPrefix="uc6" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc5" %>
<%@ Register Src="../../Controls/AddToWishlist.ascx" TagName="AddToWishlist" TagPrefix="uc4" %>
<%@ Register Src="../../Controls/VariantsGridDisplay.ascx" TagName="VariantsGridDisplay"
    TagPrefix="uc3" %>
<%@ Register Src="../../Controls/SuggestedItems.ascx" TagName="SuggestedItems" TagPrefix="uc3" %>
<%@ Register Src="../../Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail"
    TagPrefix="ucc2" %>
<%@ Register Src="../../Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="ucc1" %>
<%@ Register Src="../../Controls/CrossSellDisplay.ascx" TagName="CrossSellDisplay"
    TagPrefix="uc2" %>
<%@ Register Src="../../Controls/ProductReviewDisplay.ascx" TagName="ProductReview"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">    
    <ucc2:CategoryBreadCrumbTrail ID="CategoryBreadCrumbTrail1" runat="server" />
    <ucc1:ContentColumnControl ID="PreContentColumn" runat="server" />
    <div id="bvc5productpage">
        <h1><anthem:Label ID="lblName" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label></h1>
        <div id="contentcolumn">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="errormessage" />            
            <div class="productimage">
                <uc9:ProductMainImage ID="ProductMainImage" runat="server" />
                <uc11:AdditionalImages ID="AdditionalImages1" runat="server" />                
            </div>
            <anthem:Label ID="lblDescription" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>
        </div>
        <div id="actioncolumn">
            <div id="actioncolumnpadding">
                <anthem:Label ID="lblSku" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>
                <asp:Panel DefaultButton="AddToCartImageButton" runat="server">
                    <div id="ProductOptions">
                        <uc3:VariantsGridDisplay ID="VariantsGridDisplay" runat="server" />
                    </div>
                </asp:Panel>
                <div id="ProductTypes">
                    <uc8:ProductTypeDisplay ID="ProductTypeDisplay1" runat="server"></uc8:ProductTypeDisplay>
                </div>
                <asp:Panel ID="ProductControlsPanel" runat="server">
                    <div id="ProductControls">                        
                        <div id="buttons">
                            <asp:ImageButton ID="AddToCartImageButton" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/AddToCart.png" />
                            <div>
                            <asp:Label ID="ItemAddedToCartLabel" runat="server" Visible="False" CssClass="AddedToCartMessage" EnableViewState="false"></asp:Label>                            
                            </div>
                        </div>                        
                    </div>
                </asp:Panel>
            </div>
        </div>
        <uc1:ProductReview ID="ProductReview1" runat="server" />
        <uc2:CrossSellDisplay ID="CrossSellDisplay" runat="server" />
    </div>
    <ucc1:ContentColumnControl ID="PostContentColumn" runat="server" />
    <uc3:SuggestedItems ID="SuggestedItems1" runat="server" />
</asp:Content>
