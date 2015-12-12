<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ProductReviewsList.ascx.vb" Inherits="BVModules_Controls_ProductReviewsList" %>
<%@ Register TagPrefix="uc" TagName="SingleProductDisplay" Src="~/BVModules/Controls/SingleProductDisplay.ascx" %>

<h4 id="hTitle" runat="server" />

<asp:Repeater ID="rpProductReviewList" runat="server">
    <HeaderTemplate></HeaderTemplate>
    
    <ItemTemplate>
        <div class="<%# If(Container.ItemIndex Mod 2 = 0, String.Empty, "alt") %>">
            <p class="productreviewdetails">
                <asp:Image ID="imgReviewRating" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Stars3.png" runat="server" />
                <asp:HyperLink ID="lnkProductName" runat="server" />
                <br />
                by <asp:Label ID="lblName" runat="server" /> on <asp:Label ID="lblReviewDate" runat="server" />
            </p>
		    <p class="productreviewdescription">
                <asp:Label ID="lblReviewDescription" runat="server">Review...</asp:Label>
		    </p>
		    <uc:SingleProductDisplay ID="ucSingleProductDisplay" runat="server" 
                DisplayName="false"
                DisplayDescription="false"
                DisplayPrice="false"
                DisplayAddToCartButton="false"
            />
        </div>
    </ItemTemplate>
    
    <FooterTemplate></FooterTemplate>
</asp:Repeater>