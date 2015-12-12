<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="BVModules_Checkouts_One_Page_Checkout_Plus_Login" %>
<%@ Register TagPrefix="uc" TagName="LoginControl" Src="~/BVModules/Controls/LoginControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="server">

    <div id="LoginWrapper">
	    <div class="divSkipLogin">
		    <h2>Don't have an account?</h2>
		    <p><asp:imagebutton ID="btnContinue" CausesValidation="false" ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/ContinueToCheckout.png" runat="server" /></p>
	    </div>
        <uc:LoginControl ID="ucLoginControl" HeaderText="Returning customers please sign in." runat="server" />
    </div>

</asp:Content>