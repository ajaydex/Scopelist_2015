<%@ Page Title="" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Email-My-Quote.aspx.vb" Inherits="Email_My_Quote" %>

<%@ Register Src="BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="uc1" %>
<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="~/BVModules/Controls/Search.ascx" TagName="Search" TagPrefix="uc17" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc18" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <style type="text/css">
        li.liststyle {
            background: none !important;
        }
    </style>
    <div class="one-column">
        <div class="breadcrumb">
            <a href="/">Home</a> &gt;  Request My Quote
        </div>
        <h1>
            <span>FREEDOM SALE - MAKE AN OFFER and SAVE BIG! </span></h1>
        <div class="error_panel2">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error_list"
                ValidationGroup="vg2" />
        </div>
        <uc18:MessageBox ID="messagebox1" runat="server" />
        <%--<div class="width-471">
            <h3>Fields that contain * are required!</h3>
            <div class="general-form">
                <div class="form-row">
                    <div class="form-left">
                        *First Name :
                    </div>
                    <div class="form-right">
                        <asp:TextBox ID="" runat="server"></asp:TextBox>

                    </div>
                    <div class="clr">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-left">
                        *Last Name :
                    </div>
                    <div class="form-right">
                        <asp:TextBox ID="" runat="server"></asp:TextBox>

                    </div>
                    <div class="clr">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-left">
                        *Phone Number :
                    </div>
                    <div class="form-right">
                        <asp:TextBox ID="" runat="server" class="txt_fld"></asp:TextBox>

                    </div>
                    <div class="clr">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-left">
                        Address :
                    </div>
                    <div class="form-right">
                        <asp:TextBox ID="" TextMode="MultiLine" runat="server" class="txt_fld st1"
                            Style="resize: none;"></asp:TextBox>
                    </div>
                    <div class="clr">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-left">
                        <span>*</span> Email Address :
                    </div>
                    <div class="form-right">
                        <asp:TextBox ID="" runat="server" class="txt_fld st1"></asp:TextBox>

                    </div>
                    <div class="clr">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-left">
                        Current Price :
                    </div>
                    <div class="form-right">
                        <asp:TextBox ID="" runat="server" class="txt_fld st1"
                            Style="text-decoration: line-through; padding-left: 2px;" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="clr">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-left">
                        <span>*</span> Your Price :
                    </div>
                    <div class="form-right">
                        <asp:TextBox ID="" runat="server" class="txt_fld st1"></asp:TextBox>

                    </div>
                    <div class="clr">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-left">
                        Additional Information :
                    </div>
                    <div class="form-right">
                        <asp:TextBox ID="txtMessage" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </div>
                    <div class="clr">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-left">
                        &nbsp;
                    </div>
                    <div>
                        <asp:ImageButton ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-submit.png"
                            ID="btnContact" runat="server" ToolTip="Click to send us a message" ValidationGroup="vg2"
                            Style="margin-top: 0px;" />
                    </div>
                    <div class="clr">
                    </div>
                </div>
            </div>
        </div>--%>


        <div class="contact-form-cont">
            <div class="price-form">
                <p><strong>Fields that contain * are required</strong></p>
                <input type="text" placeholder="First Name" id="txtContactFirstName" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="txtContactFirstName" Display="None"
                    ErrorMessage="First Name is Required" runat="server" ID="rfvContactFirstName"
                    ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <input type="text" placeholder="Last Name" id="txtContactLastName" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="txtContactFirstName" Display="None"
                    ErrorMessage="Last Name is Required" runat="server" ID="rfvContactLastName" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <input type="text" placeholder="*Phone number" id="txtTelephone" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="txtTelephone" Display="None" ErrorMessage="Phone Number is Required"
                    runat="server" ID="rfvTelephone" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <input type="text" placeholder="*Email address" id="txtContactEmail" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="txtContactEmail" Display="None" ErrorMessage="Email address is Required"
                    runat="server" ID="rfvContactEmail" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ControlToValidate="txtContactEmail" ValidationExpression="[\w\.-]+(\+[\w-]*)?@([\w-]+\.)+[\w-]+"
                    Display="None" ErrorMessage=" Email not valid" runat="server" ID="RegxContactEmail"
                    ValidationGroup="vg2"></asp:RegularExpressionValidator>
                <textarea placeholder="*Address-Please fill your address or atleast ZIP code for Shipping and Tax Calculation" id="txtAddress" runat="server" style="resize: none; height: 35px;"></textarea>
                <asp:RequiredFieldValidator ControlToValidate="txtAddress" Display="None" ErrorMessage="Address or Zip Code is Required"
                    runat="server" ID="rfvAddress" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <input type="text" placeholder="Product Name" class="full-width" runat="server" id="txtProductName" readonly="readonly" />
                <input type="text" placeholder="Product SKU" class="full-width" runat="server" id="txtSKU" readonly="readonly" />
                <input type="text" placeholder="Current Price $3000" id="txtCurrentPrice" runat="server" readonly="readonly" />
                <input type="text" placeholder="Your Offer" id="txtYourPrice" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="txtYourPrice" Display="None" ErrorMessage="Your Price is required"
                    runat="server" ID="rfvYourPrice" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <%--<input type="submit" value="Make Offer" id="btnContact" runat="server" validationgroup="vg2" />--%>
                <asp:Button ID="btnContact" runat="server" Text="Make Offer" ValidationGroup="vg2" />
            </div>
            <div class="price-tc">
                <p>*See Terms and conditions</p>
                <ul>
                    <li>You must register with Scopelist.com to recieve the offer.</li>
                    <li>This offer is not redeemable for cash or credit toward purchases.</li>
                    <li>Orders must exceed $500, excluding any discounts or taxes.</li>
                    <li>Spring Special Promotion is limited and subject to change or expire at any point at the sole discretion of Scopelist.com.</li>
                    <li>Your orders will receive free shipping through FedEx or UPS at the sole discretion of Scopelist. </li>
                    <li>Scopelist.com orders exceeding $1000 require authorization by an adult signature. The carrier may, at its own discretion, require a signature at the delivery address by the individual who has placed the order.</li>
                    <li>It is a requirement that we ship to the cardholder's billing address on all orders. For issues please call us at (877) 741-5532 before ordering.</li>
                    <li>Offer valid for continental USA only. Orders to Alaska and Hawaii do not qualify for free shipping.</li>
                    <li>For returns, please see return policy for details.</li>
                    <li>Also Redeemable by phone! Call (877) 741-5532.</li>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>


