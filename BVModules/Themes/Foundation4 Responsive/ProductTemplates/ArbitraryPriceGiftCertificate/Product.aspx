<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Product.master" AutoEventWireup="false" CodeFile="Product.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ProductTemplates_ArbitraryPriceGiftCertificate_Product" Title="Gift Certificate" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="~/BVModules/Controls/ProductMainImage.ascx" TagName="ProductMainImage" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddToCartButton.ascx" TagName="AddToCartButton" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ProductReviewDisplay.ascx" TagName="ProductReview" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div id="productpage">
        <div class="row">
            <div class="large-12 columns">
                <h1><asp:Label ID="lblName" runat="server"></asp:Label></h1>
            </div>
        </div>

        <div class="row">
            <div class="large-12 columns">
                <div id="ProductSKU" class="smallText">
                    <span class="ProductPropertyLabel">
                        <asp:Label ID="lblSKUTitle" runat="server" CssClass="ProductPropertyLabel">SKU:</asp:Label>
                    </span>
                    <asp:Label ID="lblSku" runat="server"></asp:Label>
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
                </div>
            </div>
            <div class="large-6 column">
                <uc:ContentColumnControl ID="PreContentColumn" runat="server" />

                <div class="variantsdisplay">
                    <table cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="choicelabel">
                                <span>Value</span>
                            </td>
                            <td class="choicefield">
                               <asp:TextBox ID="ValueTextBox" runat="server" Width="150"></asp:TextBox>
                            </td>
                         </tr>
                    </table>
                </div>

                <div class="productcontrolspanel highlight">
                    <anthem:Label ID="ItemAddedToCartLabel" runat="server" Visible="False" CssClass="AddedToCartMessage"></anthem:Label>
                    <uc:AddToCartButton ID="AddToCartButton1" runat="server" />
                </div>

                <div id="ProductDescription">
                    <asp:Label ID="lblDescription" runat="server"></asp:Label>
                </div>

                <uc:ContentColumnControl ID="PostContentColumn" runat="server" />
            </div>
        </div>
    </div>
</asp:Content>
