<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_ContentBlocks_Product_Grid_view" %>

<div class="block productgrid">

<asp:Literal EnableViewState="false" ID="PreHtml" runat="server"></asp:Literal>


    <div class="decoratedblock">
        <div class="blockcontent">
            <asp:DataList EnableViewState="false" ID="DataList1" runat="server" RepeatDirection="Horizontal" DataKeyField="bvin" RepeatLayout="Table">
                <ItemTemplate>
                    <div class="productgridimage"><asp:HyperLink EnableViewState="false" ID="lnkImage" runat="server"><img id="imagesmall" enableviewstate="false" runat="server" class="lastproductsviewed"/></asp:HyperLink></div>
                    <div class="productgridlink"><asp:HyperLink EnableViewState="false" runat="server" ID="lnkProduct"></asp:HyperLink></div>                    
                </ItemTemplate>
            </asp:DataList>
        </div>
    </div>


<asp:Literal EnableViewState="false" ID="PostHtml" runat="server"></asp:Literal>

</div>
