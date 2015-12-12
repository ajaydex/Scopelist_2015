<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="MyAccount_ChangeEmail.aspx.vb" Inherits="MyAccount_ChangeEmail" Title="Change Email" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <h1>
        <asp:Label ID="TitleLabel" runat="server">Change Email :</asp:Label></h1>
    <div class="error_panel2">
        <asp:ValidationSummary ID="valSummary" EnableClientScript="True" runat="server" ForeColor=" "
            CssClass="error_list" ValidationGroup="vgEmail" />
    </div>
    <uc1:MessageBox ID="msg" runat="server" />
    <div class="general-form">
        <div class="form-row">
            <div class="form-left">
                <span>*</span>
                <asp:Label ID="lblNewUsername" runat="server">New Email :</asp:Label>
            </div>
            <div class="form-right">
                <asp:HiddenField ID="bvinField" runat="server" />
                <asp:TextBox class="txt_fld st1" ID="inNewEmail" runat="server" MaxLength="100" />
                <bvc5:BVRequiredFieldValidator ID="valNewEmail" ControlToValidate="inNewEmail" ValidationGroup="vgEmail"
                    EnableClientScript="True" Display="None" ErrorMessage="Please enter a new email address"
                    Visible="True" runat="server" CssClass="errormessage" ForeColor=" ">*</bvc5:BVRequiredFieldValidator><bvc5:BVRegularExpressionValidator
                        ID="val2NewEmail" ControlToValidate="inNewEmail" runat="server" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"
                        ErrorMessage="Please enter a valid email address" Display="None" CssClass="errormessage"
                        ForeColor=" " ValidationGroup="vgEmail"></bvc5:BVRegularExpressionValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                <span>*</span>
                <asp:Label ID="lblConfirmNewUsername" runat="server">Confirm New Email :</asp:Label>
            </div>
            <div class="form-right">
                <asp:TextBox class="txt_fld st1" ID="inNewEmailConfirm" runat="server" MaxLength="100" />
                <bvc5:BVRequiredFieldValidator ID="valConfEmail" ValidationGroup="vgEmail" ControlToValidate="inNewEmailConfirm"
                    EnableClientScript="True" Display="None" ErrorMessage="Please confirm your new new email address"
                    Visible="True" runat="server" CssClass="errormessage" ForeColor=" ">*</bvc5:BVRequiredFieldValidator>
                <bvc5:BVCompareValidator ControlToValidate="inNewEmailConfirm" ControlToCompare="inNewEmail"
                    ID="valNewEmailConfirm" EnableClientScript="True" Display="None" ErrorMessage="E-mail addresses don't match!"
                    runat="server" CssClass="errormessage" ForeColor=" " ValidationGroup="vgEmail">*</bvc5:BVCompareValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                <span>*</span>
                <asp:Label ID="lblPassword" runat="server">Password :</asp:Label>
            </div>
            <div class="form-right">
                <asp:TextBox class="txt_fld st1" TextMode="Password" ID="inPassword" runat="server"
                    MaxLength="100" />
                <bvc5:BVRequiredFieldValidator ID="valPassword" ControlToValidate="inPassword" EnableClientScript="True"
                    Display="None" ErrorMessage="Please enter your account password" Visible="True"
                    runat="server" CssClass="errormessage" ValidationGroup="vgEmail" ForeColor=" ">*</bvc5:BVRequiredFieldValidator><bvc5:BVRegularExpressionValidator
                        ID="val2Password" ControlToValidate="inPassword" runat="server" ValidationExpression="^[a-zA-Z]([\w\d\-\.]{5,19})$"
                        ErrorMessage="Password must be between 6 and 20 characters starting with a letter and containing only letters and numbers"
                        Display="None" CssClass="errormessage" ForeColor=" " ValidationGroup="vgEmail"></bvc5:BVRegularExpressionValidator>
            </div>
            <div class="clr">
            </div>
        </div>
        <div class="form-row">
            <div class="form-left">
                &nbsp;
            </div>
            <div>
                <asp:ImageButton ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-save-change.png"
                    ID="btnSave" CausesValidation="True" runat="server" ValidationGroup="vgEmail"
                    ToolTip="Save Changes" />
                <asp:ImageButton ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-cancel.png"
                    ID="btnCancel" CausesValidation="False" runat="server" ToolTip="Cancel" />
            </div>
            <div class="clr">
            </div>
        </div>
    </div>
    <div class="clr">
    </div>
</asp:Content>
