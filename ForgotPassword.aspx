<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="ForgotPassword.aspx.vb" Inherits="ForgotPassword" title="Forgot Password" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
    <uc2:ManualBreadCrumbTrail ID="ManualBreadCrumbTrail1" runat="server" />
    <h1>
        <span>
            <asp:Label ID="TitleLabel" runat="server">Forgot Password</asp:Label></span></h1>
    <asp:ValidationSummary ID="valSummary" runat="server" EnableClientScript="True" CssClass="errormessage"
        ForeColor=" "></asp:ValidationSummary>
<uc1:MessageBox ID="msg" runat="server" />
    <p>
        This form will generate a new random password for your account. You will receive
        an email with your new password.</p>
    <asp:Label ID="lblUsername" CssClass="FormLabel" runat="server">UserName</asp:Label><asp:TextBox
        CssClass="FormInput" ID="inUsername" TabIndex="3000" runat="server" Columns="30"></asp:TextBox>&nbsp;
        <bvc5:BVRequiredFieldValidator
            ID="val2Username" runat="server" EnableClientScript="True" CssClass="errormessage"
            Visible="True" ErrorMessage="Please enter an email address" Display="Dynamic"
            ControlToValidate="inUsername" ForeColor=" ">*</bvc5:BVRequiredFieldValidator>&nbsp;<br/>
    &nbsp;<br/>
    <asp:ImageButton ID="ImageButton1" TabIndex="3002" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Cancel.png"
        CausesValidation="False"></asp:ImageButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:ImageButton ID="btnSend" TabIndex="3001" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/ResetPassword.png">
    </asp:ImageButton>
</asp:Content>

