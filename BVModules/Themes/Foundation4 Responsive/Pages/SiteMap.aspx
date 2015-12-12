<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="SiteMap.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_SiteMap" title="Site Map" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
    <div class="main">
		<div class="row">
			<div class="large-12 columns">
                <h1>Site Map</h1>

                <div class="row">
                    <div class="large-4 columns">
                        <h2>Product Catalog</h2>
                        <ul id="ColumnOne" runat="server"></ul>
                    </div>
                    <div class="large-4 columns">
                        <h2>Content Pages</h2>
                        <ul id="ColumnTwo" runat="server"></ul>
                    </div>
                    <div class="large-4 columns">
                        <h2>Site Information</h2>
                        <ul>
                            <li><a id="A1" runat="server" href="~/default.aspx" class="actuator">Home</a></li>
                            <li><a id="A2" runat="server" href="~/search.aspx" class="actuator">Search</a></li>
                        </ul>
                        <div id="MyAccountDiv" runat="server">
                            <h2>
                                Your Account</h2>
                            <ul>
                                <li><a id="A3" runat="server" href="~/MyAccount_AddressBook.aspx" class="actuator">Address Book</a></li>
                                <li id="affiliateReportli" runat="server"><a id="A4" runat="server" href="~/MyAccount_AffiliateReport.aspx"
                                    class="actuator">Affiliate Report</a></li>
                                <li><a id="A5" runat="server" href="~/MyAccount_ChangeEmail.aspx" class="actuator">Change E-mail</a></li>
                                <li><a id="A6" runat="server" href="~/MyAccount_ChangePassword.aspx" class="actuator">Change
                                    Password</a></li>
                                <li><a id="A7" runat="server" href="~/MyAccount_MailingLists.aspx" class="actuator">Mailing
                                    Lists</a></li>
                                <li><a id="A8" runat="server" href="~/MyAccount_Orders.aspx" class="actuator">Orders</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

