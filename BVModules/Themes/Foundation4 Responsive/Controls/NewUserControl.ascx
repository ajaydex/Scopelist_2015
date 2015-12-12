<%@ Control Language="VB" AutoEventWireup="false" CodeFile="NewUserControl.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_NewUserControl" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<h2>New users&hellip;</h2>
<p>To create a new account please fill in each of the form fields below.</p>

<uc:MessageBox Id="ucMessageBox" runat="server" />

<asp:ValidationSummary ID="valNewUserSummary" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server" ValidationGroup="NewUser" ForeColor="White" DisplayMode="BulletList" HeaderText='<a href="#" class="close">&times;</a>'></asp:ValidationSummary>

<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSaveChanges">

    <div class="row">
        <div class="large-6 columns">
            <asp:Label ID="UsernameLabel" runat="server" Text="Username" AssociatedControlID="UsernameField"></asp:Label>
            <bvc5:BVRequiredFieldValidator ValidationGroup="NewUser" ID="valRequiredUsername" runat="server" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter a username" ControlToValidate="UsernameField" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>
            <asp:TextBox ID="UsernameField" autocomplete="off" runat="server" MaxLength="100" placeholder="required"></asp:TextBox>
        </div>
        <div class="large-6 columns">
            <asp:Label ID="EmailLabel" runat="server" Text="Email" AssociatedControlID="EmailField"></asp:Label>
            <bvc5:BVRequiredFieldValidator ValidationGroup="NewUser" ID="val2Username" EnableClientScript="True" runat="server" ControlToValidate="EmailField" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter an email address" Visible="True">*</bvc5:BVRequiredFieldValidator>
            <bvc5:BVRegularExpressionValidator ValidationGroup="NewUser" ID="valUsername" runat="server" ControlToValidate="EmailField" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter a valid email address" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></bvc5:BVRegularExpressionValidator>
            <asp:TextBox ID="EmailField" runat="server" MaxLength="100" placeholder="required"></asp:TextBox>
        </div>
    </div>

    <div class="row">
        <div class="large-6 columns">
            <asp:Label ID="FirstNameLabel" runat="server" Text="First Name" AssociatedControlID="FirstNameField"></asp:Label>
            <bvc5:BVRequiredFieldValidator ValidationGroup="NewUser" ID="valFirstName" EnableClientScript="True" runat="server" ControlToValidate="FirstNameField" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter a first name or nickname" Visible="True" />
            <asp:TextBox ID="FirstNameField" runat="server" MaxLength="50" placeholder="required"></asp:TextBox>
        </div>

        <div class="large-6 columns">
            <asp:Label ID="LastNameLabel" runat="server" Text="Last Name" AssociatedControlID="LastNameField"></asp:Label>
            <bvc5:BVRequiredFieldValidator ValidationGroup="NewUser" ID="RequiredFieldValidator1" EnableClientScript="True" runat="server" ControlToValidate="LastNameField" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter a last name" Visible="True">*</bvc5:BVRequiredFieldValidator>
            <asp:TextBox ID="LastNameField" runat="server" MaxLength="50" placeholder="required"></asp:TextBox>
        </div>
    </div>

    <div class="row">
        <div class="large-6 columns">
            <em id="PasswordReminder" runat="server" class="right smallText"></em>
            <asp:Label ID="PasswordLabel" runat="server" Text="Password" AssociatedControlID="PasswordField"></asp:Label>
            <bvc5:BVRequiredFieldValidator ValidationGroup="NewUser" ID="valPassword" runat="server" ControlToValidate="PasswordField" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> A password is required" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>
            <asp:TextBox ID="PasswordField" autocomplete="off" runat="server" TextMode="Password" placeholder="required"></asp:TextBox>
        </div>

        <div class="large-6 columns">
            <asp:Label ID="PasswordConfirmLabel" runat="server" Text="Confirm Password" AssociatedControlID="PasswordConfirmField"></asp:Label>
            <bvc5:BVRequiredFieldValidator ValidationGroup="NewUser" ID="RequiredFieldValidator2" runat="server" ControlToValidate="PasswordConfirmField" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> A password confirmation is required" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>
            <bvc5:BVCompareValidator ID="CompareValidator1" runat="server" ControlToCompare="PasswordField" ControlToValidate="PasswordConfirmField" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Password and Confirmation Must Match." ValidationGroup="NewUser">*</bvc5:BVCompareValidator>
            <asp:TextBox ID="PasswordConfirmField" autocomplete="off" runat="server" TextMode="Password" placeholder="required"></asp:TextBox>
        </div>
    </div>

    <div class="row">
        <div class="large-6 columns">
            <asp:Label ID="PasswordHintLabel" runat="server" Text="Password Hint:" AssociatedControlID="PasswordHintField"></asp:Label>
            <asp:TextBox ID="PasswordHintField" CssClass="forminput" runat="server" Columns="30"></asp:TextBox>
        </div>

        <div class="large-6 columns">
            <asp:Label ID="PasswordAnswerLabel" runat="server" Text="Password Answer:" AssociatedControlID="PasswordAnswerField"></asp:Label>
            <asp:TextBox ID="PasswordAnswerField" CssClass="forminput" runat="server" Columns="30"></asp:TextBox>
        </div>
    </div>

    <asp:PlaceHolder ID="phDynamicFields" runat="server"></asp:PlaceHolder>

    <asp:ImageButton ID="btnSaveChanges" runat="server" ValidationGroup="NewUser"></asp:ImageButton>    
</asp:Panel>
<asp:HiddenField ID="BvinField" runat="server" />
