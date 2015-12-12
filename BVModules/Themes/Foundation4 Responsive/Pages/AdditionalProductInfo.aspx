<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="AdditionalProductInfo.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_AdditionalProductInfo" title="Additional Product Information" %>

<%@ Register Src="~/BVModules/Controls/UpSellDisplay.ascx" TagName="UpSellDisplay" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
    <p><strong>Item added to cart. <a href="~/Cart.aspx" enableviewstate="false" runat="server">View Cart &raquo;</a></strong></p>
    <p>You may also be interested in these products&hellip;</p>
    <uc:UpSellDisplay ID="UpSellDisplay" runat="server" 
        DisplayAddToCartButton="true"
        RemainOnPageAfterAddToCart="true" 
        Title="Would you prefer these?" 
		Columns="6" />
    <hr />
    <asp:ImageButton ID="ContinueToCartImageButton" AlternateText="Continue To Cart" ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/NoThankYou.png" runat="server" />
</asp:Content>

