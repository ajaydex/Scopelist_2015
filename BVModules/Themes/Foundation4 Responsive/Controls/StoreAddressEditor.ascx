<%@ Control Language="VB" AutoEventWireup="false" CodeFile="StoreAddressEditor.ascx.vb"
 Inherits="BVModules_Themes_Foundation4_Responsive_Controls_StoreAddressEditor" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<div class="row">
    <div class="large-4 columns">
        <asp:Label ID="firstNameLabel" runat="server" Text="First" AssociatedControlID="firstNameField"></asp:Label>
        <bvc5:BVRequiredFieldValidator ID="ValFirstNameField" runat="server" Display="Dynamic" ControlToValidate="firstNameField" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> First Name is Required">*</bvc5:BVRequiredFieldValidator>
        <asp:TextBox ID="firstNameField" runat="server" placeholder="required"></asp:TextBox>
    </div>
</div>
    
<div id="MiddleInitialRow" class="row" runat="server">
    <div class="large-4 columns">
        <asp:Label ID="LabeMiddleInitialLabel" runat="server" Text="MI" AssociatedControlID="MiddleInitialField"></asp:Label>
        <asp:TextBox ID="MiddleInitialField" runat="server" MaxLength="1"></asp:TextBox>
    </div>
</div>

<div class="row">
    <div class="large-4 columns">
        <asp:Label ID="lastNameLabel" runat="server" Text="Last" AssociatedControlID="lastNameField"></asp:Label>
        <bvc5:BVRequiredFieldValidator ID="valLastName" runat="server" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Last Name is Required" ControlToValidate="lastNameField">*</bvc5:BVRequiredFieldValidator>
        <asp:TextBox ID="lastNameField" runat="server" placeholder="required"></asp:TextBox>
    </div>
</div>

<div class="row">
    <div class="large-6 columns">
        <asp:Label ID="lstCountryLabel" runat="server" Text="Country" AssociatedControlID="lstCountry"></asp:Label>
        <anthem:DropDownList ID="lstCountry" runat="server" AutoCallBack="True" EnabledDuringCallBack="false" TextDuringCallBack="Please Wait..."></anthem:DropDownList>
        
        <asp:Label ID="address1Label" runat="server" Text="Address" AssociatedControlID="address1Field"></asp:Label>
        <bvc5:BVRequiredFieldValidator ID="valAddress" runat="server" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Address is Required" ControlToValidate="address1Field">*</bvc5:BVRequiredFieldValidator>
        <asp:TextBox ID="address1Field" runat="server" placeholder="required"></asp:TextBox>

        <div id="StreetLine2Row" runat="server">
            <asp:TextBox ID="address2Field" runat="server"></asp:TextBox>
        </div>

        <div id="StreetLine3Row" runat="server">
            <asp:TextBox ID="address3Field" runat="server"></asp:TextBox>
        </div>

        <asp:Label ID="cityLabel" runat="server" Text="City" AssociatedControlID="cityField"></asp:Label>
        <bvc5:BVRequiredFieldValidator ID="valCity" runat="server" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> City is Required" ControlToValidate="cityField" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>
        <asp:TextBox ID="cityField" runat="server"></asp:TextBox>

        <div class="row">
            <div class="large-3 columns">
                <asp:Label ID="stateLabel" runat="server" Text="State" AssociatedControlID="lstState"></asp:Label>
                <bvc5:BVRequiredFieldValidator ID="ShippingStateListRequiredFieldValidator" runat="server" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Shipping State is Required" ControlToValidate="lstState" Enabled="false" Display="Dynamic"></bvc5:BVRequiredFieldValidator> 
                <anthem:DropDownList ID="lstState" runat="server" AutoCallBack="true" EnabledDuringCallBack="true" TextDuringCallBack="Please Wait..."></anthem:DropDownList>
                <anthem:TextBox ID="stateField" runat="server" Visible="False"></anthem:TextBox>
            </div>

            <div class="large-4 columns">
                <asp:Label ID="postalCodeLabel" runat="server" Text="Zip" AssociatedControlID="postalCodeField"></asp:Label>
                <bvc5:BVRequiredFieldValidator ID="valPostalCode" runat="server" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Postal Code is Required" ControlToValidate="postalCodeField" Display="Dynamic" >*</bvc5:BVRequiredFieldValidator>                
                <bvc5:BVRegularExpressionValidator ID="PostalCodeBVRegularExpressionValidator" runat="server" ControlToValidate="postalCodeField" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Postal code is invalid."></bvc5:BVRegularExpressionValidator>
                <asp:TextBox ID="postalCodeField" runat="server"></asp:TextBox>
            </div>

            <div class="large-5 columns">
                <label>County</label>
                <anthem:DropDownList runat="server" ID="CountyField"></anthem:DropDownList>
            </div>
        </div>

        <div id="CompanyNameRow" runat="server">
            <asp:Label ID="CompanyLabel" runat="server" Text="Company" AssociatedControlID="CompanyField"></asp:Label>
            <bvc5:BVRequiredFieldValidator ID="valCompany" runat="server" ControlToValidate="CompanyField" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Company is Required" Enabled="False" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>
            <asp:TextBox ID="CompanyField" runat="server"></asp:TextBox>
        </div>

        <div id="PhoneRow" runat="server">
            <asp:Label ID="PhoneNumberLabel" runat="server" Text="Phone" AssociatedControlID="PhoneNumberField"></asp:Label>
            <bvc5:BVRequiredFieldValidator ID="valPhone" runat="server" ControlToValidate="PhoneNumberField" ErrorMessage="Phone Number is Required" Enabled="False" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>
            <asp:TextBox ID="PhoneNumberField" runat="server"></asp:TextBox>
        </div>

        <div id="FaxRow" runat="server">
            <asp:Label ID="FaxNumberLabel" runat="server" Text="Fax" AssociatedControlID="FaxNumberField"></asp:Label>
            <bvc5:BVRequiredFieldValidator ID="valFax" runat="server" ControlToValidate="FaxNumberField" ErrorMessage="Fax Number is Required" Enabled="False" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>
            <asp:TextBox ID="FaxNumberField" runat="server"></asp:TextBox>
        </div>

        <div id="WebSiteURLRow" runat="server">
            <asp:Label ID="WebSiteURLLabel" runat="server" Text="Web Site" AssociatedControlID="WebSiteURLField"></asp:Label>
            <bvc5:BVRequiredFieldValidator ID="valWebSite" runat="server" ControlToValidate="WebSiteURLField" ErrorMessage="Web Site URL is Required" Enabled="False" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>
            <asp:TextBox ID="WebSiteURLField" runat="server"></asp:TextBox>
        </div>
    </div>
</div>

<asp:HiddenField ID="AddressBvin" runat="server" />
    
<!--
    <tr id="NickNameRow" runat="server">
        <td class="formlabel">
            <asp:Label ID="NickNameLabel" runat="server" Text="Nick Name:" AssociatedControlID="NickNameField"></asp:Label></td>
        <td class="formfield">
            <asp:TextBox ID="NickNameField" runat="server" Columns="20" CssClass="forminput"></asp:TextBox>
            <bvc5:BVRequiredFieldValidator ID="valNickName" runat="server" ErrorMessage="Nick Name is Required" ControlToValidate="NickNameField" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator>

        </td>
    </tr>
-->    