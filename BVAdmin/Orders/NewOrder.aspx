<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="NewOrder.aspx.vb" Inherits="BVAdmin_Orders_NewOrder" Title="Create New Order" %>
<%@ Register Src="../../BVModules/Controls/GiftCertificates.ascx" TagName="GiftCertificates" TagPrefix="uc7" %>
<%@ Register Src="../../BVModules/Controls/VariantsDisplay.ascx" TagName="VariantsDisplay" TagPrefix="uc6" %>
<%@ Register Src="../Controls/UserPicker.ascx" TagName="UserPicker" TagPrefix="uc5" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../../BVModules/Controls/CreditCardInput.ascx" TagName="CreditCardInput" TagPrefix="uc4" %>
<%@ Register Src="../Controls/ProductPicker.ascx" TagName="ProductPicker" TagPrefix="uc3" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/AddressEditor.ascx" TagName="AddressEditor" TagPrefix="uc1" %>
<%@ Register src="../Controls/KitComponentsDisplay.ascx" tagname="KitComponentsDisplay" tagprefix="uc8" %>
<%@ Register Src="../../BVModules/Controls/AddressBookSimple.ascx" TagName="AddressBookSimple" TagPrefix="uc9" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <anthem:Panel AutoUpdateAfterCallBack="true" runat="server">

        <div class="f-row">
    	    <div class="six columns">
	            <h1>New Order</h1>
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
        


        <uc2:MessageBox ID="MessageBox1" runat="server" />
    
        <hr />
    	    <asp:Label ID="StatusField" runat="server"></asp:Label>
        <hr />
        
        
        <asp:Panel ID="pnlEditLineItem" runat="server" Visible="false" DefaultButton="btnCancelLineEdit">
            <div class="controlarea1">
                <h3>Edit Line Item</h3>
                <asp:HiddenField ID="EditLineBvin" runat="server" />
                <asp:Label ID="lblLineEdit" runat="server"></asp:Label>                    
                <asp:Panel ID="EditLineVariantsDisplayContainer" runat="server">
                    <uc6:VariantsDisplay ID="EditLineVariantsDisplay" runat="server" AllowCallBacks="false" />
                </asp:Panel>
                <uc8:KitComponentsDisplay ID="EditLineKitComponentsDisplay" runat="server" />
                <br />
                <asp:ImageButton ID="btnCancelLineEdit" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" AlternateText="Cancel" CausesValidation="False" /> 
                <asp:ImageButton ID="btnSaveLineEdit" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" AlternateText="Update Line" CausesValidation="false" />
            </div>
        </asp:Panel>
    
        <asp:GridView Style="margin: 20px 0px;" GridLines="None" ID="ItemsGridView" DataKeyNames="bvin" runat="server" AutoGenerateColumns="False" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Product">
                    <ItemTemplate>
                        <div class="CartItemDescription">
                            <asp:Label ID="lblDescription" runat="server"></asp:Label>                                    
                            <asp:PlaceHolder ID="CartInputModifiersPlaceHolder" runat="server"></asp:PlaceHolder>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Price">
                    <ItemTemplate>                                
                        <asp:TextBox ID="PriceField" cssclass="inputPrice" runat="server" Text='<%# Bind("AdjustedPrice","{0:c}") %>'></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <asp:TextBox ID="QtyField" cssclass="inputQty" runat="server" Text='<%# Bind("Quantity","{0:#}") %>'></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("LineTotal", "{0:c}") %>'></asp:Label>
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
        
            <EditRowStyle CssClass="row" />
            <HeaderStyle CssClass="rowheader" />
            <AlternatingRowStyle CssClass="alternaterow" />
        </asp:GridView>
    
        <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
            <tr>
                <td align="right">
                    Sub Total: <strong><asp:Label ID="SubTotalField2" runat="server"></asp:Label></strong>
                    <br />
                    <asp:ImageButton ID="btnUpdateQuantities" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Update-small.png" AlternateText="Update" CausesValidation="False" TabIndex="100" />
                </td>
            </tr>
        </table>
    
        <hr />

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
                    <uc3:ProductPicker ID="ProductPicker1" runat="server" IsMultiSelect="false" DisplayPrice="true" DisplayInventory="true" DisplayKits="true" />
                    <br />
                    <asp:ImageButton ID="btnProductPickerCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Close.png" AlternateText="Close Browser" />
                    <asp:ImageButton ID="btnProductPickerOkay" runat="server" AlternateText="Add Product To Order" CausesValidation="false" ImageUrl="~/BVAdmin/Images/Buttons/AddToOrder.png" />
                </div>
            </asp:Panel>
        
            <asp:Panel ID="pnlProductChoicesBase" runat='server' Visible="true">
                <asp:Panel ID="pnlProductChoices" runat="server" Visible="false" style="background:#C0C0C0; padding:15px;">
                    <asp:Panel ID="AddLineVariantsDisplayContainer" runat="server">
                    <uc6:VariantsDisplay ID="VariantsDisplay1" runat="server" />
                    </asp:Panel>
                    <uc8:KitComponentsDisplay ID="AddNewKitComponentsDisplay" runat="server" />
                    <br />
                    <asp:ImageButton ID="btnCloseVariants" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Close.png" AlternateText="Close Browser" />&nbsp;
                    <asp:ImageButton CausesValidation="false" ID="btnAddVariant" runat="server" AlternateText="Add Product To Order" ImageUrl="~/BVAdmin/Images/Buttons/AddToOrder.png" TabIndex="222" />
                </asp:Panel>
            </asp:Panel>
        </asp:Panel>                
            
    
        <hr />
    
        <div class="f-row">
    	    <div class="six columns">
        	    <h5><asp:Label ID="EmailAddressLabel" runat="server" Text="E-mail:"></asp:Label></h5>
                <asp:TextBox ID="EmailAddressTextBox" runat="server" TabIndex="3000" Columns="40"></asp:TextBox><asp:RegularExpressionValidator ID="EmailRegularExpressionValidator" runat="server" ControlToValidate="EmailAddressTextBox" ErrorMessage="Invalid E-mail Address." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                <br />
                <br />
        
                <h5>Ship To:</h5>
                <anthem:Panel ID="pnlShippingAddressBook" AutoUpdateAfterCallBack="true" runat="server">
                    <uc9:AddressBookSimple ID="ShippingAddressBook" AddressType="Shipping" AddressFormat="<strong>[[FirstName]] [[LastName]]</strong> [[Line1]], [[City]], [[RegionName]] [[PostalCode]]" runat="server" />
                </anthem:Panel>
                <uc1:AddressEditor ID="ShipToAddress" runat="server" TabOrderOffSet="1000" ShowCounty="true" />
                <br />
                <br />
              
                <asp:CheckBox ID="chkBillToSame" Checked="true" runat="server" AutoPostBack="true" Text="Bill to Same Address" />
                <br />
                <br />
            
                <anthem:Panel ID="pnlBillTo" AutoUpdateAfterCallBack="true" runat="server" Visible="false">
                    <h5>Bill To:</h5>
                    <uc9:AddressBookSimple ID="BillingAddressBook" AddressType="Billing" AddressFormat="<strong>[[FirstName]] [[LastName]]</strong> [[Line1]], [[City]], [[RegionName]] [[PostalCode]]" runat="server" />
                    <uc1:AddressEditor ID="BillToAddress" runat="server" TabOrderOffSet="2000" ShowCounty="true" />
                </anthem:Panel>
            </div>
            <div class="six columns">
                <div class="controlarea1">
                    <ul class="tabs">
                        <li><asp:LinkButton ID="btnFindUsers" CausesValidation="false" Text="Find Users" CssClass="active" runat="server" /></li>
                        <li><asp:LinkButton ID="btnNewUsers" CausesValidation="false" Text="New User" runat="server" /></li>
                        <li><asp:LinkButton ID="btnFindOrders" CausesValidation="false" Text="Find Orders" runat="server" /></li>
                    </ul>
                    <br />
                    <br />
                    <asp:MultiView ID="viewFindUsers" runat="server" ActiveViewIndex="0">
                        <asp:View ID="ViewFind" runat="server">
                            <strong>Search for User</strong><br />
                            <asp:Label ID="lblFindUserMessage" runat="server"></asp:Label>
                            <asp:Panel ID="pnlFindUser" runat="server" DefaultButton="btnFindUser">
                                <table border="0" cellspacing="0" cellpadding="0">           
                                    <tr>
                                        <td class="formlabel">
                                            Email:</td>
                                        <td class="formfield">
                                            <asp:TextBox ID="FindUserEmailField" runat="server" Columns="30"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="formlabel">
                                            First Name:</td>
                                        <td class="formfield">
                                            <asp:TextBox ID="FindUserFirstNameField" runat="server" Columns="30"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="formlabel">
                                            Last Name:</td>
                                        <td class="formfield">
                                            <asp:TextBox ID="FindUserLastNameField" runat="server" Columns="30"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="formlabel">&nbsp;
                                            </td>
                                        <td class="formfield">
                                            <asp:Button ID="btnFindUser" runat="server" Text="Find User(s)" CausesValidation="false" />
                                            </td>
                                    </tr>
                                </table>
                            </asp:Panel>  
                        
                            <asp:GridView ShowHeader="false" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="260">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblUsername" runat="server" Text='<%# Bind("Username") %>'>'></asp:Label><br />
                                            <span class="smalltext">
                                                <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("Email") %>'>'></asp:Label><br />
                                                <asp:Label ID="lblFirstName" runat="server" Text='<%# Bind("FirstName") %>'>'></asp:Label>
                                                <asp:Label ID="lblLastName" runat="server" Text='<%# Bind("LastName") %>'>'></asp:Label></span></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="SelectUserButton" runat="server" CausesValidation="false" CommandName="Edit"
                                                ImageUrl="~/BVAdmin/Images/Buttons/Select.png" AlternateText="Select User"></asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="row" />
                                <HeaderStyle CssClass="rowheader" />
                                <AlternatingRowStyle CssClass="alternaterow" />
                            </asp:GridView>
            
                        </asp:View>
                
                
                        <asp:View ID="ViewNew" runat="server">
                            <strong>Add New User</strong><br />
                            <asp:Label ID="lblNewUserMessage" runat="server"></asp:Label>
                            <asp:Panel ID="pnlNewUser" runat="server" DefaultButton="btnNewUserSave">
                                <table border="0" cellspacing="0" cellpadding="0">           
                                    <tr>
                                        <td class="formlabel">
                                            Email:</td>
                                        <td class="formfield">
                                            <asp:TextBox ID="NewUserEmailField" runat="server" Columns="30"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="formlabel">
                                            First Name:</td>
                                        <td class="formfield">
                                            <asp:TextBox ID="NewUserFirstNameField" runat="server" Columns="30"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="formlabel">
                                            Last Name:</td>
                                        <td class="formfield">
                                            <asp:TextBox ID="NewUserLastNameField" runat="server" Columns="30"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="formlabel">&nbsp;
                                            </td>
                                        <td class="formfield">
                                            <asp:Button ID="btnNewUserSave" runat="server" Text="Add New User" CausesValidation="false" />
                                            </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </asp:View>
                
                
                        <asp:View ID="ViewOrder" runat="server">
                            <strong>Find User By Order</strong>
                            <asp:Label ID="lblFindOrderMessage" runat="server"></asp:Label>
                            <asp:Panel ID="pnlFindUserByOrder" runat="server" DefaultButton="btnGoFindOrder">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="formlabel">Order Number: </td>
                                    <td><asp:TextBox ID="FindOrderNumberField" runat="server" Columns="20"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td><asp:Button ID="btnGoFindOrder" CausesValidation="false" runat="server" Text="Find This Order" /></td>
                                </tr>
                            </table>
                            </asp:Panel>
                        </asp:View>
                    </asp:MultiView>                               
                    <asp:HiddenField ID="UserIdField" runat="server" />
                </div>
            </div> 
 	    </div>
    
        <hr />
    
        <div class="f-row">
    	    <div class="six columns">
                <uc7:GiftCertificates ID="GiftCertificates1" runat="server" ShowTitle="true" TabIndex="5050" />
                <hr />
                <asp:Panel ID="pnlCoupons" runat="server" DefaultButton="btnAddCoupon" Width="300px">
                    <h5>Add Promotional Code:</h5>
                    <asp:TextBox ID="CouponField" runat="server" TabIndex="9100"></asp:TextBox>
                
                    <asp:ImageButton ID="btnAddCoupon" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" AlternateText="Add Coupon to Cart" /><br />
                    <asp:GridView cellpadding="0" CellSpacing="0" GridLines="none" ID="CouponGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="CouponCode" ShowHeader="False">
                        <Columns>
                            <asp:BoundField DataField="CouponCode" ShowHeader="False" />
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnDeleteCoupon" ImageUrl="~/BVAdmin/Images/Buttons/x.png" runat="server"
                                        CausesValidation="false" CommandName="Delete" AlternateText="Delete Coupon" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </div>
            <div class="six columns">
        	    <h5>Payment</h5>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr runat="server" id="rowCreditCard" visible="false">
                        <td valign="top">
                            <asp:RadioButton ID="rbCreditCard" GroupName="PaymentGroup" runat="server" Checked="false" TabIndex="5000" /></td>
                        <td>
                            Credit Card
                            <div class="controlarea1">
                        	    <uc4:CreditCardInput ID="CreditCardInput1" runat="server" TabIndex="5001" />
                            </div>
                            <br />
                        </td>
                    </tr>
                    <tr runat="server" id="trPurchaseOrder" visible="false">
                        <td valign="top">
                            <asp:RadioButton ID="rbPurchaseOrder" GroupName="PaymentGroup" runat="server" Checked="false" TabIndex="5010" />
                   	    </td>
                        <td>
                            <asp:Label ID="lblPurchaseOrderDescription" runat="server"></asp:Label>
                            <div class="controlarea1">
                        	    Purchase Order # <asp:TextBox ID="PurchaseOrderField" runat="server" Columns="10" TabIndex="5011"></asp:TextBox>
                            </div>
                            <br />
                   	    </td>
                    </tr>
                    <tr runat="server" id="rowCheck" visible="false">
                        <td valign="top">
                            <asp:RadioButton ID="rbCheck" GroupName="PaymentGroup" runat="server" Checked="false"  TabIndex="5020" /></td>
                        <td>
                    	    <div>
                            <asp:Label ID="lblCheckDescription" runat="server"></asp:Label>
                            </div>
                            <br />
                        </td>
                    </tr>
                    <tr runat="server" id="rowTelephone" visible="false">
                        <td valign="top">
                            <asp:RadioButton ID="rbTelephone" GroupName="PaymentGroup" runat="server" Checked="false" TabIndex="5030" /></td>
                        <td>
                    	    <div>
                        	    <asp:Label ID="lblTelephoneDescription" runat="server"></asp:Label>
                            </div>
                            <br />
                   	    </td>
                    </tr>
                    <tr runat="server" id="trCOD" visible="false">
                        <td valign="top">
                            <asp:RadioButton ID="rbCOD" GroupName="PaymentGroup" runat="server" Checked="false" TabIndex="5040" /></td>
                        <td>
                    	    <div>
                            <asp:Label ID="lblCOD" runat="server"></asp:Label>
                            </div>
                            <br />
                   	    </td>
                    </tr>
                </table>
            </div>
   	    </div>
        
        <hr />
         
   	    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;"> 
            <tr>
                <td valign="top">
                    <h5>Customer Instructions</h5>
                    <asp:TextBox ID="InstructionsField" runat="server" Columns="40" Height="150px" Rows="3" TextMode="MultiLine"  TabIndex="9000"></asp:TextBox>
                </td>

                <td valign="top" align="right">
                    <table cellspacing="0" cellpadding="2" width="400" border="0">
                        <tr>
                            <td class="formlabel">SubTotal:</td>
                            <td align="right">
                                <asp:Label ID="SubTotalField" runat="server"></asp:Label>
                       	    </td>
                        </tr>
                        <tr>
                            <td class="formlabel">Tax: &nbsp; <asp:Checkbox ID="TaxExemptField" Text="<em>Exempt</em>" AutoPostBack="true" runat="server" CssClass="checkBox"></asp:Checkbox></td>
                            <td align="right">
                                <asp:Label ID="TaxTotalField" AutoUpdateAfterCallBack="true" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="FormLabel">
                                <asp:dropdownlist ID="ShippingRatesList" runat="server" AutoPostBack="true" />
                            </td>
                            <td class="FormLabel" align="right">                            
                                <asp:TextBox ID="ShippingTotalField" runat="server" AutoPostBack="true" AutoUpdateAfterCallBack="true" Columns="8" style="text-align:right;"></asp:TextBox>
                                
                                <bvc5:BVRequiredFieldValidator ID="ShippingRatesListBVRequiredFieldValidator" InitialValue="" runat="server" ControlToValidate="ShippingRatesList" Display="Dynamic" ErrorMessage="Shipping Method Required"></bvc5:BVRequiredFieldValidator>
                                <bvc5:BVRequiredFieldValidator ID="ShippingTotalBVRequiredFieldValidator" runat="server" InitialValue="" ControlToValidate="ShippingTotalField" Display="Dynamic" ErrorMessage="Shipping Total Required"></bvc5:BVRequiredFieldValidator>
                                <bvc5:BVCustomValidator ID="ShippingTotalBVCustomValidator" runat="server" ControlToValidate="ShippingTotalField" Display="Dynamic" ErrorMessage="Shipping total must be a monetary value"></bvc5:BVCustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">Shipping Discounts:</td>
                            <td align="right">
                                <asp:Label ID="ShippingDiscountField" AutoUpdateAfterCallBack="true" runat="server"></asp:Label>
                       	    </td>

                        </tr>
                        <tr>
                            <td class="formlabel">Handling:</td>
                            <td align="right">
                                <asp:Label ID="HandlingTotalField" runat="server"></asp:Label>
                       	    </td>
                        </tr>
                        <tr>
                            <td class="formlabel">Admin Discounts:</td>
                            <td align="right">
                                &ndash; <asp:TextBox ID="OrderDiscountAdjustments" AutoPostBack="true" runat="server" Columns="8" style="text-align:right;"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel" style="border-top:1px solid gray;">Order Total</td>
                            <td style="border-top:1px solid gray;" align="right">
                                <strong><asp:Label ID="GrandTotalField" AutoUpdateAfterCallBack="true" runat="server"></asp:Label></strong>
                            </td>
                        </tr>
					    <tr id="trLoyaltyPointsUsed" runat="server">
                            <td class="alignleft"><asp:Label ID="LoyaltyPointsUsedLabel" runat="server">Loyalty Points Credit</asp:Label>:</td>
                            <td class="alignright" align="right"><asp:Label ID="LoyaltyPointsUsedCurrencyField" AutoUpdateAfterCallBack="true" runat="server" /> <!--(<asp:Label ID="LoyaltyPointsUsedField" AutoUpdateAfterCallBack="true" runat="server" />)--></td>
                        </tr>
                        <tr class="giftcertrow" id="trGiftCertificateRow" runat="server">
                            <td class="alignleft">Gift Certificate(s) Credit:</td>
                            <td class="alignright" align="right"><asp:Label ID="GiftCertificateField" runat="server" /></td>
                        </tr>
	                    <tr class="amountdue">
                            <td class="alignleft"><strong>Amount Due</strong></td>
                            <td class="alignright" align="right"><strong><asp:Label ID="AmountDueField" AutoUpdateAfterCallBack="true" runat="server" /></strong></td>
                        </tr>
                        <tr id="trLoyaltyPointsEarned" runat="server">
                            <td class="alignleft"><asp:Label ID="LoyaltyPointsEarnedLabel" runat="server">Loyalty Points Earned</asp:Label>:</td>
                            <td class="alignright" align="right"><asp:Label ID="LoyaltyPointsEarnedField" AutoUpdateAfterCallBack="true" runat="server" /> <!--(<asp:Label ID="LoyaltyPointsEarnedCurrencyField" runat="server" />)--></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <hr />
        <div style="text-align:right">
            <asp:ImageButton ID="btnSubmit" runat="server" AlternateText="Place Order" ImageUrl="~/BVAdmin/Images/Buttons/PlaceOrder.png" TabIndex="9999" />
            <asp:HiddenField ID="BvinField" runat="server" Value="" />
        </div>
    </anthem:Panel>
</asp:Content>