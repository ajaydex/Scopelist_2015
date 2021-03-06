<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Manufacturers.aspx.vb" Inherits="BVAdmin_People_Manufacturers" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<h1>
    Manufacturers</h1>
    
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                <tr>
                    <td align="left" valign="middle"><h2>
                        <asp:Label ID="lblResults" runat="server">No Results</asp:Label></h2></td>
                    <td align="center" valign="middle">
                        <asp:Panel ID="pnlFilter" runat="server" DefaultButton="btnGo">
                            Filter:
                            <asp:TextBox ID="FilterField" runat="server" Width="200px"></asp:TextBox>
                            <asp:ImageButton ID="btnGo" runat="server" AlternateText="Filter Results" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" /></asp:Panel>
                    </td>
                    <td align="right" valign="middle">
                        <asp:HyperLink ID="btnNew" runat="server" NavigateUrl="Manufacturers_edit.aspx" ToolTip="Add New Manufacturer" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
                        <asp:HyperLink ID="lnkImportExport" runat="server" NavigateUrl="~/BVAdmin/ImportExport.aspx?id=CBB17285-85D6-4506-841A-7749E1BFCC10" ToolTip="Import/Export" ImageUrl="~/BVAdmin/Images/Buttons/ImportExport.png" CssClass="iframe" />
                    </td>
                </tr>
            </table>
        &nbsp;
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin"
        BorderColor="#CCCCCC" CellPadding="0" GridLines="None" Width="100%" AllowPaging="True" DataSourceID="ObjectDataSource1">
        
        <PagerSettings Mode="NumericFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></PagerSettings>
        <PagerStyle CssClass="pager"></PagerStyle>
        
        <Columns>
            <asp:BoundField DataField="DisplayName" HeaderText="Manufacturer Name" />
            <asp:BoundField DataField="EmailAddress" HeaderText="Email" />
            <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton OnClientClick="return window.confirm('Delete this manufacturer?');" ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                        Text="Delete" CssClass="btn-delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
        <PagerSettings Position="TopAndBottom" />
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="True" OldValuesParameterFormatString="original_{0}"
        SelectCountMethod="GetRowCount" SelectMethod="FindAllWithFilter" TypeName="BVSoftware.Bvc5.Core.Contacts.Manufacturer">
        <SelectParameters>
            <asp:ControlParameter ControlID="FilterField" Name="filter" PropertyName="Text" Type="String" />            
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

