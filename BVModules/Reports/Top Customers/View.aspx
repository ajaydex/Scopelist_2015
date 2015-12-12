<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminReports.master" AutoEventWireup="false" CodeFile="View.aspx.vb" Inherits="BVAdmin_Reports_Customers" title="Top Customers" %>
<%@ Register Src="~/BVAdmin/Controls/DateRangePicker.ascx" TagName="DateRangePicker" TagPrefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Sales By Customer</h2>
    <asp:Label ID="lblDateRange" runat="server">Date Range:</asp:Label>
    <uc2:DateRangePicker ID="DateRangeField" runat="server" /><br />
    <asp:ImageButton ImageUrl="~/BVAdmin/Images/Buttons/View.png" ID="btnShow" runat="server" CausesValidation="False" CssClass="printhidden" />
    <br /><br />
    <asp:Label ID="lblResults" runat="server"></asp:Label>
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="UserID" BorderColor="#CCCCCC" CellPadding="0" GridLines="None" Width="100%"  AllowPaging="true" AllowSorting="true" PagerSettings-Mode="Numeric">
        <Columns>
            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
            <asp:BoundField DataField="UserName" HeaderText="User Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" HtmlEncode="false" />
            <asp:CommandField ShowEditButton="True" EditText="View" />
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
</asp:Content>

