<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SingleProductDisplay.ascx.vb" Inherits="BVModules_Controls_SingleProductDisplay" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Panel ID="SingleProductDisplayPanel" runat="server" CssClass="SingleProductDisplay" DefaultButton="AddToCartImageButton">    
    <div class="SingleProductDisplayImage">
        <a id="productimagelink" runat="server">
            <asp:Image ID="ProductImage" runat="server" />
        </a>        
    </div>
    <div class="ProductBadge">
        <asp:HyperLink ID="BadgeImage" runat="server"></asp:HyperLink>
    </div>
    <div class="SingleProductDisplayName">
	    <asp:CheckBox ID="SelectedCheckBox" runat="server" Visible="false" />	    
	    <asp:HyperLink ID="NameHyperLink" runat="server">Product Name</asp:HyperLink>
	</div>
    <div class="SingleProductDisplayDescription">
	    <asp:Label ID="DescriptionLabel" runat="server" CssClass="DescriptionLabel" Text="Label"></asp:Label>
    </div>
    <div class="SingleProductDisplayPrice">
	    <asp:Label ID="PriceLabel" runat="server" CssClass="PriceLabel" Text="Label"></asp:Label>
    </div>
    <div class="SingleProductDisplayQuantity">
        <asp:Label ID="QuantityLabel" runat="server" Text="Quantity" Visible="false"></asp:Label>
        <asp:TextBox ID="QuantityTextBox" runat="server" Visible="false" Columns="2">1</asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" ErrorMessage="Quantity is required" Text="*" ControlToValidate="QuantityTextBox" ForeColor=" " CssClass="errormessage"></bvc5:BVRequiredFieldValidator>
        <bvc5:BVRegularExpressionValidator ID="QuantityRegularExpressionValidator" runat="server" ErrorMessage="Quantity must be a number." ControlToValidate="QuantityTextBox" ValidationExpression="\d*" ForeColor=" " CssClass="errormessage"></bvc5:BVRegularExpressionValidator>
    </div>
    <div class="SingleProductDisplayAddToCart">
        <anthem:ImageButton ID="AddToCartImageButton" runat="server" Visible="false" CommandName="AddToCart" EnableCallBack="False" />
        <anthem:HyperLink ID="DetailsImageButton" runat="server" Visible="false" EnableCallBack="False" CausesValidation="False" />
    </div>    
    <div class="SingleProductDisplayAddedToCart">
        <anthem:Label ID="AddedToCartLabel" runat="server" Text="Item has been added to your cart." Visible="False" AutoUpdateAfterCallBack="true"></anthem:Label>
    </div>
</asp:Panel>