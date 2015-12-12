<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Orders.aspx.vb" ValidateRequest="false" Inherits="BVAdmin_Configuration_Orders" title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Orders</h1>         
    <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>
    
    <uc1:MessageBox ID="MessageBox1" runat="server" />
        
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <p><a href="OrderStatusCodes.aspx">Click Here to Edit Order Status Codes</a> </p>
       
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
            <tr>
                <td class="formlabel">Default Checkout:</td>
                <td class="formfield">
                    <anthem:DropDownList ID="CheckoutField" AutoCallBack="true" runat="server" Style="float:left;margin-right:4px;"></anthem:DropDownList>
					<anthem:ImageButton ID="btnCheckoutEdit" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" AutoUpdateAfterCallBack="true" runat="server" Style="float:left;" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">Force E-mail Address On Anonymous Checkout</td>
                <td class="formfield">
                    <asp:CheckBox ID="ForceEmailCheckBox" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">Hide Shipping Address On Non-Shipping Orders</td>
                <td class="formfield">
                    <asp:CheckBox ID="HideShippingAddressCheckBox" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">Hide Shipping Controls On Non-Shipping Orders</td>
                <td class="formfield">
                    <asp:CheckBox ID="HideShippingControlsCheckBox" runat="server" />
                </td>
            </tr>        
            <tr>
                <td class="formlabel">Maximum Order Quantity:</td>
                <td class="formfield">
                    <asp:TextBox ID="OrderLimiteQuantityField" Columns="9" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">Allow 0 Dollar Orders:</td>
                <td class="formfield">
                    <asp:CheckBox ID="ZeroDollarOrdersCheckBox" runat="server" />                
                </td>
            </tr>
             <tr>
                <td class="formlabel">Last Order Number:</td>
                <td class="formfield">
                    <asp:TextBox ID="LastOrderNumberField" Columns="9" runat="server"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="LastOrderNumberBVRequiredFieldValidator" runat="server" ControlToValidate="LastOrderNumberField" ErrorMessage="Last order number must be entered."></bvc5:BVRequiredFieldValidator> 
                    <bvc5:BVRegularExpressionValidator ID="LastOrderNumberBVRegularExpressionValidator" runat="server" ControlToValidate="LastOrderNumberField" ValidationExpression="\d{1,10}" ErrorMessage="Last order number must be numeric."></bvc5:BVRegularExpressionValidator>
                </td>
            </tr>        
            <tr>
                <td class="formlabel">Increment by</td>
                <td class="formfield"><asp:TextBox Columns="3" runat="server" ID="OrderSeedLowField" Text="1"></asp:TextBox> to <asp:TextBox ID="OrderSeedHighField" runat="server" Columns="3" Text="1"></asp:TextBox> for each new order</td>            
            </tr>
            <tr>
                <td class="formlabel">Email New Orders To:</td>
                <td class="formfield">
                    <asp:TextBox Columns="40" runat="server" ID="OrderNotificationEmailField"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator3" runat="server" ControlToValidate="OrderNotificationEmailField" EnableClientScript="True" ErrorMessage="E-mail Address Is Required." ForeColor=" " CssClass="errormessage" Display="Dynamic"></bvc5:BVRequiredFieldValidator>                
                </td>
            </tr>
            <tr>
                <td class="formlabel">Dropship Notification:</td>
                <td class="formfield">
                    <asp:DropDownList ID="DropShipModeDropDownList" runat="server">
                        <asp:ListItem Value="0">Built-in</asp:ListItem>
                        <asp:ListItem Value="1">BV Services</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
             <tr>
                <td class="formlabel">Cart Cleanup Last Run:</td>
                <td class="formfield">
                    <asp:Label ID="lblCartCleanupLastRun" runat="Server"></asp:Label> <asp:ImageButton ID="btnRunCleanup" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/RunCartCleanup.png" AlternateText="Run Cart Cleanup Now." /></td>
            </tr>
            <tr>
                <td class="formlabel">Cleanup Orders Older Than</td>
                <td class="formfield">
                    <asp:TextBox ID="CartCleanupDaysOldField" Columns="4" runat="server"></asp:TextBox> Days
                </td>
            </tr>
            <tr>
                <td class="formlabel">Run Cleanup Every:</td>
                <td class="formfield">
                    <asp:TextBox ID="CartCleanupIntervalInHoursField" Columns="4" runat="server"></asp:TextBox> Hours
                    <bvc5:BVRangeValidator ID="BVRangeValidator1" runat="server" ControlToValidate="CartCleanupIntervalInHoursField" ErrorMessage="Cart cleanup cannot be run more than 1 time per hour and no less than every 30 days (720 hours)" MinimumValue="1" MaximumValue="720" Type="Integer">*</bvc5:BVRangeValidator>
                </td>
            </tr>
            <tr>
                <td colspan="2"><br /><h2>Cart Settings</h2></td>
             </tr>
             <tr>
                <td class="formlabel">Redirect To Shopping Cart After Item Is Added:</td>
                <td class="formfield">
                    <asp:CheckBox ID="RedirectToShoppingCartAfterItemIsAddedCheckBox" runat="server" />
                </td>
             </tr>
             <tr>
                <td class="formlabel">Merge Identical Cart Items:</td>
                <td class="formfield">
                    <asp:CheckBox ID="MergeCartItemsCheckBox" runat="server" />
                </td>
             </tr>
             <tr>
                <td class="formlabel">Item Added To Cart Text:</td>
                <td class="formfield">
                    <asp:TextBox ID="ItemAddedToCartTextBox" runat="server"></asp:TextBox>
                </td>
             </tr>         
             <tr>
                <td class="formlabel">Display Up Sells When Adding Item To Cart:</td>
                <td class="formfield">
                    <asp:CheckBox ID="DisplayCartUpSellsCheckBox" runat="server" />
                </td>
             </tr>
             <tr>
                <td class="formlabel">Display Cross Sells When Adding Item To Cart:</td>
                <td class="formfield">
                    <asp:CheckBox ID="DisplayCartCrossSellsCheckBox" runat="server" />
                </td>
             </tr>
             <tr>
                <td class="formlabel">Display Cross Sells In Cart:</td>
                <td class="formfield">
                    <asp:CheckBox ID="DisplayCrossSellsInShoppingCartCheckBox" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">Display Shipping Calculator In Cart:</td>
                <td class="formfield">
                    <asp:CheckBox ID="DisplayShippingCalculatorInCartCheckBox" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">Force User To Agree To Site Terms Before Checkout:</td>
                <td class="formfield">
                    <asp:CheckBox ID="ForceSiteTermsCheckBox" runat="server" />
                </td>
            </tr>  
        </table>
        <br />
        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
        &nbsp;
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
    </asp:Panel>
</asp:Content>

