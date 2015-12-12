<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="GettingStartedEmail.aspx.vb" Inherits="BVAdmin_GettingStartedEmail" Title="Change Default Admin Username" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Change Default Admin Username</h1>        
    <p>You must change the default username and password for your store before accepting any orders for security reasons.</p>
    
    <asp:Label ID="lblError" runat="server" CssClass="errormessage"></asp:Label>

    <asp:Panel ID="pnlForm" DefaultButton="btnOK" runat="server">
        <table cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td class="formlabel">
                    New User Name</td>
                <td class="formfield">
                    <asp:TextBox ID="UserNameField" runat="server" Columns="30" TextMode="SingleLine"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="errormessage"
                        ErrorMessage="RequiredFieldValidator" ForeColor=" " ControlToValidate="passwordField">Required</bvc5:BVRequiredFieldValidator>
            </tr>
            <tr>
                <td class="formlabel">
                    New Email Address</td>
                <td class="formfield" colspan="2">
                    <asp:TextBox ID="EmailField" runat="server" Columns="30"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="valEmail" runat="server" CssClass="errormessage"
                        ErrorMessage="RequiredFieldValidator" ForeColor=" " ControlToValidate="EmailField">Required</bvc5:BVRequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    New Password</td>
                <td class="formfield">
                    <asp:TextBox ID="passwordField" runat="server" Columns="30" TextMode="Password"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="errormessage"
                        ErrorMessage="RequiredFieldValidator" ForeColor=" " ControlToValidate="passwordField">Required</bvc5:BVRequiredFieldValidator>
            </tr>
            <tr>
                <td class="formlabel">
                    Confirm New Password</td>
                <td class="formfield" >
                    <asp:TextBox ID="passwordField2" runat="server" Columns="30" TextMode="Password"></asp:TextBox>
                    <bvc5:BVCompareValidator ID="CompareValidator1" runat="server" CssClass="errormessage"
                        ErrorMessage="CompareValidator" ForeColor=" " ControlToValidate="passwordField2"
                        ControlToCompare="passwordField">Passwords don't match!</bvc5:BVCompareValidator></td>
            </tr>
        </table>
        <br />
        <br />
        <a onclick="JavaScript:window.close();" href="#"><img alt="Close Window" src="images/buttons/Cancel.png" border="0"/></a>
        &nbsp;
        <asp:ImageButton ID="btnOK" runat="server" ImageUrl="images/buttons/ok.png"></asp:ImageButton>
    </asp:Panel>

    <asp:Panel ID="pnlThanks" runat="server" Visible="False">
        &nbsp;<br/>
        Thank you! Your username and password have been updated!<br/>
        &nbsp;<br/>
        <a href="Default.aspx">
            <img alt="Back To Dashboard" src="images/buttons/OK.png" border="0"/></a>
    </asp:Panel>

    <div style="text-align: center">
        <br/>
        &nbsp;<br/>
        &nbsp;<br/>
    </div>
</asp:Content>

