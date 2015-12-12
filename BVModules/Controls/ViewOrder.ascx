<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewOrder.ascx.vb" Inherits="BVModules_Controls_ViewOrder" %>
<%@ Register Src="PrintThisPage.ascx" TagName="PrintThisPage" TagPrefix="uc1" %>
<%--<table border="0" cellspacing="0" cellpadding="3" width="500px">
    <tr>
        <td width="33%">
            <h1 id="OrderNumberHeader" runat="server">Order
                <asp:Label ID="OrderNumberField" runat="server" Text="000000"></asp:Label></h1>
            <asp:Label ID="PONumberLabel" runat="server" Text=""></asp:Label>
        </td>
        <td align="left" valign="top">
            <asp:Label ID="StatusField" runat="server"></asp:Label></td>
        <td width="33%" valign="top" align="right" rowspan="2">
            <uc1:PrintThisPage ID="PrintThisPage1" runat="server" />            
        </td>
    </tr>
    <tr>
        <td valign="top">
            <span class="lightlabel">Sold To:</span><br />
            <asp:Label ID="BillingAddressField" runat="server"></asp:Label>
        </td>
        <td valign="top">
            <asp:Panel ID="pnlShipTo" runat="server" Visible="true">
                <span class="lightlabel">Ship To:</span><br />
                <asp:Label ID="ShippingAddressField" runat="server"></asp:Label></asp:Panel>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <asp:GridView Style="margin: 20px 0px 20px 0px; border-bottom: solid 1px #666;" GridLines="None"
                ID="ItemsGridView" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="bvin">
                <Columns>
                    <asp:TemplateField ItemStyle-VerticalAlign="top">
                        <ItemTemplate>
                            <asp:CheckBox ID="SelectedCheckBox" runat="server" Checked="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SKU" ItemStyle-VerticalAlign="top">
                        <ItemTemplate>
                            <asp:Label ID="SKUField" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Item" ItemStyle-VerticalAlign="top">
                        <ItemTemplate>                            
                                <asp:Label ID="DescriptionField" runat="server"></asp:Label>
                                <asp:PlaceHolder ID="CartInputModifiersPlaceHolder" runat="server"></asp:PlaceHolder><br />            
                                <asp:PlaceHolder ID="KitDisplayPlaceHolder" runat="server"></asp:PlaceHolder>
                                <asp:Literal ID="lblGiftWrap" runat="server" Text="Gift Wrap - Qty:"></asp:Literal>
                                <asp:Literal ID="lblGiftWrapQty" runat="server"></asp:Literal><asp:Literal ID="lblGiftWrapPrice" runat="server"></asp:Literal><br /><br />
                                <asp:Literal ID="lblGiftWrapDetails" runat="server"></asp:Literal>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Shipping" ItemStyle-VerticalAlign="top">
                        <ItemTemplate>
                            <asp:Label ID="ShippingStatusField" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price" ItemStyle-VerticalAlign="top">
                        <ItemTemplate>
                            <asp:Label ID="AdjustedPriceField" runat="server" Text='<%# Bind("AdjustedPrice", "{0:c}") %>'></asp:Label><br />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                        <HeaderStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Quantity" ItemStyle-VerticalAlign="top">
                        <ItemTemplate>
                            <asp:Label ID="QuantityField" runat="server" Text='<%# Bind("Quantity","{0:#}") %>'></asp:Label><br />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                        <HeaderStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Line Total" ItemStyle-VerticalAlign="top">
                        <ItemTemplate>
                            <asp:Label ID="LineTotalField" runat="server" Text='<%# Bind("LineTotal", "{0:c}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                        <HeaderStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
            <asp:Panel ID="pnlReturn" runat="server">
            <asp:ImageButton ID="ReturnItemsImageButton" runat="server" ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/ReturnItems.png" AlternateText="Return selected items" /><br />
            <div class="errorDiv">
                <asp:Label ID="returnErrorLabel" runat="server" Text="" EnableViewState="False"></asp:Label>
            </div>
            <asp:Placeholder ID="itemsToReturnText" runat="server">(Please select the items to return and press the "Return Items" button.)</asp:Placeholder>
            </asp:Panel></td>
    </tr>
    <tr>
        <td valign="top">
            <asp:Panel ID="pnlInstructions" runat="server" Visible="false">
                <em>Customer's Instructions:</em><br />
                <asp:Label ID="InstructionsField" runat="server"></asp:Label>
            </asp:Panel>
            <asp:Panel ID="pnlGiftCertificates" runat="server" Visible="true">
                <em>Gift Certificates</em>
                <asp:GridView ID="GiftCertificatesGridView" runat="server" GridLines="None" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="CertificateCode" HeaderText="Certificate Code" />
                    </Columns>
                    <EmptyDataTemplate>
                        <div>None</div>
                    </EmptyDataTemplate>
                    <EditRowStyle CssClass="row" />
                    <HeaderStyle CssClass="rowheader" />
                    <AlternatingRowStyle CssClass="alternaterow" />
                </asp:GridView>
            </asp:Panel>
        </td>
        <td valign="top">
            &nbsp;
        </td>
        <td valign="top" align="right">
            <table cellspacing="0" cellpadding="2" width="200" border="0">
                <tr>
                    <td class="FormLabel" valign="top" align="left">
                        Subtotal:</td>
                    <td class="FormLabel" valign="top" align="right">
                        <asp:Label ID="SubTotalField" runat="server"></asp:Label></td>
                </tr>
                <tr runat="server" id="DiscountsRow" visible="false">
                    <td class="FormLabel" valign="top" align="left">
                        Discounts:</td>
                    <td class="FormLabel" valign="top" align="right">
                        <asp:Label ID="DiscountsLabel" runat="server"></asp:Label></td>
                </tr>
                <tr runat="server" id="DiscountedSubTotalRow" visible="false">
                    <td class="FormLabel" valign="top" align="left"></td>
                    <td class="FormLabel" valign="top" align="right">
                        <asp:Label ID="DiscountedSubTotalLabel" runat="server"></asp:Label></td>
                </tr>                
                <tr>
                    <td class="FormLabel" valign="top" align="left">
                        Tax:</td>
                    <td class="FormLabel" valign="top" align="right">
                        <asp:Label ID="TaxTotalField" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="FormLabel" valign="top" align="left">
                        Shipping:</td>
                    <td class="FormLabel" valign="top" align="right">
                        <asp:Label ID="ShippingTotalField" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="FormLabel" valign="top" align="left">
                        Handling:</td>
                    <td class="FormLabel" valign="top" align="right">
                        <asp:Label ID="HandlingTotalField" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="FormLabel" valign="top" align="left">
                        &nbsp;
                    </td>
                    <td class="FormLabel" valign="top" align="right" style="border-top: solid 1px #666;">
                        <strong>
                            <asp:Label ID="GrandTotalField" runat="server"></asp:Label></strong></td>
                </tr>
                <tr id="trLoyaltyPointsUsed" runat="server">
	                <td class="FormLabel">
                        <asp:Label ID="LoyaltyPointsUsedLabel" runat="server">Loyalty Points Credit</asp:Label></td>
	                <td class="FormLabel">
                        <asp:Label ID="LoyaltyPointsUsedCurrencyField" runat="server" /> <!--(<asp:Label ID="LoyaltyPointsUsedField" runat="server" />)--></td>
	            </tr>
                <tr class="giftcertrow" id="trGiftCertificateRow" runat="server">
                    <td class="FormLabel" valign="top" align="left">
                        Gift Certificate(s) Credit:</td>
                    <td class="FormLabel" valign="top" align="right">
                        <asp:Label ID="GiftCertificateField" runat="server" /></td>
                </tr>
		        <tr class="amountdue">
		            <td class="FormLabel" valign="top" align="left">
                        <strong>Amount Due:</strong></td>
		            <td class="FormLabel" valign="top" align="right">
                        <strong><asp:Label ID="AmountDueField" runat="server" /></strong></td>
	            </tr>
	            <tr id="trLoyaltyPointsEarned" runat="server">
	                <td class="FormLabel" valign="top" align="left">
                        <asp:Label ID="LoyaltyPointsEarnedLabel" runat="server">Loyalty Points Earned</asp:Label>:</td>
	                <td class="FormLabel" valign="top" align="right">
                        <asp:Label ID="LoyaltyPointsEarnedField" runat="server" /> <!--(<asp:Label ID="LoyaltyPointsEarnedCurrencyField" runat="server" />)--></td>
	            </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <div style="height: 20px;">
            </div>
        </td>
    </tr>
    <tr runat="Server" id="trNotes">
        <td valign="top" class="controlarea2">
            <div id="packagesdiv" runat="server">
                <em>Packages:</em>        
                <asp:GridView ID="PackagesGridView" runat="server" AutoGenerateColumns="False" GridLines="None">
                    <EmptyDataTemplate>No Shipped Packages Available</EmptyDataTemplate>
                    <Columns>                    
                        <asp:TemplateField HeaderText="Shipped Date">                        
                            <ItemTemplate>
                                <asp:Label ID="ShippedDateLabel" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tracking Number">
                            <ItemTemplate>                            
                                <asp:HyperLink ID="TrackingNumberHyperLink" runat="server"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle CssClass="row" />
                    <HeaderStyle CssClass="rowheader" />
                    <AlternatingRowStyle CssClass="alternaterow" />
                </asp:GridView>
            </div>
            <br/>
            <em>Public Notes:</em>
            <asp:GridView GridLines="None" Style="margin-top: 8px;" Width="100%" ID="PublicNotesField"
                runat="server" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="bvin">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="lblAuditDate" runat="server" Text='<%# Bind("AuditDate","{0:d}") %>'></asp:Label><br />
                            <asp:Label ID="NoteField" runat="server" Text='<%# Bind("Note") %>'></asp:Label>                            
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="row" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
        </td>
        <td valign="top" class="controlarea2">
            
        </td>
        <td class="controlarea2" align="left" valign="top">
            <em>Payment Information:</em>
            <table class="controlarea1" style="margin-top: 8px; color: #666; font-size: 11px;"
                border="0" cellspacing="0" cellpadding="3" width="100%">
                <tr>
                    <td colspan="2" class="formfield" style="border-bottom: solid 1px #999;">
                        <asp:Label runat="server" ID="lblPaymentSummary"></asp:Label></td>
                </tr>                
                <tr>
                    <td class="formfield">
                        Payment Received:</td>
                    <td class="formlabel">
                        <asp:Label ID="PaymentChargedField" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="formfield">
                        Gift Card Total:</td>
                    <td class="formlabel">
                        <asp:Label ID="GiftCardAmountLabel" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="formfield">
                        Total:</td>
                    <td class="formlabel">
                        <asp:Label ID="PaymentTotalField" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="formfield" style="border-bottom: solid 1px #999; padding-bottom: 3px;">
                        Refunded:</td>
                    <td class="formlabel" style="border-bottom: solid 1px #999; padding-bottom: 3px;">
                        <asp:Label ID="PaymentRefundedField" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="formfield">
                        Amount Due:</td>
                    <td class="formlabel" style="color: #333;">
                        <strong>
                            <asp:Label ID="PaymentDueField" runat="server"></asp:Label></strong></td>
                </tr>
            </table>
            &nbsp;<br />
            <em>Codes Used:</em><br />
            <asp:Label ID="CouponField" runat="server" CssClass="BVSmallText"></asp:Label>
        </td>
    </tr>
