<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminProduct.master" AutoEventWireup="false" 
CodeFile="Products_Edit_Inventory.aspx.vb" Inherits="BVAdmin_Catalog_Products_Edit_Inventory" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <h1>Inventory</h1>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <div><asp:Label ID="InventoryDisabledLabel" runat="server" Text="Inventory is disabled for the entire store. These settings will have no effect." EnableViewState="False" ForeColor="Red" Visible="False"></asp:Label></div>
    <table border="0" cellspacing="0" cellpadding="0">   
    <tr>
       <td colspan="2">
        When this item is out of stock: 
		<asp:DropDownList id="OutOfStockModeField" runat="server">
        <asp:ListItem Text="Remove From Store" Value="0"></asp:ListItem>
        <asp:ListItem Text="Leave on Store (Ignore Inventory)" Value="1"></asp:ListItem>
        <asp:ListItem Text="Show as Out of Stock (Allow Orders)" Value="2"></asp:ListItem>
        <asp:ListItem Text="Show as Out of Stock (Do not allow Orders)" Value="3"></asp:ListItem>
        </asp:DropDownList>

		<br />                
        <br />
		
        <asp:GridView ID="EditsGridView" runat="server" BorderWidth="0px" cellpadding="0" CellSpacing="1"
            DataKeyNames="bvin" GridLines="None" AutoGenerateColumns="False">
            <Columns>
                <asp:TemplateField HeaderText="SKU">                 
                    <ItemTemplate>
                        <asp:Label CssClass="smalltext" ID="Label1" runat="server" Text='<%# Bind("SKU") %>'></asp:Label><br />
                        <asp:Label CssClass="smalltext" ID="Label2" runat="server" Text='<%# Bind("ProductName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Enabled">
                    <ItemTemplate><asp:CheckBox ID="chkTrackInventory" runat="server" /></ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField Visible="false">
                    <ItemTemplate><asp:Label ID="lblStatus" runat="server" Text="0"></asp:Label></ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Available">
                    <ItemTemplate><asp:Label ID="lblQuantityAvailable" runat="server" Text="0"></asp:Label></ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Out Of Stock Point">
                    <ItemTemplate><asp:TextBox ID="OutOfStockPointField" runat="server" Columns="5" Text="0"></asp:TextBox></ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Reorder Point">
                    <ItemTemplate><asp:TextBox ID="ReorderPointField" runat="server" Columns="5" Text="0"></asp:TextBox></ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Reserved">
                    <ItemTemplate><asp:Label ID="lblQuantityReserved" runat="server" Text="0"></asp:Label></ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="For Sale">
                    <ItemTemplate><asp:Label ID="lblQuantityAvailableForSale" runat="server" Text="0"></asp:Label></ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate><asp:TextBox ID="AdjustmentField" runat="server" Columns="5" Text="0"></asp:TextBox></ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate><asp:DropDownList ID="AdjustmentModeField" runat="Server">
                    <asp:ListItem Value="1" Text="Add"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Subtract"></asp:ListItem>
                    <asp:ListItem Value="3" Text="Set To"></asp:ListItem>
                    </asp:DropDownList></ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="row" />
            <HeaderStyle CssClass="rowheader" />
            <AlternatingRowStyle CssClass="alternaterow" />
        </asp:GridView>
       </td>
    </tr>
	</table>
    
	<br/><br/>
	
	<asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" AlternateText="Cancel" CausesValidation="false" />
	&nbsp;
	<asp:ImageButton ID="btnSaveChanges" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" AlternateText="Save Changes" />
       
    <asp:HiddenField ID="bvinfield" runat="server" />   
</asp:Content>

