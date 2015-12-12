<%@ Control Language="VB" AutoEventWireup="false" CodeFile="StoreAddressEditor.ascx.vb"
    Inherits="BVModules_Controls_StoreAddressEditor" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%--<div class="addresseditor">
    <table>
        <tr>
            <td class="formlabel">
                <asp:Label ID="lstCountryLabel" runat="server" Text="Country:" AssociatedControlID="lstCountry"></asp:Label>
            </td>
            <td class="formfield">
                <anthem:DropDownList ID="lstCountry" runat="server" AutoCallBack="True" EnabledDuringCallBack="false"
                    TextDuringCallBack="Please Wait...">
                </anthem:DropDownList></td>
        </tr>
        <tr id="NickNameRow" runat="server">
            <td class="formlabel">
                <asp:Label ID="NickNameLabel" runat="server" Text="Nick Name:" AssociatedControlID="NickNameField"></asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="NickNameField" runat="server" Columns="20" CssClass="forminput"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valNickName" runat="server" ErrorMessage="Nick Name is Required"
                    ControlToValidate="NickNameField" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator></td>
        </tr>
        <tr>
            <td class="formlabel">
                <asp:Label ID="firstNameLabel" runat="server" Text="First" AssociatedControlID="firstNameField"></asp:Label>,
                <asp:Label ID="LabeMiddleInitialLabel" runat="server" Text="MI:" AssociatedControlID="MiddleInitialField"></asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="firstNameField" runat="server" Columns="10" CssClass="forminput medium"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="ValFirstNameField" runat="server" ControlToValidate="firstNameField"
                    ErrorMessage="First Name is Required" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator>
                <asp:TextBox ID="MiddleInitialField" runat="server" Columns="2" MaxLength="1" CssClass="forminput short"></asp:TextBox>
                </td>
        </tr>
        <tr>
            <td class="formlabel">
                <asp:Label ID="lastNameLabel" runat="server" Text="Last:" AssociatedControlID="lastNameField"></asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="lastNameField" runat="server" Columns="20" CssClass="forminput"></asp:TextBox><bvc5:BVRequiredFieldValidator
                    ID="valLastName" runat="server" ErrorMessage="Last Name is Required" ControlToValidate="lastNameField" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator></td>
        </tr>
        <tr id="CompanyNameRow" runat="server">
            <td class="formlabel">
                <asp:Label ID="CompanyLabel" runat="server" Text="Company:" AssociatedControlID="CompanyField"></asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="CompanyField" runat="server" Columns="20" CssClass="forminput"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valCompany" runat="server" ControlToValidate="CompanyField"
                    ErrorMessage="Company is Required" Enabled="False" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator></td>
        </tr>
        <tr>
            <td class="formlabel">
                <asp:Label ID="address1Label" runat="server" Text="Address:" AssociatedControlID="address1Field"></asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="address1Field" runat="server" Columns="20" CssClass="forminput"></asp:TextBox><bvc5:BVRequiredFieldValidator
                    ID="valAddress" runat="server" ErrorMessage="Address is Required" 
                    ControlToValidate="address1Field" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator></td>
        </tr>
        <tr id="StreetLine2Row" runat="server">
            <td class="formlabel">
                 
            </td>
            <td class="formfield">
                <asp:TextBox ID="address2Field" runat="server" Columns="20" CssClass="forminput"></asp:TextBox></td>
        </tr>
        <tr id="StreetLine3Row" runat="server">
            <td class="formlabel">
                 
            </td>
            <td class="formfield">
                <asp:TextBox ID="address3Field" runat="server" Columns="20" CssClass="forminput"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel">
                <asp:Label ID="cityLabel" runat="server" Text="City:" AssociatedControlID="cityField"></asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="cityField" runat="server" Columns="20" CssClass="forminput"></asp:TextBox><bvc5:BVRequiredFieldValidator
                    ID="valCity" runat="server" ErrorMessage="City is Required" ControlToValidate="cityField" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator></td>
        </tr>
        <tr>
            <td class="formlabel">
                <asp:Label ID="stateLabel" runat="server" Text="State" AssociatedControlID="lstState"></asp:Label>,
                <asp:Label ID="postalCodeLabel" runat="server" Text="Zip:" AssociatedControlID="postalCodeField"></asp:Label></td>
            <td class="formfield">
                <anthem:DropDownList ID="lstState" runat="server" AutoCallBack="true" EnabledDuringCallBack="true"
                    TextDuringCallBack="Please Wait...">
                </anthem:DropDownList>
                <bvc5:BVRequiredFieldValidator ID="ShippingStateListRequiredFieldValidator" runat="server"
                                ErrorMessage="Shipping State is Required" ForeColor=" " CssClass="errormessage" ControlToValidate="lstState" Enabled="false" Display="Dynamic"></bvc5:BVRequiredFieldValidator>                
                <anthem:TextBox ID="stateField" runat="server" Columns="10" CssClass="forminput short"
                    Visible="False"></anthem:TextBox>                
                <asp:TextBox ID="postalCodeField" runat="server" Columns="5" CssClass="forminput short"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valPostalCode" runat="server" ErrorMessage="Postal Code is Required"
                    ControlToValidate="postalCodeField" ForeColor=" " CssClass="errormessage" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>                
                <bvc5:BVRegularExpressionValidator ID="PostalCodeBVRegularExpressionValidator" runat="server" CssClass="errormessage" 
                    ControlToValidate="postalCodeField" Display="Dynamic" ErrorMessage="Postal code is invalid."></bvc5:BVRegularExpressionValidator>
                <anthem:DropDownList runat="server" ID="CountyField">
                </anthem:DropDownList>
            </td>
        </tr>
        <tr id="PhoneRow" runat="server">
            <td class="formlabel">
                <asp:Label ID="PhoneNumberLabel" runat="server" Text="Phone:" AssociatedControlID="PhoneNumberField"></asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="PhoneNumberField" runat="server" Columns="20" CssClass="forminput"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valPhone" runat="server" ControlToValidate="PhoneNumberField"
                    ErrorMessage="Phone Number is Required" Enabled="False" ForeColor=" " CssClass="errormessage">
                *</bvc5:BVRequiredFieldValidator></td>
        </tr>
        <tr id="FaxRow" runat="server">
            <td class="formlabel">
                <asp:Label ID="FaxNumberLabel" runat="server" Text="Fax:" AssociatedControlID="FaxNumberField"></asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="FaxNumberField" runat="server" Columns="20" CssClass="forminput"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valFax" runat="server" ControlToValidate="FaxNumberField"
                    ErrorMessage="Fax Number is Required" Enabled="False" ForeColor=" " CssClass="errormessage">
                *</bvc5:BVRequiredFieldValidator></td>
        </tr>
        <tr id="WebSiteURLRow" runat="server">
            <td class="formlabel">
                <asp:Label ID="WebSiteURLLabel" runat="server" Text="Web Site:" AssociatedControlID="WebSiteURLField"></asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="WebSiteURLField" runat="server" Columns="20" CssClass="forminput"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valWebSite" runat="server" ControlToValidate="WebSiteURLField"
                    ErrorMessage="Web Site URL is Required" Enabled="False" ForeColor=" " CssClass="errormessage">
                *</bvc5:BVRequiredFieldValidator></td>
        </tr>
    </table>
    <asp:HiddenField ID="AddressBvin" runat="server" />
