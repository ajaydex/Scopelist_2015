<%@ Control Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_Mailing_List_Signup_view" %>

<div class="block mailingListSignup">
    <h4><asp:Label ID="lblTitle" runat="server" Text="Mailing List"></asp:Label></h4>

    <asp:Label ID="lblSuccess" CssClass="alert-box success" runat="server" Text="Thank You!" Visible="false" />
    
    <asp:Panel ID="pnlMailingListSignupForm" DefaultButton="btnGoEmail" runat="server">
        <asp:Label ID="lblError" CssClass="alert-box alert" runat="server" Text="" Visible="false" />
        <asp:ValidationSummary ID="valNewUserSummary" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server" ValidationGroup="MailingListSignupGroup" ForeColor="White" DisplayMode="BulletList" />
        <label>
            <asp:Label ID="lblInstructions" runat="server" Text="Enter Your Email Address" />
        </label>
        <bvc5:BVRequiredFieldValidator ValidationGroup="MailingListSignupGroup" ID="rfvEmail" runat="server" ControlToValidate="EmailAddressField" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter a valid email address" />
        <bvc5:BVRegularExpressionValidator ValidationGroup="MailingListSignupGroup" ID="valEmail" runat="server" ControlToValidate="EmailAddressField" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter a valid email address" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$" />

        <asp:TextBox ID="EmailAddressField" runat="server"></asp:TextBox>
        <asp:ImageButton ID="btnGoEmail" runat="server" ImageUrl="~/images/buttons/go.gif" ValidationGroup="MailingListSignupGroup" />
    </asp:Panel>
</div>