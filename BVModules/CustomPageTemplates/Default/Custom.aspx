<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Custom.aspx.vb" Inherits="BVModules_CustomPageTemplates_Default_Custom" %>
<%@ Register TagName="ContentColumnControl" TagPrefix="uc" Src="~/BVModules/Controls/ContentColumnControl.ascx" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
    <uc:ContentColumnControl ID="PreContentColumn" runat="server" />
    
    <h1><span><asp:Label ID="lblName" Text="Title Loads Here" runat="server" /></span></h1>
    <asp:Literal ID="litContent" runat="server" />
    
    <uc:ContentColumnControl ID="PostContentColumn" runat="server" />
</asp:Content>