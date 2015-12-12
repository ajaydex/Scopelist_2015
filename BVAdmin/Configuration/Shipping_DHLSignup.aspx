<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/BVAdmin/BVAdmin.master" CodeFile="Shipping_DHLSignup.aspx.vb" Inherits="BVAdmin_Configuration_Shipping_DHLSignup" %>
<%@ Register Src="~/BVAdmin/Controls/DatePicker.ascx" TagName="DatePicker" TagPrefix="uc" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>DHL API Registration</h1>
    <uc:MessageBox ID="msgBox" runat="server" />
    <asp:MultiView ID="mvSignupForm" ActiveViewIndex="0" runat="server">
        <asp:View ID="signupView" runat="server">
            <div class="dhlSignupForm">
                <table border="0" cellspacing="0" cellpadding="5">
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Region:
                        </td>
                        <td class="formfield" align="left" valign="top">
                            <asp:DropDownList ID="regionField" runat="server" Columns="40">
                                <asp:ListItem Value="">-Select a Region-</asp:ListItem>
                                <asp:ListItem Value="AM">Americas</asp:ListItem>
                                <asp:ListItem Value="EU">Europe</asp:ListItem>
                                <asp:ListItem Value="AP">Asia-Pacific</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ControlToValidate="regionField" CssClass="errormessage" ErrorMessage="Region is a required field." Display="Dynamic" runat="server">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Company Name:
                        </td>
                        <td class="formfield" align="left" valign="top">
                            <asp:TextBox ID="companyNameField" runat="server" Columns="40" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="companyNameField" CssClass="errormessage" ErrorMessage="Company name is a required field." Display="Dynamic" runat="server">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Account Number:
                        </td>
                        <td class="formfield" align="left" valign="top">
                            <asp:TextBox ID="accountNumberField" runat="server" Columns="40" />
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            IT Contact (e-mail):
                        </td>
                        <td class="formfield" align="left" valign="top">
                            <asp:TextBox ID="itContactField" runat="server" Columns="40" />
                            <asp:RequiredFieldValidator CssClass="errormessage" runat="server" ControlToValidate="itContactField" Display="Dynamic" ErrorMessage="IT Contact is a required field">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator CssClass="errormessage" runat="server" ControlToValidate="itContactField" Display="Dynamic"
                                    ErrorMessage="Please enter a valid email address" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Contact e-mail for future product support:
                        </td>
                        <td class="formfield" align="left" valign="top">
                            <asp:TextBox ID="futureContactEmailField" runat="server" Columns="40" />
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Business Contact (e-mail)
                        </td>
                        <td class="formfield" align="left" valign="top">
                            <asp:TextBox ID="businessContactField" runat="server" Columns="40" />
                            <asp:RequiredFieldValidator ControlToValidate="businessContactField" CssClass="errormessage" ErrorMessage="Business contact is a required field." Display="Dynamic" runat="server">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator CssClass="errormessage" runat="server" ControlToValidate="businessContactField" Display="Dynamic" ErrorMessage="Please enter a valid email address" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Planned go live date
                        </td>
                        <td class="formfield" align="left" valign="top">
                            <uc:DatePicker ID="goLiveDatePicker" RequiredErrorMessage="Planned go live date is a required field." InvalidFormatErrorMessage="The date that you entered is in an invalid format." runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Expected Transaction Volume (Daily, Weekly, Monthly, etc.)
                        </td>
                        <td class="formfield" align="left" valign="top">
                            <asp:TextBox ID="expectedTransactionVolumeField" runat="server" Columns="40" />
                            <asp:RequiredFieldValidator ControlToValidate="expectedTransactionVolumeField" CssClass="errormessage" ErrorMessage="Expected transaction volume is a required field." Display="Dynamic" runat="server">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table><br />
                <asp:ImageButton ImageUrl="~/BVAdmin/Images/Buttons/Submit.png" ID="btnSubmit" AlternateText="Submit" runat="server" />
            </div>
        </asp:View>
        <asp:View ID="successView" runat="server">
            Your DHL API registration request has been successfully sent! Please wait to be contacted by a DHL representative.<br /><br />
            <asp:ImageButton ImageUrl="~/BVAdmin/images/buttons/continue.png" ID="btnContinue" AlternateText="Continue" runat="server" />
        </asp:View>
    </asp:MultiView>
</asp:Content>
