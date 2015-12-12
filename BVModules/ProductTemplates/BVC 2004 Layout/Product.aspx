<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="Product.aspx.vb" Inherits="BVModules_ProductTemplates_BVC_2004_Layout_Product"
    Title="Product Details" %>
<%@ Register Src="../../Controls/OutOfStockDisplay.ascx" TagName="OutOfStockDisplay"
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
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <ucc2:CategoryBreadCrumbTrail ID="CategoryBreadCrumbTrail1" runat="server" />
    <ucc1:ContentColumnControl ID="PreContentColumn" runat="server" />
    <div id="bvc2004productpage">
        <div id="menucolumn">
            <ucc1:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="System Product Page" />
        </div>
        <div id="imagecolumn">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="errormessage" />
            <uc15:OutOfStockDisplay ID="OutOfStockDisplay1" runat="server" />
            <div id="productimage">                
                <uc14:ProductMainImage ID="ProductMainImage1" runat="server" />
                <uc6:AdditionalImages ID="AdditionalImages" runat="server" />                
            </div>
            <uc7:EmailThisPage ID="EmailThisPage1" runat="server" />
            <uc1:PrintThisPage ID="PrintThisPage2" runat="server" />
            <uc2:RelatedItems ID="RelatedItems2" runat="server" />
            <uc4:CrossSellDisplay ID="CrossSellDisplay" runat="server" DisplayDescriptions="true"
                RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Table" DisplayMode="Wide"
                DisplayAddToCartButton="true" />
            <uc8:SuggestedItems ID="SuggestedItems1" runat="server" />
        </div>
        <div id="contentcolumn">            
            <h1>
                <anthem:Label ID="lblName" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label></h1>
            <div id="ProductSKU">
                <span class="ProductPropertyLabel">
                    <asp:Label ID="lblSKUTitle" runat="server" CssClass="ProductPropertyLabel">SKU:</asp:Label>
                </span>
                <anthem:Label ID="lblSku" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label></div>
            <div id="ProductDescription">
                <anthem:Label ID="lblDescription" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label></div>
            <div id="ProductProperties">
                <ul id="lstProperties" runat="server">
                </ul>
            </div>            
                <div id="ProductControls">
                    <div id="ProductOptions">
                        <uc8:VariantsDisplay ID="VariantsDisplay" runat="server" />                    
                    </div>
                    <anthem:Panel ID="ProductControlsPanel" runat="server">
                        <div id="ProductTypes">
                            <uc13:ProductTypeDisplay ID="ProductTypeDisplay1" runat="server"></uc13:ProductTypeDisplay>                
                        </div>
                        <anthem:Panel ID="pnlPrices" runat="server">
                            <div id="Prices">
                                <table cellspacing="0" cellpadding="3">
                                    <tr id="trListPrice" runat="server">
                                        <td align="right">
                                            <b>
                                                <asp:Label ID="lblListPriceName" runat="server" CssClass="ProductPropertyLabel">List Price</asp:Label></b></td>
                                        <td>
                                            <anthem:Label ID="lblListPrice" runat="server" CssClass="ListPrice" Text="$x.xx"
                                                AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <b>
                                                <asp:Label ID="lblSitePriceName" runat="server" CssClass="ProductPropertyLabel">Your Price</asp:Label></b></td>
                                        <td>
                                            <anthem:Label ID="lblSitePrice" runat="server" CssClass="SitePrice" Text="$x.xx"
                                                AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                                    </tr>
                                    <tr id="trYouSave" runat="server">
                                        <td align="right">
                                            <b>
                                                <asp:Label ID="lblYouSaveLabel" runat="server" CssClass="ProductPropertyLabel">You Save</asp:Label></b></td>
                                        <td>
                                            <anthem:Label ID="lblYouSave" runat="server" CssClass="YouSave" Text="$x.xx" AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                                    </tr>
                                    <tr id="trQuantity" runat="server">
                                        <td class="ProductPropertyLabel" align="right">
                                            <b>
                                                <asp:Label ID="lblQuantity" runat="server" CssClass="ProductPropertyLabel">Quantity</asp:Label></b></td>
                                        <td>
                                            <asp:TextBox ID="QuantityField" TabIndex="5000" runat="server" CssClass="FormInput"
                                                Columns="5" MaxLength="4">1</asp:TextBox><bvc5:BVRequiredFieldValidator ID="valQty"
                                                    runat="server" CssClass="errormessage" ForeColor=" " Display="Dynamic" ControlToValidate="QuantityField"
                                                    EnableClientScript="True" ErrorMessage="Please Enter A Quantity">*</bvc5:BVRequiredFieldValidator>
                                                    <bvc5:BVRegularExpressionValidator
                                                        ID="val2Qty" runat="server" CssClass="errormessage" ForeColor=" " Display="Dynamic"
                                                        ControlToValidate="QuantityField" EnableClientScript="True" ErrorMessage="Quantity Must be between 1 and 9999"
                                                        ValidationExpression="\d+|\d+\d+|\d+\d+\d+|\d+\d+\d+\d+"></bvc5:BVRegularExpressionValidator></td>
                                    </tr>
                                </table>
                            </div>
                        </anthem:Panel>
                        <asp:ValidationSummary ID="valSummary" runat="server" CssClass="errormessage" ForeColor=" "
                            EnableClientScript="True" DisplayMode="BulletList" ShowSummary="True"></asp:ValidationSummary>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="left" valign="top">
                                    <uc11:AddToCartButton ID="AddToCartButton1" runat="server" />
                                    <uc9:AddToWishlist ID="AddToWishlist1" runat="server" />                      
                                </td>
                                <td id="tdWishList" runat="server" align="left" valign="top">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Literal ID="AmazonBuyLink" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <anthem:Label ID="ItemAddedToCartLabel" CssClass="AddedToCartMessage" runat="server"
                                        Text="Item has been added to cart." Visible="False" AutoUpdateAfterCallBack="true"></anthem:Label>
                                </td>
                            </tr>
                        </table>
                        <uc12:VolumeDiscounts ID="VolumeDiscounts1" runat="server" />
                    </anthem:Panel>
                </div>            
        </div>
        <uc3:ProductReviewDisplay ID="ProductReviewDisplay2" runat="server" />
    </div>
    <ucc1:ContentColumnControl ID="PostContentColumn" runat="server" />
</asp:Content>
