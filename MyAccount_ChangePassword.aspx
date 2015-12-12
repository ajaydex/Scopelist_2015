<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="MyAccount_ChangePassword.aspx.vb" Inherits="MyAccount_ChangePassword"
    Title="Change Password" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <h1>
        <asp:Label ID="TitleLabel" runat="server">CHANGE PASSWORD</asp:Label></h1>
    <asp:ValidationSummary ID="ValidationSummary1" CssClass="error_list" EnableClientScript="True"
        runat="server" ForeColor=" " ValidationGroup="vgPassword" />
    <uc1:MessageBox ID="msg" runat="server" />
    <div class="general-form">
        <div class="form-row">
            <div class="form-left">
                <span>*</span>
                <asp:Label ID="lblPassword" runat="server">Password :</asp:Label>
            </div>
            <div class="form-rightalt">
                <asp:TextBox CssClass="FormInput" TextMode="Password" ID="inCurrentPassword" runat="server"
                    Columns="20" MaxLength="100" />
                <bvc5:BVRequiredFieldValidator ID="valCurrentPassword" ControlToValidate="inCurrentPassword"
                    EnableClientScript="True" Display="None" ValidationGroup="vgPassword" ErrorMessage="Please enter your current password"
                    Visible="True" runat="server" CssClass="errormessage" ForeColor=" ">*</bvc5:BVRequiredFieldValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                <span>*</span>
                <asp:Label ID="lblNewPassword" runat="server">New Password :</asp:Label>
            </div>
            <div class="form-rightalt">
                <asp:TextBox CssClass="FormInput" TextMode="Password" ID="inNewPassword" runat="server"
                    Columns="20" MaxLength="100" />
                <bvc5:BVRequiredFieldValidator ID="valNewPassword" ControlToValidate="inNewPassword"
                    EnableClientScript="True" Display="None" ErrorMessage="Please enter your new password"
                    Visible="True" runat="server" ValidationGroup="vgPassword" CssClass="errormessage"
                    ForeColor=" ">*</bvc5:BVRequiredFieldValidator>
                <bvc5:BVRegularExpressionValidator ID="valNewPasswordEx" ControlToValidate="inNewPassword"
                    runat="server" ValidationExpression="^[a-zA-Z]([\w\d\-\.]{5,19})$" ErrorMessage="Password must be between 6 and 20 characters starting with a letter and containing only letters and numbers"
                    Display="None" CssClass="errormessage" ForeColor=" "></bvc5:BVRegularExpressionValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left" style="width: 131px;">
                <span>*</span>
                <asp:Label ID="lblConfirmNewPassword" runat="server">Confirm Password :</asp:Label>
            </div>
            <div class="form-rightalt">
                <asp:TextBox CssClass="FormInput" TextMode="Password" ID="inNewPasswordConfirm" runat="server"
                    Columns="20" MaxLength="100" />
                <bvc5:BVRequiredFieldValidator ID="valNewPasswordConfirm2" ControlToValidate="inNewPasswordConfirm"
                    EnableClientScript="True" Display="None" ErrorMessage="Please confirm your new password"
                    Visible="True" runat="server" ValidationGroup="vgPassword" CssClass="errormessage"
                    ForeColor=" ">*</bvc5:BVRequiredFieldValidator>
                <bvc5:BVCompareValidator ControlToValidate="inNewPasswordConfirm" ControlToCompare="inNewPassword"
                    ID="valNewPasswordConfirm" EnableClientScript="True" Display="None" ErrorMessage="New passwords don't match!"
                    runat="server" CssClass="errormessage" ForeColor=" ">*</bvc5:BVCompareValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                &nbsp;
            </div>
            <div class="form-right">
                <asp:ImageButton ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-save-change.png"
                    ID="btnSave" CausesValidation="True" ValidationGroup="vgPassword" runat="server"
                    ToolTip="Save Change" CssClass="custom" />
                <asp:ImageButton ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-cancel.png"
                    ID="btnCancel" CausesValidation="False" runat="server" ToolTip="Cancel" CssClass="custom" />
            </div>
            <asp:HiddenField ID="bvinField" runat="server" />
            <div class="clr">
            </div>
        </div>
    </div>
    <div class="clr">
    </div>
</asp:Content>