</table>
--%>
<div class="left-half-border">
    <h3 id="OrderNumberHeader" runat="server">
        Order
        <asp:Label ID="OrderNumberField" runat="server" Text="000000" Style="color: #362A12"></asp:Label></h3>
    <asp:Label ID="PONumberLabel" runat="server" Text=""></asp:Label>
    <asp:Label ID="StatusField" runat="server"></asp:Label>
    Sold To:
    <p>
        <asp:Label ID="BillingAddressField" runat="server"></asp:Label>
    </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Panel ID="pnlShipTo" runat="server" Visible="true">
            <span class="lightlabel">Ship To:</span><br />
            <asp:Label ID="ShippingAddressField" runat="server"></asp:Label></asp:Panel>
    </p>
</div>
<div class="right-half">
    <uc1:PrintThisPage ID="PrintThisPage1" runat="server" />
    <p>
        &nbsp;</p>
    <asp:Panel ID="pnlInstructions" runat="server" Visible="false">
        <h3>
            Customer's Instructions:</h3>
        <p>
            <asp:Label ID="InstructionsField" runat="server"></asp:Label></p>
    </asp:Panel>
    <p>
        &nbsp;</p>
    <asp:Panel ID="pnlGiftCertificates" runat="server" Visible="true">
        <h3>
            Gift Certificates:</h3>
        <asp:GridView ID="GiftCertificatesGridView" runat="server" GridLines="None" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="CertificateCode" HeaderText="Certificate Code" />
            </Columns>
            <EmptyDataTemplate>
                <p>
                    None</p>
            </EmptyDataTemplate>
            <EditRowStyle CssClass="row" />
            <HeaderStyle CssClass="rowheader" />
            <AlternatingRowStyle CssClass="alternaterow" />
        </asp:GridView>
    </asp:Panel>
