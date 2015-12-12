<%@ Control Language="VB" AutoEventWireup="false" CodeFile="adminview.ascx.vb" Inherits="BVModules_ContentBlocks_Product_Grid_adminview" %>

<div class="block productgrid">
    <h6>Product Grid</h6>
    <pre><asp:Label ID="PreHtml" runat="server"></asp:Label></pre>
    <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" DataKeyField="bvin"
        RepeatLayout="Table">
        <ItemTemplate>
            <div>
            	<a href="<%#Eval("Setting5") %>"><img src="../../<%#Eval("Setting4") %>" border="none" /></a>
            </div>
            <div>
            	<a href="<%#Eval("Setting5") %>"><%#Eval("Setting3") %></a>
            </div>
        </ItemTemplate>
    </asp:DataList>
    <pre><asp:Label ID="PostHtml" runat="server"></asp:Label></pre>       
</div>
