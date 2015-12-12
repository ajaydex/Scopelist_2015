<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="MyAccount_Themes.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_Themes" Title="Theme Selection" %>

<%@ Register Src="~/BVModules/Controls/StyleSheetSelector.ascx" TagName="StyleSheetSelector" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <uc:StyleSheetSelector ID="StyleSheetSelector1" runat="server" />
</asp:Content>
