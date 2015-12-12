<%@ Control Language="VB" AutoEventWireup="false" CodeFile="LoginControl.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_LoginControl" %>

<%@ Register Src="~/bvmodules/controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:ValidationSummary ID="valLoginSummary" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server" ValidationGroup="UserLogin" ForeColor="White" DisplayMode="BulletList" HeaderText='<a href="#" class="close">&times;</a>' />

<h2 id="HeaderTextH2" runat="server"></h2>

<uc:MessageBox ID="MessageBox1" runat="server" />

<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnLogin">

	<asp:Label ID="UsernameLabel" CssClass="required" runat="server" Text="Username" AssociatedControlID="UsernameField"></asp:Label>

    <bvc5:BVRequiredFieldValidator ValidationGroup="UserLogin" ID="valRequiredUsername" runat="server" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter a username" ControlToValidate="UsernameField" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>

	<asp:TextBox ID="UsernameField" autocomplete="off" runat="server" ToolTip="Enter Your Username" placeholder="required" TabIndex="1"></asp:TextBox>


    <em class="right smallText"><asp:HyperLink ID="lnkForgotPassword" runat="server" NavigateUrl="~/ForgotPassword.aspx" TabIndex="5">I Forget.</asp:HyperLink></em>
	<asp:Label ID="PasswordLabel" CssClass="required" runat="server" Text="Password" AssociatedControlID="PasswordField"></asp:Label>

    <bvc5:BVRequiredFieldValidator ValidationGroup="UserLogin" ID="valRequiredPassword" runat="server" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Password is required" ControlToValidate="PasswordField" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>

    <asp:TextBox ID="PasswordField" autocomplete="off" runat="server" TextMode="Password" ToolTip="Enter Your Password" placeholder="required" TabIndex="2"></asp:TextBox>
    

    <div id="trRememberMe" runat="server">
		<asp:CheckBox ID="RememberMeCheckBox" runat="server" Text="Remember Me" Checked="true" TabIndex="3" />
    </div>
    <br />
	<asp:ImageButton ID="btnLogin" runat="server" ValidationGroup="UserLogin" TabIndex="4" />

</asp:Panel>

<asp:HiddenField ID="RedirectToField" runat="server" />
