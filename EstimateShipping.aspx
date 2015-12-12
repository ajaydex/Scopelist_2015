<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Popup.master" AutoEventWireup="false" CodeFile="EstimateShipping.aspx.vb" Inherits="EstimateShipping" title="Estimate Shipping" %>
<%@ Register TagPrefix="anthem" Assembly="Anthem" Namespace="Anthem" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core.Content" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BvcPopupContentPlaceholder" Runat="Server">
<table border="0" cellspacing="0" cellpadding="3">
<tr>
    <td class="formlabel">Country:</td>
    <td class="formfield">
        <asp:DropDownList ID="lstCountry" runat="server"              
            AutoPostBack="true"            
            DataTextField="DisplayName" 
            DataValueField="bvin" CausesValidation="false">
        </asp:DropDownList>
    </td>
</tr>
    <tr id="City" runat="server">
    <td class="formlabel">City:</td>
    <td class="formfield">
        <asp:TextBox ID="CityField" runat="server" />
        <bvc5:BVRequiredFieldValidator ID="CityFieldRequired" runat="server" 
            AutoUpdateAfterCallBack="true"
            ControlToValidate="CityField"           
            ErrorMessage="The City is required." 
            Text="<br />Required">
        </bvc5:BVRequiredFieldValidator>
    </td>
</tr>
<tr id="State" runat="server">
    <td class="formlabel">State:</td>
    <td class="formfield">
        <asp:DropDownList ID="lstRegion" runat="server" />
        <asp:TextBox ID="txtRegion" runat="server" />
        <bvc5:BVRequiredFieldValidator ID="StateFieldRequired" runat="server" AutoUpdateAfterCallBack="true" ControlToValidate="txtRegion" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> State is required." Text="*" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
    </td>
</tr>
<tr id="PostalCode" runat="server">
    <td class="formlabel">Postal Code:</td>
    <td class="formfield">
        <asp:TextBox ID="ZipCodeField" runat="server" />
        <bvc5:BVRequiredFieldValidator ID="ZipCodeRequired" runat="server" 
            AutoUpdateAfterCallBack="true"
            ControlToValidate="ZipCodeField" 
            ErrorMessage="The Zip Code is required." 
            Text="<br />Required">
        </bvc5:BVRequiredFieldValidator>
        <bvc5:BVRegularExpressionValidator ID="PostalCodeBVRegularExpressionValidator" runat="server" CssClass="errormessage" 
            ControlToValidate="ZipCodeField" Display="Dynamic" ErrorMessage="Postal code is invalid."></bvc5:BVRegularExpressionValidator>
    </td>
</tr>
<tr id="GetRatesButton" runat="server">
    <td class="formlabel">&nbsp;</td>
    <td class="formfield">
        <anthem:ImageButton runat="server" ID="btnGetRates" 
            ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/GetRates.png"
            TextDuringCallBack="Retrieving rates...">
        </anthem:ImageButton>
    </td>
</tr>
</table>
<anthem:ValidationSummary ID="ValidationSummary" runat="server" 
    AutoUpdateAfterCallBack="true"
    DisplayMode="BulletList" 
    EnableClientScript="True">
</anthem:ValidationSummary>    
<anthem:Label ID="message" runat="server"
    AutoUpdateAfterCallBack="true">
</anthem:Label>
<anthem:Repeater ID="lstShippingRates" runat="server" 
    AutoUpdateAfterCallBack="true"
    Visible="false">
    <HeaderTemplate><ul></HeaderTemplate>
    <ItemTemplate>
        <li><%# Eval("RateAndNameForDisplay") %></li>
    </ItemTemplate>
    <FooterTemplate></ul></FooterTemplate>
</anthem:Repeater>
<div style="padding:30px;text-align:center;">
<a href="javascript:window.close();">Close Window</a></div>
</asp:Content>

