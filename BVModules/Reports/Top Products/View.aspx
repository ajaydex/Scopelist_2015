<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminReports.master" AutoEventWireup="false" CodeFile="View.aspx.vb" Inherits="BVAdmin_Reports_Products" title="Top Products" %>

<%@ Register Src="~/BVAdmin/Controls/DateRangePicker.ascx" TagName="DateRangePicker" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Sales By Product</h2>
    
    <uc1:DateRangePicker ID="DateRangeField" runat="server" />
    <div class="skuFilterHolder">
        <asp:Label ID="lblSkuFilter" runat="server">Filter by SKU: </asp:Label>
        <asp:TextBox ID="txtSkuFilter" runat="server"></asp:TextBox>
        <asp:Button ID="btnSkuFilter" Text="Filter" runat="server" />
    </div>
    <br /><br />
    <asp:ImageButton ImageUrl="~/BVAdmin/Images/Buttons/OK.png" id="btnShow" runat="server" CausesValidation="False" Visible="false" CssClass="printhidden" />
    
    
    <asp:Label ID="lblResults" runat="server"></asp:Label>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin"
        BorderColor="#CCCCCC" CellPadding="3" GridLines="None" Width="100%"  AllowPaging="True" AllowSorting="True" PagerSettings-Mode="Numeric">
        <Columns>
            <asp:BoundField DataField="SKU" HeaderText="SKU" />
            <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
            <asp:BoundField DataField="Total Ordered" HeaderText="Total Ordered" DataFormatString="{0:f0}" HtmlEncode="false" />
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
    
</asp:Content>