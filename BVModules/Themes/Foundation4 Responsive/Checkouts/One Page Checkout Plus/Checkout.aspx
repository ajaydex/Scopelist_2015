<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Checkout.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Checkouts_One_Page_Checkout_Plus_Checkout" Title="Checkout" %>
<%@ Register Src="Payment.ascx" TagName="Payment" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/GiftCertificates.ascx" TagName="GiftCertificates" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/Shipping.ascx" TagName="Shipping" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/AddressBookSimple.ascx" TagName="AddressBookSimple" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/SiteTermsAgreement.ascx" TagName="SiteTermsAgreement" TagPrefix="uc" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:content id="Head1" contentplaceholderid="headcontent" runat="server">
    <link href="<%= Page.ResolveUrl("checkout.css") %>" type="text/css" rel="stylesheet" />
	<%--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script>--%>
	<script type="text/javascript">
	    function init_page() {
	        $("[id$='_EmailAddressField']").change(function () {
	            if ($(this).val() != "") {
	                $.ajax({
	                    type: "POST",
	                    async: false,
	                    timeout: 500,
	                    contentType: "application/json; charset=utf-8",
	                    dataType: "json",
	                    url: '<%=Page.ResolveUrl("checkout.aspx")%>/DoesEmailExist',
	                    data: '{"email":"' + $(this).val() + '"}',
	                    success: function (result) {
	                        if (result.d == true) {
	                            $("#EmailAddressValidate").show();

	                            $("#<%= pnlPassword.ClientID %>").hide();
	                            $("#<%= UsernameField.ClientID %>").val("");
	                            $("#<%= PasswordField.ClientID %>").val("");
	                            $("#<%= PasswordConfirmField.ClientID %>").val("");
	                        }
	                        else {
	                            $("#EmailAddressValidate").hide();

	                            $("#<%= pnlPassword.ClientID %>").show();
	                        }
	                    },
	                    error: function (result) {
	                        alert(result.status + " " + result.statusText);
	                    }
	                });
	            }
	        });

	        $("#<%= ShippingpostalCodeField.ClientID %>").keyup(function (event) {
	            if ($("#<%= ShippinglstCountry.ClientID %>").val() == "bf7389a2-9b21-4d33-b276-23c9c18ea0c0") {
	                var zip = $.trim($("#<%= ShippingpostalCodeField.ClientID %>").val().replace(" ", "").replace("-", ""));
	                if (zip.length == 5 || zip.length == 9) {
	                    $("#<%= Shippingaddress1Field.ClientID %>").focus();
	                    $("#<%= ShippingpostalCodeField.ClientID %>").focus();
	                }
	            }
	        });

	        $("#PaymentMethods [type=radio]").change(function () {
	            var selectedRadioButtons = $("input:radio[name$=PaymentGroup]:checked");
	            if (selectedRadioButtons.length > 0 && selectedRadioButtons.attr("id").match(/rbCreditCard$/))
	                $('.creditcardinput').slideDown();
	            else
	                $('.creditcardinput').slideUp();
	        });
	        $("#PaymentMethods [type=radio]").trigger("change");

	        $("#<%= UsernameField.ClientID %>, #<%= PasswordField.ClientID %>, #<%= PasswordConfirmField.ClientID %>").change(function () {
	            if ($("#<%= UsernameField.ClientID %>").val().length > 0 && $("#<%= PasswordField.ClientID %>").val().length > 0 && $("#<%= PasswordConfirmField.ClientID %>").val().length > 0)
	                $("#<%= trLoyaltyPointsEarned.ClientID %>").show();
	            else
	                $("#<%= trLoyaltyPointsEarned.ClientID %>").hide();
	        });
	        $("#<%= UsernameField.ClientID %>,#<%= PasswordField.ClientID %>,#<%= PasswordConfirmField.ClientID %>").trigger("change");

	        if (typeof init_ccinput == "function") {
	            init_ccinput();
	        }
	    }

	    $(document).ready(function () {
            init_page();
	    });
	    $(document).ajaxStart(function () {
	        $('#wait').show();
	    }).ajaxStop(function () {
	        $('#wait').hide();
	    });
	</script>
