<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminProduct.master" AutoEventWireup="false" CodeFile="ProductUpSellCrossSell.aspx.vb" Inherits="BVAdmin_Catalog_ProductUpSellCrossSell" title="Untitled Page" MaintainScrollPositionOnPostback="true" %>

<%@ Register Src="../../BVModules/Controls/CrossSellDisplay.ascx" TagName="CrossSellDisplay" TagPrefix="uc4" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc3" %>
<%@ Register Src="../Controls/ProductPicker.ascx" TagName="ProductPicker" TagPrefix="uc1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <h1>Up Sells/Cross Sells</h1>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
	<uc3:MessageBox ID="MessageBox1" runat="server" />

	<h2>UP SELLS</h2>
    <asp:GridView ID="UpSellsGridView" runat="server" AutoGenerateColumns="False" GridLines="none" style="width:100%;">
        <EmptyDataTemplate>
            There are no selected products.
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="SelectedCheckBox" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ProductName" HeaderText="Name" />
            <asp:BoundField DataField="Sku" HeaderText="Sku" />
            <asp:TemplateField HeaderText="Product Description Override">                        
                <ItemTemplate>                   
                    <asp:TextBox ID="DescriptionOverrideTextBox" runat="server" TextMode="MultiLine" Rows="3" MaxLength="512">
                    </asp:TextBox> 
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="moveUpButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Up.png" CommandName="MoveUp" />
                    <asp:ImageButton ID="moveDownButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Down.png" CommandName="MoveDown" />
                </ItemTemplate>
                <ItemStyle Width="20px" />
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
    <br />
    <asp:ImageButton ID="UpSellsRemoveImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Remove.png" CausesValidation="False" />
    
    <br /><br />
    
    <h6>Add Up Sell Products</h6>
    
    <uc1:ProductPicker ID="UpSellsProductPicker" runat="server" />
    <br />
    <asp:ImageButton ID="UpSellsAddImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Add.png" CausesValidation="False" />
    
	<hr />
	<br />
	<h2>CROSS SELLS</h2>
    <asp:GridView ID="CrossSellsGridView" runat="server" AutoGenerateColumns="False" GridLines="none">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="SelectedCheckBox" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ProductName" HeaderText="Name" />
            <asp:BoundField DataField="Sku" HeaderText="Sku" />                   
            <asp:TemplateField HeaderText="Product Description Override">                        
                <ItemTemplate>                   
                    <asp:TextBox ID="DescriptionOverrideTextBox" runat="server" TextMode="MultiLine" Rows="3" MaxLength="512">
                    </asp:TextBox> 
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>                        
                <ItemTemplate>
                    <asp:ImageButton ID="moveUpButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Up.png" CommandName="MoveUp" />
                    <asp:ImageButton ID="moveDownButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Down.png" CommandName="MoveDown" />
                </ItemTemplate>
                <ItemStyle Width="20px" />
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <EmptyDataTemplate>
            There are no selected products.
        </EmptyDataTemplate>
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
	<br />
    
    <asp:ImageButton ID="CrossSellsRemoveImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Remove.png" CausesValidation="False" />
			
	<br />
    <br />
    
    <h6>Add Cross Sell Products</h6>
    
    <uc1:ProductPicker ID="CrossSellsProductPicker" runat="server" />
    <br />
	<asp:ImageButton ID="CrossSellsAddImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Add.png" CausesValidation="False" />
	
   	<br />
    <br />
	<hr />
	<asp:ImageButton ID="CancelImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
	&nbsp;
	<asp:ImageButton ID="SaveImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
	
    <uc3:MessageBox ID="MessageBox2" runat="server" />
</asp:Content>

