<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Themes.aspx.vb" Inherits="BVAdmin_Configuration_Themes" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<h1>Themes</h1>
<uc1:MessageBox ID="MessageBox1" runat="server" />
<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="formlabel">Current Theme:</td>
            <td class="formfield">
                <asp:DropDownList ID="ThemeField" runat="server" AutoPostBack="True">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="formlabel">
                Preview:</td>
            <td class="formfield">
                <asp:Image ID="PreviewImage" runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel">
                Author:</td>
            <td class="formfield">
                <asp:HyperLink ID="lnkAuthor" Target="_blank" runat="server"></asp:HyperLink></td>
        </tr>
        <tr>
            <td class="formlabel">
                Version:</td>
            <td class="formfield">
                <asp:HyperLink ID="lnkVersion" Target="_blank" runat="server"></asp:HyperLink></td>
        </tr>
        <tr>
            <td class="formlabel">
                Title:</td>
            <td class="formfield">
                <asp:Label ID="lblTitle" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td class="formlabel">
                Description:</td>
            <td class="formfield">
                <asp:Label ID="lblDescription" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        
        </table>
        <br />
        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
        &nbsp;
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>

        </asp:Panel>
</asp:Content>

