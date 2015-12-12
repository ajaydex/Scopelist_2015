<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminReports.master" AutoEventWireup="false" CodeFile="View.aspx.vb" Inherits="BVModules_Reports_Sales_By_Product_Type_View" Title="Sales By Product Type" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Src="~/BVAdmin/Controls/DateRangePicker.ascx" TagName="DateRangePicker" TagPrefix="uc" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
	<h2>Sales By Product Type</h2>

	<uc:MessageBox id="ucMessageBox" runat="server" />
    
    <table cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="formlabel">Date Range:</td>
			<td>
                <uc:DateRangePicker id="ucDateRangeField" RangeType="ThisMonth" runat="server" />
            </td>
		</tr>
	</table>
	<br />
	<asp:ImageButton id="btnShow" ImageUrl="~/BVAdmin/Images/Buttons/View.png" CausesValidation="False" runat="server" CssClass="printhidden" />

	<br />
    <br />

    <asp:Label ID="lblResults" runat="server" />
    <asp:GridView ID="gvProductTypes" AutoGenerateColumns="False" ShowFooter="true" AllowPaging="False" AllowSorting="False" PagerSettings-Mode="Numeric" BorderColor="#CCCCCC" CellPadding="0" GridLines="None" Width="100%" runat="server">
        <Columns>			
            <asp:BoundField DataField="ProductTypeName" HeaderText="Name" />
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" DataFormatString="{0:N0}" />
            <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" />
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
</asp:Content>