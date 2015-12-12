<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ForgotPassword.ascx.vb" Inherits="BVModules_Controls_ForgotPassword" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
   
   <h1>
        <span>
            <asp:Label ID="TitleLabel" runat="server">Forgot Password</asp:Label></span></h1>
    <asp:ValidationSummary ID="valSummary" runat="server" EnableClientScript="True" CssClass="errormessage"
        ForeColor=" "></asp:ValidationSummary>
    <uc1:MessageBox ID="msg" runat="server" />
    <p>
        This form will generate a new random password for your account.<br />
        You will recieve an email with your new password.</p>
    <asp:Label ID="lblUsername" CssClass="FormLabel" runat="server">Username</asp:Label>&nbsp;<asp:TextBox
        CssClass="FormInput" ID="inUsername" TabIndex="3000" runat="server" Columns="30"></asp:TextBox>&nbsp;<bvc5:BVRequiredFieldValidator
            ID="val2Username" runat="server" EnableClientScript="True" CssClass="errormessage"
            Visible="True" ErrorMessage="Please enter an email address" Display="Dynamic"
            ControlToValidate="inUsername" ForeColor=" ">*</bvc5:BVRequiredFieldValidator><bvc5:BVRegularExpressionValidator
                ID="valUsername" runat="server" CssClass="errormessage" ErrorMessage="Please enter a valid email address"
                Display="Dynamic" ControlToValidate="inUsername" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"
                ForeColor=" "></bvc5:BVRegularExpressionValidator><br/>
    &nbsp;<br/>
    <asp:ImageButton ID="ImageButton1" TabIndex="3002" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Cancel.png"
        CausesValidation="False"></asp:ImageButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:ImageButton ID="btnSend" TabIndex="3001" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/ResetPassword.png">
    </asp:ImageButton>