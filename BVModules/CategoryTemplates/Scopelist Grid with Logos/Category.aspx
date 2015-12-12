<%@ Page Title="Category" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Scopelist_Grid_with_Logos_Category" %>

<%@ Register Src="~/BVModules/Controls/CategorySortOrder.ascx" TagName="CategorySortOrder"
    TagPrefix="uc4" %>
<%@ Register Src="~/BVModules/Controls/Pager.ascx" TagName="Pager" TagPrefix="uc3" %>
<%@ Register Src="~/BVModules/Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="uc1" %>
<%@ Register Src="~/BVModules/Controls/Search.ascx" TagName="Search" TagPrefix="uc17" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div class="breadcrumb">
        <uc2:CategoryBreadCrumbTrail ID="CategoryBreadCrumbTrail1" IncludeHomepage="True"
            IncludeProductName="True" runat="server" />
    </div>
    <div class="heading-h2">
        <asp:Literal ID="startH1" runat="server" Visible="false" Text="<h1>"></asp:Literal>
        <asp:Label ID="lblTitle" runat="Server" CssClass="h1font"></asp:Label>
        <asp:Literal ID="endH1" runat="server" Visible="false" Text="</h1>"></asp:Literal>
    </div>
    <uc1:ContentColumnControl ID="PreContentColumn" runat="server" />
    <div id="categorybanner">
        <asp:Image runat="server" ID="BannerImage" /></div>
    <asp:Literal ID="DescriptionLiteral" runat="server"></asp:Literal>
    <asp:DataList ID="DataList2" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
        DataKeyField="bvin" CssClass="grid-view" Width="100%">
        <ItemTemplate>
            <div class="scroller">
                <a id="recordnameanchor" runat="server" class="CatImageLink">
                    <asp:Image runat="server" ID="imgLogo" Width="150" Height="80" />
                </a>
                <br />
                <a id="CatTitle" runat="server" class="CatName" />
            </div>
            <div class="info">
                <br />
                <asp:Literal runat="server" ID="litRecord" EnableViewState="false"></asp:Literal>
            </div>
        </ItemTemplate>
    </asp:DataList>
    <uc1:ContentColumnControl ID="PostContentColumn" runat="server" />
</asp:Content>
