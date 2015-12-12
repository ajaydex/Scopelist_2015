<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="MailServer.aspx.vb" Inherits="BVAdmin_Configuration_MailServer" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Mail Server</h1>        
   	<uc1:MessageBox ID="msg" runat="server" />    
    <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>
    
<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel wide">
                Mail Server:</td>
            <td class="formfield">
                <asp:TextBox ID="MailServerField" runat="server" Columns="40"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel wide">Use Basic SMTP Authentication</td>
            <td class="formfield"><asp:CheckBox ID="chkMailServerAuthentication" runat="server" Text=" Yes"></asp:CheckBox></td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Username:</td>
            <td class="formfield">
                <asp:TextBox ID="UsernameField"  runat="server" Columns="40"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Password:</td>
            <td class="formfield">
                <asp:TextBox ID="PasswordField" runat="server" Columns="40"></asp:TextBox></td>
        </tr>
           <td class="formlabel wide">Use SSL for SMTP</td>
            <td class="formfield"><asp:CheckBox ID="chkSSL" runat="server" Text=" Yes"></asp:CheckBox></td>
        </tr>
        <tr>
            <td class="formlabel wide">
                SMTP Port:</td>
            <td class="formfield">
                <asp:TextBox ID="SmtpPortField" runat="server" Columns="4"></asp:TextBox> (leave blank for default port)</td>
        </tr>
        <tr>
            <td class="formlabel wide">Forgot Password Email Template:</td>
            <td class="formfield">
                 <asp:DropDownList ID="ddlForgotPassword" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Email Friend Template:</td>
            <td class="formfield">
                 <asp:DropDownList ID="ddlEmailFriend" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Contact Us Email Template:</td>
            <td class="formfield">
                 <asp:DropDownList ID="ddlContactUs" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide" align="right">Contact Page Email Recipient:</td>
            <td class="formField">
                <asp:TextBox ID="txtContactUsEmailRecipient" runat="server" Columns="40"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator3" runat="server" ControlToValidate="txtContactUsEmailRecipient" EnableClientScript="True" ErrorMessage="E-mail Address Is Required." ForeColor=" " CssClass="errormessage" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                <bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator4" ForeColor=" " CssClass="errormessage"
                    runat="server" ControlToValidate="txtContactUsEmailRecipient" Display="Dynamic" ErrorMessage="Please enter a valid email address"
                    ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></bvc5:BVRegularExpressionValidator>    
            </td>
        </tr>
    </table>   
     
    <br />
    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
    &nbsp;
    <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
        
   	<br />
    <br /> 
    <br />
   
    <h4>Send Test Message</h4>
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="formfield">
            	To: 
                <asp:TextBox ID="TestToField" runat="server" Columns="40" ></asp:TextBox> <asp:ImageButton ImageUrl="~/BVAdmin/Images/Buttons/send.png" ID="btnSendTest" runat="server" ValidationGroup="TestEmail" />
                
                <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TestToField"
                    ErrorMessage="E-mail address is required." ValidationGroup="TestEmail">*</bvc5:BVRequiredFieldValidator>
                <bvc5:BVRegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TestToField"
                    ErrorMessage="E-mail address is not in proper format." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ValidationGroup="TestEmail">*</bvc5:BVRegularExpressionValidator>
          	</td>
        </tr>
    </table>
    </div>
</asp:Panel>
</asp:Content>


