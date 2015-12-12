<%@ Page Language="VB" ValidateRequest="false" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Analytics.aspx.vb" Inherits="BVAdmin_Configuration_Analytics" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Analytics Settings</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>
    <br />
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <h2>Google Analytics</h2>
        <table border="0" cellspacing="0" cellpadding="3" class="linedTable">
            <tr>
                <td class="formlabel">Enable Google Analytics:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkGoogleTracker" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">Tracking ID:<br />
                    <span class="smalltext">(e.g. UA-XXXXXXXX-X)</span></td>
                <td class="formfield">
                    <asp:TextBox ID="GoogleTrackingIdField" Columns="15" Width="90px" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">Use Display Features:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkAnalyticsGoogleUseDisplayFeatures" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">Use Enhanced Link Attribution:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkAnalyticsGoogleUseEnhancedLinkAttribution" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">Enable Ecommerce Tracking:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkGoogleEcommerce" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">Affiliation/Store Name:</td>
                <td class="formfield">
                    <asp:TextBox ID="GoogleEcommerceStoreNameField" Columns="50" Width="300px" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" class="formheading"><h2>Google AdWords</h2></td>
            </tr>
            <tr>
                <td class="formlabel">Enable Google AdWords tracking:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkGoogleAdwords" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">google_conversion_id:</td>
                <td class="formfield">
                    <asp:TextBox ID="GoogleAdwordsConversionIdField" Columns="25" Width="150px" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">google_conversion_label:</td>
                <td class="formfield">
                    <asp:TextBox ID="GoogleAdwordsLabelField" Columns="25" Width="150px" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">google_conversion_color:</td>
                <td class="formfield">
                    <asp:TextBox ID="GoogleAdwordsBackgroundColorField" Columns="10" Width="60px" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" class="formheading"><h2>Google Tag Manager</h2></td>
            </tr>
            <tr>
                <td class="formlabel">Enable Google Tag Manager:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkGoogleTagManager" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">Container ID:<br />
                    <span class="smalltext">(e.g. GTM-XXXXXX)</span></td>
                <td class="formfield">
                    <asp:TextBox ID="GoogleTagManagerContainerIdField" Columns="15" Width="90px" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" class="formheading"><h2>Microsoft AdCenter</h2></td>
            </tr>
            <tr>
                <td class="formlabel">Enable Microsoft AdCenter tracking:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkMicrosoftAdcenter" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">Microsoft AdCenter tracking code:<br />
                    <span class="smalltext">(Copy/paste your tracking code here)</span>
                </td>
                <td class="formfield">
                    <asp:TextBox ID="MicrosoftAdCenterTrackingCodeField" TextMode="MultiLine" Rows="10" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" class="formheading"><h2>Yahoo Advertising</h2></td>
            </tr>
            <tr>
                <td class="formlabel">Enable Yahoo Sales tracking:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkYahoo" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">Account ID:</td>
                <td class="formfield">
                    <asp:TextBox ID="YahooAccountIdField" Columns="50" Width="300px" runat="server"></asp:TextBox></td>
            </tr>
        </table>

        <br />
        <br />
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
    </asp:Panel>
</asp:Content>