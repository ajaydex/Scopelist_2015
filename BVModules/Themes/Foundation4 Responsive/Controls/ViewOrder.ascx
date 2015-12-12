<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewOrder.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_ViewOrder" %>
<%@ Register Src="~/BVModules/Controls/PrintThisPage.ascx" TagName="PrintThisPage" TagPrefix="uc" %>

<hr />

<div class="row">
    <div class="large-6 columns">
        <h3 id="OrderNumberHeader" runat="server" style="margin-top:0;">Order <asp:Label ID="OrderNumberField" runat="server" Text="000000"></asp:Label></h3>

        <asp:Label ID="PONumberLabel" runat="server" Text=""></asp:Label>

        <p><asp:Label ID="StatusField" runat="server"></asp:Label></p>  
    </div>
    <div class="large-6 columns text-right hide-on-print">
        <uc:PrintThisPage ID="PrintThisPage1" runat="server" />
    </div>
</div>

<div class="row">
    <div class="large-6 small-6 columns">
        <h4>Sold To:</h4>
        <p><asp:Label ID="BillingAddressField" runat="server"></asp:Label></p>
    </div>
    <div class="large-6 small-6 columns">
        <asp:Panel ID="pnlShipTo" runat="server" Visible="true">
            <h4>Ship To:</h4>
            <p><asp:Label ID="ShippingAddressField" runat="server"></asp:Label></p>
        </asp:Panel>
    </div>
</div>

<hr />
    
<asp:GridView GridLines="None" ID="ItemsGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" CssClass="dataTable">
    <Columns>
        <asp:TemplateField ItemStyle-VerticalAlign="top">
            <ItemTemplate>
                <asp:CheckBox ID="SelectedCheckBox" runat="server" Checked="false" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="SKU" ItemStyle-VerticalAlign="top">
            <ItemTemplate>
                <asp:Label ID="SKUField" runat="server"></asp:Label>
                <br />
                <asp:Label ID="DescriptionField" runat="server"></asp:Label>
                <asp:PlaceHolder ID="CartInputModifiersPlaceHolder" runat="server"></asp:PlaceHolder>            
                <asp:PlaceHolder ID="KitDisplayPlaceHolder" runat="server"></asp:PlaceHolder>
                <asp:Literal ID="lblGiftWrap" runat="server" Text="Gift Wrap - Qty:"></asp:Literal>
                <asp:Literal ID="lblGiftWrapQty" runat="server"></asp:Literal>
                <asp:Literal ID="lblGiftWrapPrice" runat="server"></asp:Literal>
                <asp:Literal ID="lblGiftWrapDetails" runat="server"></asp:Literal>
                <br />
                <asp:Label ID="ShippingStatusField" runat="server"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Price" ItemStyle-VerticalAlign="top">
            <ItemTemplate>
                <asp:Label ID="AdjustedPriceField" runat="server" Text='<%# Bind("AdjustedPrice", "{0:c}") %>'></asp:Label><br />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="QTY" ItemStyle-VerticalAlign="top">
            <ItemTemplate>
                <asp:Label ID="QuantityField" runat="server" Text='<%# Bind("Quantity","{0:#}") %>'></asp:Label><br />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Line Total" ItemStyle-VerticalAlign="top">
            <ItemTemplate>
                <asp:Label ID="LineTotalField" runat="server" Text='<%# Bind("LineTotal", "{0:c}") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

<asp:Panel ID="pnlReturn" runat="server">
    <br />
    <p><asp:Placeholder ID="itemsToReturnText" runat="server">Please select the items to return and press the "Return Items" button.</asp:Placeholder></p>
    
    <div class="">
        <asp:Label ID="returnErrorLabel" runat="server" Text="" EnableViewState="False"></asp:Label>
    </div>

    <asp:ImageButton ID="ReturnItemsImageButton" runat="server" ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/ReturnItems.png" AlternateText="Return selected items" />

    
</asp:Panel>

<hr />
    
<asp:Panel ID="pnlInstructions" runat="server" Visible="false">
    <h4>Customer's Instructions:</h4>
    <p><asp:Label ID="InstructionsField" runat="server"></asp:Label></p>
</asp:Panel>

<hr />

