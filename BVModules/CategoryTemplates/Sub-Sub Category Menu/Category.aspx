<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Sub_Sub_Category_Menu" title="Category" %>
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
            <asp:Repeater ID="rptrSubCategories" runat="server">
                <ItemTemplate>
                    <asp:PlaceHolder ID="plSub" runat="server">
                        <asp:Label ID="lblCategoryHeading" runat="server"></asp:Label>
                    <asp:Repeater ID="rptrSubSubCategories" runat="server"> 
                        <HeaderTemplate>
                            <div class="row">
                        </HeaderTemplate>
                            <ItemTemplate>
                                <div class="record">
                                    <div class="recordimage">
                                        <a id="recordimageanchor" runat="server" href=""><img id="recordimageimg" runat="server" src="" border="0" alt="" /></a>
                                    </div>
                                    <div class="recordname">
                                        <a id="recordnameanchor" runat="server" href=""></a>
                                    </div>                         
                                </div>
                            </ItemTemplate>
                        <FooterTemplate>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>
                        </asp:DataList>
                    </asp:PlaceHolder>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <uc1:ContentColumnControl ID="PostContentColumn" runat="server" />
    </div>
</asp:Content>


