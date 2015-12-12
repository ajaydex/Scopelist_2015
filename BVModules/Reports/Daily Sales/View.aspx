<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminReports.master" AutoEventWireup="false"
    CodeFile="View.aspx.vb" Inherits="BVAdmin_Reports_Sales_Day" Title="Daily Sales" %>

<%@ Register Src="~/BVAdmin/Controls/DatePicker.ascx" TagName="DatePicker" TagPrefix="uc2" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Daily Sales</h2>
    
    <asp:Label ID="Instructions" runat="server">Enter a date or select a date from the calendar.  Press the "View" button after making your selection</asp:Label>
    <br />
    <br />
    
    <uc1:MessageBox ID="msg" runat="server" />
    
    <table cellspacing="0" border="0" cellpadding="0">
        <tr>
            <td style="padding-right:10px;">
                <asp:ImageButton ID="btnLast" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/left.png" ToolTip="Last" />
            </td>
            <td align="center">
                <uc2:DatePicker ID="DatePicker" runat="server" />
            </td>
            <td style="padding-left:10px;">
                <asp:ImageButton ID="btnNext" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/right.png" ToolTip="Next" />
            </td>
        </tr>
    </table>
	<br />
    <asp:ImageButton ID="btnShow" runat="server" CausesValidation="False" ImageUrl="~/BVAdmin/Images/Buttons/view.png" ToolTip="Ok" CssClass="printhidden" />
    <br />
    <br />

    <asp:Label ID="lblResponse" Text="" runat="server" CssClass="BVSmallText" />

    <asp:DataGrid DataKeyField="bvin" CellPadding="0" BorderWidth="0" CellSpacing="0" ID="dgList" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="none" width="100%"> 
    	
        <HeaderStyle CssClass="rowheader" />
        <ItemStyle CssClass="row" />
        <AlternatingItemStyle CssClass="alternaterow" />
        <FooterStyle CssClass="rowheader"></FooterStyle>
        
        <Columns>
            <asp:BoundColumn DataField="OrderNumber" HeaderText="Order Number"></asp:BoundColumn>
            <asp:BoundColumn DataField="SubTotal" HeaderText="Sub Total" DataFormatString="{0:c}"></asp:BoundColumn>
            <asp:BoundColumn DataField="OrderDiscounts" HeaderText="Discounts" DataFormatString="{0:c}"></asp:BoundColumn>
            <asp:BoundColumn DataField="ShippingTotal" HeaderText="Shipping" DataFormatString="{0:c}"></asp:BoundColumn>
            <asp:BoundColumn DataField="HandlingTotal" HeaderText="Handling" DataFormatString="{0:c}"></asp:BoundColumn>
            <asp:BoundColumn DataField="TaxTotal" HeaderText="Tax" DataFormatString="{0:c}"></asp:BoundColumn>
            <asp:BoundColumn DataField="GrandTotal" HeaderText="Grand Total" DataFormatString="{0:c}"></asp:BoundColumn>
            <asp:HyperLinkColumn DataNavigateUrlField="bvin" DataNavigateUrlFormatString="~/BVAdmin/Orders/ViewOrder.aspx?id={0}" Text="<img src='../../../BVAdmin/Images/Buttons/OrderDetails.png' />">
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
            </asp:HyperLinkColumn>
        </Columns>
        <PagerStyle CssClass="FormLabel" Mode="NumericPages"></PagerStyle>
    </asp:DataGrid>
</asp:Content>
