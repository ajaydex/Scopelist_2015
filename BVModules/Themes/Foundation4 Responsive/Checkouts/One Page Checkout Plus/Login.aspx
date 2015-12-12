<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Checkouts_One_Page_Checkout_Plus_Login" %>
<%@ Register TagPrefix="uc" TagName="LoginControl" Src="~/BVModules/Controls/LoginControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="server">

    <div class="row">
        <div class="small-12 large-5 large-centered columns" id="LoginWrapper">
	        <fieldset class="highlight">
		        <h2>Don't have an account?</h2>
		        <asp:imagebutton ID="btnContinue" CausesValidation="false" ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/ContinueToCheckout.png" runat="server" />
	        </fieldset>
            <fieldset>
                <uc:LoginControl ID="ucLoginControl" HeaderText="Returning customers please sign in." runat="server" />
            </fieldset>
        </div>
    </div>

</asp:Content>