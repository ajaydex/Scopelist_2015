<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Service.master" AutoEventWireup="false"
    CodeFile="ContactUs.aspx.vb" Inherits="Contact" Title="Contact Us" ValidateRequest="false" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <style type="text/css">
        li.liststyle
        {
            min-width: 400px !important;
            background: none !important;
        }
    </style>
    <style type="text/css">
        /*CONTENT COLUMN EDIT LINKS*//*used for the content column edit links when logged in*/a.customButton
        {
            background: #BC1122 url(/BVAdmin/Images/edit-icon.png) no-repeat center center;
            color: #fff;
            text-decoration: none;
            padding: 5px 10px;
            -webkit-border-radius: 0 0 5px 5px;
            -moz-border-radius: 0 0 5px 5px;
            border-radius: 0 0 5px 5px;
            vertical-align: middle;
            display: inline-block;
            position: absolute;
            top: 0;
            right: 10px;
            opacity: .8;
            font-weight: bold;
            text-indent: -999px;
            width: 15px;
            overflow: hidden;
        }
        a.customButton:hover
        {
            opacity: 1;
        }
        /*has to be positioned so the content column edit link is in the correct location*/.postContentColumn, .preContentColumn
        {
            position: relative;
        }
        .contact-form label
        {
            display: block;
            float: left;
            margin-top: 0;
            text-align: left;
            width: 100px;
            margin-bottom: -5px;
            margin-left: 0px;
        }
        .contact-form
        {
            background: none;
            border-right: 1px solid #cacac7;
        }
        .contact-form input[type="text"], .contact-form select, .contact-form textarea
        {
            border: 1px solid #cacac7;
            margin: 9px 0;
            color: #515044;
        }
        .contact-add-right
        {
            overflow: hidden;
        }
        .top-section
        {
            border-bottom: solid 1px #cacac7;
            display: block;
            overflow: hidden;
            padding-bottom: 40px;
        }
        .contact-form textarea
        {
            height: 100px;
        }
        .contact-form input[type="submit"]
        {
            margin: 0;
            background: #ca0d09;
            border: solid 1px #ca0d09;
        }
        .contact-add-right p
        {
            border-bottom: dotted 1px #cacac7;
            margin-right: 20px;
            overflow: hidden;
            margin-bottom: 10px;
        }
        .contact-form-bottom
        {
            display: block;
            float: left;
            margin-right: 30px;
            overflow: hidden;
            padding: 15px;
            width: 43%;
        }
        .contact-form-bottom ul li
        {
            list-style: circle;
            list-style-type: circle;
            padding: 0 0 5px 10px;
            background: none;
        }
        .contact-add-right-bottom
        {
            overflow: hidden;
            float: left;
            padding-top: 15px;
        }
        .contact-add-right-bottom ul li
        {
            list-style: circle;
            list-style-type: circle;
            padding: 0 0 5px 10px;
            background: none;
        }
        
        .error_message_text
        {
            width: 70%;
        }
        
        .success_panel
        {
            min-height: 20px;
        }
    </style>
    <asp:Panel ID="pnlContactForm" runat="server">
        <fieldset class="contactform">
            <legend>Contact Form</legend>
            <table id="ContactUsFormTable" runat="server">
            </table>
            <div class="buttonrow">
                <asp:ImageButton ID="ImageButton1" runat="server" ToolTip="Submit" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Submit.png">
                </asp:ImageButton></div>
        </fieldset>
    </asp:Panel>
    <div class="big-column">
        <div class="breadcrumb">
            <div class="breadcrumbs">
                <div itemtype="http://data-vocabulary.org/Breadcrumb" itemscope="">
                    <a itemprop="url" href="/"><span itemprop="title">Home</span> </a><span class="spacer">
                        &nbsp;&gt;&nbsp;</span>
                    <div itemtype="http://data-vocabulary.org/Breadcrumb" itemscope="" itemprop="child">
                        <span itemprop="title">Contact Us</span>
                    </div>
                </div>
            </div>
        </div>
        <h1>
            <asp:Label ID="TitleLabel" runat="server">Contact Us</asp:Label>
        </h1>
        <div class="top-section">
            <div class="contact-form">
                <h3>
                    Fields that contain * are required!</h3>
                <div class="error_panel2">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error_list"
                        ValidationGroup="vg2" />
                </div>
                <uc1:MessageBox ID="msg" runat="server" style="width: 327px;" />
                <label>
                    *First name :</label><asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtFirstName" Display="None" ErrorMessage="First Name is Required"
                    runat="server" ID="rfvYourName" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <label>
                    *Last name :</label><asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtLastName" Display="None" ErrorMessage="Last Name is Required"
                    runat="server" ID="RequiredFieldValidator2" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <label>
                    *Email :</label><asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtEmail" Display="None" ErrorMessage="Email is Required"
                    runat="server" ID="rfvEmail" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <label>
                    *Phone no:</label><asp:TextBox ID="txtTelephone" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtTelephone" Display="None" ErrorMessage="Phone Number is Required"
                    runat="server" ID="rfvTelephone" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <label>
                    *Purpose :</label><asp:DropDownList ID="ddlPurpose" runat="server" class="txt_fld">
                        <asp:ListItem Value="">--None--</asp:ListItem>
                        <asp:ListItem Value="Quotes">Quotes</asp:ListItem>
                        <asp:ListItem Value="Orders">Orders</asp:ListItem>
                        <asp:ListItem Value="Tracking">Tracking</asp:ListItem>
                        <asp:ListItem Value="Shipping">Shipping</asp:ListItem>
                        <asp:ListItem Value="Returns">Returns</asp:ListItem>
                        <asp:ListItem Value="Compliments">Compliments</asp:ListItem>
                        <asp:ListItem Value="Suggestions">Suggestions</asp:ListItem>
                        <asp:ListItem Value="Other">Other</asp:ListItem>
                    </asp:DropDownList>
                <asp:RequiredFieldValidator ControlToValidate="ddlPurpose" Display="None" ErrorMessage="Purpose is  Required"
                    runat="server" ID="RequiredFieldValidator1" ValidationGroup="vg2"></asp:RequiredFieldValidator>
                <label>
                    *Your queries :</label>
                <asp:TextBox ID="txtMessage" TextMode="MultiLine" runat="server"></asp:TextBox>
                <input type="submit" value="Submit" runat="server" validationgroup="vg2" id="btnContactUs" />
            </div>
            <div class="contact-add-right" id="contactUsInfo" runat="server">
            </div>
        </div>
        <div class="clear">
        </div>
        <div class="contact-bottom" id="contactUsBottom" runat="server">
        </div>
    </div>
</asp:Content>
