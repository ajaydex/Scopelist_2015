<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_CategoryTemplates_Grid_Category" Title="Category" %>
<%@ Register Src="~/BVModules/Controls/CategorySortOrder.ascx" TagName="CategorySortOrder" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/CategoryDisplay.ascx" TagName="CategoryDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/Pager.ascx" TagName="Pager" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Themes/Foundation4 Responsive/Controls/ProductGridDisplay.ascx" TagName="ProductGridDisplay" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" runat="Server">
    <script src="/bvmodules/themes/Foundation4%20Responsive/scripts/cookie.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentHolder" runat="Server">
    
    <h1><asp:Label ID="lblTitle" runat="Server"></asp:Label></h1>

    <div class="row">
        <div class="large-10 columns push-2">
            <uc:ContentColumnControl ID="PreContentColumn" runat="server" />

            <div id="categorybanner">
                <asp:Image runat="server" ID="BannerImage" />
            </div>
            
            <div class="row gridheader">
                <div class="large-8 columns">
                    <uc:Pager ID="Pager1" runat="server" /> 
                </div>
                <div class="large-4 columns">
                    <uc:CategoryDisplay ID="CategoryDisplay1" DispayType="Grid" runat="server" />
                    <uc:CategorySortOrder ID="CategorySortOrder1" runat="server" />
                </div>
            </div>

            <uc:ProductGridDisplay ID="ProductGridDisplay" runat="server" />

            <div class="gridfooter">
                <uc:Pager ID="Pager2" runat="server" />
            </div>
                
            <asp:ImageButton ID="AddItemsToCartImageButton" runat="server" AlternateText="Add Selected Items To Cart" ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/AddSelectedItems.png" Visible="false" CausesValidation="false" />
            <div id="categorydescription">
                <asp:Literal ID="DescriptionLiteral" runat="server"></asp:Literal>
            </div>

            <uc:ContentColumnControl ID="PostContentColumn" runat="server" />

        </div>
        <div class="large-2 columns pull-10 hideforlowres">
        	<uc:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="System Category Page" />
        </div>
    </div>

</asp:Content>
