<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminReports.master" AutoEventWireup="false" CodeFile="View.aspx.vb" Inherits="BVModules_Reports_Customers_Who_Purchased_View" title="Untitled Page" %>
<%@ Register Src="../../../BVAdmin/Controls/DateRangePicker.ascx" TagName="DateRangePicker" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<h2>Customers Who Purchased</h2>
<table class="linedTable" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="formlabel wide">Find Customers Who Purchased SKU </td>
        <td class="formfield"><asp:TextBox ID="PurchasedSkuField" runat="server" Columns="15" Text="MYSKU123"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel wide">Ignore customers who also purchased </td>
        <td class="formfield"><asp:TextBox ID="AlsoPurchasedField" runat="server" Columns="40" Text="ABC123"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel wide">Limit to the Following Date Range </td>
        <td class="formfield"><uc1:DateRangePicker ID="DateRangeField" runat="server" /></td>
    </tr>
</table>
<br />

<asp:ImageButton ID="btnGo" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Submit.png" CssClass="printhidden" />
<br /><br />
<asp:Label ID="lblResult" runat="server"></asp:Label>

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BorderColor="#CCCCCC" CellPadding="3" GridLines="None" Width="100%"  AllowPaging="false" AllowSorting="false" PagerSettings-Mode="Numeric">
        <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:Literal ID="litOrderHistory" runat="server" Text='<%# Eval("OrderHistoryLiteral") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="LastName" />     
        <asp:BoundField DataField="FirstName" />     
        <asp:BoundField DataField="Company" />     
        <asp:BoundField DataField="Phone" />     
        <asp:BoundField DataField="Email" />     
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
    <br />
    E-Mail List:<br />
    <asp:TextBox ID="txtEmailCollection" runat="server" Columns="80" Rows="6" TextMode="MultiLine" />
</asp:Content>