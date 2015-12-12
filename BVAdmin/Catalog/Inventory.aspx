<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Inventory.aspx.vb" Inherits="BVAdmin_Catalog_Inventory" title="Inventory" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../Controls/SimpleProductFilter.ascx" TagName="SimpleProductFilter" TagPrefix="uc3" %>
<%@ Register Src="../Controls/InventoryModifications.ascx" TagName="InventoryModifications" TagPrefix="uc2" %>

<asp:Content ContentPlaceHolderID="headcontent" runat="server">
    <script type="text/javascript">
        function init_page() {
            $("input[id$='TrackInventoryCheckBox']:checked").siblings('.hide').toggle();
        }

        function Anthem_PostCallBack() {
            CallBackFinished();
            init_page();
        }

        $(document).ready(function() {
            init_page();
        });
    </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Inventory Edit</h1>
    <div>
    	<asp:Label ID="InventoryDisabledLabel" runat="server" Text="Inventory is disabled for the entire store. These settings will have no effect." EnableViewState="False" ForeColor="Red" Visible="False"></asp:Label>
    </div>
    
    <div class="text-right">
        <asp:HyperLink ID="lnkImportExport" runat="server" NavigateUrl="~/BVAdmin/ImportExport.aspx?id=1261AD24-2274-45B6-917F-21891D3915AE" ToolTip="Import/Export" ImageUrl="~/BVAdmin/Images/Buttons/ImportExport.png" CssClass="iframe" />
    </div>    

    <uc3:SimpleProductFilter ID="SimpleProductFilter" runat="server" />

    <asp:Label id="topLabel" runat="server"><div class="alert-box secondary"><strong>Note:</strong> Changing the page will save all changes on current page.</div></asp:Label>

    <anthem:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="Bvin" AllowPaging="True" DataSourceID="ObjectDataSource1" GridLines="none">
        <PagerSettings Mode="NextPreviousFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></PagerSettings>
        <PagerStyle CssClass="pager"></PagerStyle>
        
        <Columns>
            <asp:BoundField DataField="ProductName" HeaderText="Name" />
            <asp:BoundField DataField="Sku" HeaderText="Sku" />
            <asp:BoundField DataField="SitePrice" HeaderText="Price" HtmlEncode="False" DataFormatString="{0:c}" />

            <asp:TemplateField HeaderText="Qty Available">
                <ItemTemplate>
                    <asp:Label ID="QuantityAvailableLabel" runat="server" Text="Label"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Out-of-Stock Point">
                <ItemTemplate>
                    <asp:Label ID="OutOfStockPointLabel" runat="server" Text="Label"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Qty Reserved">
                <ItemTemplate>
                    <asp:Label ID="QuantityReservedLabel" runat="server" Text="Label"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField> 
                                       
            <asp:TemplateField ItemStyle-CssClass="trackInventory">
                <ItemTemplate>
                    <div style="width:200px;">
                        <asp:CheckBox ID="TrackInventoryCheckBox" Text="Track Inventory" OnClick="$(this).siblings('.hide').slideToggle('fast')" runat="server" />
                        <div class="hide controlarea2">
                            <uc2:InventoryModifications id="InventoryModifications" runat="server"></uc2:InventoryModifications>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
        <EmptyDataTemplate>
            <div class="alert-box alert">No Products Were Found.</div>
        </EmptyDataTemplate>
        <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
    </anthem:GridView>

    <br />
    <asp:Label id="BottomLabel" runat="server"><div class="alert-box secondary"><strong>Note:</strong> Changing the page will save all changes on current page.</div></asp:Label>
    <br /><br />
    <asp:ImageButton ID="SaveChangesImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
            
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="True" OldValuesParameterFormatString="original_{0}"
        SelectCountMethod="GetRowCount" SelectMethod="FindByCriteria" TypeName="BVSoftware.Bvc5.Core.Catalog.Product">
        <SelectParameters>
            <asp:SessionParameter Name="criteria" SessionField="InventoryCriteria" Type="Object" />
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>