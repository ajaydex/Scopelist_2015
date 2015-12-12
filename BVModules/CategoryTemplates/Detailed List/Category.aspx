<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Detailed_List_Category"
    Title="Category" %>

<%@ Register Src="../../Controls/CategorySortOrder.ascx" TagName="CategorySortOrder"
    TagPrefix="uc4" %>
<%@ Register Src="../../Controls/Pager.ascx" TagName="Pager" TagPrefix="uc3" %>

<%@ Register Src="../../Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="../../Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <uc2:CategoryBreadCrumbTrail ID="CategoryBreadCrumbTrail1" IncludeHomepage="True" IncludeProductName="True" runat="server" />
    <div id="categoryleft">
        <uc1:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="System Category Page" />
    </div>
    <div id="categorymain">
        <h1>
            <asp:Label ID="lblTitle" runat="Server"></asp:Label></h1>
        <uc1:ContentColumnControl ID="PreContentColumn" runat="server" />
        <div id="categorybanner">
            <asp:Image runat="server" ID="BannerImage" /></div>
        <div id="categorydescription">
            <asp:Literal ID="DescriptionLiteral" runat="server"></asp:Literal>
        </div>
        <div id="categorydetailedlisttemplate">
            <uc4:CategorySortOrder ID="CategorySortOrder1" runat="server" />
            <div id="categorydetailedlisttemplaterecords">
                <uc3:Pager ID="Pager1" runat="server" />
                <asp:DataList ID="DataList1" runat="server" RepeatColumns="1"
                    DataKeyField="bvin" EnableViewState="false" RepeatLayout="flow">
                    <ItemTemplate>
                        <div class="record">
                            <asp:Literal runat="server" ID="litRecord" EnableViewState="false"></asp:Literal>
                            <div class="recordimage">
                                <a id="recordimageanchor" runat="server" href="">
                                    <img id="recordimage" runat="server" src="" alt="" />
                                </a>
                            </div>
                            <div class="recordsku">
                                <a id="recordskuanchor" runat="server" href=""></a>
                            </div>
                            <div class="recordname">
                                <a id="recordnameanchor" runat="server" href=""></a>
                            </div>
                            <div class="recordshortdescription">
                                <asp:Literal ID="recordshortdescriptionfield" runat="server"></asp:Literal>
                            </div>
                            <div class="recordprice">
                                <a id="recordpriceanchor" runat="server" href=""></a>
                            </div>
                            <p id="addedtocart" runat="server" visible="false" class="AddedToCartMessage">
                            </p>
                            <div class="recordcontrols">
                                <asp:ImageButton ID="AddToCartImageButton" runat="server" CommandName="AddToCart" />
                                <asp:ImageButton ID="DetailsImageButton" runat="server" Visible="false" />
                            </div>
                        </div>
                    </ItemTemplate>
                    <AlternatingItemStyle CssClass="alt" />
                </asp:DataList>
                <uc3:Pager ID="Pager2" runat="server" />
            </div>
        </div>
        <uc1:ContentColumnControl ID="PostContentColumn" runat="server" />
    </div>
    
</asp:Content>
