<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AddressEditor.ascx.vb" Inherits="BVAdmin_Controls_AddressEditor" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<anthem:Panel ID="pnlShipping" runat="server">
    <table cellpadding="0" cellspacing="0">
        <tr>
            <td class="formlabel">
                Country:
            </td>
            <td class="formfield">
                <anthem:DropDownList ID="lstCountry" TabIndex="101" runat="server" AutoCallBack="true"></anthem:DropDownList>
       	    </td>
        </tr>
        <tr id="trNickNameRow" runat="server" visible="true">
            <td class="formlabel">Nick Name:</td>
            <td class="formfield">
        	    <asp:TextBox ID="NickNameField" TabIndex="102" runat="server" ></asp:TextBox>
       	    </td>
        </tr>
        <tr>
            <td class="formlabel">
                First:&nbsp;
       	    </td>
            <td class="formfield">
                <asp:TextBox ID="firstNameField" TabIndex="103" runat="server" Columns="20"></asp:TextBox>
                <asp:TextBox ID="MiddleInitialField" TabIndex="104" runat="server" Columns="2" MaxLength="1" Width="50px" placeholder="MI"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valFirstName" runat="server" ErrorMessage="First Name is Required"  ControlToValidate="firstNameField" display="dynamic">*</bvc5:BVRequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Last:
            </td>
            <td class="formfield">
                <asp:TextBox ID="lastNameField" TabIndex="105" runat="server" Columns="30"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valLastName" runat="server" ErrorMessage="Last Name is Required" ControlToValidate="lastNameField" display="dynamic">*</bvc5:BVRequiredFieldValidator>
       	    </td>
        </tr>
        <tr id="CompanyNameRow" runat="server">
            <td class="formlabel">
                Company:
       	    </td>
            <td class="formfield">
                <asp:TextBox ID="CompanyField" TabIndex="106" runat="server" Columns="30"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valCompany" runat="server" ControlToValidate="CompanyField"  ErrorMessage="Company is Required" Enabled="False" display="dynamic">*</bvc5:BVRequiredFieldValidator>
      	    </td>
        </tr>
        <tr>
            <td class="formlabel">
                Address:
            </td>
            <td class="formfield">
                <asp:TextBox ID="address1Field" TabIndex="107" runat="server" Columns="30"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valAddress" runat="server" ErrorMessage="Address is Required" ControlToValidate="address1Field" display="dynamic">*</bvc5:BVRequiredFieldValidator>
       	    </td>
        </tr>
        <tr>
            <td class="formlabel">&nbsp;
            
            </td>
            <td class="formfield">
                <asp:TextBox ID="address2Field" TabIndex="108" runat="server" Columns="30"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="formlabel">&nbsp;
            
            </td>
            <td class="formfield">
                <asp:TextBox ID="address3Field" TabIndex="108" runat="server" Columns="30"></asp:TextBox>
       	    </td>
        </tr>
        <tr>
            <td class="formlabel">
                City:
            </td>
            <td class="formfield">
                <asp:TextBox ID="cityField" TabIndex="109" runat="server" Columns="30"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valCity" runat="server" ErrorMessage="City is Required" ControlToValidate="cityField" display="dynamic">*</bvc5:BVRequiredFieldValidator>
       	    </td>
        </tr>
        <tr>
            <td class="formlabel">State, Zip:&nbsp;</td>
            <td class="formfield">
           	    <anthem:DropDownList ID="lstState" TabIndex="110" runat="server" AutoCallBack="true"></anthem:DropDownList> 
                <anthem:TextBox ID="stateField" TabIndex="111" AutoCallBack="true" runat="server"  Visible="False"></anthem:TextBox>
                <anthem:TextBox ID="postalCodeField" TabIndex="112" AutoCallBack="true" runat="server" Columns="6"></anthem:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valPostalCode" runat="server" ErrorMessage="Postal Code is Required"  ControlToValidate="postalCodeField"  display="dynamic">*</bvc5:BVRequiredFieldValidator>
                <asp:Label ID="lblStateError" runat="server" Visible="False">*</asp:Label><br />
                <anthem:DropDownList runat="server" id="CountyField" AutoCallBack="true" AutoUpdateAfterCallBack="true" TabIndex="113"></anthem:DropDownList>
            </td>
        </tr>        
        <tr id="PhoneRow" runat="server">
            <td class="formlabel">
                Phone:
            </td>
            <td class="formfield">
                <asp:TextBox ID="PhoneNumberField" TabIndex="114" runat="server"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valPhone" runat="server" ControlToValidate="PhoneNumberField" ErrorMessage="Phone Number is Required" Enabled="False" display="dynamic">*</bvc5:BVRequiredFieldValidator>
       	    </td>
        </tr>
        <tr id="FaxRow" runat="server">
            <td class="formlabel">
                Fax:
            </td>
            <td class="formfield">
                <asp:TextBox ID="FaxNumberField" TabIndex="115" runat="server"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valFax" runat="server" ControlToValidate="FaxNumberField" ErrorMessage="Fax Number is Required" Enabled="False"  display="dynamic">*</bvc5:BVRequiredFieldValidator>
       	    </td>
        </tr>
        <tr id="WebSiteURLRow" runat="server">
            <td class="formlabel">Web Site:</td>
            <td class="formfield">
                <asp:TextBox ID="WebSiteURLField" TabIndex="116" runat="server"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="valWebSite" runat="server" ControlToValidate="WebSiteURLField" ErrorMessage="Web Site URL is Required" Enabled="False"  display="dynamic">*</bvc5:BVRequiredFieldValidator>
      	    </td>
        </tr>
    </table>

    <asp:HiddenField ID="AddressBvin" runat="server" />
</anthem:Panel>