</div>
<div class="clr">
</div>
<asp:GridView GridLines="None" ID="ItemsGridView" runat="server" AutoGenerateColumns="False"
    Width="100%" DataKeyNames="bvin" CssClass="order-history">
    <Columns>
        <asp:TemplateField HeaderStyle-Width="50px" ItemStyle-Width="50px">
            <ItemTemplate>
                <asp:CheckBox ID="SelectedCheckBox" runat="server" Checked="false" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="SKU">
            <ItemTemplate>
                <asp:Label ID="SKUField" runat="server" ToolTip=""></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Product Name">
            <ItemTemplate>
                <asp:Label ID="DescriptionField" runat="server"></asp:Label>
                <asp:PlaceHolder ID="CartInputModifiersPlaceHolder" runat="server"></asp:PlaceHolder>
                <asp:PlaceHolder ID="KitDisplayPlaceHolder" runat="server"></asp:PlaceHolder>
                <asp:Literal ID="lblGiftWrap" runat="server" Text="Gift Wrap - Qty:"></asp:Literal>
                <asp:Literal ID="lblGiftWrapQty" runat="server"></asp:Literal><asp:Literal ID="lblGiftWrapPrice"
                    runat="server"></asp:Literal>
                <asp:Literal ID="lblGiftWrapDetails" runat="server"></asp:Literal>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Shipping" ItemStyle-Width="91px">
            <ItemTemplate>
                <asp:Label ID="ShippingStatusField" runat="server"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Price">
            <ItemTemplate>
                <asp:Label ID="AdjustedPriceField" runat="server" Text='<%# Bind("AdjustedPrice", "{0:c}") %>'></asp:Label><br />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Quantity">
            <ItemTemplate>
                <asp:Label ID="QuantityField" runat="server" Text='<%# Bind("Quantity","{0:#}") %>'></asp:Label><br />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Subtotal">
            <ItemTemplate>
                <asp:Label ID="LineTotalField" runat="server" Text='<%# Bind("LineTotal", "{0:c}") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:Panel ID="pnlReturn" runat="server">
    <asp:ImageButton ID="ReturnItemsImageButton" runat="server" ImageUrl="~/BVModules/Themes/OpticAuthority/Images/ReturnItems.png"
        AlternateText="Return selected items" /><br />
    <div class="errorDiv">
        <asp:Label ID="returnErrorLabel" runat="server" Text="" EnableViewState="False"></asp:Label>
    </div>
    (Please select the items to return and press the "Return Items" button.)
