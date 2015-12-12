<%@ Page Title="Product Details" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="labor-day-offer.aspx.vb" Inherits="labor_day_offer" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc18" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <style type="text/css">
        li.liststyle
        {
            background: none !important;
        }
    </style>
    <div class="one-column">
        <div class="breadcrumb">
            <a href="/">Home</a> &gt; Make An Offer and SAVE BIG
        </div>
        <h1>
            <span>MAKE AN OFFER and SAVE BIG! </span>
        </h1>
        <div class="error_panel2">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error_list"
                ValidationGroup="vg2" />
        </div>
        <uc18:MessageBox ID="messagebox1" runat="server" />
        <div class="contact-form-cont">
            <div class="price-form">
                <p>
                    <strong>Fields that contain * are required</strong></p>
                <input type="text" placeholder="*First Name" id="first_name" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="first_name" Display="None" ErrorMessage="First Name is Required"
                    runat="server" ID="rfvContactFirstName" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <input type="text" placeholder="*Last Name" id="last_name" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="last_name" Display="None" ErrorMessage="Last Name is Required"
                    runat="server" ID="rfvContactLastName" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <input type="text" placeholder="*Phone number" id="txtTelephone" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="txtTelephone" Display="None" ErrorMessage="Phone Number is Required"
                    runat="server" ID="rfvTelephone" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <input type="text" placeholder="*Email address" id="email" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="email" Display="None" ErrorMessage="Email address is Required"
                    runat="server" ID="rfvContactEmail" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ControlToValidate="email" ValidationExpression="[\w\.-]+(\+[\w-]*)?@([\w-]+\.)+[\w-]+"
                    Display="None" ErrorMessage=" Email not valid" runat="server" ID="RegxContactEmail"
                    ValidationGroup="vg2"></asp:RegularExpressionValidator>
                <textarea placeholder="*Address-Please fill your address or atleast ZIP code for Shipping and Tax Calculation"
                    id="txtAddress" runat="server" style="resize: none; height: 35px;"></textarea>
                <asp:RequiredFieldValidator ControlToValidate="txtAddress" Display="None" ErrorMessage="Address or Zip Code is Required"
                    runat="server" ID="rfvAddress" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <input type="text" placeholder="Product Name" class="full-width" runat="server" id="txtProductName"
                    readonly="readonly" />
                <input type="text" placeholder="Product SKU" class="full-width" runat="server" id="txtSKU"
                    readonly="readonly" />
                <input type="text" placeholder="Current Price $3000" id="txtCurrentPrice" runat="server"
                    readonly="readonly" />
                <input type="text" placeholder="Your Offer" id="txtYourPrice" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="txtYourPrice" Display="None" ErrorMessage="Your Price is required"
                    runat="server" ID="rfvYourPrice" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <br />
                <span style="margin-left: 8px; font-weight: bold;">Expedited Shipping Needed</span>
                <asp:DropDownList ID="ddlExpeditedShipping" runat="server" class="txt_fld">
                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                    <asp:ListItem Value="No" Selected="True">No</asp:ListItem>
                </asp:DropDownList>
                <br />
                <span style="margin-left: 8px; font-weight: bold;">Cash Back Choice</span>
                <asp:DropDownList ID="ddlCashBackChoose" name="ddlCashBackChoose" runat="server"
                    class="txt_fld">
                    <asp:ListItem Text="-None-" Value=""></asp:ListItem>
                    <asp:ListItem Selected="True">Amazon Gift Card</asp:ListItem>
                    <asp:ListItem>By Check</asp:ListItem>
                    <asp:ListItem>By Paypal</asp:ListItem>
                </asp:DropDownList>
                <br />
                <br />
                <asp:Button ID="btnContact" runat="server" Text="Make Offer" ValidationGroup="vg2" />
            </div>
            <div class="price-tc">
                <p>
                    *See Terms and conditions</p>
                <ul>
                    <li>$25 cash back bonus is given for any purchase of $500 or above from Scopelist.com
                        website.</li>
                    <li>For Make an offer and Save BIG, all reasonable offers will be considered - Once
                        you submit an offer you will receive an email declaring whether we have accepted
                        your offer. We will present you with our best price.</li>
                    <li>Prices and availability are subject to change.</li>
                    <li>Scopelist.com orders exceeding $750 require authorization by an adult signature.
                        The carrier may, at its own discretion, require a signature at the delivery address
                        by the individual who has placed the order.</li>
                    <li>It is a requirement that we ship to the cardholder's billing address on all orders.
                        For issues please call us at (877) 741-5532 before ordering. </li>
                    <li>Sales taxes apply to PA customers</li>
                    <li>For returns, please see return policy for details</li>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
