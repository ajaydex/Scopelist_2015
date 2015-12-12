<%@ Control Language="VB" AutoEventWireup="false" CodeFile="adminview.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_Last_Products_Viewed_adminview" %>

<div class="block lastProductsViewed">
    <h6>Last Products Viewed</h6>
    
    <pre><asp:Label ID="PreHtml" runat="server"></asp:Label></pre>
    
    <asp:DataList ID="DataList1" runat="server" DataKeyField="bvin" RepeatLayout="Table">
        <ItemTemplate>
        	<div>
            	<a href="<%#Eval("ProductURL") %>"><img id="imagesmall" runat="server" class="lastproductsviewed"  /></a>
            </div>
            <div>
            	<a href="<%#Eval("ProductURL") %>"><%#Eval("ProductName")%></a>
            </div>
        </ItemTemplate>
    </asp:DataList>
    
    <pre><asp:Label ID="PostHtml" runat="server"></asp:Label></pre>            
</div>