</asp:Panel>
<h3>
    Summary</h3>
<table width="100%" border="0" cellspacing="0" cellpadding="4" class="summary">
    <tr>
        <td>
            SubTotal :
        </td>
        <td>
            <asp:Label ID="SubTotalField" runat="server"></asp:Label>
        </td>
    </tr>
    <tr runat="server" id="DiscountsRow" visible="false">
        <td>
            Discounts :
        </td>
        <td>
            <asp:Label ID="DiscountsLabel" runat="server"></asp:Label>
        </td>
    </tr>
    <tr runat="server" id="DiscountedSubTotalRow" visible="false">
        <td>
        </td>
        <td>
            <asp:Label ID="DiscountedSubTotalLabel" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            Tax :
        </td>
        <td>
            <asp:Label ID="TaxTotalField" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            Shipping :
        </td>
        <td>
            <asp:Label ID="ShippingTotalField" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            Handling :
        </td>
        <td>
            <asp:Label ID="HandlingTotalField" runat="server"></asp:Label>
        </td>
    </tr>
</table>
<div class="below-cart">
    <span class="float-r">Your Price<span class="price">
        <asp:Label ID="GrandTotalField" runat="server"></asp:Label></span></span>
    <div class="clr">
    </div>
</div>
<!--
<table>
    <tr id="trLoyaltyPointsUsed" runat="server">
        <td class="FormLabel">
            <asp:Label ID="LoyaltyPointsUsedLabel" runat="server">Loyalty Points Credit</asp:Label></td>
        <td class="FormLabel">
            <asp:Label ID="LoyaltyPointsUsedCurrencyField" runat="server" /> <!--(<asp:Label ID="LoyaltyPointsUsedField" runat="server" />)-->
