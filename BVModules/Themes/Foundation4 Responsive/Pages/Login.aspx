<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" Language="vb" AutoEventWireup="false" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_Login" CodeFile="Login.aspx.vb" %>

<%@ Register Src="~/BVModules/Controls/LoginControl.ascx" TagName="LoginControl" TagPrefix="uc" %>
<%@ Register Src="~/BvModules/Controls/NewUserControl.ascx" TagName="NewUserControl" TagPrefix="uc" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="headcontent">
	<%-- CONTENT IS INJECTED INTO THE <HEAD> --%>
</asp:Content>

<asp:Content ID="content2" runat="server" ContentPlaceHolderID="MainContentHolder">
    
    <div class="main">
		<div class="row">
			<div class="large-12 columns">

                <h1><asp:Label ID="TitleLabel" runat="server">Login</asp:Label></h1>
    
                <div class="row">
                    <div class="large-4 columns">
                        <fieldset id="CurrentUsers" class="highlight">
                            <uc:LoginControl ID="LoginControl1" runat="server" />
                            <asp:HyperLink ID="ContactUsHyperLink" CssClass="PrivateNewAccount" runat="server" NavigateUrl="~/ContactUs.aspx">Contact Us</asp:HyperLink>
                        </fieldset>
                    </div>
                    <div class="large-8 columns">
                        <asp:Panel ID="pnlNewUser" runat="server">
                            <fieldset id="NewUsers">
                                <uc:NewUserControl ID="NewUserControl1" runat="server" LoginAfterCreate="true" />
                            </fieldset>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>  
    </div>

</asp:Content>
