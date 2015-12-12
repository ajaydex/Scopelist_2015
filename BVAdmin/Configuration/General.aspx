<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="General.aspx.vb" Inherits="BVAdmin_Configuration_General" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>General Site Settings</h1>        
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>

    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
            <tr>
                <td class="formlabel wide">Store Name:</td>
                <td class="formfield">
                    <asp:TextBox ID="SiteNameField" Columns="50" Width="300px" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel wide">Store Email Address:</td>
                <td class="formfield">
                    <asp:TextBox ID="ContactEmailField" Columns="50" Width="300px" runat="server"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="EmailAddressRequiredFieldValidator" runat="server" ControlToValidate="ContactEmailField" EnableClientScript="True" ErrorMessage="E-mail Address Is Required." ForeColor=" " CssClass="errormessage" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                    <bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator1" ForeColor=" " CssClass="errormessage"
                        runat="server" ControlToValidate="ContactEmailField" Display="Dynamic" ErrorMessage="Please enter a valid email address"
                        ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></bvc5:BVRegularExpressionValidator>        
                </td>
            </tr>
            <tr>
                <td class="formlabel wide">Site Home Page File Name:</td>
                <td class="formfield">
                    <asp:TextBox ID="SiteHomePageFileNameField" Columns="50" Width="300px" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel wide">Store Is Closed:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkStoreClosed" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel wide">Allow Personalized Themes:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkAllowPersonalizedThemes" runat="server" /></td>
            </tr>
        </table>
        <br />
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
    </asp:Panel>
</asp:Content>

