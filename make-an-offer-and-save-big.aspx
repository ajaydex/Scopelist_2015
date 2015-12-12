<%@ Page Title="Product Details" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Make-an-offer-and-save-big.aspx.vb" Inherits="SalesForceFormLead" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc18" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentHolder" runat="Server">
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
                    rows="3" cols="2" id="txtAddress" runat="server" style="resize: none; height: 35px;"></textarea>
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
                <asp:Button ID="btnContact" runat="server" Text="Make Offer" ValidationGroup="vg2" />
            </div>
            <div class="price-tc new_porice">
                <p>
                    Terms and conditions</p>
                <ul>
                    <!--  <li>You must register with Scopelist.com to recieve the offer.</li>
                    <li>This offer is not redeemable for cash or credit toward purchases.</li>
                    <li>Orders must exceed $500, excluding any discounts or taxes.</li>
                    <li>"Make An Offer and SAVE BIG" promotion is limited and subject to change or expire at any point at the sole discretion of Scopelist.</li>
                    <li>Your orders will receive free shipping through FedEx or UPS at the sole discretion of Scopelist. </li>-->
                    <li>Scopelist.com orders exceeding $750 require authorization by an adult signature.
                        The carrier may, at its own discretion, require a signature at the delivery address
                        by the individual who has placed the order.</li>
                    <li>It is a requirement that we ship to the cardholder's billing address on all orders.
                        For issues please call us at (866) 271-7212 before ordering.</li>
                    <!--  <li>Offer valid for continental USA only. Orders to Alaska and Hawaii do not qualify for free shipping.</li>-->
                    <li>For returns, please see <a href="http://www.scopelist.com/ReturnForm.aspx" target="_blank">
                        return policy</a> for details.</li>
                    <li>SAME DAY SHIPPING: Payment received by 4PM EST are shipped on the SAME DAY.</li>
                    <li>Please see <a href="http://www.scopelist.com/why-scopelist.aspx" target="_blank">
                        "Why Scopelist" </a>to know why we strive to be the best among sports optics retailers.
                    </li>
                </ul>
            </div>
        </div>
        <div style="padding: 20px 0; display: block; clear: both; overflow: hidden; margin: 40px 0 0 0;">
            <p style="font-size: 12px; text-align: center;">
                <em style="color: #000; font-size: 16px;">"The only place I will buy optics from"</em>
                <span style="color: #000; font-size: 14px; padding-right: 5px;">--- Mark</span>
                August 30, 2014</p>
        </div>
    </div>
</asp:Content>
