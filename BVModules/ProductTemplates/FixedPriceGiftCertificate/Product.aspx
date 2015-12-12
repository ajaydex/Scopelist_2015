<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Product.master" AutoEventWireup="false"
    CodeFile="Product.aspx.vb" Inherits="BVModules_ProductTemplates_FixedPriceGiftCertificate_Product"
    Title="Gift Certificate" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<%@ Register Src="../../Controls/ProductMainImage.ascx" TagName="ProductMainImage"
    TagPrefix="uc5" %>

<%@ Register Src="../../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc4" %>

<%@ Register Src="../../Controls/AddToCartButton.ascx" TagName="AddToCartButton"
    TagPrefix="uc3" %>

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
        <div id="contentcolumn">            
            <div id="imagecolumn">                
                <uc5:ProductMainImage ID="ProductMainImage1" runat="server" />
            </div>
            <div id="textcolumn">
                <h1>
                    <asp:Label ID="lblName" runat="server"></asp:Label></h1>
                <asp:Label ID="lblSku" runat="server"></asp:Label><br />
                <asp:Label ID="lblDescription" runat="server"></asp:Label><br />
            </div>
        </div>
        <div id="actioncolumn">
            <div id="actioncolumnpadding">
                <uc3:AddToCartButton ID="AddToCartButton1" runat="server" />                
            </div>
            <anthem:Label ID="ItemAddedToCartLabel" runat="server" Visible="False" CssClass="AddedToCartMessage"></anthem:Label>
        </div>
    </div>
    <div id="CrossSells">
        <uc2:CrossSellDisplay ID="CrossSellDisplay" runat="server" />
    </div>
    <ucc1:ContentColumnControl ID="PostContentColumn" runat="server" />
</asp:Content>
