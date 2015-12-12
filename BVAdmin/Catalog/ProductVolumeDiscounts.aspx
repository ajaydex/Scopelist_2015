<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminProduct.master" AutoEventWireup="false" CodeFile="ProductVolumeDiscounts.aspx.vb" Inherits="BVAdmin_Catalog_ProductVolumeDiscounts" title="Untitled Page" %>

<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core" TagPrefix="cc1" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <h1>Volume Discounts</h1>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">    
    <div>
        <uc1:MessageBox ID="MessageBox1" runat="server" />
    </div> 

	<table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>Qty</td>
			<td>&nbsp;</td>
            <td>Price</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
        </tr>
        <tr>
            <td><asp:TextBox ID="QuantityTextBox" runat="server"></asp:TextBox></td>
			<td>&nbsp;</td>
            <td><asp:TextBox ID="PriceTextBox" runat="server"></asp:TextBox></td>
			<td>&nbsp;</td>
            <td><asp:ImageButton ID="NewLevelImageButton" runat="server" AlternateText="New Level" ImageUrl="~/BVAdmin/Images/Buttons/New.png" /></td>
        </tr>
	</table>
	<br /><br />
    <div>
        <asp:GridView ID="VolumeDiscountsGridView" runat="server" DataKeyNames="bvin" AutoGenerateColumns="False" GridLines="none" style="width:500px;" RowStyle-Height="40">
            <Columns>
                <asp:BoundField HeaderText="Quantity" DataField="Qty" />                
                <asp:BoundField HeaderText="Price" DataField="Amount" DataFormatString="{0:c}" HtmlEncode="False" />                
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="DeleteImageButton" runat="server" CommandName="Delete" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
			<RowStyle CssClass="row" />
			<HeaderStyle CssClass="rowheader" />
			<AlternatingRowStyle CssClass="alternaterow" />
        </asp:GridView>        
    </div>
	
</asp:Content>

