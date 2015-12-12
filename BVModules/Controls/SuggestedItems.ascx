<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SuggestedItems.ascx.vb" Inherits="BVModules_Controls_SuggestedItems" %>
    <asp:Panel ID="SuggestedItemsPanel" runat="server">
    <div class="productgrid">
        <div class="decoratedblock blockcontent">            
            <h4 id="SuggestedItemsTitle" class="suggesteditemstitle" runat="server"></h4>
            <asp:DataList ID="DataList1" runat="server" DataKeyField="bvin" RepeatLayout="Table" RepeatDirection="Horizontal" RepeatColumns="3">
                <ItemTemplate>                        
                    <div class="suggesteditem">
                        <div class="suggestedimage">
                            <a href="<%#Eval("ProductURL") %>"><img runat="server" id="productImage" /></a>                        
                        </div>
                        <div class="suggestedname">
                            <a href="<%#Eval("ProductURL") %>"><%#Eval("ProductName")%></a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </div>
</asp:Panel>