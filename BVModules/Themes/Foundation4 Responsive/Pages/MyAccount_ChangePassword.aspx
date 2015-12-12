<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="MyAccount_ChangePassword.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_ChangePassword" title="Change Password" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
   
    <h2><asp:Label ID="TitleLabel" runat="server">Change Password</asp:Label></h2>

    <asp:Panel runat="server" DefaultButton="btnSave">
        <fieldset>
            <uc:MessageBox ID="msg" runat="server" />

            <asp:ValidationSummary ID="valSummary" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server"  ValidationGroup="ChangePassword" ForeColor="White" DisplayMode="BulletList" HeaderText='<a href="#" class="close">&times;</a>' />

            <div class="row">
                <div class="large-6 columns">
                    <em class="right smallText"><a href="forgotpassword.aspx">I Forget.</a></em> 
                    <asp:Label ID="lblPassword" runat="server" AssociatedControlID="inCurrentPassword">Password</asp:Label>
                    <bvc5:BVRequiredFieldValidator ID="valCurrentPassword" ControlToValidate="inCurrentPassword" EnableClientScript="True" Display="Dynamic" ValidationGroup="ChangePassword" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter your current password" Visible="True" runat="server">*</bvc5:BVRequiredFieldValidator>
                    <asp:TextBox TextMode="Password" ID="inCurrentPassword" runat="server" MaxLength="100" />
                </div>
            </div>

            <div class="row">
                <div class="large-6 columns">
                    <asp:Label ID="lblNewPassword" runat="server" AssociatedControlID="inNewPassword">New Password</asp:Label>
                    <bvc5:BVRequiredFieldValidator ID="valNewPassword" ControlToValidate="inNewPassword" EnableClientScript="True" Display="Dynamic" ValidationGroup="ChangePassword"  ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter your new password" Visible="True" runat="server">*</bvc5:BVRequiredFieldValidator>
                    <bvc5:BVRegularExpressionValidator ID="valNewPasswordEx" ControlToValidate="inNewPassword" runat="server" ValidationExpression="^[a-zA-Z]([\w\d\-\.]{5,19})$" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Password must be between 6 and 20 characters starting with a letter and containing only letters and numbers" Display="Dynamic" ValidationGroup="ChangePassword" ></bvc5:BVRegularExpressionValidator>
                    <asp:TextBox TextMode="Password" ID="inNewPassword" runat="server" MaxLength="100" />
                </div>
                <div class="large-6 columns">
                    <asp:Label ID="lblConfirmNewPassword" runat="server" AssociatedControlID="inNewPasswordConfirm">Confirm New Password</asp:Label>
                    <bvc5:BVRequiredFieldValidator ID="valNewPasswordConfirm2" ControlToValidate="inNewPasswordConfirm" EnableClientScript="True" Display="Dynamic" ValidationGroup="ChangePassword"  ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please confirm your new password" Visible="True" runat="server">*</bvc5:BVRequiredFieldValidator>
                    <bvc5:BVCompareValidator ControlToValidate="inNewPasswordConfirm" ControlToCompare="inNewPassword" ID="valNewPasswordConfirm" EnableClientScript="True" Display="Dynamic" ValidationGroup="ChangePassword"  ErrorMessage="<i class='fa fa-exclamation-triangle'></i> New passwords don't match!" runat="server">*</bvc5:BVCompareValidator>
                    <asp:TextBox  TextMode="Password" ID="inNewPasswordConfirm" runat="server" MaxLength="100" />
                </div>
            </div>
    
            <asp:ImageButton ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/SaveChanges.png" ID="btnSave" CausesValidation="True" runat="server" ValidationGroup="ChangePassword"  />
        </fieldset>

        <asp:ImageButton ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Cancel.png" ID="btnCancel" CausesValidation="False" runat="server" />
        <asp:HiddenField ID="bvinField" runat="server" />

    </asp:Panel>

</asp:Content>

