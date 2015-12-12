<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Product.master" AutoEventWireup="false"
    CodeFile="Product.aspx.vb" Inherits="BVModules_ProductTemplates_Bvc5_Product"
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
<%@ Register Src="../../Controls/VariantsDisplay.ascx" TagName="VariantsDisplay"
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
        <h1>
            <span>
                <anthem:Label ID="lblName" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label></span></h1>
        <div id="contentcolumn">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="errormessage" />
            <uc10:OutOfStockDisplay ID="OutOfStockDisplay1" runat="server" />
            <div class="productimage">
                <uc9:ProductMainImage ID="ProductMainImage" runat="server" />
                <uc11:AdditionalImages ID="AdditionalImages1" runat="server" />                
            </div>
            <anthem:Label ID="lblDescription" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>
        </div>
        <div id="actioncolumn">
            <div id="actioncolumnpadding">
                <anthem:Label ID="lblSku" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>
                <div id="ProductOptions">
                    <uc3:VariantsDisplay ID="VariantsDisplay" runat="server" />
                </div>
                <div id="ProductTypes">
                    <uc8:ProductTypeDisplay ID="ProductTypeDisplay1" runat="server"></uc8:ProductTypeDisplay>
                </div>
                <anthem:Panel ID="ProductControlsPanel" runat="server">
                    <div id="ProductControls">
                        <anthem:Panel ID="PricePanel" runat="server" AutoUpdateAfterCallBack="true">
                            <table id="Prices">
                                <tr id="trListPrice" runat="server">
                                    <td class="formlabel">
                                        <asp:Label ID="lblListPriceName" runat="server" CssClass="productpropertylabel listprice">List Price</asp:Label></td>
                                    <td class="formfield">
                                        <anthem:Label ID="lblListPrice" runat="server" CssClass="listprice" Text="$x.xx"
                                            AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                                </tr>
                                <tr>
                                    <td class="formlabel">
                                        <asp:Label ID="lblSitePriceName" runat="server" CssClass="productpropertylabel siteprice">Your Price</asp:Label></td>
                                    <td class="formfield">
                                        <anthem:Label ID="lblSitePrice" runat="server" CssClass="siteprice" Text="$x.xx"
                                            AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                                </tr>
                                <tr id="trYouSave" runat="server">
                                    <td class="formlabel">
                                        <asp:Label ID="lblYouSaveLabel" runat="server" CssClass="productpropertylabel yousave">You Save</asp:Label></td>
                                    <td class="formfield">
                                        <anthem:Label ID="lblYouSave" runat="server" CssClass="yousave" Text="$x.xx" AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                                </tr>
                                <tr id="trQuantity" runat="server">
                                    <td class="formlabel">
                                        <asp:Label ID="lblQuantity" runat="server" CssClass="productpropertylabel qty" Text="Qty:"></asp:Label></td>
                                    <td class="formfield">
                                        <asp:TextBox ID="QuantityField" runat="server" Text="1" CssClass="forminput short"></asp:TextBox>
                                        <bvc5:BVRequiredFieldValidator ID="valQty"
                                                runat="server" CssClass="errormessage" ForeColor=" " Display="Dynamic" ControlToValidate="QuantityField"
                                                EnableClientScript="True" ErrorMessage="Please Enter A Quantity">*</bvc5:BVRequiredFieldValidator>
                                        <bvc5:BVRegularExpressionValidator
                                                    ID="val2Qty" runat="server" CssClass="errormessage" ForeColor=" " Display="Dynamic"
                                                    ControlToValidate="QuantityField" EnableClientScript="True" ErrorMessage="Quantity Must be between 1 and 9999"
                                                    ValidationExpression="\d+|\d+\d+|\d+\d+\d+|\d+\d+\d+\d+"></bvc5:BVRegularExpressionValidator>                                        
                                    </td>
                                </tr>
                            </table>
                        </anthem:Panel>
                        <div id="buttons">
                            <uc6:AddToCartButton ID="AddToCartButton1" runat="server" />
                            <anthem:Label ID="ItemAddedToCartLabel" runat="server" Visible="False" CssClass="AddedToCartMessage"></anthem:Label>
                            <uc4:AddToWishlist ID="AddToWishlist1" runat="server" />                        
                        </div>
                        <uc7:VolumeDiscounts ID="VolumeDiscounts1" runat="server" />
                    </div>
                </anthem:Panel>
            </div>
        </div>
        <uc1:ProductReview ID="ProductReview1" runat="server" />
        <uc2:CrossSellDisplay ID="CrossSellDisplay" runat="server" />
    </div>
    <ucc1:ContentColumnControl ID="PostContentColumn" runat="server" />
    <uc3:SuggestedItems ID="SuggestedItems1" runat="server" />
</asp:Content>
