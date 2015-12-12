<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Header.ascx.vb" Inherits="BVAdmin_Header" %>
<%@ Register Src="~/BVAdmin/Controls/WaitingMessage.ascx" TagName="WaitingMessage" TagPrefix="uc2" %>
<%@ Register Src="HelpWithThisPage.ascx" TagName="HelpWithThisPage" TagPrefix="uc1" %>

<div id="header" class="printhidden">
    <div class="f-row">
        <div class="twelve columns">
            <div id="branding">
                <div id="brand">
                    <div class="util">
                        <asp:HyperLink EnableViewState="false" runat="server" NavigateUrl="~/BVAdmin/Help.aspx" ID="lnkHelp">Help</asp:HyperLink>
                        <span>|</span>
                        <asp:HyperLink runat="server" NavigateUrl="~/Logout.aspx" ID="lnkLogout">Log Out</asp:HyperLink>
                        <span>|</span>
                        <strong>
                            <asp:HyperLink EnableViewState="false" NavigateUrl="~/" runat="server" ID="lnkGoToStore" CssClass="goToStore">Go To Store</asp:HyperLink>
                        </strong>
                    </div>
                    <img src="/bvadmin/images/bvc-logo.png" style="display: block;" />
                    <asp:Panel ID="pnlHeaderMessage" CssClass="headerIdMsg" EnableViewState="false" runat="server" />
                </div>
            </div>

            <div class="nav">
                <ul>
                    <li id="lnkDashboard" runat="server"><a href="~/BVAdmin/Default.aspx" runat="server">Dashboard</a></li>
                    <li id="lnkCatalog" runat="server"><a href="~/BVAdmin/Catalog/Default.aspx" runat="server">Catalog</a>
                        <ul>
                            <li><a href="~/BVAdmin/Catalog/Default.aspx" runat="server">Products</a></li>
                            <li><a href="~/BVAdmin/Catalog/Kits.aspx" runat="server">Kits</a></li>
                            <li><a href="~/BVAdmin/Catalog/Categories.aspx" runat="server">Categories</a></li>
                            <li><a href="~/BVAdmin/Catalog/ProductSharedChoices.aspx" runat="server">Shared Choices</a></li>
                            <li><a href="~/BVAdmin/Catalog/ProductTypes.aspx" runat="server">Product Types</a></li>
                            <li><a href="~/BVAdmin/Catalog/ProductTypeProperties.aspx" runat="server">Type Properties</a></li>
                            <li><a href="~/BVAdmin/Catalog/ReviewsToModerate.aspx" runat="server">Reviews</a></li>
                            <li><a href="~/BVAdmin/Catalog/ProductBatchEdit.aspx" runat="server">Product Batch Edit</a></li>
                            <li><a href="~/BVAdmin/Catalog/Inventory.aspx" runat="server">Inventory Edit</a></li>
                            <li><a href="~/BVAdmin/Catalog/InventoryBatchEdit.aspx" runat="server">Inventory Batch Edit</a></li>
                            <li><a href="~/BVAdmin/Catalog/GiftCertificates.aspx" runat="server">Gift Certificates</a></li>
                            <li><a href="~/BVAdmin/Catalog/FileVault.aspx" runat="server">File Vault</a></li>
                        </ul>
                    </li>
                    <li id="lnkMarketing" runat="server"><a href="~/BVAdmin/Marketing/Default.aspx" runat="server">Marketing</a>
                        <ul>
                            <li><a href="~/BVAdmin/Marketing/Default.aspx" runat="server">Offers</a></li>
                            <li><a href="~/BVAdmin/Marketing/Sales.aspx" runat="server">Sales</a></li>
                        </ul>
                    </li>
                    <li id="lnkPeople" runat="server"><a href="~/BVAdmin/People/Default.aspx" runat="server">People</a>
                        <ul>
                            <li><a href="~/BVAdmin/People/Default.aspx" runat="server">Users</a></li>
                            <li><a href="~/BVAdmin/People/Roles.aspx" runat="server">Groups</a></li>
                            <li><a href="~/BVAdmin/People/Affiliates.aspx" runat="server">Affiliates</a></li>
                            <li><a href="~/BVAdmin/People/Manufacturers.aspx" runat="server">Manufacturers</a></li>
                            <li><a href="~/BVAdmin/People/Vendors.aspx" runat="server">Vendors</a></li>
                            <li><a href="~/BVAdmin/People/MailingLists.aspx" runat="server">Mailing Lists</a></li>
                            <li><a href="~/BVAdmin/People/AffiliateSignupConfig.aspx" runat="server">Affiliate Sign-up Config</a></li>
                            <li><a href="~/BVAdmin/People/UserSignupConfig.aspx" runat="server">User Sign-up Config</a></li>
                            <li><a href="~/BVAdmin/People/ContactUsConfig.aspx" runat="server">Contact Us Config</a></li>
                            <li><a href="~/BVAdmin/People/PriceGroups.aspx" runat="server">Price Groups</a></li>
                        </ul>
                    </li>
                    <li id="lnkContent" runat="server"><a href="~/BVAdmin/Content/Default.aspx" runat="server">Content</a>
                        <ul>
                            <li><a href="~/BVAdmin/Content/StoreInfo.aspx" runat="server">Store Info</a></li>
                            <li><a href="~/BVAdmin/Content/Default.aspx" runat="server">Home Page</a></li>
                            <li><a href="~/BVAdmin/Content/CustomPages.aspx" runat="server">Custom Pages</a></li>
                            <li><a href="~/BVAdmin/Content/Policies.aspx" runat="server">Policies</a></li>
                            <li><a href="~/BVAdmin/Content/Columns.aspx" runat="server">Columns</a></li>
                            <li><a href="~/BVAdmin/Content/MetaTags.aspx" runat="server">Meta Tags</a></li>
                            <li><a href="~/BVAdmin/Content/EmailTemplates.aspx" runat="server">Email Templates</a></li>
                            <li><a href="~/BVAdmin/Content/PrintTemplates.aspx" runat="server">Print Templates</a></li>
                            <li><a href="~/BVAdmin/Content/CategoryTemplates.aspx" runat="server">Category Templates</a></li>
                            <li><a href="~/BVAdmin/Content/CustomUrl.aspx" runat="server">Custom URLs</a></li>
                            <li><a href="~/BVAdmin/Content/UrlRedirect.aspx" runat="server">URL Redirects</a></li>
                            <li><a href="~/BVAdmin/Content/StoreClosed.aspx" runat="server">Closed Page</a></li>
                        </ul>
                    </li>
                    <li id="lnkOrders" runat="server"><a href="~/BVAdmin/Orders/Default.aspx" runat="server">Orders</a>
                        <ul>
                            <li><a href="~/BVAdmin/Orders/Default.aspx" runat="server">Order Manager</a></li>
                            <li><a href="~/BVAdmin/Orders/NewOrder.aspx" runat="server">New Order</a></li>
                            <li><a href="~/BVAdmin/Orders/UPSOnlineTools.aspx" runat="server">UPS Shipping</a></li>
                            <li><a href="~/BVAdmin/Orders/RMA.aspx" runat="server">Returns</a></li>
                        </ul>
                    </li>
                    <li id="lnkReports" runat="server"><a href="~/BVAdmin/Reports/Default.aspx" runat="server">Reports</a>
                        <ul id="ulReports" runat="server">
                            <!-- dynamic -->
                        </ul>
                    </li>
                    <li id="lnkOptions" runat="server"><a href="~/BVAdmin/Configuration/General.aspx" runat="server">Options</a>
                        <ul>
                            <li><a href="~/BVAdmin/Configuration/General.aspx" runat="server">Site Settings</a></li>
                            <li><a href="~/BVAdmin/Configuration/EventLog.aspx" runat="server">Audit Log</a></li>
                            <li><a href="~/BVAdmin/Configuration/VersionInfo.aspx" runat="server">About</a></li>
                            <li><a href="~/BVAdmin/Configuration/License.aspx" runat="server">License</a></li>
                            <li><a href="~/BVAdmin/Configuration/Workflow.aspx" runat="server">Workflows</a></li>
                        </ul>
                    </li>
                    <li id="lnkPlugins" runat="server"><a href="~/BVAdmin/Plugins/Default.aspx" runat="server">Plug-ins</a>
                        <ul id="ulPlugins" runat="server">
                            <!-- dynamic -->
                        </ul>
                    </li>
                    <!--<li id="lnkInvalidLicense" runat="server"><a href="~/BVAdmin/Configuration/License.aspx" runat="server"></a>License</li>-->
                </ul>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {

        //submenu active states
        var pathname = window.location.pathname.toLowerCase();
        $("#submenu a").each(function () {
            var href = $(this).attr("href").toLowerCase();
            if (pathname.indexOf(href) != -1) {
                $(this).addClass("currentpg");
            }
        });

    });
