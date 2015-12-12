<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_CategoryTemplates_Sub_Category_Menu_Category" title="Category" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">

    <h1><asp:Label ID="lblTitle" runat="Server"></asp:Label></h1>

    <div class="row">
        
        <div class="large-10 columns push-2">
            <uc:ContentColumnControl ID="PreContentColumn" runat="server" />

            <div id="categorybanner">
                <asp:Image runat="server" ID="BannerImage" />
            </div>

            <div id="categorydescription">
                <asp:Literal id="DescriptionLiteral" runat="server"></asp:Literal>
            </div>

            <div class="row categorygrid">
                <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" DataKeyField="bvin"> 
                    <ItemTemplate>
                        <div class="small-6 large-3 columns">
                            <div class="record">
                                <div class="recordimage">
                                    <a id="recordimageanchor" runat="server" href="">
                                        <img id="recordimageimg" runat="server" src="" border="0" alt="" />
                                    </a>
                                </div>
                                <div class="recordname">
                                    <a id="recordnameanchor" runat="server" href=""></a>
                                </div>
                                <div class="recordChildren">
                                    <asp:Literal runat="server" ID="litRecord" EnableViewState="false"></asp:Literal>
                                </div>                            
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>

            <uc:ContentColumnControl ID="PostContentColumn" runat="server" />

        </div>

        <div class="large-2 columns pull-10 hideforlowres">
            <uc:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="System Category Page" />
        </div>
    </div>

</asp:Content>

