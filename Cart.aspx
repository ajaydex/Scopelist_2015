<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="Cart.aspx.vb" Inherits="Cart" Title="Shopping Cart" %>

<%@ Register Src="BVModules/Controls/PaypalExpressCheckoutButton.ascx" TagName="PaypalExpressCheckoutButton"
    TagPrefix="uc4" %>
<%@ Register Src="BVModules/Controls/CrossSellDisplay.ascx" TagName="CrossSellDisplay"
    TagPrefix="uc3" %>
<%@ Register Src="BVModules/Controls/EstimateShipping.ascx" TagName="EstimateShipping"
    TagPrefix="uc2" %>
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<%@ Register Src="BVModules/Controls/CartShippingCalculator.ascx" TagName="CartShippingCalculator"
    TagPrefix="uc" %>
<%@ Register TagPrefix="anthem" Assembly="Anthem" Namespace="Anthem" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/scripts/togglebox.js") %>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('h4.kit-detail-header').click(toggleBox);
        });
    </script>
    <div class="breadcrumb">
        <a href="Default.aspx">Home</a> &gt; Shopping Cart
    </div>
    <asp:Panel ID="pnlAll" DefaultButton="btnUpdateQuantities" runat="server">
        <h1>
            <asp:Label ID="TitleLabel" runat="server">Shopping Cart</asp:Label></h1>
        <uc1:MessageBox ID="MessageBox1" runat="server" />
        <asp:ValidationSummary ID="valNewUserSummary" EnableClientScript="True" ShowSummary="true"
            runat="server" ValidationGroup="NewUser" CssClass="error_list validationSummary">
        </asp:ValidationSummary>
        <asp:ValidationSummary ID="valPromotionalCode" EnableClientScript="True" ShowSummary="true"
            runat="server" ValidationGroup="PromotionalCode" CssClass="error_list validationSummary">
        </asp:ValidationSummary>
        <div class="info_panel">
            <div class="panel-inner">
                <img class="info_tick" alt="" src="BVModules/Themes/Scopelist/ScopelistImages/info.png" />
                <asp:Label ID="lblcart" runat="server">Your Cart is Empty</asp:Label>
                <div>
                </div>
            </div>
        </div>
        <asp:Panel ID="pnlWholeCart" runat="server" Visible="true">
            <asp:Literal ID="ItemListLiteral" runat="server"></asp:Literal>
            <asp:GridView GridLines="None" ID="ItemGridView" runat="server" AutoGenerateColumns="False"
                Width="100%" DataKeyNames="bvin" CssClass="cart-table" EnableViewState="false">
                <Columns>
                    <asp:TemplateField ShowHeader="true" HeaderText="Remove" HeaderStyle-CssClass="remove-col">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                ImageUrl="~/BVModules/Themes/OpticAuthority/Images/cross.png" AlternateText="Delete"
                                Height="10" Width="9" />
                            <asp:ImageButton ID="btnGiftWrap" runat="server" CausesValidation="false" CommandName="GiftWrap"
                                ImageUrl="~/BVModules/Themes/Print Book/Images/Buttons/GiftWrapSmall.png" AlternateText="GiftWrap"
                                Style="width: 55px; margin-top: 5px;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Image" HeaderStyle-HorizontalAlign="left" HeaderStyle-CssClass="img-col">
                        <ItemTemplate>
                            <div class="image">
                                <asp:Image ID="imgProduct" runat="server" AlternateText="" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="true" HeaderText="Product Details" HeaderStyle-CssClass="product-col"
                        ItemStyle-HorizontalAlign="Left" ItemStyle-Width="250px">
                        <ItemTemplate>
                            <div id="cartitemdescription" runat="server" class="name">
                                <asp:LinkButton ID="DescriptionLinkButton" runat="server"></asp:LinkButton>
                                <asp:PlaceHolder ID="CartInputModifiersPlaceHolder" runat="server"></asp:PlaceHolder>
                                <asp:PlaceHolder ID="KitDisplayPlaceHolder" runat="server"></asp:PlaceHolder>
                            </div>
                            <div id="giftwrapdetails" runat="server" class="giftwrapdetails" style="margin-left: 10px;">
                                <span class="giftwrapqty">
                                    <asp:Label ID="lblgiftwrap" runat="server" Text="Gift Wrap - Qty:"></asp:Label>
                                    <asp:Literal ID="lblgiftwrapqty" runat="server"></asp:Literal>
                                </span><span class="giftwrapprice">
                                    <asp:Literal ID="lblgiftwrapprice" runat="server"></asp:Literal></span> <span class="giftwrapdetails">
                                        <asp:Literal ID="lblGiftWrapDetails" runat="server"></asp:Literal></span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price" HeaderStyle-HorizontalAlign="right" HeaderStyle-CssClass="price-col">
                        <ItemTemplate>
                            <asp:Literal ID="Label1" runat="server" Text='<%# Bind("AdjustedPrice", "{0:c}") %>'></asp:Literal>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Quantity/Update" HeaderStyle-HorizontalAlign="right"
                        HeaderStyle-CssClass="qty-col">
                        <ItemTemplate>
                            <div class="qty">
                                <asp:TextBox ID="QtyField" runat="server" Text='<%# Bind("Quantity","{0:#}") %>'
                                    CssClass="qty-field"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="QtyField" Text="*" ErrorMessage="Quantity Must Be Entered"
                                    runat="server" ID="rfvQuantity" ValidationGroup="NewUser"></asp:RequiredFieldValidator>
                                <bvc5:BVRegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                    ErrorMessage="Quantity Must Be Numeric" ControlToValidate="QtyField" ValidationExpression="\d{1,6}"
                                    ForeColor=" " CssClass="errormessage" Display="None" ValidationGroup="NewUser"></bvc5:BVRegularExpressionValidator>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Subtotal" HeaderStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle"
                        HeaderStyle-CssClass="subtotal-col">
                        <ItemTemplate>
                            <span class="totallabel">
                                <asp:Literal ID="TotalWithoutDiscountsLabel" runat="server" Text='' Visible="false"></asp:Literal></span>
                            <span class="totallabel">
                                <asp:Literal ID="TotalLabel" runat="server" Text=''></asp:Literal></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <div class="below-cart">
                <span class="float-r">Total: <span class="price">
                    <asp:Label ID="lblSubTotal" runat="server" Text=""></asp:Label></span></span>
                <asp:Label ID="lblMakeChanges" runat="server" Style="padding-top: 3px;">Make any changes above? </asp:Label>
                <asp:ImageButton runat="server" ID="btnUpdateQuantities" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-update.png"
                    ToolTip="Update Your Cart" AlternateText="Update Your Cart" ValidationGroup="NewUser" />
                <uc2:EstimateShipping ID="EstimateShipping1" runat="server" />
                <div class="clr">
                </div>
            </div>
            <div id="carttotals" style="display: none">
                <table border="0" cellspacing="0" cellpadding="3">
                    <tr id="trDiscounts" runat="server">
                        <td class="formlabel">
                            Order Discounts:
                        </td>
                        <td class="formfield">
                            <asp:Label ID="lblDiscounts" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
                <uc:CartShippingCalculator ID="CartShippingCalculator" DisplayTax="true" DisplayHandling="true"
                    runat="server" />
            </div>
            <div class="checkout-block">
                <span class="float-r">
                    <asp:ImageButton ID="btnContinueShopping" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-keep-shopping.png"
                        AlternateText="Continue Shopping" ToolTip="Continue Shopping" />
                    <span id="cartactioncheckout" runat="server">
                        <asp:ImageButton ID="btnCheckout" runat="server" ValidationGroup="NewUser" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-checkout.png"
                            AlternateText="Checkout" ToolTip="Checkout" />
                        <uc4:PaypalExpressCheckoutButton ID="PaypalExpressCheckoutButton1" runat="server"
                            DisplayText="false" />
                    </span></span>
                <asp:Panel ID="pnlCoupons" runat="server" DefaultButton="btnAddCoupon">
                    <div>
                        Add a Promotional Code:
                        <asp:TextBox ID="CouponField" runat="server" CssClass="normal_fld"></asp:TextBox>
                        <asp:Button Text="Submit" ValidationGroup="PromotionalCode" ID="btnAddCoupon" runat="server"
                            CssClass="submit" ToolTip="Submit" />
                        <asp:RequiredFieldValidator ControlToValidate="CouponField" Text="*" ErrorMessage="The code does not appear to be valid."
                            runat="server" ID="rfvQuantity" ValidationGroup="PromotionalCode"></asp:RequiredFieldValidator>
                    </div>
                    <asp:GridView EnableViewState="false" CellPadding="3" CellSpacing="0" GridLines="none"
                        ID="CouponGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="CouponCode"
                        ShowHeader="False">
                        <Columns>
                            <asp:BoundField DataField="CouponCode" ShowHeader="False" />
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnDeleteCoupon" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/x.png"
                                        runat="server" CausesValidation="false" CommandName="Delete" AlternateText="Delete Coupon" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
                <div class="clr">
                </div>
            </div>
        </asp:Panel>
    </asp:Panel>
    <div style="margin-top: 145px;">
        <uc3:CrossSellDisplay ID="CrossSellDisplay1" runat="server" DisplayAddToCartButton="false"
            DisplaySelectedCheckBox="true" RepeatDirection="Horizontal" />
    </div>
</asp:Content>
