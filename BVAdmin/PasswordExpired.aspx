<%@ Page Title="" Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="PasswordExpired.aspx.vb" Inherits="BVAdmin_PasswordExpired" %>
<%@ Register Src="Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" Runat="Server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Password Expired</h1>        
    <p>Your admin password has expired. Please set a new password now.</p>
    <asp:Panel ID="pnlForm" runat="server">
        <uc1:MessageBox ID="ucMessageBox" runat="server" />
        <table cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td class="formlabel">
                    Current Password</td>
                <td class="formfield">
                    <asp:TextBox ID="CurrentPasswordField" autocomplete="off" runat="server" Columns="30" TextMode="Password"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator2" runat="server" ErrorMessage="<strong>Current Password</strong> is required" ControlToValidate="CurrentPasswordField" Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    New Password</td>
                <td class="formlabel">
                    <asp:TextBox ID="passwordField" autocomplete="off" runat="server" Columns="30" TextMode="Password"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  ErrorMessage="<strong>New Password</strong> is required" ControlToValidate="passwordField" Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Confirm New Password</td>
                <td class="formlabel" >
                    <asp:TextBox ID="passwordField2" autocomplete="off" runat="server" Columns="30" TextMode="Password"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator3" runat="server"  ErrorMessage="<strong>Confirm New Password</strong> is required" ControlToValidate="passwordField2" Display="Dynamic" />
                    <bvc5:BVCompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords do not match -- <strong>New Password</strong> and <strong>Confirm New Password</strong> must be the same" ControlToValidate="passwordField2" ControlToCompare="passwordField" Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    &nbsp;
                </td>
                <td class="formlabel"> 
                    <asp:ImageButton ID="btnOK" runat="server" ImageUrl="images/buttons/ok.png"></asp:ImageButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>