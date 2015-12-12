<%@ Control Language="VB" AutoEventWireup="false" CodeFile="LoginControl.ascx.vb"
    Inherits="BVModules_Controls_LoginControl" %>
<%@ Register Src="MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<div class="error_panel2">
    <asp:ValidationSummary ID="valLoginSummary" CssClass="error_list validationSummary"
        EnableClientScript="True" runat="server" ValidationGroup="Login"></asp:ValidationSummary>
</div>
<h3 id="HeaderTextH2" runat="server">
    Returning User? <span><a id="lnkSign" runat="server" style="color: #D91414">Sign In</a></span>
    here</h3>
<uc1:MessageBox ID="MessageBox1" runat="server" />
<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnLogin">
    <div class="general-form" style="padding-top: 25px !important;">
        <div class="form-row">
            <div class="form-left">
                <asp:Label ID="UsernameLabel" CssClass="sr_panellabel" runat="server" Text="Username :"
                    AssociatedControlID="UsernameField"></asp:Label>
            </div>
            <div class="form-right">
                <asp:TextBox ID="UsernameField" runat="server" ToolTip="Enter Your Username" TabIndex="1"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="UsernameField" Display="None" ErrorMessage="Please enter a Username"
                    runat="server" ID="rfvName" ValidationGroup="Login"></asp:RequiredFieldValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                <asp:Label ID="PasswordLabel" CssClass="sr_panellabel" runat="server" Text="*Password :"
                    AssociatedControlID="PasswordField"></asp:Label>
            </div>
            <div class="form-right">
                <asp:TextBox ID="PasswordField" CssClass="txt_fld st1" runat="server" TextMode="Password"
                    ToolTip="Enter Your Password" TabIndex="2"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="PasswordField" Display="None" ErrorMessage="please enter a Password"
                    runat="server" ID="rfvPassword" ValidationGroup="Login"></asp:RequiredFieldValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                &nbsp;
            </div>
            <div class="form-right">
                <p class="remem" id="trRememberMe" runat="server" style="padding-left: 0px; padding-bottom: 0px;">
                    <asp:CheckBox ID="RememberMeCheckBox" runat="server" Text="  Remember Me" Checked="true"
                        TabIndex="3" />
                </p>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                &nbsp;
            </div>
            <div class="form-right">
                <asp:ImageButton ID="btnLogin" CssClass="signInNew signin custom" runat="server"
                    ToolTip="Login" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-signin.png"
                    ValidationGroup="Login" TabIndex="4" Style="float: left; border: none" />
                <div class="forgotPassword">
                    <asp:HyperLink ID="lnkForgotPassword" TabIndex="5" runat="server" NavigateUrl="~/ForgotPassword.aspx"
                        CssClass="frgt_pass">Forgot Your Password?</asp:HyperLink>
                </div>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                &nbsp;
            </div>
            <div class="form-right">
                <div id="signupId" runat="server">
                    If You Are New User?
                    <asp:HyperLink ID="HyperLink1" TabIndex="5" runat="server" NavigateUrl="~/login.aspx"
                        CssClass="frgt_pass"> Click Here To Sign Up</asp:HyperLink>
                </div>
            </div>
            <div class="clr">
            </div>
        </div>
    </div>
</asp:Panel>
<asp:HiddenField ID="RedirectToField" runat="server" />
