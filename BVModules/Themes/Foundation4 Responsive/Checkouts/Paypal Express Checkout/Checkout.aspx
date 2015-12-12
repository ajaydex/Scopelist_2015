<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Checkout.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Checkouts_Paypal_Express_Checkout_Checkout" title="PayPal Express Checkout" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/SiteTermsAgreement.ascx" TagName="SiteTermsAgreement" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/Shipping.ascx" TagName="Shipping" TagPrefix="uc" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:content id="Head1" contentplaceholderid="headcontent" runat="server">
    <link href="<%= Page.ResolveUrl("checkout.css") %>" type="text/css" rel="stylesheet" />
</asp:content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">

    <div id="PayPalExpressCheckout">

        <div class="row">
            <div class="large-12 columns">
                <h1>PayPal Checkout</h1>
                <uc:MessageBox id="MessageBox1" runat="server" />
		        <asp:ValidationSummary ID="ValidationSummary1" data-alert CssClass="alert-box alert" runat="server" ForeColor="White" DisplayMode="BulletList" HeaderText='<a href="#" class="close">&times;</a>' ></asp:ValidationSummary>
            </div>
        </div>

        <asp:Panel ID="FixedInfoPanel" runat="server" CssClass="row checkoutStep">
            <div class="large-6 columns">
                <h2>Ship To:</h2>    
        
                <p class="shiptoAddress">
                <asp:Label ID="CountryLabel" runat="server" Text=""></asp:Label>
                <br />
                <asp:Label ID="FirstNameLabel" runat="server" Text=""></asp:Label> 
                <asp:Label ID="MiddleInitialLabel" runat="server" Text=""></asp:Label>
                <asp:Label ID="LastNameLabel" runat="server" Text=""></asp:Label>        
                <br />
                <asp:Label ID="CompanyLabel" runat="server" Text=""></asp:Label>    
                <br />
                <asp:Label ID="StreetAddress1Label" runat="server" Text=""></asp:Label>
                <asp:Label ID="StreetAddress2Label" runat="server" Text=""></asp:Label>
                <br />
                <asp:Label ID="CityLabel" runat="server" Text=""></asp:Label>, 
                <asp:Label ID="StateLabel" runat="server" Text=""></asp:Label> 
                <asp:Label ID="ZipLabel" runat="server" Text=""></asp:Label>
                <br />
                <asp:PlaceHolder ID="countyHolder" runat="server">
                    <strong>County:</strong> <anthem:DropDownList ID="ddCounty" AutoCallBack="true" runat="server"></anthem:DropDownList>
                </asp:PlaceHolder>
                </p>

                <p class="shiptoAddress">
                <strong>E-mail:</strong> <asp:Label ID="EmailLabel" runat="server" Text=""></asp:Label>
                <br />
                <strong>Phone:</strong> <asp:Label ID="PhoneNumberLabel" runat="server" Text=""></asp:Label>
		        </p>
                <p id="Tr3" runat="server">
                   Paypal Address Status: 
                   <strong><asp:Label ID="AddressStatusLabel" runat="server" Text=""></asp:Label></strong>
                   <br />
                   <bvc5:BVCustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Paypal Address Must Be Confirmed." ForeColor=" " CssClass="errormessage">*</bvc5:BVCustomValidator>
                </p>
                
                <br />

                <asp:LinkButton ID="EditAddressLinkButton" runat="server" CausesValidation="False" CssClass="button secondary">Edit Address</asp:LinkButton>

            </div>
            <div class="large-6 columns">
                <h2>Shipping</h2>
                <uc:Shipping ID="Shipping" runat="server" TabIndex="2000" />
            </div>

        </asp:Panel>

        <!-- REVIEW YOU ORDER -->
        <div class="row checkoutStep stepReview">
            <div class="large-12 columns">
                <h2>Review Your Order</h2>
                <div class="reviewInstructions">
            	    <asp:Literal ID="litReviewInstructions" runat="server" />
                </div>
                <anthem:Panel ID="pnlReview" AutoUpdateAfterCallBack="true" runat="server">
		            <table cellspacing="0" id="ReviewTable">
		                <tr>
		                    <td colspan="2">
		                        <asp:GridView GridLines="None" ID="ItemsGridView" cssclass="itemTable" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="bvin">
		                            <Columns>
	                                    <asp:TemplateField HeaderText="Product">
	                                        <ItemTemplate>
	                                            <asp:Panel ID="pnlImage" CssClass="pad10 hideforlowres" runat="server">
	                                        	    <asp:Image ID="ImageField" runat="server" />
	                                            </asp:Panel>
                                                <div class="pad10">
	                                                <strong><asp:Label ID="SKUField" runat="server" /></strong> <asp:Label ID="DescriptionField" runat="server" CssClass="ProductName" />
	                                                <em><asp:PlaceHolder ID="CartInputModifiersPlaceHolder" runat="server" /></em>
	                                            </div>
	                                        </ItemTemplate>
	                                        <ItemStyle CssClass="image one" />
		                                    <HeaderStyle CssClass="image one" />
	                                    </asp:TemplateField>
		                                <asp:TemplateField HeaderText="Qty">
		                                    <ItemTemplate>
	                                    	    <div class="pad10">
		                                    	    <asp:Label ID="QuantityField" runat="server" Text='<%# Bind("Quantity","{0:#}") %>'></asp:Label>
	                                            </div>
		                                    </ItemTemplate>
		                                    <ItemStyle CssClass="two" />
		                                    <HeaderStyle CssClass="two" />
		                                </asp:TemplateField>
		                                <asp:TemplateField HeaderText="Price">
		                                    <ItemTemplate>
	                                    	    <div class="pad10">
		                                    	    <asp:Label ID="AdjustedPriceField" runat="server" Text='<%# Bind("AdjustedPrice", "{0:c}") %>'></asp:Label>
	                                            </div>
		                                    </ItemTemplate>
		                                    <ItemStyle CssClass="three" />
		                                    <HeaderStyle CssClass="three" />
		                                </asp:TemplateField>
		                                <asp:TemplateField HeaderText="Totals">
		                                    <ItemTemplate>
	                                    	    <div class="pad10">
		                                    	    <span class="lineitemnodiscounts"><asp:Literal ID="TotalWithoutDiscountsLabel" runat="server" Text='' Visible="false"></asp:Literal></span>
	                                                <span class="totallabel"><asp:Literal ID="TotalLabel" runat="server" Text=''></asp:Literal></span>
	                                            </div>
		                                    </ItemTemplate>
		                                    <ItemStyle CssClass="four" />
		                                    <HeaderStyle CssClass="four" />
		                                </asp:TemplateField>
		                            </Columns>
		                            <HeaderStyle CssClass="rowheader" />
		                            <RowStyle CssClass="tdrow" />
		                            <AlternatingRowStyle CssClass="altrow" />
		                        </asp:GridView>
		                    </td>
		                </tr>
                    </table>

                    <div class="row">
                        <div class="large-6 columns">
                            <asp:Label ID="lblSpecialInstructions" runat="server" AssociatedControlID="SpecialInstructions" text="Special Instructions" />
						    <asp:TextBox ID="SpecialInstructions" TextMode="MultiLine" runat="server" Columns="60" Rows="4" CssClass="formtextarea specialInstructions" Wrap="true" TabIndex="3001" />
                        </div>
                        <div class="large-6 columns totals">
                            <table cellspacing="0">
		                        <tr class="tdrow">
		                            <td class="alignleft">Subtotal:</td>
		                            <td class="alignright"><asp:Label ID="SubTotalField" runat="server" /></td>
		                        </tr>
		                        <tr id="OrderDiscountsRow" runat="server" class="highlightrow">
		                            <td class="alignleft">Discounts:</td>
		                            <td class="alignright"><asp:Label ID="OrderDiscountsField" runat="server" /></td>
		                        </tr>
		                        <tr class="altrow">
		                            <td class="alignleft">Tax:</td>
		                            <td class="alignright"><asp:Label ID="TaxTotalField" runat="server" />
		                            </td>
		                        </tr>
		                        <tr class="tdrow">
		                            <td class="alignleft">Shipping:</td>
		                            <td class="alignright"><asp:Label ID="ShippingTotalField" runat="server" /></td>
		                        </tr>
		                        <tr class="altrow">
		                            <td class="alignleft">Handling:</td>
		                            <td class="alignright"><asp:Label ID="HandlingTotalField" runat="server" /></td>
		                        </tr>
		                        <tr class="highlightrow grandtotal">
		                            <td class="alignleft"><strong>Order Total:</strong></td>
		                            <td class="alignright"><strong><asp:Label ID="GrandTotalField" runat="server" /></strong></td>
		                        </tr>
	                            <tr id="trLoyaltyPointsUsed" runat="server">
	                                <td class="alignleft"><strong><asp:Label ID="LoyaltyPointsUsedLabel" runat="server">Loyalty Points Credit</asp:Label>:</strong></td>
	                                <td class="alignright"><strong><asp:Label ID="LoyaltyPointsUsedCurrencyField" runat="server" /></strong> <!--(<asp:Label ID="LoyaltyPointsUsedField" runat="server" />)--></td>
	                            </tr>
                                <tr class="giftcertrow" id="trGiftCertificateRow" runat="server">
                                    <td class="alignleft"><strong>Gift Certificate(s) Credit:</strong></td>
                                    <td class="alignright"><strong><asp:Label ID="GiftCertificateField" runat="server" /></strong></td>
                                </tr>
		                        <tr class="amountdue">
		                            <td class="alignleft"><strong>Amount Due:</strong></td>
		                            <td class="alignright"><strong><asp:Label ID="AmountDueField" runat="server" /></strong></td>
	                            </tr>
	                            <tr id="trLoyaltyPointsEarned" runat="server">
	                                <td class="alignleft"><strong><asp:Label ID="LoyaltyPointsEarnedLabel" runat="server">Loyalty Points Earned</asp:Label>:</strong></td>
	                                <td class="alignright"><strong><asp:Label ID="LoyaltyPointsEarnedField" runat="server" /></strong> <!--(<asp:Label ID="LoyaltyPointsEarnedCurrencyField" runat="server" />)--></td>
	                            </tr>
		                    </table>
                        </div>
                    </div>

                </anthem:Panel>
            </div>
        </div>

        <!-- MAILING LIST SIGNUP / SITE TERMS / SUBMIT -->
        <div class="row checkoutStep stepMailingList">
            <div class="large-12 columns">
                <hr />
            </div>
            <div class="large-6 columns">
                <!--<asp:ImageButton ID="btnKeepShopping" runat="server" AlternateText="Keep Shopping" CausesValidation="False" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/ContinueShopping.png" TabIndex="3000" />-->
            </div>
            <div class="large-6 columns">
                <asp:Panel ID="pnlSiteTermsAgreement" CssClass="required" runat="server">
                    <uc:SiteTermsAgreement ID="SiteTermsAgreement1" runat="server" />
                    <asp:CustomValidator ID="cvSiteTermsAgreement" CssClass="error" EnableClientScript="false" Display="None" ForeColor=" " runat="server" />
                </asp:Panel>

                <hr />

                <div class="pad-top-1em text-right">
                    <asp:ImageButton ID="CheckoutImageButton" cssclass="btnSubmit" runat="server" AlternateText="Place Order" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/PlaceOrder.png" TabIndex="3201" />
                </div>

            </div>
        </div>
    </div>

</asp:Content>