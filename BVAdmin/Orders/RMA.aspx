<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="RMA.aspx.vb" Inherits="BVAdmin_Orders_RMA" title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Returns</h1>    
    <uc1:MessageBox ID="MessageBox" runat="server" /> 
    <asp:DropDownList ID="StatusFilterDropDownList" runat="server" AutoPostBack="True">
        <asp:ListItem Selected="True" Value="-1">All</asp:ListItem>
        <asp:ListItem Value="1">Pending</asp:ListItem>
        <asp:ListItem Value="2">Open</asp:ListItem>
        <asp:ListItem Value="3">Closed</asp:ListItem>
        <asp:ListItem Value="4">Rejected</asp:ListItem>
    </asp:DropDownList>
	<br />
    <br />
    <asp:GridView ID="RMAGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" CellPadding="0" GridLines="None" Width="100%" AllowPaging="True" DataSourceID="ObjectDataSource1">
    
    	<pagersettings Mode="NextPreviousFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></pagersettings>
        <pagerstyle CssClass="pager"></pagerstyle>
        <Columns>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox ID="chkSelectAll" CssClass="selectAll" runat="server" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="SelectedCheckBox" runat="server" /> 
                </ItemTemplate>
                <ItemStyle Width="25px" />
            </asp:TemplateField>
            <asp:HyperLinkField HeaderText="RMA Id" DataTextField="Number" DataNavigateUrlFields="bvin" DataNavigateUrlFormatString="RMADetail.aspx?id={0}" />
            <asp:HyperLinkField HeaderText="Order Id" DataTextField="OrderNumber" DataNavigateUrlFields="OrderBvin" DataNavigateUrlFormatString="ViewOrder.aspx?id={0}" />            
            <asp:BoundField HeaderText="Name" DataField="Name" />
            <asp:BoundField HeaderText="Amount" DataField="Amount" DataFormatString="{0:c}" HtmlEncode="False" />            
            <asp:BoundField HeaderText="Status" DataField="StatusText" />
            <asp:BoundField HeaderText="Date" DataField="DateOfReturn" DataFormatString="{0:d}" HtmlEncode="false" />
            <asp:HyperLinkField DataNavigateUrlFields="bvin" DataNavigateUrlFormatString="RMADetail.aspx?id={0}" Text="View" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Delete">Delete</asp:LinkButton>
                </ItemTemplate>                
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>            
            <p>There are no returns to display.</p>
        </EmptyDataTemplate>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
        <PagerSettings Position="TopAndBottom" />
    </asp:GridView>
    
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="True" OldValuesParameterFormatString="original_{0}" SelectCountMethod="GetRowCount" SelectMethod="FindAll" TypeName="BVSoftware.Bvc5.Core.Orders.RMA">
        <SelectParameters>
            <asp:ControlParameter ControlID="StatusFilterDropDownList" Name="status" PropertyName="SelectedValue"
                Type="Object" />        
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <br />
            
    <asp:ImageButton ID="ApproveImageButton" runat="server" AlternateText="Approve Selected RMAs" ImageUrl="~/BVAdmin/Images/Buttons/ApproveReturn.png" />&nbsp;
    <asp:ImageButton ID="CloseImageButton" runat="server" AlternateText="Close Selected RMAs" ImageUrl="~/BVAdmin/Images/Buttons/CloseReturn.png" />    <asp:ImageButton ID="RejectImageButton" runat="server" AlternateText="Reject Selected RMAs" ImageUrl="~/BVAdmin/Images/Buttons/RejectReturn.png" />
    
</asp:Content>

