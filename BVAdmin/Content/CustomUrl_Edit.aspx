<%@ Page ValidateRequest="false" Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="CustomUrl_Edit.aspx.vb" Inherits="BVAdmin_Content_CustomUrl_Edit" Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>
        Edit Custom Url</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <asp:Label ID="lblError" runat="server" CssClass="errormessage"></asp:Label>
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSaveChanges">
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="formlabel">
                    Requested Url:</td>
                <td class="formfield">
                    <asp:TextBox ID="RequestedUrlField" runat="server" Columns="80" TabIndex="2000" Width="500px"></asp:TextBox><bvc5:BVRequiredFieldValidator
                        ID="RequiredVal1" runat="server" ErrorMessage="Please enter a Requested Url"
                        ControlToValidate="RequestedUrlField">*</bvc5:BVRequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Redirect To Url:</td>
                <td class="formfield">
                    <asp:TextBox ID="RedirectToUrlField" runat="server" Columns="80" TabIndex="2010" Width="500px"></asp:TextBox><bvc5:BVRequiredFieldValidator
                        ID="RequiredVal2" runat="server" ErrorMessage="Please enter a Redirect To Url"
                        ControlToValidate="RedirectToUrlField">*</bvc5:BVRequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="formlabel">
                    <asp:ImageButton ID="btnCancel" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Cancel.png"
                        CausesValidation="False"></asp:ImageButton></td>
                <td class="formfield">
                    <asp:ImageButton ID="btnSaveChanges" TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png">
                    </asp:ImageButton></td>
            </tr>
        </table>
    </asp:Panel>
    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>
