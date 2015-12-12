<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Avalara.aspx.vb" Inherits="BVAdmin_Configuration_Avalara" title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="panel">
        <a href="http://bit.ly/1vGgZKN" target="_blank"><img src="/BVAdmin/Images/Avalara-logo-200x100.png" alt="Avalara" /></a>
        <p>Avalara&rsquo;s cloud-based AvaTax provides an end-to-end sales tax automation solution featuring:</p>
        <ul style="margin-left:1em;">
            <li>Address validation</li>
            <li>Product &amp; service taxability</li>
            <li>Reporting and tax support</li>
        </ul>
        
        <p>Merchants can also automate filing and exemption certificate management!</p> 
        
        <p>Want <a href="http://bit.ly/1vGgZKN" target="_blank">more information</a> or a <a href="http://bit.ly/1vGgZKN" target="_blank">free sales tax consultation</a>?</p>
    </div>


    <h1>Avalara Tax Setup</h1>  
    
    <uc1:MessageBox ID="MessageBox1" runat="server" />    
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel wide">Enable Avalara:</td>
            <td class="formfield">
                <asp:CheckBox ID="EnableCheckBox" runat="server" />   
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Log Avalara Messages On Order:</td>
            <td class="formfield">
                <asp:CheckBox ID="LogMessagesOnOrderCheckBox" runat="server" />   
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Account:</td>
            <td class="formfield">
                <asp:TextBox ID="AccountTextBox" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">License Key:</td>
            <td class="formfield">
                <asp:TextBox ID="LicenseKeyTextBox" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">UserName:</td>
            <td class="formfield">
                <asp:TextBox ID="UserNameField" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Password:</td>
            <td class="formfield">
                <asp:TextBox ID="PasswordField" runat="server"></asp:TextBox>
            </td>
        </tr>
        
        <tr>
            <td class="formlabel wide">Company Code (leave blank if you just have one default company):</td>
            <td class="formfield">
                <asp:TextBox ID="CompanyCodeTextBox" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Url:</td>
            <td class="formfield">
                <asp:TextBox ID="UrlTextBox" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Debug Mode:</td>
            <td class="formfield">
                <asp:CheckBox ID="DebugCheckBox" runat="server" />
            </td>
        </tr>
    </table>
    
    <br />
    
    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
    &nbsp;
    <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
    </asp:Panel>
</asp:Content>

