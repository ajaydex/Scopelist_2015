<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Sub_Category_Menu_2_Category"
    Title="Category" %>
<%@ Register Src="../../Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="../../Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <uc2:CategoryBreadCrumbTrail ID="CategoryBreadCrumbTrail1" IncludeHomepage="True" IncludeProductName="True" runat="server" />
        <asp:Label ID="lblTitle" runat="Server"></asp:Label>
        <div id="subcategorymenu2featured">
                <asp:HyperLink ID="FeaturedHyperLink" runat="server">
                    <asp:Image ID="FeaturedImage" runat="server" />
                </asp:HyperLink><br />                
                <h2><asp:Label ID="lblFeaturedName" runat="server"></asp:Label></h2>
                <asp:Label ID="lblFeaturedSku" runat="server"></asp:Label><br />
                <asp:Literal id="FeaturedDescriptionLiteral" runat="server"></asp:Literal><br />
        </div>
        <div id="subcategorymenu2main">
            <uc1:ContentColumnControl ID="PreContentColumn" runat="server" />
            <div id="categorybanner">
                <asp:Image runat="server" ID="BannerImage" /></div>
            <div id="categorydescription">
                <asp:Literal id="DescriptionLiteral" runat="server"></asp:Literal></div>
            <div id="subcategorymenu2">                
                <asp:DataList ID="DataList1" runat="server" RepeatColumns="2" RepeatDirection="Horizontal"
                    DataKeyField="bvin">
                    <ItemStyle VerticalAlign="top" />
                    <ItemTemplate>
                        <div class="record">
                            <div class="recordimage">
                                <a id="recordimageanchor" runat="server" href=""><img id="recordimageimg" runat="server" src="" border="0" alt="" /></a>
                            </div>
                            <div class="recordname">
                                <a id="recordnameanchor" runat="server" href=""></a>
                            </div>
                            <div class="recordChildren">
                                <asp:Literal runat="server" ID="litRecord" EnableViewState="false"></asp:Literal>
                            </div>                            
                        </div>
                    </ItemTemplate>
                    <AlternatingItemStyle CssClass="alt" />
                </asp:DataList>
            </div>
            <uc1:ContentColumnControl ID="PostContentColumn" runat="server" />
        </div>
</asp:Content>
