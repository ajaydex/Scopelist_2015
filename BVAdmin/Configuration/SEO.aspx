<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="SEO.aspx.vb" Inherits="BVAdmin_Configuration_SEO" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>SEO</h1>        
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <br />
        <h2>URL Settings</h2>
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
            <tr>
                <td class="formlabel">Site Standard Root:</td>
                <td class="formfield">
                    <asp:TextBox ID="SiteStandardRoot" Columns="40" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                        Redirect to Primary Domain:<br />
                        <p class="smalltext">(e.g. redirect http://mydomain.com to http://www.mydomain.com)</p>
                </td>
                <td class="formfield">
                    <asp:CheckBox ID="chkRedirectToPrimaryDomain" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel wide">Site Home Page File Name:</td>
                <td class="formfield">
                    <asp:TextBox ID="SiteHomePageFileNameField" Columns="15" Width="90px" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">Auto URL Rewriting for Categories:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkUrlRewriteCategories" runat="server" /> prefix: <asp:TextBox ID="UrlRewriteCategoriesPrefixField" runat="server" Columns="20" Width="120"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">Auto URL Rewriting for Product:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkUrlRewriteProducts" runat="server" />
                    prefix:
                    <asp:TextBox ID="UrlRewriteProductsPrefixField" runat="server" Columns="20" Width="120"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">Use Canonical URL Tag:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkCanonicalUrlEnabled" runat="server" /></td>
            </tr>
            <tr>
                <td colspan="2" class="formheading"><h2>Structured Data</h2></td>
            </tr>
            <tr>
                <td class="formlabel wide">Google Rich Snippets</td>
                <td class="formfield">
                    <p class="mediumtext">Use the "Bvc2013" product template (or a custom template derived from it) to add Google Rich Snippet support to your product pages. Google Sitelinks search box is also supported.</p>
                </td>
            </tr>
            <tr>
                <td class="formlabel wide">Enable Facebook Open Graph meta data</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkFacebookOpenGraph" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="2" class="formheading"><h2>Meta Data</h2></td>
            </tr>
            <tr>
                <td class="formlabel wide">Append Store Name to Meta Title:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkMetaTitleAppendStoreName" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel wide">Homepage Meta Title:</td>
                <td class="formfield">
                    <asp:TextBox ID="txtHomepageMetaTitle" Columns="50" Width="300px" runat="server" Rows="2" TextMode="MultiLine" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Homepage Meta Description:</td>
                <td class="formfield">
                    <asp:TextBox ID="txtHomepageMetaDescritpion" Columns="50" Width="300px" runat="server" Height="150px" Rows="5" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">Homepage Meta Keywords:</td>
                <td class="formfield">
                    <asp:TextBox ID="txtHomepageMetaKeywords" Columns="50" Width="300px" runat="server" Height="75px" Rows="3" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2">
                    <h5>Default Meta Data</h5>
                    <p class="mediumtext">The meta keywords and meta description data below is used on pages where no meta keywords or meta description data is specified. It is no longer a best practice to repeat generic meta data across site pages and is instead recommended that you leave these fields blank.</p>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Default Meta Description:</td>
                <td class="formfield">
                    <asp:TextBox ID="MetaDescriptionField" Columns="50" Width="300px" runat="server" Height="150px" Rows="5" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">Default Meta Keywords:</td>
                <td class="formfield">
                    <asp:TextBox ID="MetaKeywordsField" Columns="50" Width="300px" runat="server" Height="75px" Rows="3" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
        </table>
        <br />
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
    </asp:Panel>
</asp:Content>