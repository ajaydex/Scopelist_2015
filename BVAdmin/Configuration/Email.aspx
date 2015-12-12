<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Email.aspx.vb" Inherits="BVAdmin_Configuration_Email" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Email Addresses</h1>    
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">        
        <tr>
            <td class="formlabel wide">Store Email Address:</td>
            <td class="formfield">
                <asp:TextBox ID="ContactEmailField" Columns="40" runat="server"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="EmailAddressRequiredFieldValidator" runat="server" ControlToValidate="ContactEmailField" EnableClientScript="True" ErrorMessage="E-mail Address Is Required." ForeColor=" " CssClass="errormessage" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                <%--<bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator1" ForeColor=" " CssClass="errormessage"
                    runat="server" ControlToValidate="ContactEmailField" Display="Dynamic" ErrorMessage="Please enter a valid email address"
                    ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></bvc5:BVRegularExpressionValidator>--%>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Inventory Low Email Report:</td>
            <td class="formfield">
                <asp:TextBox ID="EmailReportToTextBox" runat="server" Columns="40"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator1" runat="server" ControlToValidate="EmailReportToTextBox" EnableClientScript="True" ErrorMessage="E-mail Address Is Required." ForeColor=" " CssClass="errormessage" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                <%--<bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator2" ForeColor=" " CssClass="errormessage"
                    runat="server" ControlToValidate="EmailReportToTextBox" Display="Dynamic" ErrorMessage="Please enter a valid email address"
                    ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></bvc5:BVRegularExpressionValidator>--%>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Contact Page Email Recipient:</td>
            <td class="formField">
                <asp:TextBox ID="txtContactUsEmailRecipient" runat="server" Columns="40"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator2" runat="server" ControlToValidate="txtContactUsEmailRecipient" EnableClientScript="True" ErrorMessage="E-mail Address Is Required." ForeColor=" " CssClass="errormessage" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                <%--<bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator3" ForeColor=" " CssClass="errormessage"
                    runat="server" ControlToValidate="txtContactUsEmailRecipient" Display="Dynamic" ErrorMessage="Please enter a valid email address"
                    ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></bvc5:BVRegularExpressionValidator>--%>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Email New Orders To:</td>
            <td class="formfield">
                <asp:TextBox Columns="40" runat="server" ID="OrderNotificationEmailField"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator3" runat="server" ControlToValidate="OrderNotificationEmailField" EnableClientScript="True" ErrorMessage="E-mail Address Is Required." ForeColor=" " CssClass="errormessage" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                <%--<bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator4" ForeColor=" " CssClass="errormessage"
                    runat="server" ControlToValidate="OrderNotificationEmailField" Display="Dynamic" ErrorMessage="Please enter a valid email address"
                    ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></bvc5:BVRegularExpressionValidator>--%>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Product Review Notification Recipient:</td>
            <td class="formfield">
                <asp:TextBox Columns="40" runat="server" ID="ProductReviewEmailField"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator4" runat="server" ControlToValidate="ProductReviewEmailField" EnableClientScript="True" ErrorMessage="E-mail Address Is Required." ForeColor=" " CssClass="errormessage" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                <%--<bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator4" ForeColor=" " CssClass="errormessage"
                    runat="server" ControlToValidate="ProductReviewEmailField" Display="Dynamic" ErrorMessage="Please enter a valid email address"
                    ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></bvc5:BVRegularExpressionValidator>--%>
            </td>
        </tr>
     </table>
     <br />
     <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
     </asp:Panel>
</asp:Content>

