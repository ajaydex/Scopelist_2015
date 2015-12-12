<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="VersionInfo.aspx.vb" Inherits="BVAdmin_Configuration_VersionInfo" title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>About</h1>
        
	<uc1:MessageBox ID="msg" runat="server" />
    <dl>
        <dt>Application Version:</dt>
        <dd><asp:Label ID="lblApplicationVersion" runat="server"></asp:Label></dd>
        <dt>Database Version:</dt>
        <dd><asp:Label ID="lblDatabaseVersion" runat="server"></asp:Label></dd>
    </dl>
    <asp:Label ID="lblVersion" Text="" runat="server" />
    
    <h3>eMail Version Info</h3>
    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
        <tr>
            <td class="formlabel">
                To:
           	</td>
            <td>
                <asp:TextBox ID="ToField" runat="server" Columns="40">support@bvcommerce.com</asp:TextBox>
           	</td>
        </tr>
        <tr>
            <td class="formlabel" style="height: 21px">
                From:</td>
            <td style="height: 21px">
                <asp:TextBox ID="FromField" runat="server" Columns="40">yourname@company.com</asp:TextBox>
          	</td>
        </tr>
        <tr>
            <td class="formlabel">
                Subject:</td>
            <td>
                <asp:TextBox ID="SubjectField" runat="server" Columns="40">Version Information Details</asp:TextBox>
           	</td>
        </tr>
        <tr>
            <td class="formlabel">
                Notes:
            </td>
            <td>
                <asp:TextBox ID="NotesField" runat="server" TextMode="MultiLine">Special instructions or notes</asp:TextBox>
           	</td>
        </tr>
        <tr>
            <td class="formlabel">
                Include Site URLs?</td>
            <td>
                <asp:CheckBox ID="chkIncludeURLs" runat="server" Checked="True"></asp:CheckBox>
           	</td>
        </tr>
        <tr>
            <td class="formlabel">
                Include WebAppSettings?
           	</td>
            <td>
                <asp:CheckBox ID="chkIncludeWebAppSettings" runat="server" Checked="True"></asp:CheckBox>
           	</td>
        </tr>
        <tr>
            <td class="formlabel">
                Include Connection String?
           	</td>
            <td>
                <asp:CheckBox ID="chkIncludeConnectionString" runat="server"></asp:CheckBox>
           	</td>
        </tr>
    </table>
    <br />
    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="../images/buttons/Email.png"></asp:ImageButton>
</asp:Content>

