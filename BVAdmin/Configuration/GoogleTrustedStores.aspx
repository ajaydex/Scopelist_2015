<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="GoogleTrustedStores.aspx.vb" Inherits="BVAdmin_Configuration_GoogleTrustedStores" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h1>Google Trusted Stores Settings</h1>
    <uc:MessageBox ID="ucMessageBox" runat="server" />

    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel">Enable Google Trusted Stores integration:<br />
                <span><a href="http://www.google.com/trustedstores/" target="_blank">Learn more</a></span>
            </td>
            <td class="formfield">
                <asp:CheckBox ID="GoogleTrustedStoresEnabled" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Google Trusted Stores Account ID:</td>
            <td class="formfield">
                <asp:TextBox ID="txtGoogleTrustedStoresAccountID" runat="server" />
                <bvc5:BVRequiredFieldValidator ControlToValidate="txtGoogleTrustedStoresAccountID" ErrorMessage="Please enter your 'Google Trusted Stores Account ID'" Display="Dynamic" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Badge Location:</td>
            <td class="formfield">
                <asp:DropDownList ID="ddlGoogleTrustedStoresBadgeLocation" AutoPostBack="true" runat="server">
                    <asp:ListItem>BOTTOM_RIGHT</asp:ListItem>
                    <asp:ListItem>BOTTOM_LEFT</asp:ListItem>
                    <asp:ListItem>USER_DEFINED</asp:ListItem>
                </asp:DropDownList>
                <br />
                <asp:Label ID="lblCustomBadgeLocation" CssClass="mediumtext" runat="server">Add an HTML element to your theme with an id value of "GTS_CONTAINER" (e.g. <code>&lt;div id="GTS_CONTAINER"&gt;&lt;/div&gt;</code>) where you would like the badge to be inserted.</asp:Label>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Shipping Time:</td>
            <td class="formfield">
                Orders ship within 
                <asp:DropDownList ID="ddlGoogleTrustedStoresShippingDays" runat="server" /><br />
                by 
                <asp:DropDownList ID="ddlGoogleTrustedStoresShippingTime" runat="server" /> <span>(Current time: <%=DateTime.Now.ToShortTimeString() %>)</span></td>
        </tr>
        <tr>
            <td class="formlabel wide">Saturday Shipping:</td>
            <td class="formfield">
                <asp:CheckBox ID="chkGoogleTrustedStoresSaturdayShipping" runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel wide">Max Transit Time:</td>
            <td class="formfield">
                <asp:TextBox ID="txtGoogleTrustedStoresMaxTransitDays" Columns="2" runat="server" /> days
                <bvc5:BVRequiredFieldValidator ControlToValidate="txtGoogleTrustedStoresMaxTransitDays" ErrorMessage="Please enter a value for 'Max Transit Time'" Display="Dynamic" runat="server" />
                <bvc5:BVCompareValidator ControlToValidate="txtGoogleTrustedStoresMaxTransitDays" Operator="DataTypeCheck" Type="Integer" ErrorMessage="'Max Transit Time' must be a positive integer" Display="Dynamic" runat="server" /><br />
                <span class="smalltext">Maximum numbers of days that a shipment, once picked up by the carrier, will take to arrive at its destination&mdash;assume the slowest shipping method traveling the furthest distance.</span>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Max Backorder Time:</td>
            <td class="formfield">
                <asp:TextBox ID="txtGoogleTrustedStoresMaxBackorderDays" Columns="2" runat="server" /> days
                <bvc5:BVRequiredFieldValidator ControlToValidate="txtGoogleTrustedStoresMaxBackorderDays" ErrorMessage="Please enter a value for 'Max Backorder Time'" Display="Dynamic" runat="server" />
                <bvc5:BVCompareValidator ControlToValidate="txtGoogleTrustedStoresMaxBackorderDays" Operator="DataTypeCheck" Type="Integer" ErrorMessage="'Max Backorder Time' must be a positive integer" Display="Dynamic" runat="server" /><br />
                <span class="smalltext">Maximum numbers of days until a backordered product is back in stock and ready to ship.</span>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <br />
                <h2>Google Shopping settings</h2>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Google Shopping Account ID:</td>
            <td class="formfield">
                <asp:TextBox ID="txtGoogleShoppingAccountID" runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel wide">Google Shopping Country:</td>
            <td class="formfield">
                <asp:DropDownList ID="ddlGoogleShoppingCountry" AutoPostBack="true" runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel wide">Google Shopping Language:<br />
                <span><a href="http://www.loc.gov/standards/iso639-2/php/English_list.php">ISO 639-1 language code</a></span></td>
            <td class="formfield">
                <asp:TextBox ID="txtGoogleShoppingLanguage" runat="server" /></td>
        </tr>
    </table>
    <br />
    <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="~/BVAdmin/images/buttons/SaveChanges.png" />
</asp:Content>