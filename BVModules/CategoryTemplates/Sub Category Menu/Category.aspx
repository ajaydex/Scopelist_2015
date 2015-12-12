<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Sub_Category_Menu_Category" title="Category" %>
<%@ Register Src="../../Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="../../Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <uc2:CategoryBreadCrumbTrail ID="CategoryBreadCrumbTrail1" IncludeHomepage="True" IncludeProductName="True" runat="server" />
    <div class="maincontentwrapper">
        <asp:Label ID="lblTitle" runat="Server"></asp:Label>
        <uc1:ContentColumnControl ID="PreContentColumn" runat="server" />
        <div id="categorybanner">
            <asp:Image runat="server" ID="BannerImage" /></div>
        <div id="categorydescription">
            <asp:Literal id="DescriptionLiteral" runat="server"></asp:Literal>
        </div>
        <div id="subcategorymenu">                
                <asp:DataList ID="DataList1" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
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


