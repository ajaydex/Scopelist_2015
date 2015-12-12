<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CartShippingCalculator.ascx.vb" Inherits="BVModules_Controls_CartShippingCalculator" %>
<%@ Register Src="~/BVModules/Controls/Shipping.ascx" TagName="Shipping" TagPrefix="uc" %>
<%@ Register TagPrefix="anthem" Assembly="Anthem" Namespace="Anthem" %>

<table cellspacing="0" cellpadding="0" class="shippingCalcTable">
    <tr class="costRow">
        <td class="formlabel">
            <anthem:Label ID="lblShippingMethod" AutoUpdateAfterCallBack="true" runat="server" />
            <anthem:LinkButton ID="btnChange" Text="[Change]" CssClass="changeLink" AutoUpdateAfterCallBack="true" EnableCallBack="true" EnabledDuringCallBack="false" TextDuringCallBack="[Loading...]" runat="server" />:
        </td>
        <td class="formfield">
            <anthem:Label ID="ShippingTotalField" AutoUpdateAfterCallBack="true" runat="server" />
        </td>
    </tr>
        
    <tr class="estimatorRow">
        <td colspan="2">
        	
            <anthem:Panel ID="pnlShipping" CssClass="calcBox" DefaultButton="btnGetRates" AutoUpdateAfterCallBack="true" runat="server">
                <div>
                    <div id="ShippingCalculatorAddress"> 
                        <h3>1. Enter Shipping Address</h3>
                        <table cellspacing="0">
                            <tr>
                                <td class="formlabel"><label>Country</label></td>
                                <td class="formfield">
                                    <asp:DropDownList ID="lstCountry" runat="server"              
                                        AutoPostBack="true"
                                        DataTextField="DisplayName" 
                                        DataValueField="bvin" CausesValidation="false">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr id="State" runat="server">
                                <td class="formlabel"><label>State</label></td>
                                <td class="formfield">
                                    <anthem:DropDownList ID="lstRegion" AutoUpdateAfterCallBack="true" runat="server" />
                                    <anthem:TextBox ID="RegionField" AutoUpdateAfterCallBack="true" runat="server" />
                                </td>
                            </tr>
                            <tr id="City" runat="server">
                                <td class="formlabel"><label>City</label></td>
                                <td class="formfield">
                                    <anthem:TextBox ID="CityField" runat="server" />
                                    <bvc5:BVRequiredFieldValidator ID="CityFieldRequired" runat="server" 
                                        AutoUpdateAfterCallBack="true"
                                        ControlToValidate="CityField" 
                                        EnableClientScript="false"            
                                        ErrorMessage="The City is required." 
                                        Text="<br />Required"
                                        ValidationGroup="Address">
                                    </bvc5:BVRequiredFieldValidator>
                                </td>
                            </tr>
                            <tr id="PostalCode" runat="server">
                                <td class="formlabel"><label>Postal Code</label></td>
                                <td class="formfield">
                                    <anthem:TextBox ID="ZipCodeField" runat="server" />
                                    <bvc5:BVRequiredFieldValidator ID="ZipCodeRequired" runat="server" 
                                        AutoUpdateAfterCallBack="true"
                                        ControlToValidate="ZipCodeField" 
                                        EnableClientScript="false"             
                                        ErrorMessage="The Zip Code is required." 
                                        Text="<br />Required"
                                        ValidationGroup="Address">
                                    </bvc5:BVRequiredFieldValidator>
                                    <bvc5:BVRegularExpressionValidator ID="PostalCodeBVRegularExpressionValidator" runat="server" CssClass="errormessage" 
                                        ControlToValidate="ZipCodeField" Display="Dynamic" ErrorMessage="Postal code is invalid."></bvc5:BVRegularExpressionValidator>
                                </td>
                            </tr>
                            <tr id="GetRatesButton" runat="server">
                                <td class="formlabel">&nbsp;</td>
                                <td class="formfield">
                                    <anthem:ImageButton runat="server" ID="btnGetRates" 
                                        ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/GetRates.png"
                                        TextDuringCallBack="Retrieving rates..."
                                        ValidationGroup="Address">
                                    </anthem:ImageButton>
                                </td>
                            </tr>
                        </table>
                        <anthem:ValidationSummary ID="ValidationSummary" runat="server" 
                            AutoUpdateAfterCallBack="true"
                            DisplayMode="BulletList" 
                            EnableClientScript="True"
                            ValidationGroup="Address">
                        </anthem:ValidationSummary>    
                        <anthem:Label ID="message" runat="server"
                            AutoUpdateAfterCallBack="true">
                        </anthem:Label> 
                            
                    </div>
            
                    <anthem:Panel ID="pnlShippingMethod" AutoUpdateAfterCallBack="true" runat="server">
                        <div id="ShippingCalculatorMethod">
                            <h3>2. Select Shipping Method</h3>
                            <uc:Shipping ID="ucShipping" runat="server" />
                        </div>
                    </anthem:Panel>
                
                    <anthem:ImageButton ID="btnClose" CssClass="closeBtn" ImageUrl="~/BVModules/Themes/Bvc5/images/close-button.png" CausesValidation="false" AutoUpdateAfterCallBack="true" runat="server" />
                    
                    <div style="clear:both;"></div>
                    
                </div>
            </anthem:Panel>	
           
        </td>
    </tr>
    <tr id="trHandlingTotal" class="estimatedHandling" runat="server">
        <td class="formlabel">
            <span>Handling:</span>
        </td>
        <td class="formfield">
            <anthem:Label ID="HandlingTotalField" runat="server" />
        </td>
    </tr>
    <tr id="trTaxTotal" class="estimatedTax" runat="server">
        <td class="formlabel">
            <span>Tax:</span>
        </td>
        <td class="formfield">
            <anthem:Label ID="TaxTotalField" runat="server" />
        </td>
    </tr>
    <tr class="estimatedTotal">
        <td class="formlabel">
            <span>Total:</span>
        </td>
        <td class="formfield">
            <anthem:Label ID="GrandTotalField" runat="server" />
        </td>
    </tr>
</table>