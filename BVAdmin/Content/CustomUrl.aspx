<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="CustomUrl.aspx.vb" Inherits="BVAdmin_Content_CustomUrl" Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>
        Custom Urls</h1>
    <uc1:MessageBox ID="msg" runat="server" />
    <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td align="left" valign="middle">
                <h2> <asp:Label ID="lblResults" runat="server">No Results</asp:Label></h2>
            </td>
            <td align="right" valign="middle">
                <asp:HyperLink ID="btnNew" runat="server" NavigateUrl="CustomUrl_Edit.aspx" ToolTip="Add New Custom Url" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
                <asp:HyperLink ID="lnkImportExport" runat="server" NavigateUrl="~/BVAdmin/ImportExport.aspx?id=72682388-C4EC-4FBE-AC44-6742A717CB16" ToolTip="Import/Export" ImageUrl="~/BVAdmin/Images/Buttons/ImportExport.png" CssClass="iframe" />
            </td>
        </tr>
    </table>
    &nbsp;
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" 
        BorderColor="#CCCCCC" CellPadding="0" GridLines="None" Width="100%" AllowPaging="True" DataSourceID="ObjectDataSource1"> 
        
        <PagerSettings Mode="NumericFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></PagerSettings>
        <PagerStyle CssClass="pager"></PagerStyle>
        
        <Columns>
            <asp:BoundField DataField="RequestedUrl" HeaderText="Requested Url" />
            <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton OnClientClick="return window.confirm('Delete this custom url?');"
                        ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
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
        SelectCountMethod="GetRowCount" SelectMethod="FindAll" TypeName="BVSoftware.Bvc5.Core.Content.CustomUrl">
        <SelectParameters>            
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