</asp:content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <asp:Panel DefaultButton="btnSubmit" runat="server">
        <div id="OnePageCheckoutPlus">
            <div class="row">
                <div class="large-12 columns">
                    <h1>Checkout</h1>
                    <uc:MessageBox id="MessageBox1" runat="server" />
		            <asp:ValidationSummary ID="ValidationSummary1" data-alert CssClass="alert-box alert" runat="server" ForeColor="White" DisplayMode="BulletList" HeaderText='<a href="#" class="close">&times;</a>' ></asp:ValidationSummary>
                </div>
            </div>
            
            <!-- SHIPPING ADDRESS -->
            <anthem:Panel ID="pnlShipping" CssClass="row checkoutStep stepShippingAddress" runat="server">
                <div class="large-12 columns">
                    <h2 id="ShipToHeader" runat="server">Shipping Address &amp; Method</h2>
                </div>
                <div class="large-6 columns push-6">
                    <div class="checkoutInstructions">
                        <asp:Literal ID="litShippingInstructions" runat="server" />
                    </div>
                </div>
                <div class="large-6 columns pull-6">
                    <br />
                    <uc:AddressBookSimple ID="ucAddressBookSimpleShipping" AddressType="Shipping" AddressFormat="<strong>[[FirstName]] [[LastName]]</strong> [[Line1]], [[City]], [[RegionName]] [[PostalCode]]" TabIndex="1100" runat="server" />
                
                    <div class="row">
                        <div class="large-6 columns">
                            <asp:Label ID="EmailAddressLabel" text="Email" class="label" runat="server" />
                            <asp:TextBox ID="EmailAddressField" CssClass="forminput" TabIndex="1000" runat="server" />
                            <asp:RegularExpressionValidator ID="BVRegularExpressionValidator1" CssClass="error" runat="server" ControlToValidate="EmailAddressField" Display="Dynamic" ErrorMessage="Please enter a valid email address" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"><div class="validationMsg"><div>Please enter a valid email address</div></div></asp:RegularExpressionValidator>
                            <bvc5:BVRequiredFieldValidator ID="EmailAddressRequiredFieldValidator" runat="server" EnableClientScript="false" ErrorMessage="E-mail Address Is Required" ControlToValidate="EmailAddressField" CssClass="error" Display="None" />
                        </div>
                    </div>
                
                    <asp:Label ID="EmailAddressText" runat="server" Visible="false" />
                    <div id="EmailAddressValidate" class="validationMsg" style="display:none;"><div>That email address is already in use.<br />Please <a href="/login.aspx?ReturnURL=%7e%2fcheckout%2fcheckout.aspx">Sign in</a> to your account.</div></div>
                    <!--We respect your privacy. <asp:HyperLink ID="lnkPrivacyPolicy" NavigateUrl="~/checkout/privacypopup.aspx" onclick="window.open(this.href, 'Policy', 'width=400, height=500, menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no'); return false;" Text="Privacy Policy" runat="server" />-->
                    
                    <div class="row">
                        <div class="large-6 columns">
                            <asp:Label ID="lblShippingFirstNameField" AssociatedControlID="ShippingfirstNameField" text="First" runat="server" />
                            <bvc5:BVRequiredFieldValidator ID="ShippingValFirstNameField" runat="server" ControlToValidate="ShippingfirstNameField" ErrorMessage="First Name is Required" CssClass="error" Display="None" EnableClientScript="false" />
                            <asp:TextBox ID="ShippingfirstNameField" CssClass="forminput" TabIndex="1003" Columns="20" runat="server" />
                        </div>
                        <div class="large-6 columns" runat="server">
                            <asp:Label ID="lblShippingMiddleInitialField" AssociatedControlID="ShippingMiddleInitialField" text=", MI" runat="server" />
                            <asp:TextBox ID="ShippingMiddleInitialField" CssClass="forminput short" TabIndex="1004" runat="server" Columns="2" MaxLength="1" />
                        </div>
                        <div class="large-6 columns">
                            <asp:Label ID="lblShippingLastNameField" AssociatedControlID="ShippinglastNameField" Text="Last" runat="server" />
                            <bvc5:BVRequiredFieldValidator ID="ShippingvalLastName" ErrorMessage="Last Name is Required" CssClass="error" ControlToValidate="ShippinglastNameField" Display="None" EnableClientScript="false" runat="server" />
                            <asp:TextBox ID="ShippinglastNameField" CssClass="forminput" TabIndex="1005" Columns="20" runat="server" />
                        </div>
                    </div>
                

                    <div class="row">
                        <div class="large-6 columns">
                            <div id="ShippingCompanyNameRow" runat="server">
                                <asp:Label ID="lblShippingCompanyField" AssociatedControlID="ShippingCompanyField" text="Company" runat="server" />
                                <bvc5:BVRequiredFieldValidator ID="ShippingvalCompany" ControlToValidate="ShippingCompanyField" CssClass="error" ErrorMessage="Company is Required" Enabled="False" Display="None" EnableClientScript="false" runat="server" />
                                <asp:TextBox ID="ShippingCompanyField" CssClass="forminput" TabIndex="1006" Columns="20" runat="server" />
                            </div>
                            <div id="ShippingPhoneRow" runat="server">
                                <asp:Label ID="lblShippingPhoneNumberField" runat="server" AssociatedControlID="ShippingPhoneNumberField" text="Phone" />
                                <bvc5:BVRequiredFieldValidator ID="ShippingvalPhone" runat="server" ControlToValidate="ShippingPhoneNumberField" CssClass="error" ErrorMessage="Phone Number is Required" Enabled="False" Display="None" EnableClientScript="false" />
                                <asp:TextBox ID="ShippingPhoneNumberField" CssClass="forminput" TabIndex="1014" runat="server" Columns="20" />
                            </div>
                            <div id="ShippingFaxRow" runat="server">
                                <asp:Label ID="lblShippingFaxNumberField" runat="server" AssociatedControlID="ShippingFaxNumberField" text="Fax" />
                                <bvc5:BVRequiredFieldValidator ID="ShippingvalFax" runat="server" ControlToValidate="ShippingFaxNumberField" CssClass="error" ErrorMessage="Fax Number is Required" Enabled="False" Display="None" EnableClientScript="false" />
                                <asp:TextBox ID="ShippingFaxNumberField" CssClass="forminput" TabIndex="1015" runat="server" Columns="20" />
                            </div>
                            <div id="ShippingWebSiteURLRow" runat="server">
                                <asp:Label ID="lblShippingWebSiteURLField" runat="server" AssociatedControlID="ShippingWebSiteURLField" text="Website" />
                                <bvc5:BVRequiredFieldValidator ID="ShippingvalWebSite" runat="server" ControlToValidate="ShippingWebSiteURLField" CssClass="error" ErrorMessage="Web Site URL is Required" Enabled="False" Display="None" EnableClientScript="false" />
                                <asp:TextBox ID="ShippingWebSiteURLField" CssClass="forminput" TabIndex="1016" runat="server" Columns="20" />
                            </div>
                        
                            <div>
                                <asp:Label ID="lblShipping1stCountry" AssociatedControlID="ShippinglstCountry" text="Country" runat="server" />
                                <anthem:DropDownList ID="ShippinglstCountry" TabIndex="1101" runat="server" AutoCallBack="True" EnabledDuringCallBack="false" TextDuringCallBack="Please Wait..." />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="large-6 columns">
                            <asp:Label ID="lblShippingaddress1Field" AssociatedControlID="Shippingaddress1Field" Text="Address" runat="server" />
                            <bvc5:BVRequiredFieldValidator ID="ShippingvalAddress" ErrorMessage="Address is Required" CssClass="error" ControlToValidate="Shippingaddress1Field" Display="None" EnableClientScript="false" runat="server" />
                            <asp:TextBox ID="Shippingaddress1Field" CssClass="forminput" TabIndex="1107" Columns="20" runat="server" />
                        </div>
                    
                        <div class="large-6 columns">
                            <asp:Label ID="lblShippingaddress2Field" AssociatedControlID="Shippingaddress2Field" Text="Address 2" runat="server" />
                            <asp:TextBox ID="Shippingaddress2Field" CssClass="forminput" TabIndex="1108" Columns="20" runat="server" />
                        </div>
                   	</div>
                        
                    <div class="row">    
                        <div class="large-6 columns">
                            <asp:Label ID="lblShippingCityField" AssociatedControlID="ShippingcityField" text="City" runat="server" />
                            <bvc5:BVRequiredFieldValidator ID="ShippingvalCity" ErrorMessage="City is Required" CssClass="error" ControlToValidate="ShippingcityField" Display="None" EnableClientScript="false" runat="server" />
                            <asp:TextBox ID="ShippingcityField" CssClass="forminput" TabIndex="1109" Columns="20" runat="server" />
                        </div>
                       
                        <div class="large-3 columns checkoutField state">
                            <asp:Label ID="ShippingStateLabel" runat="server" Text="State" />
                            <bvc5:BVRequiredFieldValidator ID="ShippingStateListRequiredFieldValidator" ErrorMessage="Shipping State is Required" CssClass="error" ControlToValidate="ShippinglstState" Display="None" EnableClientScript="false" runat="server" />
                            <anthem:DropDownList ID="ShippinglstState" runat="server" AutoCallBack="true" TextDuringCallBack="" TabIndex="1110" />
                            <anthem:TextBox ID="ShippingstateField" CssClass="forminput medium" TabIndex="1111" runat="server" Columns="10" Visible="False" />
                            <!--<anthem:Label ID="ShippinglblStateError" runat="server" Visible="False" text="*" />-->
                        </div>
                        <div class="large-3 columns checkoutField zip">
                            <asp:Label ID="ShippingPostalCodeLabel" runat="server" AssociatedControlID="ShippingpostalCodeField" Text="Zip" />
                            <bvc5:BVRegularExpressionValidator ID="ShippingPostalCodeBVRegularExpressionValidator" runat="server" CssClass="error" ControlToValidate="ShippingpostalCodeField" Display="None" ErrorMessage="Postal code is invalid." EnableClientScript="false" />
                            <bvc5:BVRequiredFieldValidator ID="ShippingvalPostalCode" runat="server" ErrorMessage="Postal Code is Required" CssClass="error" ControlToValidate="ShippingpostalCodeField" Display="None" EnableClientScript="false" />
                            <anthem:TextBox AutoCallBack="true" CssClass="forminput short" ID="ShippingpostalCodeField" TabIndex="1112" runat="server" Columns="10" />
                        </div>
                  	</div>
                        
                  
                
                    <anthem:Panel CssClass="checkoutField" AutoUpdateAfterCallBack="true" runat="server">
                        <asp:Label ID="ShippingCountyLabel" AssociatedControlID="ShippingCountyField" Text="County" runat="server" />
                        <anthem:DropDownList runat="server" ID="ShippingCountyField" TabIndex="1113" Style="width:auto;" AutoCallBack="True" />
                    </anthem:Panel>
                   
                    <div id="ShippingSection" class="shippingMethod" runat="server">
                        <h3>Choose a Shipping Method</h3>
                        <uc:Shipping ID="Shipping" runat="server" TabIndex="2000" />
                    </div>
                </div>
            
                <asp:HiddenField ID="ShippingAddressBvin" runat="server" />
            </anthem:Panel>
        
            <!-- BILLING ADDRESS -->
            <anthem:Panel ID="BillToSection" CssClass="row checkoutStep stepBillingAddress" AutoUpdateAfterCallback="True" runat="server">
                <div class="large-12 columns">
                    <h2>Billing Address</h2>
                </div>
				<div class="large-6 columns push-6">
                    <div class="checkoutInstructions">
                        <asp:Literal ID="litBillingInstructions" runat="server" />
                    </div>
                </div> 
                <div class="large-6 columns pull-6">
                    <br />
           		    <div>
                	    <asp:CheckBox ID="chkBillToSame" Text="Same as Shipping Address" Checked="true" AutoPostBack="true" CausesValidation="false" TabIndex="2001" runat="server" />
                        <%--<anthem:CheckBox ID="chkBillToSame" Text="Same as Shipping Address" Checked="true" AutoCallBack="True" TabIndex="2001" TextDuringCallBack="Loading..." runat="server" />--%>
            	    </div>
                    <br />
                    <anthem:Panel ID="pnlBilling" CssClass="" runat="server">
                        <uc:AddressBookSimple ID="ucAddressBookSimpleBilling" AddressType="Billing" AddressFormat="<strong>[[FirstName]] [[LastName]]</strong> [[Line1]], [[City]], [[RegionName]] [[PostalCode]]" TabIndex="1000" runat="server" />
            	
                        
                        <div class="row">
                        	<div class="large-6 columns">
                                <asp:Label ID="lblBillingfirstNameField" runat="server" AssociatedControlID="BillingfirstNameField" text="First" />
                                <bvc5:BVRequiredFieldValidator ID="BillingValFirstNameField" runat="server" ControlToValidate="BillingfirstNameField" ErrorMessage="First Name is Required" CssClass="error" Display="None" EnableClientScript="false" />
                                <asp:TextBox ID="BillingfirstNameField" CssClass="forminput" TabIndex="2003" runat="server" Columns="10" />
                            </div>
                            <div class="large-6 columns">
                                <asp:Label ID="lblBillingMiddleInitialField" runat="server" AssociatedControlID="BillingMiddleInitialField" text=", MI" />
                                <asp:TextBox ID="BillingMiddleInitialField" CssClass="forminput short" TabIndex="2004" runat="server" Columns="2" MaxLength="1" />
                            </div>
                            <div class="large-6 columns">
                                <asp:Label ID="lblBillinglastNameField" runat="server" AssociatedControlID="BillinglastNameField" text="Last" />
                                <bvc5:BVRequiredFieldValidator ID="BillingvalLastName" runat="server" ErrorMessage="Last Name is Required" CssClass="error" ControlToValidate="BillinglastNameField" Display="None" EnableClientScript="false" />
                                <asp:TextBox ID="BillinglastNameField" CssClass="forminput" TabIndex="2005" runat="server" Columns="20" />
                            </div>
                      	</div>
                
                        <div class="row">
                            <div class="large-6 columns">
                                <div id="BillingCompanyNameRow" runat="server">
                                    <asp:Label ID="lblBillingCompanyField" runat="server" AssociatedControlID="BillingCompanyField" text="Company" />
                                    <bvc5:BVRequiredFieldValidator ID="BillingvalCompany" runat="server" ControlToValidate="BillingCompanyField" CssClass="error" ErrorMessage="Company is Required" Enabled="False" Display="None" EnableClientScript="false" />
                                    <asp:TextBox ID="BillingCompanyField" CssClass="forminput" TabIndex="2006" runat="server" Columns="20" />
                                </div>
                                <div id="BillingPhoneRow" runat="server">
                                    <asp:Label ID="lblBillingPhoneNumberField" runat="server" AssociatedControlID="BillingPhoneNumberField" text="Phone" />
                                    <bvc5:BVRequiredFieldValidator ID="BillingvalPhone" runat="server" ControlToValidate="BillingPhoneNumberField" CssClass="error" ErrorMessage="Phone Number is Required" Enabled="False" Display="None" EnableClientScript="false" />
                                    <asp:TextBox ID="BillingPhoneNumberField" CssClass="forminput" TabIndex="2014" runat="server" Columns="20" />
                                </div>
                                <div id="BillingFaxRow" runat="server">
                                    <asp:Label ID="lblBillingFaxNumberField" runat="server" AssociatedControlID="BillingFaxNumberField" text="Fax" />
                                    <bvc5:BVRequiredFieldValidator ID="BillingvalFax" runat="server" ControlToValidate="BillingFaxNumberField" CssClass="error" ErrorMessage="Fax Number is Required" Enabled="False" Display="None" EnableClientScript="false" />
                                    <asp:TextBox ID="BillingFaxNumberField" CssClass="forminput" TabIndex="2015" runat="server" Columns="20" />
                                </div>
                                <div id="BillingWebSiteURLRow" runat="server">
                                    <asp:Label ID="lblBillingWebSiteURLField" runat="server" AssociatedControlID="BillingWebSiteURLField" text="Website" />
                                    <bvc5:BVRequiredFieldValidator ID="BillingvalWebSite" runat="server" ControlToValidate="BillingWebSiteURLField" CssClass="error" ErrorMessage="Web Site URL is Required" Enabled="False" Display="None" EnableClientScript="false" />
                                    <asp:TextBox ID="BillingWebSiteURLField" CssClass="forminput" TabIndex="2016" runat="server" Columns="20" />
                                </div>
                    
                                <div>
                                    <asp:Label ID="lblBillinglstCountry" runat="server" AssociatedControlID="BillinglstCountry" text="Country" />
                                    <anthem:DropDownList ID="BillinglstCountry" TabIndex="2101" runat="server" AutoCallBack="True" EnabledDuringCallBack="false" TextDuringCallBack="Please Wait..." />
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                        	<div class="large-6 columns">
                                <asp:Label ID="lblBillingaddress1Field" runat="server" AssociatedControlID="Billingaddress1Field" text="Address" />
                                <bvc5:BVRequiredFieldValidator ID="BillingvalAddress" runat="server" ErrorMessage="Address is Required" CssClass="error" ControlToValidate="Billingaddress1Field" Display="None" EnableClientScript="false" />
                                <asp:TextBox ID="Billingaddress1Field" CssClass="forminput" TabIndex="2107" runat="server" Columns="20" />
                            </div>
                            <div class="large-6 columns">
                                <asp:Label ID="lblBillingaddress2Field" runat="server" AssociatedControlID="Billingaddress2Field" text="Address 2" />
                                <asp:TextBox ID="Billingaddress2Field" CssClass="forminput" TabIndex="2108" runat="server" Columns="20" />
                            </div>
                       	</div> 
                        
                        
                       	<div class="row">
                        	<div class="large-6 columns">
                                <asp:Label ID="lblBillingcityField" runat="server" AssociatedControlID="BillingcityField" Text="City" />
                                <bvc5:BVRequiredFieldValidator ID="BillingvalCity" runat="server" ErrorMessage="City is Required" CssClass="error" ControlToValidate="BillingcityField" Display="None" EnableClientScript="false" />
                                <asp:TextBox ID="BillingcityField" CssClass="forminput" TabIndex="2109" runat="server" Columns="20" />
                            </div>
                           
                            <div class="large-3 columns checkoutField state">
                                <asp:Label ID="BillingStateLabel" runat="server" AssociatedControlID="BillinglstState" Text="State" />
                                <bvc5:BVRequiredFieldValidator ID="BillinglstStateRequiredFieldValidator" runat="server" ErrorMessage="Billing State is Required" CssClass="error" ControlToValidate="BillinglstState" Enabled="false" Display="None" EnableClientScript="false" />
                                <anthem:DropDownList ID="BillinglstState" runat="server" AutoCallBack="true" EnabledDuringCallBack="false" TextDuringCallBack="Please Wait..." tabindex="2110" />
                                <anthem:TextBox ID="BillingstateField" CssClass="forminput medium" TabIndex="2111" runat="server" Columns="10" Visible="False" />
                            </div>
                            <div class="large-3 columns checkoutField zip">
                                <asp:Label ID="BillingpostalCodeLabel" runat="server" AssociatedControlID="BillingpostalCodeField" Text="Zip" />
                                <bvc5:BVRegularExpressionValidator ID="BillingPostalCodeBVRegularExpressionValidator" runat="server" CssClass="error" ControlToValidate="BillingpostalCodeField" Display="None" ErrorMessage="Postal code is invalid." EnableClientScript="false" />
                                <bvc5:BVRequiredFieldValidator ID="BillingvalPostalCode" runat="server" Display="None" ErrorMessage="Postal Code is Required" CssClass="error" ControlToValidate="BillingpostalCodeField" EnableClientScript="false" />
                                <!--<asp:Label ID="BillinglblStateError" runat="server" Visible="False" text="*" />-->
                                <anthem:TextBox ID="BillingpostalCodeField" AutoCallBack="true" CssClass="forminput short" TabIndex="2112" runat="server" Columns="10" />
                            </div>
                       	</div>     
                
                        <div visible="false" runat="server">
                            <asp:Label ID="BillingCountyLabel" AssociatedControlID="BillingCountyField" Text="County" runat="server" />
                            <anthem:DropDownList runat="server" ID="BillingCountyField" TabIndex="2113" AutoCallBack="true" />
                        </div>
                        
                        <asp:HiddenField ID="BillingAddressBvin" runat="server" />
                    </anthem:Panel>
                </div>
            </anthem:Panel>
            
            <!-- REDEEM A GIFT CERTIFICATE -->
            <anthem:Panel ID="pnlGiftCertificate" AutoUpdateAfterCallBack="true" CssClass="row checkoutStep stepGiftCertificate" runat="server">
                <div class="large-12 columns">
                    <h2>Gift Certificate</h2>
                </div>
                <div class="large-6 columns push-6">
                    <div class="checkoutInstructions">
                        <asp:Literal ID="litGiftCertificateInstructions" runat="server" />
                    </div>
                </div>
                <div class="large-6 columns pull-6">
                    <br />
                    <uc:GiftCertificates ID="ucGiftCertificates" runat="server" TabIndex="2600" ShowTitle="false" />
                </div>
            </anthem:Panel>

            <!-- PAYMENT METHOD -->
            <anthem:Panel ID="pnlPayment" AutoUpdateAfterCallBack="true" runat="server">
	            <div class="row checkoutStep stepPayemntMethod">
                    <div class="large-12 columns">
                        <h2>Payment Method <asp:CustomValidator ID="cvPaymentMethod" Display="Dynamic" CssClass="error" ForeColor="" EnableClientScript="false" runat="server" /></h2>
                    </div>
                    <div class="large-6 columns push-6">
	                    <div class="checkoutInstructions">
	                        <asp:Literal ID="litPaymentInstructions" runat="server" />
	                    </div>
	                </div>
	                <div id="PaymentMethods" class="large-6 columns pull-6">
                        <br />
	                    <asp:CustomValidator ID="cvPaymentMethodDetail" Display="Dynamic" CssClass="error" ForeColor="" EnableClientScript="false" runat="server" />
	                    <uc:Payment ID="Payment" runat="server" TabIndex="2700" />
	                </div>
	            </div>
            </anthem:Panel>
		
            <!-- PROMOTIONAL CODE -->
            <anthem:Panel ID="pnlCoupons" CssClass="row checkoutStep stepPromotionCode" runat="server" AutoUpdateAfterCallBack="true" DefaultButton="btnAddCoupon">
                <div class="large-12 columns">
                    <h2>Promotional Code</h2>
                </div>
                <div class="large-6 columns push-6">
                    <div class="checkoutInstructions">
                        <asp:Literal ID="litPromotionalCodeInstructions" runat="server" />
                    </div>
                </div>
                <div class="large-6 columns pull-6">
                    <br />
                    <label for="<%= CouponField.ID %>">Promotion Code</label>
                    <asp:TextBox ID="CouponField" CssClass="text" runat="server" tabindex="2800" />
                    <asp:ImageButton ID="btnAddCoupon" runat="server" ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/AddToCart.png" AlternateText="Add Coupon" CausesValidation="false" />
                
                    <asp:GridView CellPadding="0" CellSpacing="0" CssClass="clear promotions" GridLines="none" ID="CouponGrid" runat="server" AutoGenerateColumns="false" DataKeyNames="CouponCode" ShowHeader="False">
                        <Columns>
                            <asp:BoundField DataField="CouponCode" ShowHeader="False" />
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnDeleteCoupon" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/x.png" runat="server" CausesValidation="false" CommandName="Delete" AlternateText="Delete Coupon" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </anthem:Panel>
        
            <!-- CREATE YOUR ACCOUNT -->
            <asp:Panel ID="pnlPassword" CssClass="row checkoutStep stepCreateAccount" runat="server">
                <div class="large-12 columns">
                    <h2>Create Your Account</h2>
                </div>
                <div class="large-6 columns push-6">
                    <div class="checkoutInstructions">
                        <asp:Literal ID="litAccountInstructions" runat="server" />
                    </div>
                </div>
                <div class="large-6 columns pull-6">
                	<br />
                    <div class="row">
                        <div class="small-6 columns">
                            <asp:Label ID="UsernameLabel" CssClass="label" runat="server" Text="Username" AssociatedControlID="UsernameField"></asp:Label>
                            <asp:TextBox ID="UsernameField" CssClass="forminput text" runat="server" Columns="25" MaxLength="100" TabIndex="2900"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="valRequiredUsername" runat="server" ErrorMessage="Username is Required" ControlToValidate="UsernameField" ForeColor="" CssClass="error" text="*" EnableClientScript="false" Display="None" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="small-6 columns">
                            <asp:Label ID="PasswordLabel" CssClass="label" runat="server" Text="Password" AssociatedControlID="PasswordField" />
                            <asp:TextBox ID="PasswordField" CssClass="forminput text" runat="server" Columns="25" TextMode="Password" TabIndex="2901" />
                            <asp:RegularExpressionValidator ID="rxvPassword" runat="server" ControlToValidate="PasswordField" ForeColor="" CssClass="error" Display="Dynamic" />
                            <bvc5:BVRequiredFieldValidator ID="valPassword" runat="server" ControlToValidate="PasswordField" ErrorMessage="Password is Required" ForeColor="" CssClass="error" text="*" EnableClientScript="false" Display="None" />
                            <asp:CustomValidator ID="cstPassword" ValidateEmptyText="true" runat="server" ControlToValidate="PasswordField" ErrorMessage="Password is Required" ForeColor="" CssClass="error" Text="*" EnableClientScript="false" Display="None"></asp:CustomValidator>
                        </div>
                        
                        <div class="small-6 columns">
                            <asp:Label ID="PasswordConfirmLabel" CssClass="label" runat="server" Text="Confirm Password" AssociatedControlID="PasswordConfirmField" /> 
                            <asp:TextBox ID="PasswordConfirmField" CssClass="forminput text" runat="server" Columns="25" TextMode="Password" TabIndex="2902" />
                            <asp:CompareValidator ID="comPasswordConfirm" runat="server" ControlToCompare="PasswordField" ControlToValidate="PasswordConfirmField" Display="Dynamic" ErrorMessage="Password and Confirmation Must Match." ForeColor=" " CssClass="error" Text="Passwords do not match" />
                            <bvc5:BVRequiredFieldValidator ID="valPasswordConfirm" runat="server" ControlToValidate="PasswordConfirmField" ErrorMessage="Password Confirmation is Required" ForeColor=" " CssClass="error" Text="*" Display="None" EnableClientScript="false" />
                        </div>
                        
                    </div>
                </div>
                
		    </asp:Panel>
        
            <!-- REVIEW YOU ORDER -->
            <div class="row checkoutStep stepReview">
                <div class="large-12 columns">
                    <h2>Review Your Order</h2>
                    <div class="reviewInstructions">
            	        <asp:Literal ID="litReviewInstructions" runat="server" />
                    </div>
                    <anthem:Panel ID="pnlReview" AutoUpdateAfterCallBack="true" runat="server">
		                <table cellspacing="0" id="ReviewTable">
		                    <tr>
		                        <td colspan="2">
		                            <asp:GridView GridLines="None" ID="ItemsGridView" cssclass="itemTable" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="bvin">
		                                <Columns>
	                                        <asp:TemplateField HeaderText="Product">
	                                            <ItemTemplate>
	                                                <asp:Panel ID="pnlImage" CssClass="pad10 hideforlowres" runat="server">
	                                        	        <asp:Image ID="ImageField" runat="server" />
	                                                </asp:Panel>
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
		                        </td>
		                    </tr>
                        </table>

                        <div class="row">
                            <div class="large-6 columns">
                                <asp:Label ID="lblSpecialInstructions" runat="server" AssociatedControlID="SpecialInstructions" text="Special Instructions" />
							    <asp:TextBox ID="SpecialInstructions" TextMode="MultiLine" runat="server" Columns="60" Rows="4" CssClass="formtextarea specialInstructions" Wrap="true" TabIndex="3001" />
                            </div>
                            <div class="large-6 columns totals">
                                <table cellspacing="0">
		                            <tr class="tdrow">
		                                <td class="alignleft">Subtotal:</td>
		                                <td class="alignright"><asp:Label ID="SubTotalField" runat="server" /></td>
		                            </tr>
		                            <tr id="OrderDiscountsRow" runat="server" class="highlightrow">
		                                <td class="alignleft">Discounts:</td>
		                                <td class="alignright"><asp:Label ID="OrderDiscountsField" runat="server" /></td>
		                            </tr>
		                            <tr class="altrow">
		                                <td class="alignleft">Tax:</td>
		                                <td class="alignright"><asp:Label ID="TaxTotalField" runat="server" />
		                                </td>
		                            </tr>
		                            <tr class="tdrow">
		                                <td class="alignleft">Shipping:</td>
		                                <td class="alignright"><asp:Label ID="ShippingTotalField" runat="server" /></td>
		                            </tr>
		                            <tr class="altrow">
		                                <td class="alignleft">Handling:</td>
		                                <td class="alignright"><asp:Label ID="HandlingTotalField" runat="server" /></td>
		                            </tr>
		                            <tr class="highlightrow grandtotal">
		                                <td class="alignleft"><strong>Order Total:</strong></td>
		                                <td class="alignright"><strong><asp:Label ID="GrandTotalField" runat="server" /></strong></td>
		                            </tr>
	                                <tr id="trLoyaltyPointsUsed" runat="server">
	                                    <td class="alignleft"><strong><asp:Label ID="LoyaltyPointsUsedLabel" runat="server">Loyalty Points Credit</asp:Label>:</strong></td>
	                                    <td class="alignright"><strong><asp:Label ID="LoyaltyPointsUsedCurrencyField" runat="server" /></strong> <!--(<asp:Label ID="LoyaltyPointsUsedField" runat="server" />)--></td>
	                                </tr>
                                    <tr class="giftcertrow" id="trGiftCertificateRow" runat="server">
                                        <td class="alignleft"><strong>Gift Certificate(s) Credit:</strong></td>
                                        <td class="alignright"><strong><asp:Label ID="GiftCertificateField" runat="server" /></strong></td>
                                    </tr>
		                            <tr class="amountdue">
		                                <td class="alignleft"><strong>Amount Due:</strong></td>
		                                <td class="alignright"><strong><asp:Label ID="AmountDueField" runat="server" /></strong></td>
	                                </tr>
	                                <tr id="trLoyaltyPointsEarned" runat="server">
	                                    <td class="alignleft"><strong><asp:Label ID="LoyaltyPointsEarnedLabel" runat="server">Loyalty Points Earned</asp:Label>:</strong></td>
	                                    <td class="alignright"><strong><asp:Label ID="LoyaltyPointsEarnedField" runat="server" /></strong> <!--(<asp:Label ID="LoyaltyPointsEarnedCurrencyField" runat="server" />)--></td>
	                                </tr>
		                        </table>
                            </div>
                        </div>

                    </anthem:Panel>
                </div>
            </div>
        
            <!-- MAILING LIST SIGNUP / SITE TERMS / SUBMIT -->
            <div class="row checkoutStep stepMailingList">
                <div class="large-12 columns">
                    <hr />
                </div>
                <div class="large-6 columns">
                    <!--<asp:ImageButton ID="btnKeepShopping" runat="server" AlternateText="Keep Shopping" CausesValidation="False" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/ContinueShopping.png" TabIndex="3000" />-->
                </div>
                <div class="large-6 columns">

                    <div>
                        <asp:CheckBox ID="chkMailingListSignup" Text="Yes! I want to receive email promotions." TabIndex="3102" runat="server" />
                    </div>

                    <asp:Panel ID="pnlSiteTermsAgreement" CssClass="required" runat="server">
                        <uc:SiteTermsAgreement ID="SiteTermsAgreement1" runat="server" />
                        <asp:CustomValidator ID="cvSiteTermsAgreement" CssClass="error" EnableClientScript="false" Display="None" ForeColor=" " runat="server" />
                    </asp:Panel>

                    <hr />

                    <div class="pad-top-1em text-right">
                        <asp:ImageButton ID="btnSubmit" cssclass="btnSubmit" runat="server" AlternateText="Place Order" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/PlaceOrder.png" TabIndex="3201" />
                    </div>

                </div>
            </div>
        </div>
        <asp:HiddenField ID="BvinField" runat="server" />
    </asp:Panel>
</asp:Content>