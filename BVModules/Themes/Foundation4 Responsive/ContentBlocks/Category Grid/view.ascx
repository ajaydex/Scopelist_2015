<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_Category_Grid_view" %>

<div class="block categorygrid">

    <asp:Literal id="litTitle" runat="server" />

    <asp:Literal EnableViewState="false" ID="PreHtml" runat="server"></asp:Literal>

    <div class="row">
        <asp:DataList ID="dlCategories" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" DataKeyField="bvin"> 
            <ItemTemplate>
                <div class="small-6 large-3 columns" id="containerDiv" runat="server">
                    <div class="record">
                        <div class="recordimage">
                            <asp:HyperLink EnableViewState="false" ID="lnkImage" runat="server">
                                <img id="imagesmall" enableviewstate="false" runat="server"/>
                            </asp:HyperLink>
                        </div>
                        <div class="recordname">
                            <asp:HyperLink EnableViewState="false" runat="server" ID="lnkCategory"></asp:HyperLink>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
    </div>

    <asp:Literal EnableViewState="false" ID="PostHtml" runat="server"></asp:Literal>
</div>