</td> </tr>
<tr class="giftcertrow" id="trGiftCertificateRow" runat="server">
    <td class="FormLabel" valign="top" align="left">
        Gift Certificate(s) Credit:
    </td>
    <td class="FormLabel" valign="top" align="right">
        <asp:Label ID="GiftCertificateField" runat="server" />
    </td>
</tr>
<tr class="amountdue">
    <td class="FormLabel" valign="top" align="left">
        <strong>Amount Due:</strong>
    </td>
    <td class="FormLabel" valign="top" align="right">
        <strong>
            <asp:Label ID="AmountDueField" runat="server" /></strong>
    </td>
</tr>
<tr id="trLoyaltyPointsEarned" runat="server">
    <td class="FormLabel" valign="top" align="left">
        <asp:Label ID="LoyaltyPointsEarnedLabel" runat="server">Loyalty Points Earned</asp:Label>:
    </td>
    <td class="FormLabel" valign="top" align="right">
        <asp:Label ID="LoyaltyPointsEarnedField" runat="server" />
        <!--(<asp:Label ID="LoyaltyPointsEarnedCurrencyField" runat="server" />)-->
    </td>
</tr>
</table> -->
<div class="checkout_p_panel" runat="Server" id="trNotes">
    <div id="packagesdiv" runat="server">
        <h3 class="order_hd2_2">
            Packages:</h3>
        <asp:GridView ID="PackagesGridView" runat="server" AutoGenerateColumns="False" GridLines="None">
            <EmptyDataTemplate>
                No Shipped Packages Available</EmptyDataTemplate>
            <Columns>
                <asp:TemplateField HeaderText="Shipped Date">
                    <ItemTemplate>
                        <asp:Label ID="ShippedDateLabel" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tracking Number">
                    <ItemTemplate>
                        <asp:HyperLink ID="TrackingNumberHyperLink" runat="server"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle CssClass="row" />
            <HeaderStyle CssClass="rowheader" />
            <AlternatingRowStyle CssClass="alternaterow" />
        </asp:GridView>
    </div>
    <h3 class="order_hd2_2">
        Public Notice</h3>
    <asp:GridView GridLines="None" Style="margin-top: 8px;" Width="100%" ID="PublicNotesField"
        runat="server" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="bvin">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <p>
                        <asp:Label ID="lblAuditDate" runat="server" Text='<%# Bind("AuditDate","{0:d}") %>'></asp:Label><br />
                        <asp:Label ID="NoteField" runat="server" Text='<%# Bind("Note") %>'></asp:Label>
                    </p>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
</div>
<h3>
    Payment Information</h3>
<p>
    <asp:Label runat="server" ID="lblPaymentSummary"></asp:Label></p>
<table width="100%" border="0" cellspacing="0" cellpadding="4" class="summary">
    <tr>
        <td>
            Payment Received :
        </td>
        <td>
            <asp:Label ID="PaymentChargedField" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            Gift Card Total :
        </td>
        <td>
            <asp:Label ID="GiftCardAmountLabel" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            Total :
        </td>
        <td>
            <asp:Label ID="PaymentTotalField" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            Refunded :
        </td>
        <td>
            <asp:Label ID="PaymentRefundedField" runat="server"></asp:Label>
        </td>
    </tr>
</table>
<div class="below-cart">
    <span class="float-r">Amount Due :<span class="price">
        <asp:Label ID="PaymentDueField" runat="server"></asp:Label></span></span>
    <div class="clr">
    </div>
</div>
<h3 class="order_hd3">
    Codes Used:<span><asp:Label ID="CouponField" runat="server" CssClass="BVSmallText"></asp:Label></span></h3>
