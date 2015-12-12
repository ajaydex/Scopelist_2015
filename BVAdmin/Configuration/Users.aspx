<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Users.aspx.vb" Inherits="BVAdmin_Configuration_Users" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
 <h1>User Settings</h1>
        <uc1:MessageBox ID="MessageBox1" runat="server" />
        <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel wide">Private Store:</td>
            <td class="formfield">
                <asp:CheckBox ID="chkPrivateStore" runat="server" /> Yes</td>
        </tr>
        <tr>
            <td class="formlabel wide">Password Minimum Length:</td>
            <td class="formfield">
                <asp:TextBox ID="PasswordMinimumField" Columns="5" runat="server"></asp:TextBox> (Must be at least 8 for PCI Compliance)</td>
        </tr>
        <tr>
            <td class="formlabel wide">Default Password Encryption:</td>
            <td class="formfield">
                <asp:DropDownList ID="DefaultPasswordEncryptionField" runat="server">
                <asp:ListItem Text="Clear Text (Not PCI Compliant)" Value="0"></asp:ListItem>
                <asp:ListItem Text="Encrypted (Not PCI Compliant)" Value="2"></asp:ListItem>
                <asp:ListItem Text="Hashed (Recommended)" Value="1"></asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="formlabel wide">Failed Logins:</td>
            <td class="formfield"><asp:TextBox ID="UserLockoutAttemptsField" Columns="3" runat="server" Text="20"></asp:TextBox> attempts = lockout for <asp:TextBox ID="UserLockoutMinutesField" runat="server" Columns="3" Text="20"></asp:TextBox> minutes.</td>
        </tr>
        <tr>
            <td class="formlabel wide">User ID Cookie Name:</td>
            <td class="formfield">
                <asp:TextBox ID="UserIDCookieNameField" Columns="50" width="300px" runat="server"></asp:TextBox></td>
        </tr>
         <tr>
            <td class="formlabel wide">Cart ID Cookie Name:</td>
            <td class="formfield">
                <asp:TextBox ID="CartIdCookieNameField" Columns="50" width="300px" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel wide">Last Products Viewed Cookie Name:</td>
            <td class="formfield">
                <asp:TextBox ID="LastProductsViewedCookieName" Columns="50" width="300px" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel wide">Remember Users:</td>
            <td class="formfield">
                <asp:CheckBox ID="chkRememberUsers" runat="Server" /> Yes</td>
        </tr>
        <tr>
            <td class="formlabel wide">Remember User Passwords:</td>
            <td class="formfield">
                <asp:CheckBox ID="chkRememberUserPasswords" runat="Server" /> Yes</td>
        </tr>
        <tr>
            <td class="formlabel wide">Redirect Users to Home Page on Login:</td>
            <td class="formfield">
                <asp:CheckBox ID="chkRedirectToHomePageOnLogin" runat="Server" /> Yes</td>
        </tr>
         <tr>
            <td class="formlabel wide">Expire Passwords after:</td>
            <td class="formfield">
                <asp:TextBox ID="PasswordExpirationDaysField" runat="server" Columns="4"></asp:TextBox> Days (No greater than 90)</td>
        </tr>
        </table>
        <br />
        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
       &nbsp;
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>

        </asp:Panel>
</asp:Content>

