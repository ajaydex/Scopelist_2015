<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="Search.aspx.vb" Inherits="search" Title="Search" %>

<%@ Register Src="~/BVModules/Controls/Pager.ascx" TagName="Pager" TagPrefix="uc3" %>
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="BVModules/Controls/SearchCriteria.ascx" TagName="SearchCriteria"
    TagPrefix="uc1" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div class="breadcrumb">
        <a href="Default.aspx">Home</a> > Search
    </div>
    <uc2:MessageBox ID="MessageBox1" runat="server" />
    <h2>
        <span>Search Our Catalog</span></h2>
    <div class="general-form center-box" style="padding-top: 12px !important;">
        <uc1:SearchCriteria ID="SearchCriteria1" runat="server" />
    </div>
    <h1>
        <span>Search result</span></h1>
    <uc2:MessageBox ID="MessageBox2" runat="server" />
    <uc3:Pager ID="Pager1" runat="server" />
    <div class="grid-view" id="dgvResults" runat="server" visible="false">
        <ul>
            <asp:DataList ID="DataList1" runat="server" RepeatColumns="5" RepeatDirection="Horizontal"
                DataKeyField="bvin" Width="100%">
                <ItemTemplate>
                    <li>
                        <div id="Div1" runat="server" visible='<%# WebAppSettings.SearchDisplayImages %>'
                            class="scroller" style="position: relative;">
                            <a id="ImageAnchor" runat="server" href="" class="image">
                                <img id="ProductImage" runat="server" alt="" border="0" src="" /></a>
                            <asp:Label CssClass="stocknew" runat="server" ID="lblStockStatusList" Text="InStock"></asp:Label>
                        </div>
                        <div class="info">
                            <div id="Div2" runat="server" visible='<%# WebAppSettings.SearchDisplaySku %>'>
                                <p>
                                    <a id="NameAnchor" runat="server" href="" style="color: #515044;"></a>
                                </p>
                                <p>
                                    <a id="SkuAnchor" runat="server" href="" style="color: #515044;"></a>
                                </p>
                            </div>
                            <div id="Div3" runat="server" visible='<%# WebAppSettings.SearchDisplayPrice %>'>
                                <p class="price">
                                    <%-- Commented by ven --%>
                                    <%--<a id="PriceAnchor" runat="server" href="" style="color: #C02400"></a>--%>
                                    <asp:Label ID="PriceAnchor" runat="server" href="" Style="color: #C02400"></asp:Label>
                                </p>
                            </div>
                        </div>
                    </li>
                </ItemTemplate>
                <AlternatingItemStyle CssClass="alt" />
            </asp:DataList>
        </ul>
    </div>
    <div id="EmptyTemplate" runat="server">
        <h4>
            No products to display
        </h4>
    </div>
    <uc3:Pager ID="Pager2" runat="server" />
    <div class="clr">
    </div>
</asp:Content>
