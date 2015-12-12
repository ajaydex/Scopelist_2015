<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="Checkout.aspx.vb" Inherits="BVModules_Checkouts_One_Page_Checkout_Checkout"
    Title="Checkout" %>

<%@ Register Src="../../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc10" %>
<%@ Register Src="../../Controls/SiteTermsAgreement.ascx" TagName="SiteTermsAgreement"
    TagPrefix="uc9" %>
<%@ Register Src="../../Controls/EmailAddressEntry.ascx" TagName="EmailAddressEntry"
    TagPrefix="uc2" %>
<%@ Register Src="../../Controls/Payment.ascx" TagName="Payment" TagPrefix="uc8" %>
<%@ Register Src="../../Controls/Shipping.ascx" TagName="Shipping" TagPrefix="uc7" %>
<%@ Register Src="../../Controls/GiftCertificates.ascx" TagName="GiftCertificates"
    TagPrefix="uc6" %>
<%@ Register Src="../../Controls/AddressBook.ascx" TagName="AddressBook" TagPrefix="uc5" %>
<%@ Register Src="../../Controls/LoginControl.ascx" TagName="LoginControl" TagPrefix="uc4" %>
<%@ Register Src="../../Controls/PaypalExpressCheckoutButton.ascx" TagName="PaypalExpressCheckoutButton"
    TagPrefix="uc3" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../../Controls/StoreAddressEditor.ascx" TagName="StoreAddressEditor"
    TagPrefix="uc1" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="cc1" %>
