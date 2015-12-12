<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="InventoryBatchEdit.aspx.vb" Inherits="BVAdmin_Catalog_InventoryBatchEdit" title="Inventory Batch Edit" %>

<%@ Register Src="~/BVAdmin/Controls/InventoryModifications.ascx" TagName="InventoryModifications" TagPrefix="uc4" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc3" %>
<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core" TagPrefix="cc1" %>
<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core.Controls" TagPrefix="bv" %>
<%@ Register Src="~/BVAdmin/Controls/ProductFilter.ascx" TagName="ProductFilter" TagPrefix="uc1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="headcontent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("div[id$='InventoryModificationsPanel'] input:checked").parent().siblings('.hide').show();
        });
    </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Inventory Batch Edit</h1>
    <asp:MultiView ID="BatchEditMultiView" runat="server" ActiveViewIndex="0">
        <asp:View ID="EditView" runat="server">
            <h2>Filter Products</h2>
            
            <uc3:MessageBox ID="MessageBox1" runat="server" EnableViewState="false" />            
           
            <uc1:ProductFilter ID="ProductFilter1" runat="server" DisplaySharedChoicesSection="true" />
            
            <h2>Inventory Modifications</h2>
            <uc4:InventoryModifications ID="InventoryModifications1" runat="server" />
            
            <br />
            <br />
            <asp:CheckBox ID="ChoiceCombinationsCheckBox" runat="server" Checked="True" Text="Show Me Choice Combinations" />
            <br />
            <br />        
            <asp:ImageButton ID="ViewImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Preview.png" />
            <br />
            <br />
                        
            <uc3:MessageBox ID="MessageBox2" runat="server" EnableViewState="false" />
            
        </asp:View>
        <asp:View ID="PreviewView" runat="server">
            <div style="overflow:scroll; width: 920px; height: 650px;">
                <asp:GridView ID="ProductsGridView" runat="server" AutoGenerateColumns="False" GridLines="none">
                    <Columns>
                        <asp:BoundField HeaderText="Product Name" DataField="ProductBvin" />
                        <asp:TemplateField HeaderText="Quantity Available">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("QuantityAvailable", "{0:#}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity Out Of Stock Point">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("QuantityOutOfStockPoint", "{0:#}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity Reserved">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("QuantityReserved", "{0:#}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Status" DataField="Status" />
                    </Columns>
                    <RowStyle CssClass="row" />
                    <HeaderStyle CssClass="rowheader" />
                    <AlternatingRowStyle CssClass="alternaterow" />
                </asp:GridView>
            </div>
            <div>
            	<asp:Label ID="AdditionalProductsLabel" runat="server" Text=""></asp:Label>
            </div>
            <asp:ImageButton ID="SaveImageButton" runat="server" AlternateText="Save" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
            <asp:ImageButton ID="CancelImageButton" runat="server" AlternateText="Cancel" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
        </asp:View>
    </asp:MultiView>
</asp:Content>

