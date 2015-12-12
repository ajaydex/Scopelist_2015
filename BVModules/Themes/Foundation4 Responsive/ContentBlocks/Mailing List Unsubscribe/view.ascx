<%@ Control Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_Mailing_List_Unsubscribe_view" %>

<div class="block mailingListUnsubscribe">
    <h4><asp:Label ID="lblTitle" runat="server" Text="Mailing List Unsubscribe"></asp:Label></h4>

    <asp:Label ID="lblSuccess" CssClass="alert-box success" runat="server" Text="Thank You!" Visible="false"></asp:Label>
    
    <asp:Panel ID="pnlMailingListSignupForm" DefaultButton="btnGoEmail" runat="server">
        <asp:Label ID="lblError" CssClass="alert-box alert" runat="server" Text="" Visible="false"></asp:Label>
        <asp:ValidationSummary ID="valNewUserSummary" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server" ValidationGroup="MailingListUnsubscribeGroup" ForeColor="White" DisplayMode="BulletList"></asp:ValidationSummary>
        <label>
            <asp:Label ID="lblInstructions" runat="server" Text="Enter Your Email Address"></asp:Label>
        </label>
        <bvc5:BVRequiredFieldValidator ValidationGroup="MailingListUnsubscribeGroup" ID="rfvEmail" runat="server" ControlToValidate="EmailAddressField" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter a valid email address" />
        <bvc5:BVRegularExpressionValidator ValidationGroup="MailingListUnsubscribeGroup" ID="valEmail" runat="server" ControlToValidate="EmailAddressField" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter a valid email address" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$" />

        <asp:TextBox ID="EmailAddressField" runat="server"></asp:TextBox>
        <asp:ImageButton ID="btnGoEmail" runat="server" ImageUrl="~/images/buttons/go.gif" ValidationGroup="MailingListUnsubscribeGroup" />
    </asp:Panel>
</div>