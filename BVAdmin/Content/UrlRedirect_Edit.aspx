<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master"  AutoEventWireup="false" CodeFile="UrlRedirect_Edit.aspx.vb" Inherits="BVAdmin_Content_UrlRedirect_Edit" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h1>Edit URL Redirect</h1>
    <uc:MessageBox ID="ucMessageBox" runat="server" />
    
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSaveChanges">
        <table border="0" cellspacing="0" cellpadding="3">
            <tr>
                <td class="formlabel">
                    Requested URL:</td>
                <td class="formfield">
                    <asp:TextBox ID="txtRequestedUrlField" runat="server" Columns="80" TabIndex="2000" Width="500px" />
                    <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator1" ControlToValidate="txtRequestedUrlField" ErrorMessage="Please enter a Requested Url" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Redirect To URL:</td>
                <td class="formfield">
                    <asp:TextBox ID="txtRedirectToUrlField" runat="server" Columns="80" TabIndex="2010" Width="500px" />
                    <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator2" ControlToValidate="txtRedirectToUrlField" ErrorMessage="Please enter a Redirect To Url" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Status Code:</td>
                <td class="formfield">
                    <asp:DropDownList ID="ddlStatusCodeField" runat="server" TabIndex="2020" Width="500px">
                        <asp:ListItem Value="301">301 Permanent</asp:ListItem>
                        <asp:ListItem Value="302">302 Temporary</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Type:</td>
                <td class="formfield">
                    <anthem:DropDownList ID="ddlRedirectTypeField" AutoCallBack="true" runat="server" Columns="80" TabIndex="2030" Width="500px">
                        <asp:ListItem Value="0">Other</asp:ListItem>
                        <asp:ListItem Value="1">Product</asp:ListItem>
                        <asp:ListItem Value="2">Category</asp:ListItem>
                        <asp:ListItem Value="3">Custom Page</asp:ListItem>
                    </anthem:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    System Data (bvin):</td>
                <td class="formfield">
                    <anthem:TextBox ID="txtSystemDataField" AutoUpdateAfterCallBack="true" runat="server" Columns="80" TabIndex="2040" Width="500px"></anthem:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Evaluate as Regex?</td>
                <td class="formfield">
                    <asp:Checkbox ID="chkIsRegexField" AutoUpdateAfterCallBack="true" runat="server" Columns="80" TabIndex="2040" Width="500px"></asp:Checkbox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    <asp:ImageButton ID="btnCancel" TabIndex="2501" ImageUrl="~/BVAdmin/images/buttons/Cancel.png" CausesValidation="False" runat="server" /></td>
                <td class="formfield">
                    <asp:ImageButton ID="btnSaveChanges" TabIndex="2500" ImageUrl="~/BVAdmin/images/buttons/SaveChanges.png" runat="server" /></td>
            </tr>
        </table>
    </asp:Panel>

    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>