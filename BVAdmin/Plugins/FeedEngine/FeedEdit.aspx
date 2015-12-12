<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="FeedEdit.aspx.vb" Inherits="BVAdmin_Plugins_FeedEngine_FeedEdit" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="server">
    <h1 id="hTitle" runat="server"></h1>
    <uc:MessageBox ID="ucMessageBox" runat="server" />
    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel">FileName</td>
            <td class="formfield">
                <asp:Label ID="lblFilePath" runat="server" /><asp:TextBox ID="txtFileName" runat="server" size="50" /><br />
                <asp:HyperLink ID="lnkFeed" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">HostName</td>
            <td class="formfield">
                ftp://<asp:TextBox ID="txtHostName" size="50" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">UserName</td>
            <td class="formfield">
                <asp:TextBox ID="txtUserName" size="25"  runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Password</td>
            <td class="formfield">
                <asp:TextBox ID="txtPassword" size="25"  runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Affiliate ID</td>
            <td class="formfield">
                <asp:DropDownList ID="ddlAffiliateID" runat="server" />
            </td>
        </tr>
        <asp:PlaceHolder ID="FeedTypeEditPlaceHolder" runat="server"></asp:PlaceHolder>
        <asp:PlaceHolder ID="EditPlaceHolder" runat="server"></asp:PlaceHolder>
    </table>
    <br />
    <br />
    <asp:ImageButton ID="btnSubmit" Text="Save Changes" ImageUrl="~/BVAdmin/images/buttons/SaveChanges.png" runat="server" />
</asp:Content>