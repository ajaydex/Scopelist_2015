<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" Language="vb" AutoEventWireup="false"
    Inherits="login2" CodeFile="Login.aspx.vb" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register TagPrefix="uc1" TagName="LoginControl" Src="BvModules/Controls/LoginControl.ascx" %>
<%@ Register TagPrefix="uc1" TagName="NewUserControl" Src="BvModules/Controls/NewUserControl.ascx" %>
<asp:Content ContentPlaceHolderID="MainContentHolder" runat="server">
    <%--  <uc2:ManualBreadCrumbTrail ID="ManualBreadCrumbTrail1" runat="server" />
    <h1>
        <span>
            <asp:Label ID="TitleLabel" runat="server">Login</asp:Label></span></h1>
    <fieldset id="CurrentUsers">
        <legend>Current Users</legend>
        <div class="wrapone">
            <div class="wraptwo">
                <div class="wrapthree">
                    <div class="wrapfour">
                        <uc1:LoginControl ID="LoginControl1" runat="server"></uc1:LoginControl>
                        <asp:HyperLink ID="ContactUsHyperLink" CssClass="PrivateNewAccount" runat="server" NavigateUrl="~/ContactUs.aspx">Contact Us</asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    <asp:Panel ID="pnlNewUser" runat="server">
        <fieldset id="NewUsers">
            <legend>New Users</legend>
            <div class="wrapone">
                <div class="wraptwo">
                    <div class="wrapthree">
                        <div class="wrapfour">
                            <uc1:NewUserControl ID="NewUserControl1" runat="server" LoginAfterCreate="true"></uc1:NewUserControl>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
    </asp:Panel>    --%>
    <script src="BVModules/Themes/Scopelist/ScopelistJS/jquery.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#lnkLogin").css("color", "white");
        });

    </script>
    <h1>
        <span>Sign In or Sign up</span></h1>
    <div class="left-half">
        <h3>
            Current Users</h3>
        <uc1:LoginControl ID="LoginControl1" runat="server"></uc1:LoginControl>
        <asp:HyperLink ID="ContactUsHyperLink" CssClass="PrivateNewAccount" runat="server"
            NavigateUrl="~/ContactUs.aspx">Contact Us</asp:HyperLink>
    </div>
    <div class="right-half">
        <h3>
            New Users? Sign Up Here</h3>
        <uc1:NewUserControl ID="NewUserControl1" runat="server" LoginAfterCreate="true">
        </uc1:NewUserControl>
    </div>
    <div class="clr">
    </div>
</asp:Content>
