<%@ Control Language="VB" AutoEventWireup="false" CodeFile="FooterSubscribe.ascx.vb"
    Inherits="BVModules_Themes_Scopelist_controls_FooterSubscribe" %>
<%@ Register Src="~/BVModules/Controls/CustomPagesDisplay.ascx" TagName="CustomPagesDisplay"
    TagPrefix="uc2" %>
<%@ Register Src="~/BVModules/Controls/LoginMenu.ascx" TagName="LoginMenu" TagPrefix="uc1" %>
<%@ Register Src="~/BVModules/Controls/BottomMenu.ascx" TagName="BottomMenu" TagPrefix="uc2" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc3" %>
<style type="text/css">
    .footer .footer-menu span img
    {
        display: none;
    }
</style>
<div class="footer_panel">
    <div class="footer">
        <div class="footer-menu footer-column">
            <div class="footer-head">
                Customer support</div>
            <ul>
                <li>
                    <asp:HyperLink ID="lnkMyAccountOrders" runat="server" NavigateUrl="~/MyAccount_Orders.aspx"
                        Text="Your Account" /></li>
                <li>
                    <asp:HyperLink ID="lnkContactUs" runat="server" NavigateUrl="~/ContactUs.aspx" Text="Customer Service" /></li>
                <li>
                    <asp:HyperLink ID="lnkSearch" runat="server" NavigateUrl="~/Search.aspx" Text="Search" /></li>
                <li><a href="/scopelist-privacy.aspx">Privacy Policy </a></li>
                <li><a href="/scopelist-export-policy.aspx">Export Policy</a></li>
                <li><a href="/return-policys.aspx" title="Return Policy">Return Policy</a></li>
                <li><a href="/shipping-policy.aspx">Shipping Policy</a></li>
            </ul>
        </div>
        <div class="footer-menu footer-column">
            <div class="footer-head">
                Company</div>
            <ul>
                <li>
                    <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Default.aspx" Text="Home" /></li>
                <li><a href="/sitemap.aspx">Site Map</a></li>
                <li><a href="/terms.aspx">Terms &amp; Conditions</a></li>
                <li>
                    <asp:HyperLink ID="lnkAboutUs" runat="server" NavigateUrl="/about-us.aspx" Text="About Us" />
                </li>
            </ul>
        </div>
        <div class="footer-menu footer-column">
            <div class="footer-head">
                Popular Categories</div>
            <ul>
                <li><a href="/riflescopes.aspx" class="active" title="Scopes on Sale - Scope" runat="server"
                    id="lnkRiflescopes">Rifle Scopes</a></li>
                <li><a href="/binoculars.aspx" title="Binoculars">Binoculars</a></li>
                <li><a href="/spotting-scopes.aspx" title="Scopelist Spotting Scopes On Sale">Spotting
                    Scopes</a></li>
                <li><a href="/night-vision.aspx" title="Scopelist Night Vision">Night Vision</a></li>
                <li><a href="/range-finders.aspx" title="Featured Item: Geovid Laser Range Finders">
                    Range Finders</a></li>
                <%--<li><a href="/firearms.aspx" title="Scopelist Firearms for Sale" runat="server" id="lnkFirearms">
                    Firearms</a></li>--%>
                <li><a href="/manufacturers.aspx" title="Scopelist.com Manufacturers">Manufacturers</a></li>
            </ul>
        </div>
        <div class="footer-menu footer-column-last">
            <div class="Subscribe">
                <%--     <div class="footer-head">
                    Join our Newsletter For Special Offers!</div>
                <div class="error_panel2">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error_list"
                        ValidationGroup="vgSubscribe" ShowSummary="false" ShowMessageBox="false" />
                </div>
                <uc3:MessageBox ID="msg" runat="server" style="width: 300px;" />
                <div class="join-now">
                    <asp:TextBox runat="server" ID="txtFirstName" CssClass="FL-name" placeholder="First Name" />
                    <asp:RequiredFieldValidator ControlToValidate="txtFirstName" runat="server" ID="rfvFirstName"
                        ValidationGroup="vgSubscribe" Text="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:TextBox runat="server" ID="txtLastName" CssClass="FL-name" placeholder="Last Name" />
                    <asp:RequiredFieldValidator ControlToValidate="txtLastName" runat="server" ID="rfvLastName"
                        ValidationGroup="vgSubscribe" Text="*"></asp:RequiredFieldValidator>
                    <asp:TextBox runat="server" ID="txtEmail" CssClass="emailid" placeholder="Enter your Email id" />
                    <asp:RequiredFieldValidator ControlToValidate="txtEmail" runat="server" ID="rfvEmail"
                        ValidationGroup="vgSubscribe" Text="*"></asp:RequiredFieldValidator>
                    <asp:Button Text="Subscribe" runat="server" ID="btnJoinNow" ValidationGroup="vgSubscribe" />
                </div>--%>
                <a href="../../../../Join-NOW-Win-BIG.aspx">
                    <asp:Image ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/newsletter_img.jpg"
                        runat="server" Width="355" Height="146" AlternateText="Newsletter" />
                </a>
                <br />
                <div class="footer-head">
                    <center>
                        <asp:HyperLink ID="lnkUnSubScribe" runat="server" NavigateUrl="~/Modify-Your-Subscription.aspx"
                            Text="Modify Your Subscription" ForeColor="White" Font-Bold="true"></asp:HyperLink>
                    </center>
                </div>
            </div>
            <div class="footer-head">
                Security Logos and Payment Methods</div>
            <div onclick="verifySeal();">
                <img alt="footer-card" src="https://www.scopelist.com/images/footer/se_logo.png"
                    onclick="verifySeal();" style="cursor: pointer; cursor: hand" /></div>
            <span style="float: right; margin-right: 10px; margin-top: 10px;">
                <script type="text/javascript" src="https://seal.godaddy.com/getSeal?				sealID=SplsDaDnxw9LZsY3Jzq4EsCkvjMyyRzIhspJX6DOXwydnQsEM5PNW"></script>
            </span>
        </div>
    </div>
    <div class="copyright_panel">
        <div class="copyright">
            <div class="float-l">
                <div class="social">
                    <div class="footer-head">
                        Keep In Touch</div>
                    <a target="_blank" href="https://facebook.com/scopelist">
                        <img alt="facebook" src="https://www.scopelist.com/images/footer/facebook.png" /></a>
                    <a target="_blank" href="https://twitter.com/scopelistoptics">
                        <img alt="twitter" src="https://www.scopelist.com/images/footer/twitter.png" /></a>
                    <a target="_blank" href="http://blog.scopelist.com/">
                        <img alt="blogger" src="https://www.scopelist.com/images/footer/blogger.png" /></a>
                    <a target="_blank" href="https://www.pinterest.com/scopelist/">
                        <img alt="pinterest" src="https://www.scopelist.com/images/footer/pinterest.png" /></a>
                    <a target="_blank" href="https://plus.google.com/u/0/b/112751436787436122535/112751436787436122535/posts">
                        <img alt="google-plus" src="https://www.scopelist.com/images/footer/google-plus.png" /></a>
                </div>
            </div>
            <div class="float-r">
                <p>
                    <em>Descriptive, typographic, or photographic errors are subject to corrections.</em>
                    <br />
                    Copyright ©
                    <%=DateTime.Now.ToString("yyyy")%>, www.scopelist.com | All Rights Reserved</p>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    window.$zopim || (function (d, s) {
        var z = $zopim = function (c) { z._.push(c) }, $ = z.s =
d.createElement(s), e = d.getElementsByTagName(s)[0]; z.set = function (o) {
    z.set.
_.push(o)
}; z._ = []; z.set._ = []; $.async = !0; $.setAttribute('charset', 'utf-8');
        $.src = '//v2.zopim.com/?23yiljjqZPafl6q3sV9DsAOCNLgwXrf2'; z.t = +new Date; $.
type = 'text/javascript'; e.parentNode.insertBefore($, e)
    })(document, 'script');
</script>
