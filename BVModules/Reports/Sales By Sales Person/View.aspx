<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminReports.master" AutoEventWireup="false" CodeFile="View.aspx.vb" Inherits="BVModules_Reports_Sales_By_Sales_Person_View" Title="Sales By Sales Person" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Src="~/BVAdmin/Controls/DateRangePicker.ascx" TagName="DateRangePicker" TagPrefix="uc" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
	<h2>Sales By Sales Person</h2>

	<uc:MessageBox id="ucMessageBox" runat="server" />
	
	<table cellpadding="0" cellspacing="0" border="0">
        <tr>
			<td class="formlabel">Sales Person:</td>
			<td>
                <asp:DropDownList ID="ddlSalesPerson" runat="server" />
            </td>
		</tr>
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

    <hr />

    <p class="smalltext"><asp:Label ID="lblResults" runat="server" /></p>

    <asp:Label ID="lblTotalItemCount" runat="server" />
    
    <anthem:Repeater ID="rpReport" runat="server">
        <HeaderTemplate>
            <table style="border-color:#CCCCCC;width:100%;border-collapse:collapse;">
                <tr class="rowheader">
                    <th>Sales Person</th>
                    <th>Orders</th>
                    <th>Items</th>
                    <th>Amount</th>
                    <th>Avg Order</th>
                    <th></th>
                </tr>
        </HeaderTemplate>

        <ItemTemplate>
            <tr id="trSalesPersonSummary" runat="server">
                <td><asp:Label ID="lblSalesPerson" runat="server" /></td>
                <td><asp:Label ID="lblOrderCount" runat="server" /></td>
                <td><asp:Label ID="lblItemCount" runat="server" /></td>
                <td><asp:Label ID="lblSalesAmount" runat="server" /></td>
                <td><asp:Label ID="lblAvgOrderValue" runat="server" /></td>
                <td class="text-right"><anthem:LinkButton ID="viewLink" CommandName="View" runat="server">Show Orders &blacktriangledown;</anthem:LinkButton></td>
            </tr>
            <tr id="trSalesPersonOrders" visible="false" runat="server">
                <td colspan="6">
                    <asp:Repeater ID="rpOrders" runat="server">
                        <HeaderTemplate>
                            <table style="border-color:#CCCCCC;width:100%;border-collapse:collapse;">
                                <tr class="rowheader">
                                    <th>Order Number</th>
                                    <th>Grand Total</th>
                                    <th></th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr class="row">
                                <td><asp:Label ID="lblOrderNumber" runat="server"></asp:Label></td>
                                <td><asp:Label ID="lblGrandTotal" runat="server"></asp:Label></td>
                                <td class="text-right"><asp:HyperLink ID="viewLink" runat="server" >View Order &blacktriangleright;</asp:HyperLink></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </td>
            </tr>
        </ItemTemplate>

        <FooterTemplate>
                <tr class="rowfooter">
                    <td></td>
                    <td><asp:Label ID="lblTotalOrderCount" runat="server" /></td>
                    <td><asp:Label ID="lblTotalItemCount" runat="server" /></td>
                    <td><asp:Label ID="lblTotalSalesAmount" runat="server" /></td>
                    <td><asp:Label ID="lblAvgAvgOrderValue" runat="server" /></td>
                    <!--<td></td>-->
                </tr>
            </table>
        </FooterTemplate>
    </anthem:Repeater>
</asp:Content>