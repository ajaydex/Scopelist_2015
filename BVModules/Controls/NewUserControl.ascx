<%@ Control Language="VB" AutoEventWireup="false" CodeFile="NewUserControl.ascx.vb"
    Inherits="BVModules_Controls_NewUserControl" %>
<%@ Register Src="MessageBox.ascx" TagPrefix="uc" TagName="MessageBox" %>
<uc:MessageBox runat="server" ID="MessageBox1" />
<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSaveChanges">
    <div class="signup_blk" id="NewUserTable" runat="server">
    </div>
    <asp:ValidationSummary ID="valNewUserSummary" EnableClientScript="True" ShowSummary="true"
        runat="server" ValidationGroup="NewUser" CssClass="error_list validationSummary">
    </asp:ValidationSummary>
    <div class="general-form" style="padding-top: 25px !important;">
        <div class="form-row">
            <div class="form-left">
                <asp:Label ID="UsernameLabel" runat="server" Text="Username" AssociatedControlID="UsernameField"></asp:Label>
            </div>
            <div class="form-right">
                <asp:TextBox ID="UsernameField" CssClass="txt_fld st1" runat="server" Columns="30"
                    MaxLength="100" TabIndex="2000"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ValidationGroup="NewUser" CssClass="divError" ID="valRequiredUsername"
                    runat="server" ErrorMessage="Please enter a username" ControlToValidate="UsernameField"
                    ForeColor=" " Display="None"></bvc5:BVRequiredFieldValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                <asp:Label ID="EmailLabel" runat="server" Text="*Email :" AssociatedControlID="EmailField"></asp:Label>
            </div>
            <div class="form-right">
                <asp:TextBox ID="EmailField" CssClass="txt_fld st1" runat="server" Columns="30" MaxLength="100"
                    TabIndex="2001"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ValidationGroup="NewUser" ID="val2Username" CssClass="error_panel"
                    ForeColor=" " EnableClientScript="True" runat="server" ControlToValidate="EmailField"
                    Display="None" ErrorMessage="Please enter an email address" Visible="True"></bvc5:BVRequiredFieldValidator>
                <bvc5:BVRegularExpressionValidator ValidationGroup="NewUser" CssClass="error_panel"
                    ID="valUsername" ForeColor=" " runat="server" ControlToValidate="EmailField"
                    Display="None" ErrorMessage="Please enter a valid email address" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></bvc5:BVRegularExpressionValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                <asp:Label ID="FirstNameLabel" runat="server" Text="*First Name :" AssociatedControlID="FirstNameField"></asp:Label>
            </div>
            <div class="form-right">
                <asp:TextBox ID="FirstNameField" CssClass="txt_fld st1" TabIndex="2002" runat="server"
                    Columns="30" MaxLength="50"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ValidationGroup="NewUser" CssClass="error_panel" ID="valFirstName"
                    ForeColor=" " EnableClientScript="True" runat="server" ControlToValidate="FirstNameField"
                    Display="None" ErrorMessage="Please enter a first name or nickname" Visible="True"></bvc5:BVRequiredFieldValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                <asp:Label ID="LastNameLabel" runat="server" Text="*Last Name :" AssociatedControlID="LastNameField"></asp:Label>
            </div>
            <div class="form-right">
                <asp:TextBox ID="LastNameField" CssClass="txt_fld st1" TabIndex="2003" runat="server"
                    Columns="30" MaxLength="50"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ValidationGroup="NewUser" CssClass="error_panel" ID="RequiredFieldValidator1"
                    ForeColor=" " EnableClientScript="True" runat="server" ControlToValidate="LastNameField"
                    Display="None" ErrorMessage="Please enter a last name" Visible="True"></bvc5:BVRequiredFieldValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                &nbsp;</div>
            <div class="form-right" id="PasswordReminder" runat="server">
                Password must be at least 8 characters long.</div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                <asp:Label ID="PasswordLabel" runat="server" Text="*Password :" AssociatedControlID="PasswordField"></asp:Label>
            </div>
            <div class="form-right">
                <asp:TextBox ID="PasswordField" CssClass="txt_fld st1" runat="server" Columns="30"
                    TabIndex="2006" TextMode="Password"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ValidationGroup="NewUser" CssClass="error_panel" ID="valPassword"
                    runat="server" ControlToValidate="PasswordField" ErrorMessage="A password is required"
                    ForeColor=" " Display="None"></bvc5:BVRequiredFieldValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                <span>*</span><asp:Label ID="PasswordConfirmLabel" runat="server" Text="Confirm Password :"
                    AssociatedControlID="PasswordConfirmField"></asp:Label>
            </div>
            <div class="form-right">
                <asp:TextBox ID="PasswordConfirmField" CssClass="txt_fld st1" runat="server" Columns="30"
                    TabIndex="2007" TextMode="Password"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator CssClass="error_panel" ValidationGroup="NewUser" ID="RequiredFieldValidator2"
                    runat="server" ControlToValidate="PasswordConfirmField" ErrorMessage="A password confirmation is required"
                    Display="None" ForeColor=" "></bvc5:BVRequiredFieldValidator>
                <bvc5:BVCompareValidator ID="CompareValidator1" CssClass="error_panel" runat="server"
                    ControlToCompare="PasswordField" ControlToValidate="PasswordConfirmField" Display="None"
                    ErrorMessage="Password and Confirmation Password Must Match." ValidationGroup="NewUser"
                    ForeColor=" "></bvc5:BVCompareValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                <asp:Label ID="PasswordHintLabel" runat="server" Text="Password Hint :" AssociatedControlID="PasswordHintField"></asp:Label>
            </div>
            <div class="form-right">
                <asp:TextBox ID="PasswordHintField" CssClass="txt_fld st1" runat="server" Columns="30"
                    TabIndex="2008"></asp:TextBox>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                <asp:Label ID="PasswordAnswerLabel" runat="server" Text="Password Answer :" AssociatedControlID="PasswordAnswerField"></asp:Label>
            </div>
            <div class="form-right">
                <asp:TextBox ID="PasswordAnswerField" CssClass="txt_fld st1" runat="server" Columns="30"
                    TabIndex="2009"></asp:TextBox>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                &nbsp;
            </div>
            <div class="form-right">
                <asp:ImageButton ID="btnSaveChanges" TabIndex="2050" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-signupnow.png"
                    ValidationGroup="NewUser" CssClass="custom"></asp:ImageButton>
            </div>
            <div class="clr">
            </div>
        </div>
    </div>
    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Panel>
