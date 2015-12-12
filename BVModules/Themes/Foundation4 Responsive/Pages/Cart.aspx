<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Cart.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_Cart" Title="Shopping Cart" %>
<%@ Register Src="~/BVModules/Controls/PaypalExpressCheckoutButton.ascx" TagName="PaypalExpressCheckoutButton" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/CrossSellDisplay.ascx" TagName="CrossSellDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/EstimateShipping.ascx" TagName="EstimateShipping" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/CartShippingCalculator.ascx" TagName="CartShippingCalculator" TagPrefix="uc" %>


<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" runat="Server">
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/scripts/togglebox.js") %>"></script>
    <script type="text/javascript">
          $(document).ready(function() {                
            $('h4.kit-detail-header').click(toggleBox);                
          });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentHolder" runat="Server">

    <asp:Panel ID="pnlAll" DefaultButton="btnUpdateQuantities" runat="server">

        <h1><i class="fa fa-shopping-cart"></i> <asp:Label ID="TitleLabel" runat="server">Shopping Cart</asp:Label> <asp:Label ID="lblcart" runat="server"></asp:Label></h1>

        <h3><asp:Label runat="server" ID="lblempty"></asp:Label></h3>

        <uc:MessageBox ID="MessageBox1" runat="server" />

        <asp:ValidationSummary ID="ValidationSummary1" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server" ForeColor="White" DisplayMode="BulletList" HeaderText='<a href="#" class="close">&times;</a>' />
  
        <asp:Panel ID="pnlWholeCart" runat="server" Visible="true" CssClass="row cartcontainer">

            <div class="large-8 columns">

                <asp:GridView GridLines="None" ID="ItemGridView" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="bvin" CssClass="cartproductgrid" EnableViewState="false" ShowHeader="false" ShowFooter="false">
                    <Columns>

                        <asp:TemplateField ItemStyle-CssClass="cartImageColumn">
                            <ItemTemplate>
                                <div class="relative">
                                    <div class="cartitemimage">
                                        <asp:Image ID="imgProduct" runat="server" AlternateText="" />
                                    </div> 
                                
                                    <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="Delete" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/x.png" AlternateText="Delete" CssClass="deleteitem" />
                                </div>                        
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>

                                <div id="cartitemdescription" runat="server" class="cartitemdescription">
                                    
                                    <%-- PRODUCT NAME & SKU --%>
                                    <asp:LinkButton ID="DescriptionLinkButton" runat="server" CssClass="cartitemname"></asp:LinkButton>
                                    
                                    <div class="smallText">
                                        <asp:PlaceHolder ID="CartInputModifiersPlaceHolder" runat="server"></asp:PlaceHolder>
                                    </div>

                                    <div class="smallText">
                                        <asp:PlaceHolder ID="KitDisplayPlaceHolder" runat="server"></asp:PlaceHolder>
                                    </div>

                                </div>

                                <div id="giftwrapdetails" runat="server" class="giftwrapwrapper">
                                    <div class="smallText clearfix">
                                        <asp:ImageButton ID="btnGiftWrap" runat="server" CausesValidation="false" CommandName="GiftWrap" imageurl="~/BVModules/Themes/Print Book/Images/Buttons/GiftWrapSmall.png" AlternateText="GiftWrap" CssClass="left" /> 
                                        <span class="giftwrapqty">
                                            <!--<asp:Label ID="lblgiftwrap" runat="server" Text="Gift Wrap:"></asp:Label>-->
                                            <asp:Literal ID="lblgiftwrapqty" runat="server"></asp:Literal>
                                        </span>
                                        <span class="giftwrapprice">
                                            <asp:Literal ID="lblgiftwrapprice" runat="server"></asp:Literal>
                                        </span>
                                    </div>
                                    <asp:Literal ID="lblGiftWrapDetails" runat="server"></asp:Literal>
                                </div>

                                <div class="cartitemtotals clearfix">
                                    <span class="cartproductprice">
                                        <asp:Literal ID="Label1" runat="server" Text='<%# Bind("AdjustedPrice", "{0:c}") %>'></asp:Literal>
                                    </span>

                                    <div class="cartqty">
                                        <asp:TextBox ID="QtyField" Width="50" runat="server" Text='<%# Bind("Quantity","{0:#}") %>'></asp:TextBox>

                                        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Quantity Must Be Entered" ControlToValidate="QtyField" Text="*" Display="Dynamic"></bvc5:BVRequiredFieldValidator>  
                                        <bvc5:BVRegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Quantity Must Be Numeric" ControlToValidate="QtyField" ValidationExpression="\d{1,6}" Display="Dynamic"></bvc5:BVRegularExpressionValidator>
                                    </div>
                                    <span class="totallabel"><asp:Literal ID="TotalLabel" runat="server" Text=''></asp:Literal></span>
                                    <span class="lineitemnodiscounts"><asp:Literal ID="TotalWithoutDiscountsLabel" runat="server" Text='' Visible="false"></asp:Literal></span>

                                    
                                </div>

                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>

                <div id="cartactioncontinue">
                    <asp:ImageButton ID="btnContinueShopping" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/ContinueShopping.png" AlternateText="Continue Shopping" />
                </div>

                <hr />

                <div class="cartcoupons">
                    <asp:Panel ID="pnlCoupons" runat="server" DefaultButton="btnAddCoupon">
                        <label>Add a Promotional Code:</label>
                        <asp:TextBox ID="CouponField" runat="server"></asp:TextBox>
                        <asp:ImageButton ID="btnAddCoupon" runat="server" ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/AddToCart.png" AlternateText="Add Coupon to Cart" />
                        <br />
                        <asp:GridView EnableViewState="false" CellPadding="3" CellSpacing="0" GridLines="none" ID="CouponGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="CouponCode" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="CouponCode" ShowHeader="False" />
                                <asp:TemplateField ShowHeader="False" ItemStyle-CssClass="text-right">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnDeleteCoupon" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/x.png" runat="server" CausesValidation="false" CommandName="Delete" AlternateText="Delete Coupon" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>

                <hr />

            </div>

            <div class="large-4 columns">
                <div class="carttotals highlight">
                    <table border="0" cellspacing="0" cellpadding="3">
                        <tr>
                            <td>
                                Sub Total:
                            </td>
                            <td class="text-right">
                                <asp:Label ID="lblSubTotal" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr class="discountsRow" id="trDiscounts" runat="server">
                            <td>
                                Order Discounts:
                            </td>
                            <td class="text-right">
                                <strong><asp:Label ID="lblDiscounts" runat="server" Text=""></asp:Label></strong>
                            </td>
                        </tr>
                        
                        <uc:CartShippingCalculator ID="CartShippingCalculator" DisplayTax="true" DisplayHandling="true" runat="server" />
                    </table>
                </div>

                <div class="cartupdates clearfix ">
                    <uc:EstimateShipping ID="EstimateShipping1" runat="server" />

                    <asp:Label ID="lblMakeChanges" runat="server" CssClass="smallText">Make any changes to the products in your cart?<br /> Click <em>Update</em> to refresh your total.</asp:Label>
                    <asp:ImageButton ID="btnUpdateQuantities" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Update.png"  AlternateText="Update" cssclass="right" />
                </div>

                <hr />

                <div id="cartactioncheckout" class="text-right" runat="server">
                    <div class="pad-bottom-1em">
                        <asp:ImageButton ID="btnCheckout" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Checkout.png" AlternateText="Checkout" />
                    </div>
                    <uc:PaypalExpressCheckoutButton ID="PaypalExpressCheckoutButton1" runat="server" DisplayText="false" />
                </div>

            </div>

            <%-- RECOMMENDED PRODUCTS --%>
            <div class="large-12 columns">
                <uc:CrossSellDisplay ID="CrossSellDisplay" runat="server" 
                DisplayImage="true"
                DisplayNewBadge="true"
                DisplayName="true"
                DisplayDescription="false"
                DisplayPrice="true"
                DisplayAddToCartButton="true"
                DisplaySelectedCheckbox="false"
                DisplayQuantity="false"
                RemainOnPageAfterAddToCart="false" 
                Title="Cross Sells" 
		        Columns="6" />
            </div>

        </asp:Panel>
    </asp:Panel>
</asp:Content>
