<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminReports.master" AutoEventWireup="false" CodeFile="View.aspx.vb" Inherits="BVAdmin_Reports_SearchKeywords" title="Keyword Searches" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Keyword Searches</h2>
    
    <asp:GridView Width="100%" ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="0" GridLines="none">
        <Columns>
            <asp:BoundField DataField="QueryPhrase" HeaderText="Search Phrase" />
            <asp:BoundField DataField="QueryCount" HeaderText="Hits" />
            <asp:BoundField DataField="Percentage" DataFormatString="{0}%" HeaderText="Percentage" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:TemplateField>
            <ItemTemplate>
                <asp:Image ID="imgBar" runat="server" Width="200" Height="9" ImageUrl="~/BVAdmin/Images/HorizontalBar.png" AlternateText="" />
            </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
    <br />
    <asp:ImageButton ID="btnReset" runat="server" AlternateText="Reset and Clear All Searches" ImageUrl="~/BVAdmin/Images/Buttons/Reset.png" OnClientClick="return window.confirm('Delete all search history?');" />
</asp:Content>
