<%@ Page Language="VB" Title="Category" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Grid_with_Subs_Category" %>
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
        <asp:Label ID="lblTitle" runat="Server"></asp:Label>
        <uc1:ContentColumnControl ID="PreContentColumn" runat="server" />
        <div id="categorybanner">
            <asp:Image runat="server" ID="BannerImage" /></div>
        <div id="categorydescription">
            <asp:Literal ID="DescriptionLiteral" runat="server"></asp:Literal>
        </div>
        <div id="categorygridsubtemplate">
                <asp:DataList ID="DataList2" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
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
        <div id="categorygridtemplate">
            <uc4:CategorySortOrder ID="CategorySortOrder1" runat="server" />                        
            <div id="categorygridtemplaterecords">
                <uc3:Pager ID="Pager1" runat="server" />
                <asp:DataList ID="DataList1" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                    DataKeyField="bvin">
                    <ItemTemplate>
                        <div class="record">
                            <div class="recordimage">
                                <a id="ImageAnchor" runat="server" href="">
                                    <img id="ProductImage" runat="server" border="0" src="" alt="" /></a>
                            </div>
                            <div class="recordname">
                                <a id="NameAnchor" runat="server" href=""></a>
                            </div>
                            <div class="recordsku">
                                <a id="SkuAnchor" runat="server" href=""></a>
                            </div>
                            <div class="recordprice">
                                <a id="PriceAnchor" runat="server" href=""></a>
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
