<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_CategoryTemplates_Grid_Full_Width_Category" Title="Category" %>
<%@ Register Src="~/BVModules/Controls/CategorySortOrder.ascx" TagName="CategorySortOrder" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/CategoryDisplay.ascx" TagName="CategoryDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/Pager.ascx" TagName="Pager" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/SingleProductDisplay.ascx" TagName="SingleProductDisplay" TagPrefix="uc" %>
<%@ Register TagPrefix="uc" TagName="ProductGridDisplay" Src="~/BVModules/Themes/Foundation4 Responsive/Controls/ProductGridDisplay.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" runat="Server">
    <script src="/bvmodules/themes/Foundation4%20Responsive/scripts/cookie.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentHolder" runat="Server">
    
    <h1><asp:Label ID="lblTitle" runat="Server"></asp:Label></h1>

    <uc:ContentColumnControl ID="PreContentColumn" runat="server" />

    <div id="categorybanner">
        <asp:Image runat="server" ID="BannerImage" />
    </div>

    <div id="categorydescription">
        <asp:Literal ID="DescriptionLiteral" runat="server"></asp:Literal>
    </div>

    <div class="row gridheader">
        <div class="large-6 columns">
            <uc:Pager ID="Pager1" runat="server" /> 
        </div>
        <div class="large-6 columns">
            <uc:CategoryDisplay ID="CategoryDisplay1" DispayType="Grid" runat="server" />
            <uc:CategorySortOrder ID="CategorySortOrder1" runat="server" />
        </div>
    </div>

    <uc:ProductGridDisplay ID="ProductGridDisplay" Columns="4" runat="server" />

    <div class="gridfooter">
        <uc:Pager ID="Pager2" runat="server" />
    </div>

    <uc:ContentColumnControl ID="PostContentColumn" runat="server" />

</asp:Content>