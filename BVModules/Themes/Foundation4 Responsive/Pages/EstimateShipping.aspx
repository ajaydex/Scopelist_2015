<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Popup.master" AutoEventWireup="false" CodeFile="EstimateShipping.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_EstimateShipping" title="Estimate Shipping" %>
<%@ Register TagPrefix="anthem" Assembly="Anthem" Namespace="Anthem" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core.Content" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BvcPopupContentPlaceholder" Runat="Server">
    <h1>Shipping Rates</h1>

    <anthem:Label ID="message" runat="server" AutoUpdateAfterCallBack="true"></anthem:Label>

    <anthem:ValidationSummary ID="ValidationSummary" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server" AutoUpdateAfterCallBack="true" ForeColor="White" DisplayMode="BulletList" HeaderText='<a href="#" class="close">&times;</a>'></anthem:ValidationSummary>  
    <fieldset class="addressform">
        <h2>Ship To</h2>
        <div class="row">
            <div class="small-12 columns">
                <label>Country</label>
                <asp:DropDownList ID="lstCountry" runat="server" AutoPostBack="true" DataTextField="DisplayName" DataValueField="bvin" CausesValidation="false"></asp:DropDownList>
            </div>
        </div>
        <div class="row" id="City" runat="server">
            <div class="small-12 columns">
                <label>City
                    <bvc5:BVRequiredFieldValidator ID="CityFieldRequired" runat="server" AutoUpdateAfterCallBack="true" ControlToValidate="CityField" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> City is required." Text="*" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                </label>
                <asp:TextBox ID="CityField" runat="server" />
            </div>
        </div>
        <div class="row" id="State" runat="server">
            <div class="small-12 columns">
                <label>State
                    <bvc5:BVRequiredFieldValidator ID="StateFieldRequired" runat="server" AutoUpdateAfterCallBack="true" ControlToValidate="txtRegion" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> State is required." Text="*" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                </label>
                <asp:DropDownList ID="lstRegion" runat="server" />
                <asp:TextBox ID="txtRegion" runat="server" />
            </div>
        </div>
        <div class="row" id="PostalCode" runat="server">
            <div class="small-12 columns">
                <label>Postal Code
                    <bvc5:BVRequiredFieldValidator ID="ZipCodeRequired" runat="server" AutoUpdateAfterCallBack="true" ControlToValidate="ZipCodeField" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Postal Code is required." Text="*" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                    <bvc5:BVRegularExpressionValidator ID="PostalCodeBVRegularExpressionValidator" runat="server" ControlToValidate="ZipCodeField" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Field is required." Text="*" Display="Dynamic"></bvc5:BVRegularExpressionValidator>
                </label>

                <asp:TextBox ID="ZipCodeField" runat="server" />
            </div>
        </div>
        <div class="row" id="GetRatesButton" runat="server">
            <div class="small-12 columns">
                <anthem:ImageButton runat="server" ID="btnGetRates" ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/GetRates.png" ImageUrlDuringCallBack="/images/system/ajax-loader.gif"></anthem:ImageButton>
            </div>
        </div>

    </fieldset>

    <anthem:Repeater ID="lstShippingRates" runat="server" AutoUpdateAfterCallBack="true" Visible="false">
        <HeaderTemplate><ul class="rates"></HeaderTemplate>
        <ItemTemplate>
            <li><%# Eval("RateAndNameForDisplay") %></li>
        </ItemTemplate>
        <FooterTemplate></ul></FooterTemplate>
    </anthem:Repeater>

    <a href="javascript:window.close();" class="button small secondary">Close Window</a>
</asp:Content>