<div class="row">
    <div class="large-6 columns">
        <asp:Panel ID="pnlGiftCertificates" runat="server" Visible="true">
            <h4>Gift Certificates</h4>
            <asp:GridView ID="GiftCertificatesGridView" runat="server" GridLines="None" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="CertificateCode" HeaderText="Certificate Code" />
                </Columns>
                <EmptyDataTemplate>
                    <div>None</div>
                </EmptyDataTemplate>
            </asp:GridView>
            <br />
            <br />
        </asp:Panel>
    </div>
    <div class="large-6 columns">
        <table cellspacing="0" cellpadding="0" border="0" class="dataTable">
            <tr>
                <td>
                    Subtotal
                </td>
                <td align="right">
                    <asp:Label ID="SubTotalField" runat="server"></asp:Label>
                </td>
            </tr>
            <tr runat="server" id="DiscountsRow" visible="false">
                <td>
                    Discounts
                </td>
                <td align="right">
                    <asp:Label ID="DiscountsLabel" runat="server"></asp:Label>
                </td>
            </tr>
            <tr runat="server" id="DiscountedSubTotalRow" visible="false">
                <td>&nbsp;</td>
                <td align="right">
                    <asp:Label ID="DiscountedSubTotalLabel" runat="server"></asp:Label>
                </td>
            </tr>                
            <tr>
                <td>
                    Tax
                </td>
                <td align="right">
                    <asp:Label ID="TaxTotalField" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Shipping
                </td>
                <td align="right">
                    <asp:Label ID="ShippingTotalField" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Handling
                </td>
                <td align="right">
                    <asp:Label ID="HandlingTotalField" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td align="right" style="border-top: solid 1px #666;">
                    <strong><asp:Label ID="GrandTotalField" runat="server"></asp:Label></strong>
                </td>
            </tr>
            <tr id="trLoyaltyPointsUsed" runat="server">
	            <td>
                    <asp:Label ID="LoyaltyPointsUsedLabel" runat="server">Loyalty Points Credit</asp:Label>
	            </td>
	            <td>
                    <asp:Label ID="LoyaltyPointsUsedCurrencyField" runat="server" /> 
                    <!--(<asp:Label ID="LoyaltyPointsUsedField" runat="server" />)-->
	            </td>
	        </tr>
            <tr class="giftcertrow" id="trGiftCertificateRow" runat="server">
                <td>Gift Certificate(s) Credit:</td>
                <td align="right">
                    <asp:Label ID="GiftCertificateField" runat="server" />
                </td>
            </tr>
		    <tr class="amountdue">
		        <td>
                    <strong>Amount Due:</strong>
		        </td>
		        <td align="right">
                    <strong><asp:Label ID="AmountDueField" runat="server" /></strong>
		        </td>
	        </tr>
	        <tr id="trLoyaltyPointsEarned" runat="server">
	            <td>
                    <asp:Label ID="LoyaltyPointsEarnedLabel" runat="server">Loyalty Points Earned</asp:Label>:
	            </td>
	            <td align="right">
                    <asp:Label ID="LoyaltyPointsEarnedField" runat="server" /> 
                    <!--(<asp:Label ID="LoyaltyPointsEarnedCurrencyField" runat="server" />)-->
	            </td>
	        </tr>
        </table>
    </div>
</div>

<hr />  

<div runat="Server" id="trNotes" class="row">

    <div class="large-6 columns">
        <div id="packagesdiv" runat="server">
            <h4>Packages</h4>        
            <asp:GridView ID="PackagesGridView" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="datatable">
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
            </asp:GridView>
        </div>

        <h4>Public Notes</h4>
        <asp:GridView GridLines="None" ID="PublicNotesField" runat="server" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="bvin" CssClass="dataTable">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <strong><asp:Label ID="lblAuditDate" runat="server" Text='<%# Bind("AuditDate","{0:d}") %>'></asp:Label></strong><br />
                        <p><asp:Label ID="NoteField" runat="server" Text='<%# Bind("Note") %>'></asp:Label></p> 
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <div class="large-6 columns">
        <h4>Payment Information:</h4>
        <table border="0" cellspacing="0" cellpadding="0" class="dataTable">
            <tr>
                <td colspan="2" style="border-bottom: solid 1px #999;">
                    <asp:Label runat="server" ID="lblPaymentSummary"></asp:Label>
                </td>
            </tr>                
            <tr>
                <td>Payment Received:</td>
                <td align="right">
                    <asp:Label ID="PaymentChargedField" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Gift Card Total:</td>
                <td class="formlabel" align="right">
                    <asp:Label ID="GiftCardAmountLabel" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Total:</td>
                <td align="right">
                    <asp:Label ID="PaymentTotalField" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="border-bottom: solid 1px #999;">Refunded:</td>
                <td style="border-bottom: solid 1px #999;" align="right">
                    <asp:Label ID="PaymentRefundedField" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Amount Due:</td>
                <td style="color: #333;" align="right">
                    <strong><asp:Label ID="PaymentDueField" runat="server"></asp:Label></strong>
                </td>
            </tr>
        </table>
            
        <h4>Codes Used:</h4>
        <asp:Label ID="CouponField" runat="server" CssClass="BVSmallText"></asp:Label>

    </div>

   
    
</div>
