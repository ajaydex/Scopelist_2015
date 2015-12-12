<%@ Page Language="VB" ValidateRequest="false" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Social.aspx.vb" Inherits="BVAdmin_Configuration_Social" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h1>Social Settings</h1>
    <uc:MessageBox ID="ucMessageBox" runat="server" />

    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel wide">
                Enable Facebook Open Graph meta data
            </td>
            <td class="formfield">
                <asp:CheckBox ID="chkFacebookOpenGraph" runat="server" />
            </td>
        </tr>
    </table>
    <br />

    <h2>AddThis social sharing</h2>
    <span><a href="https://www.addthis.com/get/sharing" target="_blank">Get new code</a></span><br />
    <asp:TextBox ID="txtAddThisCode" TextMode="MultiLine" Rows="10" runat="server" /><br /><br />
    
    <span class="smalltext"><strong>Note:</strong> do <em>not</em> include the JavaScript &lt;script&gt; tags from AddThis as these are automatically added</span>
    <br />
    <br />
    <br />

    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel wide">
                AddThis publisher/profile ID*
            </td>
            <td class="formfield">
                <asp:TextBox ID="txtAddThisProfileID" runat="server" size="30" />
            </td>
        </tr>

        <tr style="background: #eee;">
            <td colspan="2" style="padding: 10px">
                <span class="smalltext">Don't have an account? <a href="https://www.addthis.com/register" target="_blank">Create one</a> for free.</span><br />
                <span class="smalltext">*This is not required but when used gives you social sharing analytics through the AddThis website.</span>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                &nbsp;
            </td>   
        </tr>

        <tr>
            <td class="formlabel wide">
                Track URLs that are shared by copy/paste
            </td>
            <td class="formfield">
                <asp:CheckBox ID="chkAddThisTrackkUrls" runat="server" Text=" Yes" />
            </td>
        </tr>

        <tr style="background: #eee;">
            <td colspan="2" style="padding: 10px">
                <span class="smalltext">This will add a short hashtag to the end of your URLs (e.g. <%= BVSoftware.Bvc5.Core.WebAppSettings.SiteStandardRoot%>page.aspx<span style="color:red">#UF0983</span>). This lets AddThis reveal how often visitors copy your URL from their address bar to share. Note that you must have an AddThis account to use this feature.</span>
            </td>
        </tr>
    </table>
    <br />
    <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="~/BVAdmin/images/buttons/SaveChanges.png" />
</asp:Content>