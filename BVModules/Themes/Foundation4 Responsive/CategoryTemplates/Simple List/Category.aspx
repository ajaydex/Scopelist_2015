<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_CategoryTemplates_Simple_List_Category" Title="Category" %>

<%@ Register Src="~/BVModules/Controls/CategorySortOrder.ascx" TagName="CategorySortOrder" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/Pager.ascx" TagName="Pager" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    
    <h1><asp:Label ID="lblTitle" runat="Server"></asp:Label></h1>
    
    <div class="row">
        <div class="large-10 columns push-2">
            <uc:ContentColumnControl ID="PreContentColumn" runat="server" />
            
            <div class="row">
                <div class="large-5 columns">
                    <div id="categorybanner">
                        <asp:Image runat="server" ID="BannerImage" />
                        <div id="categorydescription">
                            <asp:Literal ID="DescriptionLiteral" runat="server"></asp:Literal>
                        </div>
                    </div>
                </div>

                <div class="large-7 columns">
                    <div class="row gridheader">
                        <div class="large-12 columns">
                            <uc:Pager ID="Pager1" runat="server" />
                            <uc:CategorySortOrder ID="CategorySortOrder1" runat="server" />
                        </div>
                    </div>
                    <div id="categorysimplelisttemplaterecords">
                        <asp:DataList ID="DataList1" runat="server" RepeatColumns="1" RepeatDirection="Vertical" DataKeyField="bvin" RepeatLayout="Flow">
                            <ItemTemplate>
                                <div class="record">                            
                                    <div class="recordsku">
                                        <asp:Label ID="SkuAnchor" runat="server"></asp:Label>
                                    </div>
                                    <div class="recordname">
                                        <a id="NameAnchor" runat="server" href=""></a>
                                    </div>                            
                                    <div class="recordprice">
                                        <asp:Label ID="PriceAnchor" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <AlternatingItemStyle CssClass="alt" />
                        </asp:DataList>
                    </div>
                    <div class="gridfooter">
                        <uc:Pager ID="Pager2" runat="server" />
                    </div>
                </div>
            </div>

            <uc:ContentColumnControl ID="PostContentColumn" runat="server" />
        </div>
        <div class="large-2 columns pull-10 hideforlowres">
        	<uc:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="System Category Page" />
        </div>
    </div>

</asp:Content>
