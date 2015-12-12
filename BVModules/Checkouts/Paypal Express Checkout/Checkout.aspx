<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Checkout.aspx.vb" Inherits="BVModules_Checkouts_Paypal_Express_Checkout_Checkout" title="PayPal Express Checkout" %>

<%@ Register Src="../../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../../Controls/SiteTermsAgreement.ascx" TagName="SiteTermsAgreement" TagPrefix="uc1" %>
<%@ Register Src="~/BVModules/Controls/Shipping.ascx" TagName="Shipping" TagPrefix="uc" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">

    <h1>PayPal Checkout</h1>
    <uc2:MessageBox ID="MessageBox1" runat="server" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="errormessage" />   
     
    <asp:Panel ID="FixedInfoPanel" runat="server">

        <h2>Ship To:</h2>    
        <table width="300" cellpadding="1" cellspacing="0">
            <tr>
                <td class="formlabel">
                    Country:
                </td>
                <td class="formfield">
                    <asp:Label ID="CountryLabel" runat="server" Text=""></asp:Label>
                </td>
            </tr>   
            <tr>
                <td class="formlabel">
                    First, MI:&nbsp;</td>
                <td class="formfield">
                    <asp:Label ID="FirstNameLabel" runat="server" Text=""></asp:Label>
                    <asp:Label ID="MiddleInitialLabel" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Last:
                </td>
                <td class="formfield">
                    <asp:Label ID="LastNameLabel" runat="server" Text=""></asp:Label>        
                </td>
            </tr>
            <tr id="Tr1" runat="server">
                <td class="formlabel">
                    Company:</td>
                <td class="formfield">
                    <asp:Label ID="CompanyLabel" runat="server" Text=""></asp:Label>    
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Address:
                </td>
                <td class="formfield">
                    <asp:Label ID="StreetAddress1Label" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    &nbsp;
                </td>
                <td class="formfield">
                    <asp:Label ID="StreetAddress2Label" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    City:
                </td>
                <td class="formfield">
                    <asp:Label ID="CityLabel" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    State, Zip:&nbsp;</td>
                <td class="formfield">
                    <asp:Label ID="StateLabel" runat="server" Text=""></asp:Label>
                    <asp:Label ID="ZipLabel" runat="server" Text=""></asp:Label>
                </td>
            </tr>
			<tr>
			<tr id="countyHolder" runat="server">
				<td class="formlabel">
					County:
				</td>
				<td class="formfield">
					<anthem:DropDownList ID="ddCounty" AutoCallBack="true" runat="server"></anthem:DropDownList>
				</td>
			</tr>
			</tr>
            <tr id="Tr4" runat="server">
                <td class="formlabel">
                    E-mail:
                </td>
                <td class="formfield">
                    <asp:Label ID="EmailLabel" runat="server" Text=""></asp:Label>
		        </td>
            </tr>   
            <tr id="Tr2" runat="server">
                <td class="formlabel">
                    Phone:
                </td>
                <td class="formfield">
                    <asp:Label ID="PhoneNumberLabel" runat="server" Text=""></asp:Label>
		        </td>
            </tr>
            <tr id="Tr3" runat="server">
                <td class="formlabel">
                    Paypal Address Status:
                </td>
                <td class="formfield">
                    <asp:Label ID="AddressStatusLabel" runat="server" Text=""></asp:Label>
                    <bvc5:BVCustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Paypal Address Must Be Confirmed." ForeColor=" " CssClass="errormessage">*</bvc5:BVCustomValidator></td>
            </tr>
            <tr>
                <td colspan="2"><asp:LinkButton ID="EditAddressLinkButton" runat="server" CausesValidation="False">Edit Address</asp:LinkButton></td>
            </tr>
        </table>

        <h2>Shipping</h2>
        <uc:Shipping ID="Shipping" runat="server" TabIndex="2000" />
    </asp:Panel>

    <div class="reviewInstructions">
        <asp:Literal ID="litReviewInstructions" runat="server" />
    </div>

    <br />
    <br />
  
    <h2>Review Your Order</h2>
    <anthem:Panel ID="pnlReview" AutoUpdateAfterCallBack="true" runat="server">
		
	    <asp:GridView GridLines="None" ID="ItemsGridView" cssclass="itemTable" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="bvin">
		    <Columns>
	            <asp:TemplateField>
	                <ItemTemplate>
	                    <div class="pad10">
	                        <asp:Image ID="ImageField" runat="server" />
	                    </div>
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
		        
        <br />
        <br /> 

        <div>
            <asp:Label ID="lblSpecialInstructions" runat="server" AssociatedControlID="SpecialInstructions" text="Special Instructions" />
		    <asp:TextBox ID="SpecialInstructions" TextMode="MultiLine" runat="server" Columns="60" Rows="4" CssClass="formtextarea specialInstructions" Wrap="true" TabIndex="3001" />
        </div>

        <br />
        <br />

        <div style="margin-left:450px;">
            <table cellspacing="0">
		        <tr class="tdrow">
		            <td>SubTotal:</td>
		            <td class="text-right"><asp:Label ID="SubTotalField" runat="server" /></td>
		        </tr>
		        <tr id="OrderDiscountsRow" runat="server" class="highlightrow">
		            <td>Discounts:</td>
		            <td class="text-right"><asp:Label ID="OrderDiscountsField" runat="server" /></td>
		        </tr>
		        <tr class="altrow">
		            <td>Tax:</td>
		            <td class="text-right"><asp:Label ID="TaxTotalField" runat="server" />
		            </td>
		        </tr>
		        <tr class="tdrow">
		            <td>Shipping:</td>
		            <td class="text-right"><asp:Label ID="ShippingTotalField" runat="server" /></td>
		        </tr>
		        <tr class="altrow">
		            <td>Handling:</td>
		            <td class="text-right"><asp:Label ID="HandlingTotalField" runat="server" /></td>
		        </tr>
		        <tr class="highlightrow grandtotal">
		            <td><strong>Order Total:</strong></td>
		            <td class="text-right"><strong><asp:Label ID="GrandTotalField" runat="server" /></strong></td>
		        </tr>
	            <tr id="trLoyaltyPointsUsed" runat="server">
	                <td><strong><asp:Label ID="LoyaltyPointsUsedLabel" runat="server">Loyalty Points Credit</asp:Label>:</strong></td>
	                <td class="text-right"><strong><asp:Label ID="LoyaltyPointsUsedCurrencyField" runat="server" /></strong> <!--(<asp:Label ID="LoyaltyPointsUsedField" runat="server" />)--></td>
	            </tr>
                <tr class="giftcertrow" id="trGiftCertificateRow" runat="server">
                    <td><strong>Gift Certificate(s) Credit:</strong></td>
                    <td class="text-right"><strong><asp:Label ID="GiftCertificateField" runat="server" /></strong></td>
                </tr>
		        <tr class="amountdue">
		            <td><strong>Amount Due:</strong></td>
		            <td class="text-right"><strong><asp:Label ID="AmountDueField" runat="server" /></strong></td>
	            </tr>
	            <tr id="trLoyaltyPointsEarned" runat="server">
	                <td><strong><asp:Label ID="LoyaltyPointsEarnedLabel" runat="server">Loyalty Points Earned</asp:Label>:</strong></td>
	                <td class="text-right"><strong><asp:Label ID="LoyaltyPointsEarnedField" runat="server" /></strong> <!--(<asp:Label ID="LoyaltyPointsEarnedCurrencyField" runat="server" />)--></td>
	            </tr>
		    </table>
        </div>
        <br />
        <br /> 
    </anthem:Panel>

    <div style="margin-left:450px;">
        <uc1:SiteTermsAgreement ID="SiteTermsAgreement1" runat="server" />
   
        <br />
        <br /> 
        <!--<asp:ImageButton ID="btnKeepShopping" runat="server" AlternateText="Keep Shopping" CausesValidation="False" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/ContinueShopping.png" />-->

        <asp:ImageButton ID="CheckoutImageButton" runat="server" />
    </div>


</asp:Content>