<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SingleProductDisplay.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_SingleProductDisplay" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Panel ID="SingleProductDisplayPanel" DefaultButton="AddToCartImageButton" CssClass="SingleProductDisplay" runat="server">    
    <div class="record smallText">
        <%-- IMAGE --%>
        <div class="SingleProductDisplayImage recordimage">
            <a id="productimagelink" runat="server">
                <asp:Image ID="ProductImage" runat="server" />
            </a>        
        </div>
        
        <%-- NEW --%>
        <div id="BadgeImage" runat="server" class="new-label new-top-left"></div>

        <%-- CHECKBOX --%>
        <asp:CheckBox ID="SelectedCheckBox" runat="server" Visible="false" />

        <%-- EMPTY DIV SETS HIGHT OF REVEAL --%>
        <div class="product-info-height"></div>

        <div class="product-info">
            <%-- NAME --%>
            <div class="SingleProductDisplayName recordname">
	            <asp:HyperLink ID="NameHyperLink" runat="server">Product Name</asp:HyperLink>
	        </div>

            <%-- PRICE --%>
            <div class="SingleProductDisplayPrice recordprice">

                <%--LIST PRICE--%>
                <asp:Panel class="SingleProductDisplayListPrice recordlistprice" ID="listPricePanel" runat="server">
                    <asp:Label ID="ListPriceLabel" runat="server" CssClass="ListPriceLabel"></asp:Label>
                </asp:Panel>

	            <asp:Label ID="PriceLabel" runat="server" CssClass="PriceLabel" Text="Label"></asp:Label>
            </div>
            
            <%-- DISPLAYED ON HOVER --%>
            <div class="recordreveal">

                <%-- DESCRIPTION --%>
                <div class="SingleProductDisplayDescription recorddesc">
	                <asp:Label ID="DescriptionLabel" runat="server" CssClass="DescriptionLabel" Text="Label"></asp:Label>
                </div>

                <%-- QUANTITY --%>
                <div class="SingleProductDisplayQuantity recordqty">
                    <asp:Label ID="QuantityLabel" runat="server" Text="Qty" Visible="false" AssociatedControlID="QuantityTextBox"></asp:Label>
                    <asp:TextBox ID="QuantityTextBox" runat="server" Visible="false" Columns="2">1</asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" ErrorMessage="Quantity is required" Text="*" ControlToValidate="QuantityTextBox" ForeColor=" " CssClass="errormessage" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                    <bvc5:BVRegularExpressionValidator ID="QuantityRegularExpressionValidator" runat="server" ErrorMessage="Quantity must be a number." ControlToValidate="QuantityTextBox" ValidationExpression="\d*" ForeColor=" " CssClass="errormessage" Display="Dynamic"></bvc5:BVRegularExpressionValidator>
                </div>

                <%-- ADD TO CART / DETAILS --%>
                <div class="SingleProductDisplayAddToCart recordAddToCart">
                    <anthem:ImageButton ID="AddToCartImageButton" runat="server" Visible="false" CommandName="AddToCart" EnableCallBack="False" />
                    <asp:HyperLink ID="DetailsLink" runat="server" Visible="false"></asp:HyperLink>
                </div>
            </div>

            <%-- AJAX MESSAGE --%>
            <div class="SingleProductDisplayAddedToCart recordadded">
                <anthem:Label ID="AddedToCartLabel" runat="server" Text="Item has been added to your cart." Visible="False" AutoUpdateAfterCallBack="true"></anthem:Label>
            </div>
        </div>
    </div>
</asp:Panel>