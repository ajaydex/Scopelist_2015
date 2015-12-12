<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminReports.master" AutoEventWireup="false" CodeFile="View.aspx.vb" Inherits="BVAdmin_Reports_Coupons" title="Sales by Coupon" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<%@ Register Src="~/BVAdmin/Controls/DateRangePicker.ascx" TagName="DateRangePicker" TagPrefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Sales By Coupon</h2>

    <uc1:MessageBox ID="msg" runat="server" />

    <table class="FormTable" cellpadding="5">
        <tr>
            <td class="formlabel">
                Coupon Code:</td>
            <td>
                <asp:DropDownList ID="lstCouponCode" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Date Range:</td>
            <td>
                <uc2:DateRangePicker ID="DateRangeField" runat="server" RangeType="ThisMonth" />
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:ImageButton ID="btnShow" runat="server" CausesValidation="False" ImageUrl="~/BVAdmin/Images/Buttons/View.png" CssClass="printhidden" />
            </td>
        </tr>
    </table>
	<br />
    <br />

    <asp:Label ID="lblResponse" Text="" runat="server" CssClass="BVSmallText" />
        <asp:DataGrid DataKeyField="bvin" CellPadding="0" BorderWidth="0" CellSpacing="0" ID="dgList" runat="server" AutoGenerateColumns="False" GridLines="none" Width="100%" >
            <HeaderStyle CssClass="rowheader" />
            <AlternatingItemStyle CssClass="alternaterow"></AlternatingItemStyle>
            <ItemStyle CssClass="row"></ItemStyle>
            <FooterStyle CssClass="rowfooter"></FooterStyle>
            <Columns>
                <asp:HyperLinkColumn DataNavigateUrlField="bvin" DataNavigateUrlFormatString="~/BVAdmin/Orders/ViewOrder.aspx?id={0}"
                    DataTextField="OrderNumber" HeaderText="Order Number">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:HyperLinkColumn>
                <asp:HyperLinkColumn DataNavigateUrlField="UserID" DataNavigateUrlFormatString="~/BVAdmin/People/users_edit.aspx?id={0}"
                    DataTextField="UserEmail" HeaderText="Customer Email">
                    <ItemStyle HorizontalAlign="left"></ItemStyle>
                </asp:HyperLinkColumn>
                <asp:TemplateColumn HeaderText="SubTotal">
                    <ItemTemplate>
                        <asp:Literal ID="litSubTotal" runat="server" />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:BoundColumn DataField="GrandTotal" HeaderText="Order Total" DataFormatString="{0:C}">
                    <ItemStyle HorizontalAlign="left"></ItemStyle>
                </asp:BoundColumn>
                <asp:BoundColumn DataField="TimeOfOrder" HeaderText="Time of Order" DataFormatString="{0:D}">
                    <ItemStyle HorizontalAlign="left"></ItemStyle>
                </asp:BoundColumn>
            </Columns>
            <PagerStyle CssClass="FormLabel"></PagerStyle>
        </asp:DataGrid>
</asp:Content>

