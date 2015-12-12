<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Product.master" AutoEventWireup="false" CodeFile="Kit.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_KitTemplates_ListFoundation4Responsive_Kit" Title="Product Details" %>

<%@ Register Src="~/BVModules/Controls/OutOfStockDisplay.ascx" TagName="OutOfStockDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductMainImage.ascx" TagName="ProductMainImage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductTypeDisplay.ascx" TagName="ProductTypeDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/VolumeDiscounts.ascx" TagName="VolumeDiscounts" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddToCartButton.ascx" TagName="AddToCartButton" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc5" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductNextPrevious.ascx" TagName="NextPrev" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductReviewDisplayInline.ascx" TagName="ProductReviewDisplayInline" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductRatingDisplay.ascx" TagName="ProductRatingDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddThis.ascx" TagName="AddThis" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/EmailThisPage.ascx" TagName="EmailThisPage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/PrintThisPage.ascx" TagName="PrintThisPage" TagPrefix="uc" %>
<%@ Register src="KitComponentsDisplay.ascx" tagname="KitComponentsDisplay" tagprefix="uc" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    
    <div class="row">
        <div class="large-10 columns">
            <h1><anthem:Label ID="lblName" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label></h1>
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
                <anthem:Label ID="lblSku" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>
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
                <uc:ProductMainImage ID="ProductMainImage" runat="server" />
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

            <uc:OutOfStockDisplay ID="OutOfStockDisplay1" runat="server" />


            <anthem:Panel ID="PricePanel" runat="server" AutoUpdateAfterCallBack="true" cssclass="pricebox">
                <table cellspacing="0" cellpadding="0">  
                    <tr class="yourPrice">
                        <td class="labelCell">
                            <b><asp:Label ID="lblSitePriceName" runat="server" CssClass="ProductPropertyLabel">Your Price</asp:Label></b></td>
                        <td>
                            <anthem:Label ID="lblSitePrice" itemprop="price" runat="server" CssClass="SitePrice" Text="$x.xx" AutoUpdateAfterCallBack="true">$x.xx</anthem:Label></td>
                    </tr>
                </table>
            </anthem:Panel>

            <uc:VolumeDiscounts ID="VolumeDiscounts1" runat="server" />

            <uc:KitComponentsDisplay ID="KitComponentsDisplay" runat="server" />
            
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
            
    <uc:ProductReviewDisplayInline ID="ProductReviewDisplayInline2" runat="server" />

    <uc:ContentColumnControl ID="PostContentColumn" runat="server" />

</asp:Content>
