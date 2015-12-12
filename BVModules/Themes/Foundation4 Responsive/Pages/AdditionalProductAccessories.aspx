<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="AdditionalProductAccessories.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_AdditionalProductInfo" title="Additional Product Information" %>

<%@ Register Src="~/BVModules/Controls/CrossSellDisplay.ascx" TagName="CrossSellDisplay" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
    <p><strong>Item added to cart. <a href="~/Cart.aspx" enableviewstate="false" runat="server">View Cart &raquo;</a></strong></p>
    <p>You may also be interested in these products&hellip;</p>
    <uc:CrossSellDisplay ID="CrossSellDisplay" runat="server" 
        DisplayAddToCartButton="true"
        RemainOnPageAfterAddToCart="false" 
        Title="Complimentary Products" 
		Columns="6" />
    <hr />
    <asp:ImageButton ID="ContinueToCartImageButton" AlternateText="Continue To Cart" ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/NoThankYou.png" runat="server" />           
</asp:Content>