<asp:Content ID="head" ContentPlaceHolderID="headcontent" runat="server">
    <script src='https://ajax.microsoft.com/ajax/jQuery/jquery-1.3.2.min.js' language="javascript"
        type="text/javascript"></script>
    <script type="text/javascript">
        // JQuery methods
        function ToggleBilling() {
            //alert("checkbox clicked!");        
            if ($('#chkBill input').attr("checked")) {
                $('#billingpanel').hide();
            }
            else {
                $('#billingpanel').fadeIn("slow");
            }
        };                        
    </script>
    <script type="text/javascript">
        // Jquery Setup
        $(document).ready(function () {
            //$('#billingpanel').hide();
            ToggleBilling();
            $('#chkBill input').click(
            function () {
                ToggleBilling();
                return;
            }
            );
        });
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div class="breadcrumb">
        <a href="Default.aspx" runat="server" id="lnkHome">Home</a> > Checkout
    </div>
    <h1>
        <asp:Label ID="TitleLabel" runat="server">Checkout</asp:Label>
    </h1>
    <div>
        <cc1:ContentColumnControl ID="ContentColumnControl2" runat="server" ColumnName="Test" />
    </div>
    <uc10:MessageBox ID="MessageBox1" runat="server" />
    <div class="error_panel2">
        <anthem:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="blk_er2"
            AutoUpdateAfterCallBack="true" />
    </div>
    <div class="checkout_blk check_border">
        <uc4:LoginControl ID="LoginControl1" runat="server" HeaderText="Returning Users:"
            HideIfLoggedIn="True" />
    </div>
    <div class="border-top">
    </div>
    <div class="left-half">
        <div class=" general-form">
            <h3 class="checkout_hd">
                Contact information</h3>
            <div class="checkoutblk2">
                <uc2:EmailAddressEntry ID="EmailAddressEntry1" runat="server" TabIndex="1100" />
                <h4 class="line-behind" id="ShipToHeader" runat="server">
                    <span>Ship To</span>
                </h4>
                <anthem:Panel ID="pnlShipping" runat="server" CssClass="checkout_srpanel">
                    <div class="form-row">
                        <div class="form-left">
                            Country :
                        </div>
                        <div class="form-right">
                            <anthem:DropDownList ID="ShippinglstCountry" TabIndex="1101" runat="server" AutoCallBack="True"
                                EnabledDuringCallBack="false" TextDuringCallBack="Please Wait..." class="fld4">
                            </anthem:DropDownList>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-left">
                            <span class="checkout">*</span> First, MI :
                        </div>
                        <div class="form-right">
                            <asp:TextBox ID="ShippingfirstNameField" TabIndex="1103" runat="server" class="txt_fld st1"></asp:TextBox>
                            <asp:TextBox ID="ShippingMiddleInitialField" TabIndex="1104" runat="server" class="txt_fld st1"
                                MaxLength="1"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="ShippingValFirstNameField" runat="server" ControlToValidate="ShippingfirstNameField"
                                ErrorMessage="First Name is Required" ForeColor=" " CssClass="errormessage" Display="None"></bvc5:BVRequiredFieldValidator>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-left">
                            <span class="checkout">*</span> Last :
                        </div>
                        <div class="form-right">
                            <asp:TextBox ID="ShippinglastNameField" TabIndex="1105" runat="server" class="txt_fld st1"></asp:TextBox><bvc5:BVRequiredFieldValidator
                                ID="ShippingvalLastName" runat="server" ErrorMessage="Last Name is Required"
                                ForeColor=" " Display="None" CssClass="errormessage" ControlToValidate="ShippinglastNameField"></bvc5:BVRequiredFieldValidator>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row" id="ShippingCompanyNameRow" runat="server">
                        <div class="form-left">
                            <span class="checkout">*</span> Company :
                        </div>
                        <div class="form-right">
                            <asp:TextBox ID="ShippingCompanyField" TabIndex="1106" runat="server" class="txt_fld st1"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="ShippingvalCompany" runat="server" ControlToValidate="ShippingCompanyField"
                                ForeColor=" " CssClass="errormessage" ErrorMessage="Company is Required" Enabled="False"
                                Display="None"></bvc5:BVRequiredFieldValidator>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-left">
                            <span class="checkout">*</span> Address :
                        </div>
                        <div class="form-right">
                            <anthem:TextBox ID="ShippingAddress1Field" TabIndex="1107" runat="server" class="txt_fld st1"></anthem:TextBox><bvc5:BVRequiredFieldValidator
                                ID="ShippingvalAddress" runat="server" ErrorMessage="Address is Required" ForeColor=" "
                                CssClass="errormessage" Display="None" ControlToValidate="Shippingaddress1Field"></bvc5:BVRequiredFieldValidator>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row" id="Div1" runat="server">
                        <div class="form-left">
                        </div>
                        <div class="form-right">
                            <asp:TextBox ID="Shippingaddress2Field" TabIndex="1108" runat="server" class="txt_fld st1"></asp:TextBox>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-left">
                            <span class="checkout">*</span> City :
                        </div>
                        <div class="form-right">
                            <asp:TextBox ID="ShippingcityField" TabIndex="1109" runat="server" class="txt_fld st1"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="ShippingvalCity" runat="server" Display="None"
                                ErrorMessage="City is Required" ForeColor=" " CssClass="errormessage" ControlToValidate="ShippingcityField"></bvc5:BVRequiredFieldValidator>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-left">
                            <span class="checkout">*</span> State, Zip :
                        </div>
                        <div class="form-right">
                            <anthem:DropDownList ID="ShippinglstState" runat="server" AutoCallBack="true" TextDuringCallBack="Please Wait..."
                                TabIndex="1110" class="fld5" Style="width: 140px;">
                            </anthem:DropDownList>
                            <bvc5:BVRequiredFieldValidator ID="ShippingStateListRequiredFieldValidator" runat="server"
                                ErrorMessage="Shipping State is Required" ForeColor=" " CssClass="errormessage"
                                ControlToValidate="ShippinglstState" Enabled="false" Display="None"></bvc5:BVRequiredFieldValidator>
                            <anthem:TextBox ID="ShippingstateField" TabIndex="1111" runat="server" Visible="False"
                                class="txt_fld5 st1" Style="width: 110px;"></anthem:TextBox>
                            <anthem:TextBox AutoCallBack="true" ID="ShippingpostalCodeField" runat="server" TabIndex="1112"
                                class="txt_fldpincode" Width="130"></anthem:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="ShippingvalPostalCode" runat="server" ErrorMessage="Postal Code is Required"
                                ForeColor=" " CssClass="errormessage" ControlToValidate="ShippingpostalCodeField"
                                Display="None"></bvc5:BVRequiredFieldValidator>
                            <bvc5:BVRegularExpressionValidator ID="ShippingPostalCodeBVRegularExpressionValidator"
                                runat="server" CssClass="errormessage" ControlToValidate="ShippingpostalCodeField"
                                Display="None" ErrorMessage="Postal code is invalid."></bvc5:BVRegularExpressionValidator>
                            <anthem:Label ID="ShippinglblStateError" runat="server" Visible="False">
				            *</anthem:Label><br />
                            <anthem:DropDownList runat="server" Visible="false" ID="ShippingCountyField" TabIndex="1113"
                                AutoCallBack="True" class="fld5" Style="width: 140px;">
                            </anthem:DropDownList>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row" id="ShippingPhoneRow" runat="server">
                        <div class="form-left">
                            <span class="checkout">*</span> Phone :</div>
                        <div class="form-right">
                            <asp:TextBox ID="ShippingPhoneNumberField" TabIndex="1114" runat="server" class="txt_fld st1"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="ShippingvalPhone" runat="server" ControlToValidate="ShippingPhoneNumberField"
                                ForeColor=" " CssClass="errormessage" ErrorMessage="Phone Number is Required"
                                Enabled="False" Display="None"></bvc5:BVRequiredFieldValidator></div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row" id="ShippingFaxRow" runat="server">
                        <div class="form-left">
                            <span class="checkout">*</span> Fax :</div>
                        <div class="form-right">
                            <asp:TextBox ID="ShippingFaxNumberField" TabIndex="1115" runat="server" class="txt_fld st1"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="ShippingvalFax" runat="server" ControlToValidate="ShippingFaxNumberField"
                                ForeColor=" " Display="None" CssClass="errormessage" ErrorMessage="Fax Number is Required"
                                Enabled="False"></bvc5:BVRequiredFieldValidator></div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row" id="ShippingWebSiteURLRow" runat="server">
                        <div class="form-left">
                            <span class="checkout">*</span> Web Site :</div>
                        <div class="form-right">
                            <asp:TextBox ID="ShippingWebSiteURLField" TabIndex="1116" runat="server" class="txt_fld st1"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="ShippingvalWebSite" runat="server" ControlToValidate="ShippingWebSiteURLField"
                                ForeColor=" " CssClass="errormessage" ErrorMessage="Web Site URL is Required"
                                Enabled="False" Display="None"></bvc5:BVRequiredFieldValidator></div>
                        <div class="clr">
                        </div>
                    </div>
                </anthem:Panel>
                <h4 class="line-behind">
                    <span>Bill To<label>
                        <span id="chkBill">
                            <asp:CheckBox ID="chkBillToSame" Checked="true" runat="server" TabIndex="2100" />
                        </span>Bill to Same Address
                    </label>
                    </span>
                </h4>
            </div>
        </div>
        <div class="clr">
        </div>
        <div id="BillToSection" runat="server">
            <div id="billingpanel" class="checkout_srpanel">
                <div class=" general-form">
                    <div class="form-row">
                        <div class="form-left">
                            Country
                        </div>
                        <div class="form-right">
                            <anthem:DropDownList ID="BillinglstCountry" TabIndex="2101" runat="server" AutoCallBack="True"
                                EnabledDuringCallBack="false" TextDuringCallBack="Please Wait..." class="fld4">
                            </anthem:DropDownList>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-left">
                            <span class="checkout">*</span> First, MI :
                        </div>
                        <div class="form-right">
                            <asp:TextBox ID="BillingfirstNameField" TabIndex="2103" runat="server" class="txt_fld st1"></asp:TextBox>
                            <asp:TextBox ID="BillingMiddleInitialField" TabIndex="2104" runat="server" class="txt_fld st1"
                                MaxLength="1"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="BillingValFirstNameField" runat="server" ControlToValidate="BillingfirstNameField"
                                ErrorMessage="First Name is Required" ForeColor=" " Display="None" CssClass="errormessage"></bvc5:BVRequiredFieldValidator>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-left">
                            <span class="checkout">*</span> Last :
                        </div>
                        <div class="form-right">
                            <asp:TextBox ID="BillinglastNameField" TabIndex="2105" runat="server" class="txt_fld st1"></asp:TextBox><bvc5:BVRequiredFieldValidator
                                ID="BillingvalLastName" runat="server" ErrorMessage="Last Name is Required" ForeColor=" "
                                CssClass="errormessage" ControlToValidate="BillinglastNameField" Display="None"></bvc5:BVRequiredFieldValidator>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row" id="BillingCompanyNameRow" runat="server">
                        <div class="form-left">
                            <span class="checkout">*</span> Company :
                        </div>
                        <div class="form-right">
                            <asp:TextBox ID="BillingCompanyField" TabIndex="2106" runat="server" class="txt_fld st1"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="BillingvalCompany" runat="server" ControlToValidate="BillingCompanyField"
                                ForeColor=" " CssClass="errormessage" Display="None" ErrorMessage="Company is Required"
                                Enabled="False"></bvc5:BVRequiredFieldValidator>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-left">
                            <span class="checkout">*</span> Address :
                        </div>
                        <div class="form-right">
                            <asp:TextBox ID="Billingaddress1Field" TabIndex="2107" runat="server" class="txt_fld st1"></asp:TextBox><bvc5:BVRequiredFieldValidator
                                ID="BillingvalAddress" runat="server" ErrorMessage="Address is Required" ForeColor=" "
                                CssClass="errormessage" ControlToValidate="Billingaddress1Field" Display="None"></bvc5:BVRequiredFieldValidator>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-left">
                        </div>
                        <div class="form-right">
                            <asp:TextBox ID="Billingaddress2Field" TabIndex="2108" runat="server" class="txt_fld st1"></asp:TextBox>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-left">
                            <span class="checkout">*</span> City :
                        </div>
                        <div class="form-right">
                            <asp:TextBox ID="BillingcityField" TabIndex="2109" runat="server" class="txt_fld st1"></asp:TextBox><bvc5:BVRequiredFieldValidator
                                ID="BillingvalCity" runat="server" ErrorMessage="City is Required" ForeColor=" "
                                CssClass="errormessage" ControlToValidate="BillingcityField" Display="None"></bvc5:BVRequiredFieldValidator>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-left">
                            <span class="checkout">*</span> State, Zip :
                        </div>
                        <div class="form-right">
                            <anthem:DropDownList ID="BillinglstState" runat="server" AutoCallBack="true" EnabledDuringCallBack="false"
                                TextDuringCallBack="Please Wait..." class="fld5" Style="width: 140px;">
                            </anthem:DropDownList>
                            <anthem:TextBox ID="BillingstateField" TabIndex="2111" runat="server" class="txt_fld5 st1"
                                Visible="False" Style="width: 130px;"></anthem:TextBox>
                            <asp:TextBox ID="BillingpostalCodeField" TabIndex="2112" runat="server" class="txt_fldpincode"
                                Style="width: 130px;"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="BillingvalPostalCode" runat="server" Display="None"
                                ErrorMessage="Postal Code is Required" ForeColor=" " CssClass="errormessage"
                                ControlToValidate="BillingpostalCodeField"></bvc5:BVRequiredFieldValidator>
                            <bvc5:BVRegularExpressionValidator ID="BillingPostalCodeBVRegularExpressionValidator"
                                runat="server" CssClass="errormessage" ControlToValidate="BillingpostalCodeField"
                                Display="None" ErrorMessage="Postal code is invalid."></bvc5:BVRegularExpressionValidator>
                            <asp:Label ID="BillinglblStateError" runat="server" Visible="False">*</asp:Label><br />
                            <anthem:DropDownList runat="server" ID="BillingCountyField" TabIndex="2113" class="fld5"
                                Width="140">
                            </anthem:DropDownList>
                        </div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row" id="BillingPhoneRow" runat="server">
                        <div class="form-left">
                            <span class="checkout">*</span> Phone :</div>
                        <div class="form-right">
                            <asp:TextBox ID="BillingPhoneNumberField" TabIndex="2114" runat="server" class="txt_fld st1"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="BillingvalPhone" runat="server" ControlToValidate="BillingPhoneNumberField"
                                ForeColor=" " CssClass="errormessage" ErrorMessage="Phone Number is Required"
                                Enabled="False" Display="None"></bvc5:BVRequiredFieldValidator></div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row" id="BillingFaxRow" runat="server">
                        <div class="form-left">
                            <span class="checkout">*</span> Fax :</div>
                        <div class="form-right">
                            <asp:TextBox ID="BillingFaxNumberField" TabIndex="2115" runat="server" class="txt_fld st1"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="BillingvalFax" runat="server" ControlToValidate="BillingFaxNumberField"
                                ForeColor=" " CssClass="errormessage" ErrorMessage="Fax Number is Required" Enabled="False"
                                Display="None"></bvc5:BVRequiredFieldValidator></div>
                        <div class="clr">
                        </div>
                    </div>
                    <div class="form-row" id="BillingWebSiteURLRow" runat="server">
                        <div class="form-left">
                            <span class="checkout">*</span> Web Site :</div>
                        <div class="form-right">
                            <asp:TextBox ID="BillingWebSiteURLField" TabIndex="2116" runat="server" class="txt_fld st1"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="BillingvalWebSite" runat="server" ControlToValidate="BillingWebSiteURLField"
                                ForeColor=" " CssClass="errormessage" ErrorMessage="Web Site URL is Required"
                                Enabled="False" Display="None"></bvc5:BVRequiredFieldValidator></div>
                        <div class="clr">
                        </div>
                    </div>
                    <asp:HiddenField ID="BillingAddressBvin" runat="server" />
                </div>
            </div>
            <asp:HiddenField ID="ShippingAddressBvin" runat="server" />
        </div>
    </div>
    <div class="right-half">
        <div id="ShippingSection" runat="server">
            <h3>
                Shipping</h3>
            <uc7:Shipping ID="Shipping" runat="server" TabIndex="2200" />
            <uc6:GiftCertificates ID="GiftCertificates1" runat="server" TabIndex="2600" ShowTitle="true" />
            <br />
            <uc8:Payment ID="Payment" runat="server" TabIndex="2700" />
        </div>
        <h3>
            Special Instructions</h3>
        <asp:TextBox ID="SpecialInstructions" TextMode="MultiLine" runat="server" Columns="30"
            Rows="4" Wrap="true" TabIndex="2800" Style="resize: none"></asp:TextBox>
    </div>
    <div class=" clr">
    </div>
    <h3>
        Summary</h3>
    <table width="100%" border="0" cellspacing="0" cellpadding="4" class="summary">
        <tr>
            <td>
                SubTotal :
            </td>
            <td>
                <anthem:Label ID="SubTotalField" runat="server"></anthem:Label>
            </td>
        </tr>
        <tr>
            <td>
                Tax :
            </td>
            <td>
                <anthem:Label ID="TaxTotalField" runat="server"></anthem:Label>
            </td>
        </tr>
        <tr>
            <td>
                Shipping :
            </td>
            <td>
                <anthem:Label ID="ShippingTotalField" runat="server"></anthem:Label>
            </td>
        </tr>
        <tr>
            <td>
                Handling :
            </td>
            <td>
                <anthem:Label ID="HandlingTotalField" runat="server"></anthem:Label>
            </td>
        </tr>
        <tr id="OrderDiscountsRow" runat="server">
            <td>
                Discounts:
            </td>
            <td>
                <anthem:Label ID="OrderDiscountsField" runat="server"></anthem:Label>
            </td>
        </tr>
    </table>
    <div class="below-cart">
        <span class="float-r">Total: <span class="price">
            <anthem:Label ID="GrandTotalField" runat="server"></anthem:Label></span></span>
        <div class="clr">
        </div>
    </div>
    <div class="checkout-block">
        <span class="float-l">
            <asp:ImageButton ID="btnKeepShopping" runat="server" AlternateText="Keep Shopping"
                CausesValidation="False" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-keep-shopping.png"
                TabIndex="3000" ToolTip="Keep Shopping" />
        </span><span class="float-r">
            <asp:ImageButton ID="btnSubmit" runat="server" AlternateText="Place Order" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-place-order.png"
                TabIndex="3001" ToolTip="Place Order" />
        </span>
        <uc9:SiteTermsAgreement ID="SiteTermsAgreement1" runat="server" />
        <div class="clr">
        </div>
    </div>
    <uc5:AddressBook ID="AddressBook1" runat="server" TabIndex="1000" />
</asp:Content>
