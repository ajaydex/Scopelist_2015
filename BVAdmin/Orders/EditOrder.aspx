<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="EditOrder.aspx.vb" Inherits="BVAdmin_Orders_EditOrder" Title="Untitled Page" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../Controls/AddressEditor.ascx" TagName="AddressEditor" TagPrefix="uc1" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/ProductPicker.ascx" TagName="ProductPicker" TagPrefix="uc3" %>
<%@ Register Src="../Controls/UserPicker.ascx" TagName="UserPicker" TagPrefix="uc5" %>
<%@ Register Src="../../BVModules/Controls/VariantsDisplay.ascx" TagName="VariantsDisplay" TagPrefix="uc6" %>
<%@ Register src="../Controls/KitComponentsDisplay.ascx" tagname="KitComponentsDisplay" tagprefix="uc4" %>
<%@ Register Src="../../BVModules/Controls/AddressBookSimple.ascx" TagName="AddressBookSimple" TagPrefix="uc9" %>
<%@ Register Src="~/BVAdmin/Controls/OrderDetailsButtons.ascx" TagName="OrderDetailsButtons" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <anthem:Panel AutoUpdateAfterCallBack="true" runat="server">
	    
        <div class="f-row">
    	    <div class="six columns">
	            <h1>Edit Order <asp:Label ID="OrderNumberField" runat="server" Text="000000"></asp:Label></h1> 
            </div>
            <div class="six columns">
                <asp:Panel ID="pnlSalesPerson" runat="server">
                    <table cellspacing="0" cellpadding="0" border="0" style="float:right;margin: 10px 0 0;">
                        <tbody>
                            <tr>
                                <td class="formlabel text-right"><asp:Label ID="lblSalesPerson" AssociatedControlID="ddlSalesPerson" Text="Sales Person" runat="server" /></td>
                                <td class="formfield"><asp:DropDownList ID="ddlSalesPerson" AppendDataBoundItems="true" runat="server" /></td>
                            </tr>
                        </tbody>
                    </table>
                </asp:Panel>
            </div>
        </div> 
    
        <asp:ImageButton OnClientClick="return window.confirm('Delete this order forever?');" ID="btnDelete" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" AlternateText="Delete Order" CausesValidation="false" />

        <uc2:MessageBox ID="MessageBox1" runat="server" />
    
        <hr />
        <asp:Label ID="StatusField" runat="server"></asp:Label>
        <table border="0" cellspacing="0" cellpadding="0" style="float:right;width: 200px;">
            <tr>
                <td align="left">
                    <asp:ImageButton ID="btnPreviousStatus" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Left.png" />
                </td>
                <td align="center">
                    <asp:Label ID="lblCurrentStatus" Text="Unknown" runat="server"></asp:Label>
                </td>
                <td align="right">
                    <asp:ImageButton ID="btnNextStatus" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/right.png" />
                </td>
            </tr>
        </table>
        <hr />

        <div class="f-row">
    	    <div class="ten columns">

        	    <asp:Panel ID="pnlAdd" runat="server" DefaultButton="btnAddProductBySku">
                    <div style="background:#C0C0C0; padding:15px;">
                        Add SKU:
                        <asp:TextBox ID="NewSkuField" runat="Server" Columns="20" TabIndex="200"></asp:TextBox>
                        <asp:ImageButton ID="btnBrowseProducts" runat="server" AlternateText="Browse Products" CausesValidation="False" ImageUrl="~/BVAdmin/Images/Buttons/Browse.png" />&nbsp;
                        Quantity:
                        <asp:TextBox ID="NewProductQuantity" runat="server" Text="1" Columns="4" TabIndex="210"></asp:TextBox>
                        <asp:ImageButton CausesValidation="false" ID="btnAddProductBySku" runat="server" AlternateText="Add Product To Order" ImageUrl="~/BVAdmin/Images/Buttons/AddToOrder.png" TabIndex="220" />
                        <asp:HiddenField ID="AddProductSkuHiddenField" runat="server" />
                    </div>
                
                    <asp:Panel ID="pnlProductPicker" runat="server" Visible="false">
                        <div style="background:#C0C0C0; padding:15px;">
                            <uc3:ProductPicker ID="ProductPicker1" runat="server" IsMultiSelect="false" DisplayPrice="true" DisplayInventory="false" DisplayKits="true" />
                        
                            <br />
                            <asp:ImageButton ID="btnProductPickerCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Close.png" AlternateText="Close Browser" />
                            <asp:ImageButton ID="btnProductPickerOkay" runat="server" AlternateText="Add Product To Order" CausesValidation="false" ImageUrl="~/BVAdmin/Images/Buttons/AddToOrder.png" />
                        </div>
                    </asp:Panel>
                
                    <asp:Panel ID="pnlProductChoices" runat="server" Visible="false">
                        <div style="padding:15px;">
                            <asp:Panel ID="AddLineVariantsDisplayContainer" runat="server">
                                <uc6:VariantsDisplay ID="VariantsDisplay1" runat="server" />
                            </asp:Panel>
                            <uc4:KitComponentsDisplay ID="AddNewKitComponentsDisplay" runat="server" />
                            <br />
                            <asp:ImageButton ID="btnCloseVariants" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Close.png" AlternateText="Close Browser" />&nbsp;
                            <asp:ImageButton CausesValidation="false" ID="btnAddVariant" runat="server" AlternateText="Add Product To Order" ImageUrl="~/BVAdmin/Images/Buttons/AddToOrder.png" TabIndex="222" />
                        </div>
                    </asp:Panel>
                </asp:Panel> 
            
                <asp:Panel ID="pnlEditLineItem" runat="server" Visible="false" DefaultButton="btnCancelLineEdit">
                    <div style="padding: 5px 15px 10px;">
                        <h3>Edit Line Item</h3>
                        <asp:HiddenField ID="EditLineBvin" runat="server" />
                        <asp:Label ID="lblLineEdit" runat="server"></asp:Label>                    
                        <asp:Panel ID="EditLineVariantsDisplayContainer" runat="server">
                            <uc6:VariantsDisplay ID="EditLineVariantsDisplay" runat="server" AllowCallBacks="false" />
                        </asp:Panel>
                        <uc4:KitComponentsDisplay ID="EditLineKitComponentsDisplay" runat="server" />
                	    <br />
                        <asp:ImageButton ID="btnCancelLineEdit" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" AlternateText="Cancel" CausesValidation="False" /> 
                        <asp:ImageButton ID="btnSaveLineEdit" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" AlternateText="Update Line" CausesValidation="false" />
                    </div>
                </asp:Panel>
            
                <asp:GridView Style="margin: 20px 0" GridLines="None" ID="ItemsGridView" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="bvin">
                    <Columns>                     
                        <asp:TemplateField HeaderText="SKU">
                            <ItemTemplate>
                                <asp:Label ID="SKUField" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Item">
                            <ItemTemplate>
                                <asp:Label ID="DescriptionField" runat="server"></asp:Label>
                                <asp:PlaceHolder ID="CartInputModifiersPlaceHolder" runat="server"></asp:PlaceHolder>
                                <asp:PlaceHolder ID="KitDisplayPlaceHolder" runat="server"></asp:PlaceHolder>                               
                            </ItemTemplate>
                        </asp:TemplateField>                      
                        <asp:TemplateField HeaderText="Price">
                            <ItemTemplate>
                                <asp:TextBox ID="PriceField" cssclass="inputPrice" runat="server" Text='<%# Bind("AdjustedPrice","{0:c}") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>                            
                                <asp:TextBox ID="QtyField" cssclass="inputQty" runat="server" Text='<%# Bind("Quantity","{0:0}") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Line Total">
                            <ItemTemplate>
                                <asp:Label ID="LineTotalField" runat="server" Text='<%# Bind("LineTotal", "{0:c}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Update"
                                    ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" AlternateText="Edit" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                    ImageUrl="~/BVAdmin/Images/Buttons/x.png" AlternateText="Delete" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="row" />
                    <HeaderStyle CssClass="rowheader" />
                    <AlternatingRowStyle CssClass="alternaterow" />
                </asp:GridView> 
          
                <br />
            
                <div class="text-right">
                    <asp:LinkButton ID="RecalculateOffersLinkButton" runat="server" CssClass="button secondary">Calculate Offers</asp:LinkButton>
                    &nbsp;
                    <asp:LinkButton ID="RecalculateProductPrices" runat="server"  CssClass="button secondary">Recalculate Product Prices</asp:LinkButton>
                </div>
            
                <hr />
            
        	    <div class="f-row">
                    <div class="seven columns">
                        <uc5:UserPicker ID="UserPicker1" runat="server" />  
                        <asp:HiddenField ID="UserIdField" runat="server" />
                    </div>
                    <div class="five columns">          
                        <h5>Email Address:</h5>
                        <asp:TextBox TabIndex="1000" ID="UserEmailField" runat="server" Columns="40"></asp:TextBox>
                    </div>
                </div>
            
                <hr />
    
                <div class="f-row">
                    <div class="six columns">
                        <h5>Sold To:</h5>
                        <anthem:Panel ID="pnlBillingAddressBook" runat="server">
                            <uc9:AddressBookSimple ID="BillingAddressBook" AddressType="Billing" AddressFormat="<strong>[[FirstName]] [[LastName]]</strong> [[Line1]], [[City]], [[RegionName]] [[PostalCode]]" runat="server" />
                        </anthem:Panel>
                        <uc1:AddressEditor TabOrderOffSet="2000" ID="BillingAddressEditor" runat="server" />
                    </div>
                    <div class="six columns">
                        <h5>Ship To:</h5>
                        <anthem:Panel ID="pnlShippingAddressBook" runat="server">
                            <uc9:AddressBookSimple ID="ShippingAddressBook" AddressType="Shipping" AddressFormat="<strong>[[FirstName]] [[LastName]]</strong> [[Line1]], [[City]], [[RegionName]] [[PostalCode]]" runat="server" />
                        </anthem:Panel>
                        <uc1:AddressEditor TabOrderOffSet="2500" ID="ShippingAddressEditor" runat="server" />
                    </div>
                </div>
            
                <hr />
            
                <div class="f-row">
                    <div class="seven columns">
                        <asp:Panel ID="pnlInstructions" runat="server">
                            <h5>Customer's Instructions:</h5>
                            <asp:TextBox ID="InstructionsField" runat="server" Columns="33" TextMode="multiLine" Wrap="true" Rows="5"></asp:TextBox>
    				    </asp:Panel>
                    
                        <asp:Panel ID="pnlCoupons" runat="server" DefaultButton="btnAddCoupon"> 
                            <h5>Add Promotional Codes</h5>
                            <asp:TextBox ID="CouponField" runat="server"></asp:TextBox>
                            <asp:ImageButton ID="btnAddCoupon" runat="server" AlternateText="Add Code to Order" CausesValidation="false" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" />
                    
                            <h5>Promotional Codes In Use</h5>
                            <asp:ListBox ID="lstCoupons" style="display:block;width:100%!important;" runat="server" DataTextField="CouponCode" DataValueField="CouponCode" Rows="4" SelectionMode="Multiple"></asp:ListBox>
                            <asp:ImageButton ID="btnDeleteCoupon" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" AlternateText="Delete Codes" />
                        </asp:Panel>
                    </div>
                    <div class="five columns">
                	    <h5>Order Total</h5>
                        <table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
                            <tr>
                                <td class="FormLabel">SubTotal:</td>
                                <td class="FormLabel" align="right">
                                    <asp:Label ID="SubTotalField" runat="server"></asp:Label>
                           	    </td>
                            </tr>
                            <tr><td colspan="2"><hr class="short" /></td></tr>
                            <tr>
                         	    <td class="FormLabel">Discounts:</td>
                                <td class="FormLabel" align="right">
                                    (<asp:Label ID="OrderDiscountsField" runat="server"></asp:Label>)
                           	    </td>
                            </tr>
                            <tr><td colspan="2"><hr class="short" /></td></tr>
                            <tr>
                                <td class="FormLabel">Tax: &nbsp; <asp:Checkbox ID="TaxExemptField" Text="<em>Exempt</em>" AutoPostBack="true" runat="server" CssClass="checkBox"></asp:Checkbox>
                                </td>
                                <td class="FormLabel" align="right">
                                    <asp:Label ID="TaxTotalField" runat="server"></asp:Label>
                           	    </td>
                            </tr>
                            <tr><td colspan="2"><hr class="short" /></td></tr>
                            <tr>
                                <td class="FormLabel">
                                    <asp:DropDownList ID="ShippingRatesList" runat="server" AutoPostBack="true" /></td>
                                <td class="FormLabel" align="right">                            
                                    <asp:TextBox ID="ShippingTotalTextBox" runat="server" AutoPostBack="true" Columns="8" style="text-align:right;"></asp:TextBox>
                                    
                                    <bvc5:BVRequiredFieldValidator ID="ShippingRatesListBVRequiredFieldValidator" InitialValue="" runat="server" ControlToValidate="ShippingRatesList" Display="Dynamic" ErrorMessage="Shipping Method Required"></bvc5:BVRequiredFieldValidator>
                                    <bvc5:BVRequiredFieldValidator ID="ShippingTotalBVRequiredFieldValidator" InitialValue="" runat="server" ControlToValidate="ShippingTotalTextBox" Display="Dynamic" ErrorMessage="Shipping Total Required"></bvc5:BVRequiredFieldValidator>
                                    <bvc5:BVCustomValidator ID="ShippingTotalBVCustomValidator" runat="server" ControlToValidate="ShippingTotalTextBox" Display="Dynamic" ErrorMessage="Shipping total must be a monetary value"></bvc5:BVCustomValidator>
                                
                                </td>
                            </tr>
                            <tr><td colspan="2"><hr class="short" /></td></tr>
                            <tr>
                         	    <td class="FormLabel">Shipping Discounts:</td>
                                <td class="FormLabel" align="right">
                                    (<asp:Label ID="ShippingDiscountsField" runat="server"></asp:Label>)
                           	    </td>
                            </tr>
                            <tr><td colspan="2"><hr class="short" /></td></tr>
                            <tr>
                                <td class="FormLabel">Handling:</td>
                                <td class="FormLabel" align="right">
                                    <asp:Label ID="HandlingTotalField" runat="server"></asp:Label>
                           	    </td>
                            </tr>
                            <tr><td colspan="2"><hr class="short" /></td></tr>
                            <tr>
                                <td class="FormLabel">Admin Discounts:</td>
                                <td class="FormLabel" align="right">
                                    &ndash; <asp:TextBox ID="OrderDiscountAdjustments" AutoPostBack="true" runat="server" Columns="8" style="text-align:right;"></asp:TextBox>
                           	    </td>
                            </tr>
                            <tr><td colspan="2"><hr class="short" /></td></tr>
                            <tr> 
                                <td class="FormLabel">&nbsp;</td>
                                <td class="FormLabel" align="right">
                                    <strong>
                                        <asp:Label ID="GrandTotalField" runat="server"></asp:Label>
                               	    </strong>
                           	    </td>
                            </tr>                                      
    				    </table>
                    </div>
                </div>
            
                <hr />
            
                <h5>Payment Information:</h5>
                <div class="controlarea1">
                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td colspan="2" class="formfield" style="border-bottom: solid 1px #999;">
                                <asp:Label runat="server" ID="lblPaymentSummary"></asp:Label>
                       	    </td>
                        </tr>
                        <tr>
                            <td class="formfield">
                                Authorized:</td>
                            <td class="formlabel">
                                <asp:Label ID="PaymentAuthorizedField" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td class="formfield">
                                Charged:</td>
                            <td class="formlabel">
                                <asp:Label ID="PaymentChargedField" runat="server"></asp:Label></td>
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
                </div>
                <hr />
            
                <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" AlternateText="Cancel" CausesValidation="False" />
                &nbsp;
                <asp:ImageButton ID="btnSaveChanges" AlternateText="Save Changes" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
            
            
            </div>
            <div class="two columns text-right">
        	    <uc:OrderDetailsButtons ID="ucOrderDetailsButtons" runat="server" />
            </div>
        </div>
        <asp:HiddenField ID="BvinField" runat="server" />
    </anthem:Panel>
</asp:Content>