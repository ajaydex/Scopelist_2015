<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="License.aspx.vb" Inherits="BVAdmin_Configuration_License" Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1> License</h1>
    <uc1:MessageBox ID="msg" runat="server" />
    
        <h2>Current License Information</h2>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="formlabel">
                    License Version:</td>
                <td class="formfield">
                    <asp:Label ID="LicenseVersionField" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Product Name:</td>
                <td class="formfield">
                    <asp:Label ID="ProductNameField" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Product Version:</td>
                <td class="formfield">
                    <asp:Label ID="ProductVersionField" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td class="formlabel">
                    License Type:</td>
                <td class="formfield">
                    <asp:Label ID="ProductTypeField" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Licensed To :</td>
                <td class="formfield">
                    <asp:Label ID="CustomerNameField" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Licensed To Email:</td>
                <td class="formfield">
                    <asp:Label ID="CustomerEmailField" runat="server"></asp:Label></td>
            </tr>
             <tr>
                <td class="formlabel">
                    Web Site:</td>
                <td class="formfield">
                    <asp:Label ID="WebSiteField" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Serial Number:</td>
                <td class="formfield">
                    <asp:Label ID="SerialNumberField" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Expires:</td>
                <td class="formfield">
                    <asp:Label ID="lblExpires" runat="server"></asp:Label></td>
            </tr>
        </table>
        
            <h2>Upload License File</h2>
            <asp:FileUpload ID="FileUpload1" runat="server" /> -
            <asp:Button ID="btnUploadLicense" runat="server" Text="Install License File" />
            
  
</asp:Content>
