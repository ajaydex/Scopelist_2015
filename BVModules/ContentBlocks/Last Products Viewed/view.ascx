<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_ContentBlocks_Last_Products_Viewed_view" %>
<div class="block lastProductsViewed">
<asp:Literal EnableViewState="false" ID="PreHtml" runat="server"></asp:Literal>
<div id="ProductGrid" runat="server" class="productgrid">
    <div class="decoratedblock">
        <div class="blockcontent">
            <h4><asp:Label EnableViewState="false" ID="LPVTitle" runat="server"></asp:Label></h4>
            <asp:DataList EnableViewState="false" ID="DataList1" runat="server" DataKeyField="bvin" RepeatLayout="Table">
                <ItemTemplate>
                    <table>
                        <tr>
                            <td>
                                <a href="<%#Eval("ProductURL") %>"><img id="imagesmall" runat="server" class="lastproductsviewed"/></a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="<%#Eval("ProductURL") %>"><%#Eval("ProductName")%></a>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </div>
</div>
<asp:Literal EnableViewState="false" ID="PostHtml" runat="server"></asp:Literal>
</div>