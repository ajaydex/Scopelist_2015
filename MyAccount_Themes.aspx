<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="MyAccount_Themes.aspx.vb" Inherits="MyAccount_Themes" Title="Theme Selection" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc2" %>

<%@ Register Src="BVModules/Controls/StyleSheetSelector.ascx" TagName="StyleSheetSelector"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <uc2:ManualBreadCrumbTrail ID="ManualBreadCrumbTrail1" runat="server" />
    <uc1:StyleSheetSelector ID="StyleSheetSelector1" runat="server" />
</asp:Content>
