<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="BVAdmin_Orders_Default" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/DateRangePicker.ascx" TagName="DateRangePicker" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:HyperLink ID="lnkImportExport" runat="server" NavigateUrl="~/BVAdmin/ImportExport.aspx?id=1981E254-BABB-4C0C-8C0F-23BC2A4E619F" ToolTip="Export" ImageUrl="~/BVAdmin/Images/Buttons/Export.png" CssClass="iframe" style="float:right;margin-top:20px;"/>
    <h1>Order Manager</h1>
    <uc2:MessageBox ID="MessageBox1" runat="server" />

    

    <asp:Panel ID="pnlFilter" runat="server" DefaultButton="btnGo" class="controlarea1"> 
        <table border="0" cellspacing="0" cellpadding="0" width="100%">
           <tr>                        
                <td>Payment</td>
                <td>Shipping</td>
                <td>Status</td>
                <td>Date Range</td>
                <td style="width:180px;">Keyword</td>
           </tr>
           <tr>                       
                <td><asp:DropDownList ID="PaymentFilterField" runat="server" AutoPostBack="True">
                    <asp:ListItem Text="- Any -" Value="0"></asp:ListItem>
                    <asp:ListItem Value="1">Unpaid</asp:ListItem>
                    <asp:ListItem Value="2">Partially</asp:ListItem>
                    <asp:ListItem Value="3">Paid</asp:ListItem>
                    <asp:ListItem Value="4">Overpaid</asp:ListItem>
                </asp:DropDownList></td>
                <td><asp:DropDownList ID="ShippingFilterField" runat="server" AutoPostBack="True">
                    <asp:ListItem Text="- Any -" Value="0"></asp:ListItem>
                    <asp:ListItem Value="1">Unshipped</asp:ListItem>
                    <asp:ListItem Value="2">Partial</asp:ListItem>
                    <asp:ListItem Value="3">Shipped</asp:ListItem>
                </asp:DropDownList></td>
                <td><asp:DropDownList ID="StatusFilterField" runat="server" AutoPostBack="True">
                    <asp:ListItem Text="- Any -"></asp:ListItem>
                    <asp:ListItem>In Process</asp:ListItem>
                    <asp:ListItem>Complete</asp:ListItem>
                    <asp:ListItem>Problem</asp:ListItem>
                </asp:DropDownList></td>
                <td><uc1:DateRangePicker ID="DateRangeField" runat="server" RangeType="ThisWeek" /><%-- set RangeType to "ThisWeek" for performance rather than the previous "AllDates" --%></td>
                <td><asp:TextBox ID="FilterField" runat="server" Width="150px"></asp:TextBox></td>
                <td><asp:ImageButton ID="btnGo" runat="server" AlternateText="Filter Results" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" /></td>
           </tr>
        </table>
	</asp:Panel>
    
    <br />
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" CellPadding="0" GridLines="None" Width="100%" AllowPaging="True" DataSourceID="ObjectDataSource1">
        
        <PagerSettings Mode="NumericFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></PagerSettings>
        <PagerStyle CssClass="pager"></PagerStyle>
        
        <Columns>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox ID="chkSelectAll" CssClass="selectAll" runat="server" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelected" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="Bvin" DataNavigateUrlFormatString="ViewOrder.aspx?id={0}" DataTextField="OrderNumber" HeaderText="Order #" />
            <asp:TemplateField HeaderText="Sold To">             
                <ItemTemplate>
                    <asp:Label ID="SoldToField" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Total">              
                <ItemTemplate>
                    <asp:Label ID="GrandTotalField" runat="server" ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date">
                <ItemTemplate>
                    <asp:Label ID="TimeOfOrderField" runat="server" ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>            
            <asp:TemplateField HeaderText="Payment">               
                <ItemTemplate>
                    <asp:HyperLink ID="PaymentLink" runat="server" Text="Unknown" NavigateUrl="ReceivePayments.aspx"></asp:HyperLink>                    
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Shipping">             
                <ItemTemplate>
                    <asp:HyperLink ID="ShippingLink" runat="server" Text="Unknown" NavigateUrl="ShipOrder.aspx"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">            
                <ItemTemplate>
                    <asp:HyperLink ID="StatusLink" runat="server" Text="Unknown" NavigateUrl="~/BVAdmin/Orders/ViewOrder.aspx"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:HyperLinkField DataNavigateUrlFields="Bvin" DataNavigateUrlFormatString="ViewOrder.aspx?id={0}" Text="View" />
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
        <PagerSettings Position="TopAndBottom" />
    </asp:GridView>            
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="True" OldValuesParameterFormatString="original_{0}" SelectCountMethod="GetRowCount" SelectMethod="FindByCriteria" TypeName="BVSoftware.Bvc5.Core.Orders.Order">
        <SelectParameters>              
          <asp:SessionParameter Name="criteria" SessionField="OrderCriteria" Type="Object" />                
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
 	
    <br />
    Batch Update Checked Orders: <asp:DropDownList ID="BatchActionField" runat="server" AutoPostBack="true">
        <asp:ListItem Value="0">- Select an Action -</asp:ListItem>
        <asp:ListItem Value="">-----------------------</asp:ListItem>
        <asp:ListItem Value="Capture">Capture Funds for Authorized Orders</asp:ListItem>
        <asp:ListItem>-----------------------</asp:ListItem>
        <asp:ListItem Value="PrintInvoice">Print Invoices</asp:ListItem>
        <asp:ListItem Value="PrintPackingSlip">Print Packing Slips</asp:ListItem>
        <asp:ListItem Value="PrintAdminReceipt">Print Admin Receipts</asp:ListItem>
        <asp:ListItem Value="Print">Print Other</asp:ListItem>
    </asp:DropDownList>    
</asp:Content>

