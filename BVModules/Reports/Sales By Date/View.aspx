<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminReports.master" AutoEventWireup="false"
    CodeFile="View.aspx.vb" Inherits="BVAdmin_Reports_Default" Title="Sales By Date" %>
<%@ Register Src="~/BVAdmin/Controls/DateRangePicker.ascx" TagName="DateRangePicker" TagPrefix="uc2" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Sales By Date</h2>

    <uc1:MessageBox ID="msg" runat="server" />
    
    <table cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="formlabel">Date Range:</td>
			<td>
                <uc2:DateRangePicker ID="DateRangeField" runat="server" RangeType="ThisMonth" />
            </td>
		</tr>
	</table>
    <br />
  	<asp:ImageButton ImageUrl="~/BVAdmin/Images/Buttons/View.png" ID="btnShow" runat="server" CausesValidation="False" CssClass="printhidden" />
    
    <br />
    <br />
    <asp:Label ID="lblResponse" Text="" runat="server" CssClass="BVSmallText" />
                    
    <asp:DataGrid DataKeyField="timeoforder" CellPadding="0" BorderWidth="0" CellSpacing="0" ID="dgList" runat="server" AutoGenerateColumns="False" Width="100%" ShowFooter="True" GridLines="none">
        <HeaderStyle CssClass="rowheader" />
        <AlternatingItemStyle CssClass="alternaterow"></AlternatingItemStyle>
        <ItemStyle CssClass="row"></ItemStyle>
        <FooterStyle CssClass="rowfooter"></FooterStyle>
        <Columns>
            <asp:BoundColumn DataField="timeoforder" HeaderText="Date" DataFormatString="{0:d}"></asp:BoundColumn>
            <asp:BoundColumn DataField="OrderNumber" HeaderText="Order #"></asp:BoundColumn>
            <asp:BoundColumn DataField="SubTotal" HeaderText="SubTotal" DataFormatString="{0:C}"></asp:BoundColumn>
            <asp:BoundColumn DataField="OrderDiscounts" HeaderText="Discounts" DataFormatString="{0:C}"></asp:BoundColumn>
            <asp:BoundColumn DataField="ShippingTotal" HeaderText="Shipping" DataFormatString="{0:C}"></asp:BoundColumn>
            <asp:BoundColumn DataField="HandlingTotal" HeaderText="Handling" DataFormatString="{0:C}"></asp:BoundColumn>
            <asp:BoundColumn DataField="TaxTotal" HeaderText="Tax" DataFormatString="{0:C}"></asp:BoundColumn>
            <asp:BoundColumn DataField="GrandTotal" HeaderText="Grand Total" DataFormatString="{0:C}"></asp:BoundColumn>
            <asp:HyperLinkColumn DataNavigateUrlField="bvin" DataNavigateUrlFormatString="~/BVAdmin/Orders/ViewOrder.aspx?id={0}" Text="<img src='../../../BVAdmin/Images/Buttons/OrderDetails.png' />">
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
            </asp:HyperLinkColumn>
        </Columns>
        <PagerStyle CssClass="FormLabel"></PagerStyle>
    </asp:DataGrid>
</asp:Content>
