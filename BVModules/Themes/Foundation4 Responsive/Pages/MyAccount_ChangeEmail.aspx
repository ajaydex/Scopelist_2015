<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="MyAccount_ChangeEmail.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_MyAccount_ChangeEmail" title="Change Email" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
   
    <h2><asp:Label ID="TitleLabel" runat="server">Change Email</asp:Label></h2>

    <asp:Panel runat="server" DefaultButton="btnSave">
        <fieldset>

            <uc:MessageBox ID="msg" runat="server" />

            <asp:ValidationSummary ID="valSummary" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server" ValidationGroup="ChangeEmail" ForeColor="White" DisplayMode="BulletList" HeaderText='<a href="#" class="close">&times;</a>' />

            <div class="row">
                <div class="large-6 columns">
                    <asp:Label ID="lblNewUsername" runat="server" AssociatedControlID="inNewEmail">New Email</asp:Label>
 
                    <bvc5:BVRequiredFieldValidator ID="valNewEmail" ValidationGroup="ChangeEmail" ControlToValidate="inNewEmail" EnableClientScript="True" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter a new email address" Visible="True" runat="server">*</bvc5:BVRequiredFieldValidator>
                    <bvc5:BVRegularExpressionValidator ID="val2NewEmail" ValidationGroup="ChangeEmail" ControlToValidate="inNewEmail" runat="server" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter a valid email address" Display="Dynamic"></bvc5:BVRegularExpressionValidator>

                    <asp:TextBox ID="inNewEmail" runat="server" MaxLength="100" />     
                </div>

                <div class="large-6 columns">
                    <asp:Label ID="lblConfirmNewUsername" runat="server" AssociatedControlID="inNewEmailConfirm">Confirm New Email</asp:Label>

                    <bvc5:BVRequiredFieldValidator ID="valConfEmail" ValidationGroup="ChangeEmail" ControlToValidate="inNewEmailConfirm" EnableClientScript="True" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please confirm your new new email address" Visible="True" runat="server">*</bvc5:BVRequiredFieldValidator>

                    <bvc5:BVCompareValidator ID="valNewEmailConfirm" ValidationGroup="ChangeEmail" ControlToValidate="inNewEmailConfirm" ControlToCompare="inNewEmail" EnableClientScript="True" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> E-mail addresses don't match!" runat="server">*</bvc5:BVCompareValidator>
    
                    <asp:TextBox ID="inNewEmailConfirm" runat="server" MaxLength="100" />
                </div>
            </div>   

            <div class="row">
                <div class="large-6 columns">
                    <em class="right smallText"><a href="forgotpassword.aspx">I Forget.</a></em>
                    <asp:Label ID="lblPassword" runat="server" AssociatedControlID="inPassword">Password</asp:Label>
    
                    <bvc5:BVRequiredFieldValidator ID="valPassword" ValidationGroup="ChangeEmail" ControlToValidate="inPassword" EnableClientScript="True" Display="Dynamic" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please enter your account password" Visible="True" runat="server">*</bvc5:BVRequiredFieldValidator>

                    <bvc5:BVRegularExpressionValidator ID="val2Password" ValidationGroup="ChangeEmail" ControlToValidate="inPassword" runat="server" ValidationExpression="^[a-zA-Z]([\w\d\-\.]{5,19})$" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Password must be between 6 and 20 characters starting with a letter and containing only letters and numbers"  Display="Dynamic"></bvc5:BVRegularExpressionValidator>
    
                    <asp:TextBox TextMode="Password" ID="inPassword" runat="server" MaxLength="100" />
                </div>
            </div>


            <asp:ImageButton ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/SaveChanges.png" ID="btnSave" ValidationGroup="ChangeEmail" CausesValidation="True" runat="server" />
    
        </fieldset>

        <asp:HiddenField ID="bvinField" runat="server" />

        <asp:ImageButton ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Cancel.png" ID="btnCancel" CausesValidation="False" runat="server" />
    </asp:Panel>

    
</asp:Content>