</div>--%>
<div class="form-row">
    <div class="form-left">
        <asp:Label ID="lstCountryLabel" runat="server" Text="Country :" AssociatedControlID="lstCountry"></asp:Label>
    </div>
    <div class="form-right">
        <anthem:DropDownList ID="lstCountry" runat="server" AutoCallBack="True" EnabledDuringCallBack="false"
            TextDuringCallBack="Please Wait..." CssClass="txt_fld">
        </anthem:DropDownList>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <asp:Label ID="NickNameLabel" runat="server" Text="Nick Name :" AssociatedControlID="NickNameField"></asp:Label>
    </div>
    <div class="form-right">
        <asp:TextBox ID="NickNameField" runat="server" Columns="20" CssClass="txt_fld st1"></asp:TextBox><bvc5:BVRequiredFieldValidator
            ID="valNickName" runat="server" ErrorMessage="Nick Name is Required" ControlToValidate="NickNameField"
            ForeColor=" " CssClass="errormessage" Text="*" Display="None" ValidationGroup="grpAddressBook"></bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <span>*</span><asp:Label ID="firstNameLabel" runat="server" Text="First Name" AssociatedControlID="firstNameField"></asp:Label>,
        <asp:Label ID="LabeMiddleInitialLabel" runat="server" Text="MI :" AssociatedControlID="MiddleInitialField"></asp:Label>
    </div>
    <div class="form-right">
        <asp:TextBox ID="firstNameField" runat="server" Columns="10" CssClass="txt_fld st1"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="ValFirstNameField" runat="server" ControlToValidate="firstNameField"
            ErrorMessage="First Name is Required" ForeColor=" " CssClass="errormessage" Display="None"
            ValidationGroup="grpAddressBook">               
        </bvc5:BVRequiredFieldValidator>
        <asp:TextBox ID="MiddleInitialField" runat="server" Columns="2" MaxLength="1" CssClass="txt_fld st1"
            Style="display: none"></asp:TextBox>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <span>*</span><asp:Label ID="lastNameLabel" runat="server" Text="Last Name :" AssociatedControlID="lastNameField"></asp:Label>
    </div>
    <div class="form-right">
        <asp:TextBox ID="lastNameField" runat="server" Columns="20" CssClass="txt_fld st1"></asp:TextBox><bvc5:BVRequiredFieldValidator
            ID="valLastName" runat="server" ErrorMessage="Last Name is Required" ControlToValidate="lastNameField"
            ForeColor=" " CssClass="errormessage" Display="None" ValidationGroup="grpAddressBook"></bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <asp:Label ID="CompanyLabel" runat="server" Text="Company :" AssociatedControlID="CompanyField"></asp:Label>
    </div>
    <div class="form-right">
        <asp:TextBox ID="CompanyField" runat="server" Columns="20" CssClass="txt_fld st1"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="valCompany" runat="server" ControlToValidate="CompanyField"
            ErrorMessage="Company is Required" Enabled="False" ForeColor=" " CssClass="errormessage"
            ValidationGroup="grpAddressBook" Display="None"></bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <span>*</span><asp:Label ID="address1Label" runat="server" Text="Address :" AssociatedControlID="address1Field"></asp:Label>
    </div>
    <div class="form-right">
        <asp:TextBox ID="address1Field" runat="server" Columns="20" CssClass="txt_fld st1"></asp:TextBox><%--<bvc5:BVRequiredFieldValidator
        ID="valAddress" runat="server" ErrorMessage="Address is Required" ControlToValidate="address1Field"
        ForeColor=" " CssClass="errormessage" Display="None"></bvc5:BVRequiredFieldValidator>--%>
        <bvc5:BVRequiredFieldValidator ID="valAddress" runat="server" ErrorMessage="Address is Required"
            ControlToValidate="address1Field" ForeColor=" " CssClass="errormessage" Display="None"
            ValidationGroup="grpAddressBook"></bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        &nbsp;
    </div>
    <div class="form-right">
        <asp:TextBox ID="address2Field" runat="server" Columns="20" CssClass="txt_fld st1"></asp:TextBox>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        &nbsp;
    </div>
    <div class="form-right">
        <asp:TextBox ID="address3Field" runat="server" Columns="20" CssClass="txt_fld st1"></asp:TextBox>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <span>*</span><asp:Label ID="cityLabel" runat="server" Text="City :" AssociatedControlID="cityField"></asp:Label>
    </div>
    <div class="form-right">
        <asp:TextBox ID="cityField" runat="server" Columns="20" CssClass="txt_fld st1"></asp:TextBox><bvc5:BVRequiredFieldValidator
            ID="valCity" runat="server" ErrorMessage="City is Required" ControlToValidate="cityField"
            ForeColor=" " CssClass="errormessage" Display="None" ValidationGroup="grpAddressBook"></bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <asp:Label ID="stateLabel" runat="server" Text="State :" AssociatedControlID="lstState"></asp:Label>
    </div>
    <div class="form-right">
        <anthem:DropDownList ID="lstState" runat="server" AutoCallBack="true" EnabledDuringCallBack="true"
            TextDuringCallBack="Please Wait..." CssClass="txt_fld" Style="width: 90px !important">
        </anthem:DropDownList>
        <bvc5:BVRequiredFieldValidator ID="ShippingStateListRequiredFieldValidator" runat="server"
            ErrorMessage="Shipping State is Required" ForeColor=" " CssClass="errormessage"
            ControlToValidate="lstState" Enabled="false" Display="None" ValidationGroup="grpAddressBook"></bvc5:BVRequiredFieldValidator>
        <anthem:TextBox ID="stateField" runat="server" Columns="10" CssClass="txt_fld" Visible="False"></anthem:TextBox>
        <anthem:DropDownList runat="server" ID="CountyField" CssClass="txt_fld">
        </anthem:DropDownList>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <span>*</span>
        <asp:Label ID="postalCodeLabel" runat="server" Text="Zip :" AssociatedControlID="postalCodeField"></asp:Label>
    </div>
    <div class="form-right">
        <asp:TextBox ID="postalCodeField" runat="server" Columns="5" CssClass="txt_fld st1"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="valPostalCode" runat="server" ErrorMessage="Zip code is Required"
            ControlToValidate="postalCodeField" ForeColor=" " CssClass="errormessage" Display="None"
            ValidationGroup="grpAddressBook"></bvc5:BVRequiredFieldValidator>
        <bvc5:BVRegularExpressionValidator ID="PostalCodeBVRegularExpressionValidator" runat="server"
            CssClass="errormessage" ControlToValidate="postalCodeField" Display="None" ErrorMessage="Postal code is invalid."
            ValidationGroup="grpAddressBook"></bvc5:BVRegularExpressionValidator>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <asp:Label ID="PhoneNumberLabel" runat="server" Text="Phone :" AssociatedControlID="PhoneNumberField"></asp:Label>
    </div>
    <div class="form-right">
        <asp:TextBox ID="PhoneNumberField" runat="server" Columns="20" CssClass="txt_fld st1"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="valPhone" runat="server" ControlToValidate="PhoneNumberField"
            ErrorMessage="Phone Number is Required" Enabled="False" ForeColor=" " CssClass="errormessage"
            Display="None" ValidationGroup="grpAddressBook">
        </bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <asp:Label ID="FaxNumberLabel" runat="server" Text="Fax :" AssociatedControlID="FaxNumberField"></asp:Label>
    </div>
    <div class="form-right">
        <asp:TextBox ID="FaxNumberField" runat="server" Columns="20" CssClass="txt_fld st1"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="valFax" runat="server" ControlToValidate="FaxNumberField"
            ErrorMessage="Fax Number is Required" Enabled="False" ForeColor=" " CssClass="errormessage"
            Display="None" ValidationGroup="grpAddressBook" Text="*">
        </bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <asp:Label ID="WebSiteURLLabel" runat="server" Text="Web Site :" AssociatedControlID="WebSiteURLField"></asp:Label>
    </div>
    <div class="form-right">
        <asp:TextBox ID="WebSiteURLField" runat="server" Columns="20" CssClass="txt_fld st1"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="valWebSite" runat="server" ControlToValidate="WebSiteURLField"
            ErrorMessage="Web Site URL is Required" Enabled="False" ForeColor=" " CssClass="errormessage"
            Display="None" Text="*" ValidationGroup="grpAddressBook">
        </bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>
<asp:HiddenField ID="AddressBvin" runat="server" />
