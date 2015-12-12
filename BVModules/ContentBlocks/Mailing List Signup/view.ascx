<%@ Control Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_ContentBlocks_Mailing_List_Signup_view" %>
<div class="block mailingListSignup">
    <div class="decoratedblock">
        <h4>
            <span>
                <asp:Label ID="lblTitle" runat="server" Text="Mailing List"></asp:Label></span></h4>
        <div class="blockcontent">
            <asp:Label ID="lblSuccess" CssClass="successmessage" runat="server" Text="Thank You!"
                Visible="false"></asp:Label>
            <asp:Label ID="lblError" CssClass="errormessage" runat="server" Text="" Visible="false"></asp:Label>
            <span class="Instructions">
                <asp:Label ID="lblInstructions" runat="server" Text="Enter Your Email Address"></asp:Label>
            </span>
            <bvc5:BVRegularExpressionValidator ID="valEmail" runat="server" ErrorMessage="Please enter a valid email address."
                ControlToValidate="EmailAddressField" CssClass="errormessage" ForeColor="" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"
                ValidationGroup="MailingListSignupGroup"></bvc5:BVRegularExpressionValidator>
            <asp:Panel runat="server" DefaultButton="btnGoEmail" ID="pnlMailingListSignupForm">
                <asp:TextBox ID="EmailAddressField" Columns="15" runat="server"></asp:TextBox>
                &nbsp;<asp:ImageButton ID="btnGoEmail" runat="server" ImageUrl="~/images/buttons/go.gif"
                    ValidationGroup="MailingListSignupGroup" />
            </asp:Panel>
        </div>
    </div>
</div>
