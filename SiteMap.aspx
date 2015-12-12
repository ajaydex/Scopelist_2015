<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="SiteMap.aspx.vb" Inherits="SiteMap" Title="Site Map" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div class="breadcrumb">
        <a id="lnkHome" runat="server" href="Default.aspx">Home</a> > <a id="lnkCustomerService"
            runat="server" href="ContactUs.aspx">Customer Service</a> > Site Map
    </div>
    <h1>
        <span>Site Map </span>
    </h1>
    <div class="left-half-border">
        <h3>
            Product Catalog</h3>
        <!-- Start of sitemap -->
        <div class="sitemap">
            <ul id="ColumnOne" runat="server">
            </ul>
        </div>
    </div>
    <div class="right-half">
        <h3>
            Content Pages</h3>
        <div class="sitemap">
            <ul id="ColumnTwo" runat="server">
            </ul>
        </div>
        <h3>
            Site Information</h3>
        <div class="sitemap">
            <ul class="list">
                <li><a id="A1" runat="server" href="~/default.aspx" class="actuator">Home</a></li>
                <li><a id="A2" runat="server" href="~/search.aspx" class="actuator">Search</a></li>
            </ul>
            <div id="MyAccountDiv" runat="server">
                <h3>
                    Your Account</h3>
                <ul class="list">
                    <li><a id="A3" runat="server" href="~/MyAccount_AddressBook.aspx" class="actuator">Address
                        Book</a></li>
                    <li id="affiliateReportli" runat="server"><a id="A4" runat="server" href="~/MyAccount_AffiliateReport.aspx"
                        class="actuator">Affiliate Report</a></li>
                    <li><a id="A5" runat="server" href="~/MyAccount_ChangeEmail.aspx" class="actuator">Change
                        E-mail</a></li>
                    <li><a id="A6" runat="server" href="~/MyAccount_ChangePassword.aspx" class="actuator">
                        Change Password</a></li>
                    <li><a id="A7" runat="server" href="~/MyAccount_MailingLists.aspx" class="actuator">
                        Mailing Lists</a></li>
                    <li><a id="A8" runat="server" href="~/MyAccount_Orders.aspx" class="actuator">Orders</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="clr">
    </div>
</asp:Content>
