<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminReports.master" AutoEventWireup="false" CodeFile="View.aspx.vb" Inherits="BVModules_Reports_Shopping_Carts_Default" title="Reports - Shopping Carts" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
	<h1>Current Shopping Carts</h1>
    <uc1:MessageBox ID="msg" runat="server" />    
    
    <p>This report shows all unplaced orders (shopping carts) in the system. These carts could be for customers currently shopping on the website or from customers that have abandoned their cart. Use this report to analyze your sales funnel and email customers that abandoned their cart.</p>

    <div class="controlarea1">
       
        <div class="f-row">
            <div class="six columns">
                <h6 style="margin-top:0;">Hide Carts</h6>
                <asp:CheckBox ID="chkExcludeEmptyCarts" Text="With No Items" Checked="true" runat="server" /><br />
                <asp:CheckBox ID="chkExcludeCartsWithoutEmailAddresses" Text="With No Email Address" runat="server" />
            </div>
            <div class="six columns">
                <h6 style="margin-top:0;">Show Carts</h6>
                <asp:CheckBox ID="chkExcludeEmailedCarts" Text="That Have Been Emailed" runat="server" /> <asp:TextBox ID="txtNumberOfEmails" Text="1" Columns="1" runat="server" /> <span style="font-size:12px;">time(s)</span>
                <asp:RequiredFieldValidator ControlToValidate="txtNumberOfEmails" Text="[required]" Display="Dynamic" runat="server" />
                <asp:CompareValidator ControlToValidate="txtNumberOfEmails" Operator="DataTypeCheck" Type="Integer" Text="[must be an integer]" Display="Dynamic" runat="server" />
                <asp:RangeValidator ControlToValidate="txtNumberOfEmails" MinimumValue="0" MaximumValue="9999" Type="Integer" Text="[cannot be less than 0]" Display="Dynamic" runat="server" />
            </div>
        </div>
        <br />
        <hr class="short" />
		
        <asp:ImageButton ID="btnFilter" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" runat="server" />
 	
    </div>

    <asp:GridView DataKeyField="bvin" CellPadding="0" BorderWidth="0" CellSpacing="0" ID="gvCarts" runat="server" AutoGenerateColumns="False" Width="100%" ShowFooter="True" GridLines="none" AllowSorting="true" CssClass="smalltext">
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow"></AlternatingRowStyle>
        <RowStyle CssClass="row"></RowStyle>
        <FooterStyle CssClass="rowfooter"></FooterStyle>
        <Columns>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox ID="chkSelectAll" CssClass="selectAll" runat="server" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelected" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="TimeOfOrder" HeaderText="Created" DataFormatString="{0:g}" SortExpression="TimeOfOrder"></asp:BoundField>
            <asp:BoundField DataField="LastUpdated" HeaderText="Last Updated" DataFormatString="{0:g}" SortExpression="LastUpdated"></asp:BoundField>
            <%--<asp:BoundField DataField="bvin" HeaderText="ID #"></asp:BoundField>--%>
            <asp:TemplateField HeaderText="Customer">
                <ItemTemplate>
                    <asp:Label ID="lblName" runat="server" />
                    <asp:HyperLink ID="lnkEmail" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="SubTotal" HeaderText="SubTotal" DataFormatString="{0:C}" SortExpression="SubTotal" ItemStyle-CssClass="text-right" HeaderStyle-CssClass="text-right"></asp:BoundField>
            <asp:TemplateField HeaderText="Emailed" SortExpression="EmailCount" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center">
                <ItemTemplate>
                    <asp:Label ID="lblEmailCount" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"></ItemStyle>
                <ItemTemplate>
                    <asp:HyperLink ID="lnkView" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/View-small.png"></asp:HyperLink>
                    <asp:HiddenField ID="hfBvin" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <PagerStyle CssClass="FormLabel"></PagerStyle>
    </asp:GridView>

    <hr />

    <h5>Send selected customers a Cart Abandonment email</h5>
    Template: <asp:DropDownList ID="lstEmailTemplate" runat="server" /><br /><br />
    <asp:ImageButton ID="btnSendEmail" ImageUrl="~/BVAdmin/Images/Buttons/Email.png" ToolTip="Send Cart Abandonment Email" AlternateText="Send Cart Abandonment Email" runat="server" />
</asp:Content>
