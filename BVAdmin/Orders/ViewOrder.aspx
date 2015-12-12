<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="ViewOrder.aspx.vb" Inherits="BVAdmin_Orders_ViewOrder" Title="Untitled Page" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<%@ Register Src="~/BVAdmin/Controls/OrderDetailsButtons.ascx" TagName="OrderDetailsButtons" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
	<h1>Order <asp:Label ID="OrderNumberField" runat="server" Text="000000"></asp:Label></h1>
	<asp:Label ID="TimeOfOrderField" runat="server"></asp:Label>
    <uc1:MessageBox ID="MessageBox1" runat="server" /><br />
    
    <hr />
    <asp:Label ID="StatusField" runat="server"></asp:Label>
    <table id="tblOrderStatus" border="0" cellspacing="0" cellpadding="0" style="float:right;width: 200px;" runat="server">
        <tr>
            <td align="left">
                <asp:ImageButton ID="btnPreviousStatus" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Left.png" />
            </td>
            <td align="center">
                &nbsp;<asp:Label ID="lblCurrentStatus" Text="Unknown" runat="server"></asp:Label>&nbsp;
            </td>
            <td align="right">
                <asp:ImageButton ID="btnNextStatus" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/right.png" />
            </td>
        </tr>
    </table>
    <hr />
   
    <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
        	<td valign="top"  colspan="2">
            	<table border="0" cellspacing="0" cellpadding="0" width="100%">
                	<tr>
                    	<td>
                            <span class="lightlabel">Sales Person:</span><br /> 
                            <asp:Label ID="lblSalesPerson" runat="server" /><br /><br />

                        	<span class="lightlabel">Sold To:</span><br />
                			<asp:Label ID="BillingAddressField" runat="server"></asp:Label>
                			<asp:Literal ID="EmailAddressField" runat="server"></asp:Literal>
                        </td>
                        <td>
                        	<asp:Panel ID="pnlShipTo" runat="server" Visible="true">
                                <span class="lightlabel">Ship To:</span><br />
                                <asp:Label ID="ShippingAddressField" runat="server"></asp:Label>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top" align="right">
                <uc:OrderDetailsButtons ID="ucOrderDetailsButtons" runat="server" />
                <asp:HyperLink ID="lnkPlaceOrder" ImageUrl="~/BVAdmin/Images/Buttons/PlaceOrder.png" ToolTip="Convert shopping cart into order" Visible="false" runat="server" />
            </td>
        </tr>
  	</table>
    
    <asp:GridView Style="margin: 20px 0px 20px 0px;" GridLines="None" ID="ItemsGridView" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="bvin">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="SelectedCheckBox" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="SKU">
                <ItemTemplate>
                    <asp:Label ID="SKUField" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Item">
                <ItemTemplate>
                    <div><asp:Label ID="DescriptionField" runat="server"></asp:Label></div>
                    <div><asp:PlaceHolder ID="CartInputModifiersPlaceHolder" runat="server"></asp:PlaceHolder></div>
                    <div><asp:PlaceHolder ID="KitDisplayPlaceHolder" runat="server"></asp:PlaceHolder></div>
                    <div><asp:Literal ID="lblGiftWrap" runat="server" Text="Gift Wrap"></asp:Literal></div>
                    <div><asp:Literal ID="lblGiftWrapDetails" runat="server"></asp:Literal></div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Shipping">
                <ItemTemplate>
                    <asp:Label ID="ShippingStatusField" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Price">
                <ItemTemplate>
                    <asp:Label ID="AdjustedPriceField" runat="server" Text='<%# Bind("AdjustedPrice", "{0:c}") %>'></asp:Label><asp:Literal ID="lblGiftWrapPrice" runat="server"></asp:Literal>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Quantity">
                <ItemTemplate>
                    <asp:Label ID="QuantityField" runat="server" Text='<%# Bind("Quantity","{0:#}") %>'></asp:Label>
                    <asp:Literal ID="lblGiftWrapQty" runat="server"></asp:Literal>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Line Total">
                <ItemTemplate>
                    <asp:Label ID="LineTotalField" runat="server" Text='<%# Bind("LineTotal", "{0:c}") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
    
    <asp:ImageButton ID="btnRMA" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/ReturnSelectedItems.png" AlternateText="Create RMA" />

    <table border="0" cellspacing="0" cellpadding="0" width="100%">    	
        <tr>
            <td valign="top">
                <asp:Panel ID="pnlInstructions" runat="server" Visible="false">
                    <em>Customer's Instructions:</em><br />
                    <asp:Label ID="InstructionsField" runat="server"></asp:Label></asp:Panel>
                &nbsp;
            </td>
            <td valign="top">
                &nbsp;
            </td>
            <td valign="top" align="right">
                <table cellspacing="0" cellpadding="2" width="200" border="0">
                    <tr>
                        <td class="FormLabel" valign="top" align="left">
                            SubTotal:</td>
                        <td class="FormLabel" valign="top" align="right">
                            <asp:Label ID="SubTotalField" runat="server"></asp:Label></td>
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
                            Admin Discounts:</td>
                        <td class="FormLabel" valign="top" align="right">
                            <asp:Label ID="AdminDiscountsField" runat="server"></asp:Label></td>                    
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
	                    <td class="FormLabel"><asp:Label ID="LoyaltyPointsUsedLabel" runat="server">Loyalty Points Credit</asp:Label>:</td>
	                    <td class="FormLabel" align="right"><strong><asp:Label ID="LoyaltyPointsUsedCurrencyField" runat="server" /></strong> <!--(<asp:Label ID="LoyaltyPointsUsedField" runat="server" />)--></td>
	                </tr>
                    <tr class="giftcertrow" id="giftCertificateRow" runat="server">
                        <td class="FormLabel" valign="top" align="left">Gift Certificate(s):</td>
                        <td class="FormLabel" valign="top" align="right"><strong><asp:Label ID="GiftCertificateField" runat="server" /></strong></td>
                    </tr>
                    <tr class="giftcertrow">
                        <td class="FormLabel" valign="top" align="left"><strong>Total Received:</strong></td>
                        <td class="FormLabel" valign="top" align="right"><strong><asp:Label ID="AmountDueField" runat="server" /></strong></td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr id="trLoyaltyPointsEarned" runat="server">
	                    <td class="FormLabel"><asp:Label ID="LoyaltyPointsEarnedLabel" runat="server">Loyalty Points Earned</asp:Label>:</td>
	                    <td class="FormLabel" align="right"><asp:Label ID="LoyaltyPointsEarnedField" runat="server" /> (<asp:Label ID="LoyaltyPointsEarnedCurrencyField" runat="server" />)</td>
	                </tr>
                </table>
                
                <br />
                <br />
                <asp:DropDownList ID="lstEmailTemplate" runat="server"></asp:DropDownList>
               	<br />
                <br />
                <asp:ImageButton ImageUrl="~/BVAdmin/Images/Buttons/Email.png" ID="btnSendStatusEmail" runat="server" ToolTip="Send Update by Email" AlternateText="Send Update By Email" />
            </td>
        </tr>
  	</table>
    
    <div class="f-row">
    	<div class="twelve columns">
        	<hr />
        </div>
   	</div>
    
    <div class="f-row">
    	<div class="six columns">
        	<h2>Private Notes</h2>
            <asp:GridView GridLines="None" ID="PrivateNotesField" runat="server"  ShowHeader="false" AutoGenerateColumns="False" Width="100%" DataKeyNames="bvin">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="lblAuditDate" runat="server" Text='<%# Bind("AuditDate","{0:d} {0:T}") %>'></asp:Label>
                            <br />
                            <asp:Label ID="NoteField" runat="server" Text='<%# Bind("Note") %>'></asp:Label>
                            <br />
                            <asp:ImageButton ID="btnDeleteNote" runat="server" ImageUrl="~/bvadmin/images/buttons/delete.png"
                                    CommandName="Delete" CommandArgument='<%# Bind("bvin") %>' AlternateText="DeleteNote"
                                    OnClientClick="return window.confirm('Delete this note?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                
                <RowStyle CssClass="row" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
            <br />
            <asp:TextBox ID="NewPrivateNoteField" runat="server" ToolTip="Add a new note to this order" Rows="3" TextMode="MultiLine"></asp:TextBox>
            <br />
            <br />
            <asp:ImageButton ID="btnNewPrivateNote" runat="server" ImageUrl="~/bvadmin/images/buttons/new.png"></asp:ImageButton>
            
            <hr />
            
            <h2>Public Notes</h2>
            <asp:GridView GridLines="None" Style="margin-top: 8px;" Width="100%" ID="PublicNotesField" runat="server" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="bvin">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="lblAuditDate" runat="server" Text='<%# Bind("AuditDate","{0:d}  {0:T}") %>'></asp:Label><br />
                            <asp:Label ID="NoteField" runat="server" Text='<%# Bind("Note") %>'></asp:Label>
                            <div style="width: 75px; height: 30px; float: right;">
                                <asp:ImageButton ID="btnDeleteNote" runat="server" ImageUrl="~/bvadmin/images/buttons/delete.png"
                                    CommandName="Delete" CommandArgument='<%# Bind("bvin") %>' AlternateText="DeleteNote"
                                    OnClientClick="return window.confirm('Delete this note?');" /></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="row" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
            <asp:TextBox ID="NewPublicNoteField" runat="server" Columns="33" ToolTip="Add a new note to this order" Rows="3" TextMode="MultiLine"></asp:TextBox>
            <br />
            <br />
            <asp:ImageButton ID="btnNewPublicNote" runat="server" ImageUrl="~/bvadmin/images/buttons/new.png"></asp:ImageButton>
        </div>
        
        <div class="six columns">
            <h2>Payment Information</h2>
            <div class="controlarea1">
                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                        <td colspan="2" class="formfield" style="border-bottom: solid 1px #999;">
                            <asp:Label runat="server" ID="lblPaymentSummary"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="formfield">Authorized:</td>
                        <td class="formlabel">
                            <asp:Label ID="PaymentAuthorizedField" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="formfield">Charged:</td>
                        <td class="formlabel">
                            <asp:Label ID="PaymentChargedField" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="formfield" style="border-bottom: solid 1px #999; padding-bottom: 3px;">Refunded:</td>
                        <td class="formlabel" style="border-bottom: solid 1px #999; padding-bottom: 3px;">
                            <asp:Label ID="PaymentRefundedField" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="formfield">Amount Due:</td>
                        <td class="formlabel" style="color: #333;">
                            <strong><asp:Label ID="PaymentDueField" runat="server"></asp:Label></strong>
                        </td>
                    </tr>
                </table>
            </div>
                        
            <h2>Codes Used</h2>
            <asp:Label ID="CouponField" runat="server" CssClass="BVSmallText" />
        </div>
    </div>
        
    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>
