<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="ForgotPassword.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_ForgotPassword" title="Forgot Password" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
     <div class="main">
		<div class="row">
			<div class="large-12 columns">
                <h1><asp:Label ID="TitleLabel" runat="server">Reset Account Password</asp:Label></h1>

                <uc:MessageBox ID="msg" runat="server" />
        
                <div class="row">
                    <div class="large-5 columns">

                        <fieldset class="highlight">
                            <p>Use this form to generate a new random password for your account. You will receive an email with your new password.</p>
                            <asp:ValidationSummary ID="valSummary" runat="server" EnableClientScript="True" CssClass="messagebox" />

                            <asp:Label ID="lblUsername" AssociatedControlID="inUsername" runat="server" CssClass="required">UserName</asp:Label>

                            <bvc5:BVRequiredFieldValidator ID="val2Username" runat="server" EnableClientScript="True" CssClass="errormessage" Visible="True" ErrorMessage="Please enter an email address" Display="Dynamic" ControlToValidate="inUsername" ForeColor=" ">*</bvc5:BVRequiredFieldValidator>

                            <asp:TextBox ID="inUsername" runat="server" placeholder="required"></asp:TextBox>

                            <asp:ImageButton ID="btnSend" TabIndex="3001" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/ResetPassword.png" />
            
                        </fieldset>

            <asp:ImageButton ID="ImageButton1" TabIndex="3002" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Cancel.png" CausesValidation="False" />
                    </div>
                </div>  
            </div>
        </div>
    </div>
</asp:Content>

