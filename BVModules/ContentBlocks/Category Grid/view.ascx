<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_ContentBlocks_Category_Grid_view" %>

<div class="block categorygrid">
    <asp:Literal EnableViewState="false" ID="PreHtml" runat="server"></asp:Literal>
    <asp:Literal id="litTitle" runat="server" />

        <div class="decoratedblock">
            <div class="blockcontent">
                <asp:DataList EnableViewState="false" ID="dlCategories" runat="server" RepeatDirection="Horizontal" DataKeyField="bvin" RepeatLayout="Table">
                    <ItemTemplate>
                        <div class="categorygridimage"><asp:HyperLink EnableViewState="false" ID="lnkImage" runat="server"><img id="imagesmall" enableviewstate="false" runat="server"/></asp:HyperLink></div>
                        <div class="categorygridlink"><asp:HyperLink EnableViewState="false" runat="server" ID="lnkCategory"></asp:HyperLink></div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>

    <asp:Literal EnableViewState="false" ID="PostHtml" runat="server"></asp:Literal>
</div>