</script>

<div class="submenuWrapper">
    <div id="submenu">
        <asp:MultiView EnableViewState="false" ID="MultiView1" ActiveViewIndex="0" runat="server">
            <asp:View EnableViewState="false" ID="viewDashboard" runat="server">
                <!--<asp:HyperLink ID="Hyperlink59" runat="server" NavigateUrl="~/BVAdmin/default.aspx">Dashboard</asp:HyperLink>-->
            </asp:View>
            <asp:View EnableViewState="false" ID="viewCatalog" runat="server">
                <asp:HyperLink EnableViewState="false" ID="Hyperlink0" runat="server" NavigateUrl="~/BVAdmin/Catalog/Default.aspx">Products</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink39" runat="server" NavigateUrl="~/BVAdmin/Catalog/Kits.aspx">Kits</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink1" runat="server" NavigateUrl="~/BVAdmin/Catalog/Categories.aspx">Categories</asp:HyperLink>
                <asp:HyperLink EnableViewState="False" ID="Hyperlink2" runat="server" NavigateUrl="~/BVAdmin/Catalog/ProductSharedChoices.aspx">Shared Choices</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink4" runat="server" NavigateUrl="~/BVAdmin/Catalog/ProductTypes.aspx">Product Types</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink5" runat="server" NavigateUrl="~/BVAdmin/Catalog/ProductTypeProperties.aspx">Type Properties</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink27" runat="server" NavigateUrl="~/BVAdmin/Catalog/ReviewsToModerate.aspx">Reviews</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink21" runat="server" NavigateUrl="~/BVAdmin/Catalog/ProductBatchEdit.aspx">Product Batch Edit</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink6" runat="server" NavigateUrl="~/BVAdmin/Catalog/Inventory.aspx">Inventory Edit</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink22" runat="server" NavigateUrl="~/BVAdmin/Catalog/InventoryBatchEdit.aspx">Inventory Batch Edit</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink34" runat="server" NavigateUrl="~/BVAdmin/Catalog/GiftCertificates.aspx">Gift Certificates</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink30" runat="server" NavigateUrl="~/BVAdmin/Catalog/FileVault.aspx">File Vault</asp:HyperLink>
            </asp:View>
            <asp:View EnableViewState="false" ID="viewPeople" runat="server">
                <asp:HyperLink EnableViewState="false" ID="Hyperlink7" runat="server" NavigateUrl="~/BVAdmin/People/Default.aspx">Users</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="lnkRoles" runat="server" NavigateUrl="~/BVAdmin/People/Roles.aspx">Groups</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink8" runat="server" NavigateUrl="~/BVAdmin/People/Affiliates.aspx">Affiliates</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink9" runat="server" NavigateUrl="~/BVAdmin/People/Manufacturers.aspx">Manufacturers</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink10" runat="server" NavigateUrl="~/BVAdmin/People/Vendors.aspx">Vendors</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink11" runat="server" NavigateUrl="~/BVAdmin/People/MailingLists.aspx">Mailing Lists</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink35" runat="server" NavigateUrl="~/BVAdmin/People/AffiliateSignupConfig.aspx">Affiliate Sign-up Config</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink38" runat="server" NavigateUrl="~/BVAdmin/People/UserSignupConfig.aspx">User Sign-up Config</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink36" runat="server" NavigateUrl="~/BVAdmin/People/ContactUsConfig.aspx">Contact Us Config</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="HyperLink31" runat="server" NavigateUrl="~/BVAdmin/People/PriceGroups.aspx">Price Groups</asp:HyperLink>
            </asp:View>
            <asp:View EnableViewState="false" ID="viewMarketing" runat="server">
                <asp:HyperLink EnableViewState="false" ID="Hyperlink14" runat="server" NavigateUrl="~/BVAdmin/Marketing/Default.aspx">Offers</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink15" runat="server" NavigateUrl="~/BVAdmin/Marketing/Sales.aspx">Sales</asp:HyperLink>
            </asp:View>
            <asp:View EnableViewState="false" ID="viewContent" runat="server">
                <asp:HyperLink EnableViewState="false" ID="Hyperlink32" runat="server" NavigateUrl="~/BVAdmin/Content/StoreInfo.aspx">Store Info</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink12" runat="server" NavigateUrl="~/BVAdmin/Content/Default.aspx">Home Page</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink16" runat="server" NavigateUrl="~/BVAdmin/Content/CustomPages.aspx">Custom Pages</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink17" runat="server" NavigateUrl="~/BVAdmin/Content/Policies.aspx">Policies</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink18" runat="server" NavigateUrl="~/BVAdmin/Content/Columns.aspx">Columns</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink23" runat="server" NavigateUrl="~/BVAdmin/Content/MetaTags.aspx">Meta Tags</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink24" runat="server" NavigateUrl="~/BVAdmin/Content/EmailTemplates.aspx">Email Templates</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink29" runat="server" NavigateUrl="~/BVAdmin/Content/PrintTemplates.aspx">Print Templates</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink33" runat="server" NavigateUrl="~/BVAdmin/Content/CategoryTemplates.aspx">Category Templates</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink19" runat="server" NavigateUrl="~/BVAdmin/Content/CustomUrl.aspx">Custom URLs</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink40" runat="server" NavigateUrl="~/BVAdmin/Content/UrlRedirect.aspx">URL Redirects</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink58" runat="server" NavigateUrl="~/BVAdmin/Content/StoreClosed.aspx">Closed Page</asp:HyperLink>
            </asp:View>
            <asp:View EnableViewState="false" ID="viewOrders" runat="server">
                <asp:HyperLink EnableViewState="false" ID="Hyperlink25" runat="server" NavigateUrl="~/BVAdmin/Orders/Default.aspx">Order Manager</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink37" runat="server" NavigateUrl="~/BVAdmin/Orders/NewOrder.aspx">New Order</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink26" runat="server" NavigateUrl="~/BVAdmin/Orders/UPSOnlineTools.aspx">UPS Shipping</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink28" runat="server" NavigateUrl="~/BVAdmin/Orders/RMA.aspx">Returns</asp:HyperLink>
            </asp:View>
            <asp:View EnableViewState="false" ID="viewReports" runat="server"></asp:View>
            <asp:View EnableViewState="false" ID="viewConfiguration" runat="server">
                <asp:HyperLink EnableViewState="false" ID="Hyperlink20" runat="server" NavigateUrl="~/BVAdmin/Configuration/General.aspx">Site Settings</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink55" runat="server" NavigateUrl="~/BVAdmin/Configuration/EventLog.aspx">Audit Log</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink56" runat="server" NavigateUrl="~/BVAdmin/Configuration/VersionInfo.aspx">About</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink13" runat="server" NavigateUrl="~/BVAdmin/Configuration/License.aspx">License</asp:HyperLink>
                <asp:HyperLink EnableViewState="false" ID="Hyperlink3" runat="server" NavigateUrl="~/BVAdmin/Configuration/Workflow.aspx">Workflows</asp:HyperLink>
            </asp:View>
            <asp:View EnableViewState="false" ID="viewPlugins" runat="server"></asp:View>
        </asp:MultiView>
    </div>
</div>

<uc2:WaitingMessage ID="WaitingMessage1" runat="server" />