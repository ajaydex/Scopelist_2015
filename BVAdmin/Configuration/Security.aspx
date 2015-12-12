<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Security.aspx.vb" Inherits="BVAdmin_Configuration_Security" title="Untitled Page" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Security</h1>        
    <uc1:MessageBox ID="msg" runat="server" />
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr id="sslWarningTr" runat="server" visible="false">
            <td colspan="2">
                <anthem:Label ID="warningLabel" runat="server" CssClass="errormessage">If this site is a demo site do not change these settings or you will lock yourself out of the store.</anthem:Label>
            </td>          
        </tr>
        <tr>
            <td class="formlabel">Site Standard Root:</td>
            <td class="formfield">
            <asp:TextBox ID="SiteStandardRoot" Columns="40" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel">Secure Site Root:</td>
            <td class="formfield">
            <asp:TextBox ID="SecureSiteRoot" Columns="40" runat="server"></asp:TextBox></td>
        </tr>                
        <tr>
            <td class="formlabel">Use SSL:</td>
            <td class="formfield">
            <asp:CheckBox ID="chkUseSSL" runat="server" /></td>
        </tr>
        <tr>
            <td colspan="2">
                The following settings are for when the site standard root and site secure root are on different TLDs (Top Level Domains like bvcommerce.com or acme.com) 
                or are on different subdomains like http://www.bvcommerce.com and https://secure.bvcommerce.com. Please ignore these settings if your site always operates on
                a single domain.
            </td>
        </tr>
        <tr>
            <td class="formlabel">Site Secure And Standard Roots on different TLD:</td>
            <td class="formfield">
                <asp:CheckBox ID="DifferentTLDCheckBox" runat="server" />
            </td>
        </tr>        
        <tr>
            <td class="formlabel">Cookie Domain:</td>
            <td class="formfield">
                <asp:TextBox ID="CookieDomainTextBox" Columns="40" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="formlabel">Cookie Path:</td>
            <td class="formfield">
                <asp:TextBox ID="CookiePathTextBox" Columns="40" runat="server"></asp:TextBox>
            </td>
        </tr>
        <!--<tr>
            <td class="formlabel">3DES Cryptography Key:</td>
            <td class="formfield">
                <asp:TextBox ID="CryptographyKey3DESField" Columns="100" Width="500px" runat="server"></asp:TextBox></td>
        </tr>-->
        </table>
        <br />
        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
        &nbsp;
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
        <br />
        <br />
        
        <hr />
        <h3>Encryption Key Settings</h3>
        <asp:Button ID="btnNewKey" runat="server" Text="Generate New Encryption Key" />
        <br />
        <br />
        <asp:Button ID="btnCheckForOldKeys" runat="server" Text="Update data with Old Encryption Keys" /><br />
        <br />
        <asp:Button ID="btnReloadEncryptionKeys" runat="server" Text="Reload Encryption Keys From Disk" /><br />
        <br />
        <br />
        <br />
        <asp:Button ID="btnNewMasterKey" runat="server" Text="Replace Master Encryption Key" />
        
 	</asp:Panel>
</asp:Content>

