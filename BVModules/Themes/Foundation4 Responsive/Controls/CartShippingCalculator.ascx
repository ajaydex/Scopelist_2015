<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CartShippingCalculator.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_CartShippingCalculator" %>
<%@ Register Src="~/BVModules/Controls/Shipping.ascx" TagName="Shipping" TagPrefix="uc" %>
<%@ Register TagPrefix="anthem" Assembly="Anthem" Namespace="Anthem" %>


    <tr class="costRow">
        <td>
            <anthem:Label ID="lblShippingMethod" AutoUpdateAfterCallBack="true" runat="server" />
            <anthem:LinkButton ID="btnChange" Text="[Change]" CssClass="changeLink" AutoUpdateAfterCallBack="true" EnableCallBack="true" EnabledDuringCallBack="false" TextDuringCallBack="[Loading...]" runat="server" />:
        </td>
        <td class="text-right">
            <anthem:Label ID="ShippingTotalField" AutoUpdateAfterCallBack="true" runat="server" />
        </td>
    </tr>
    <tr class="estimatorRow">
        <td colspan="2">
            <anthem:Panel ID="pnlShipping" CssClass="calcBox" DefaultButton="btnGetRates" AutoUpdateAfterCallBack="true" runat="server"> 
                <div>

                    <anthem:Panel ID="pnlShippingMethod" AutoUpdateAfterCallBack="true" runat="server">
                        <div id="ShippingCalculatorMethod">
                            <h5>Select Shipping Method</h5>
                            <uc:Shipping ID="ucShipping" runat="server" />
                        </div>
                        <br />
                    </anthem:Panel>

                    <div id="ShippingCalculatorAddress"> 
                        <h5>Shipping Address</h5>

                        <anthem:ValidationSummary ID="ValidationSummary" runat="server" data-alert CssClass="alert-box alert" AutoUpdateAfterCallBack="true" ForeColor="White" DisplayMode="BulletList" EnableClientScript="True" ValidationGroup="Address" HeaderText='<a href="#" class="close">&times;</a>'></anthem:ValidationSummary> 


                        <div class="row">
                            <div class="small-6 large-12 columns">
                                <label>Country</label>
                                <asp:DropDownList ID="lstCountry" runat="server"              
                                    AutoPostBack="true"
                                    DataTextField="DisplayName" 
                                    DataValueField="bvin" CausesValidation="false">
                                </asp:DropDownList>
                            </div>
                            <div id="State" runat="server" class="small-6 large-12 columns">
                                <label>State</label>
                                <anthem:DropDownList ID="lstRegion" AutoUpdateAfterCallBack="true" runat="server" />
                                <anthem:TextBox ID="RegionField" AutoUpdateAfterCallBack="true" runat="server" />
                            </div>
                        </div>

                        <div id="City" runat="server">
                            <label>City</label>
                            <anthem:TextBox ID="CityField" runat="server" />
                            <bvc5:BVRequiredFieldValidator ID="CityFieldRequired" runat="server" 
                                AutoUpdateAfterCallBack="true"
                                ControlToValidate="CityField" 
                                EnableClientScript="false"            
                                ErrorMessage="The City is required." 
                                Text="<br />Required"
                                ValidationGroup="Address">
                            </bvc5:BVRequiredFieldValidator>
                        </div>

                        <div id="PostalCode" runat="server">
                            <label>Postal Code</label>
                            <bvc5:BVRequiredFieldValidator ID="ZipCodeRequired" runat="server" 
                                AutoUpdateAfterCallBack="true"
                                ControlToValidate="ZipCodeField" 
                                EnableClientScript="false"             
                                ErrorMessage="The Zip Code is required." 
                                Text="<br />Required"
                                ValidationGroup="Address"
                                display="Dynamic">
                            </bvc5:BVRequiredFieldValidator>
                            <bvc5:BVRegularExpressionValidator ID="PostalCodeBVRegularExpressionValidator" runat="server" CssClass="errormessage" ControlToValidate="ZipCodeField" Display="Dynamic" ErrorMessage="Postal code is invalid."></bvc5:BVRegularExpressionValidator>
                            <anthem:TextBox ID="ZipCodeField" runat="server" />
                        </div>

                        <div id="GetRatesButton" runat="server">
                            <anthem:ImageButton runat="server" ID="btnGetRates" 
                                ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/GetRates.png"
                                TextDuringCallBack="Retrieving rates..."
                                ValidationGroup="Address">
                            </anthem:ImageButton>
                            <anthem:ImageButton ID="btnClose" CssClass="closeBtn" ImageUrl="~/BVModules/Themes/Bvc5/images/close-button.png" CausesValidation="false" AutoUpdateAfterCallBack="true" runat="server" />
                        </div>

                        <anthem:Label ID="message" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label> 
                            
                    </div>
                
                </div>
            
            </anthem:Panel>
        </td>
    </tr>

    <tr id="trHandlingTotal" class="estimatedHandling" runat="server">
        <td>
            <span>Handling:</span>
        </td>
        <td class="text-right">
            <anthem:Label ID="HandlingTotalField" runat="server" />
        </td>
    </tr>
    <tr id="trTaxTotal" class="estimatedTax" runat="server">
        <td>
            <span>Tax:</span>
        </td>
        <td class="text-right">
            <anthem:Label ID="TaxTotalField" runat="server" />
        </td>
    </tr>
    <tr class="estimatedTotal">
        <td>
            <span>Total:</span>
        </td>
        <td class="text-right">
            <anthem:Label ID="GrandTotalField" runat="server" />
        </td>
    </tr>
