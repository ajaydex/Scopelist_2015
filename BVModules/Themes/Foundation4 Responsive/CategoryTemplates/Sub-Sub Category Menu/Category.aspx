<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_CategoryTemplates_Sub_Sub_Category_Menu" title="Category" %>

<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">

    <uc1:ContentColumnControl ID="PreContentColumn" runat="server" />

    <h1><asp:Label ID="lblTitle" runat="Server"></asp:Label></h1>

    <div id="categorybanner">
        <div class="row">
            <div class="large-12 columns">
                <asp:Image runat="server" ID="BannerImage" />
                <div id="categorydescription">
                    <asp:Literal id="DescriptionLiteral" runat="server"></asp:Literal>
                </div>
            </div>
        </div>
    </div>

    <asp:Repeater ID="rptrSubCategories" runat="server">
        <ItemTemplate>
            <asp:PlaceHolder ID="plSub" runat="server">

                <div class="categorygrid">
                    <h2><asp:Label ID="lblCategoryHeading" runat="server"></asp:Label></h2>
                    <asp:Repeater ID="rptrSubSubCategories" runat="server"> 
                        <HeaderTemplate>
                            <div class="row">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="small-6 large-3 columns" id="containerDiv" runat="server">
                                <div class="record">
                                    <div class="recordimage">
                                        <a id="recordimageanchor" runat="server" href="">
                                            <img id="recordimageimg" runat="server" src="" border="0" alt="" />
                                        </a>
                                    </div>
                                    <div class="recordname">
                                        <a id="recordnameanchor" runat="server" href=""></a>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>

            </asp:PlaceHolder>
        </ItemTemplate>
    </asp:Repeater>
    

    <uc1:ContentColumnControl ID="PostContentColumn" runat="server" />

</asp:Content>


