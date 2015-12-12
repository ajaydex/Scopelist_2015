<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Categories_AutomaticSelection.aspx.vb" Inherits="BVAdmin_Catalog_Categories_AutomaticSelection" title="Dynamic Category Selection" %>

<%@ Register Src="../Controls/ProductFilter.ascx" TagName="ProductFilter" TagPrefix="uc2" %>

<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core" TagPrefix="cc1" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Select Criteria for Category</h1>
    <uc1:MessageBox ID="msg" runat="server" />
    <uc2:ProductFilter ID="ProductFilter1" runat="server" DisplaySharedChoicesSection="false" />
    
    <asp:ImageButton ID="CancelImageButton" runat="server" AlternateText="Cancel" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
    <asp:ImageButton ID="OkImageButton" runat="server" AlternateText="Okay" ImageUrl="~/BVAdmin/Images/Buttons/Ok.png" />&nbsp;
    <asp:Panel ID="ProductListPanel" runat="server" Height="50px" Width="125px" Visible="False">
    <asp:GridView ID="ProductsGridView" runat="server" AutoGenerateColumns="False" GridLines="none" BorderWidth="0px">
        <Columns>
            <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
            <asp:BoundField DataField="Sku" HeaderText="Sku" />
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
        <asp:ImageButton ID="SaveChangesImageButton" runat="server" AlternateText="Save Changes"
            ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></asp:Panel>
    

</asp:Content>

