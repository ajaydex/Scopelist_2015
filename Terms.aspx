<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Terms.aspx.vb" Inherits="Terms" title="Terms and Conditions" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
        <uc1:ManualBreadCrumbTrail ID="ManualBreadCrumbTrail1" runat="server" />       
        <h1>
            <asp:Label ID="TitleLabel" runat="server" Text="Terms and Conditions" />
        </h1>

        <div id="termsInfo" runat="server"></div>
</asp:Content>

