<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Default.aspx.vb" Inherits="BVAdmin_People_Default" Title="Untitled Page" %>

<%@ Register Src="../Controls/UserFilter.ascx" TagName="UserFilter" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Users</h1>
    
    <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td align="left" valign="middle" ><h2>
                <asp:Label ID="lblResults" runat="server">No Results</asp:Label>
            </td>
            <td style="width:500px;">&nbsp;</td>
            <td align="right" valign="middle" >
                <asp:HyperLink ID="btnNew" runat="server" NavigateUrl="users_edit.aspx" ToolTip="Add New User" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
                <asp:HyperLink ID="lnkImportExport" runat="server" NavigateUrl="~/BVAdmin/ImportExport.aspx?id=E3895D67-7B33-48F1-A80B-072D00D02E5E" ToolTip="Export" ImageUrl="~/BVAdmin/Images/Buttons/Export.png" CssClass="iframe" />
            </td>
        </tr>
    </table>
    
    <hr />
    
    <asp:Panel ID="pnlFilter" runat="server" DefaultButton="btnGo">
        Filter:
        <asp:TextBox ID="FilterField" runat="server" Width="200px"></asp:TextBox>
        <asp:ImageButton ID="btnGo" runat="server" AlternateText="Filter Results" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" />
    </asp:Panel> 
    <br />           
    <uc1:UserFilter ID="UserFilter1" runat="server" />
    
    <br /><br />
    <asp:GridView ID="GridView1" PageSize="20" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin"
        BorderColor="#CCCCCC" CellPadding="0" GridLines="None" Width="100%" AllowPaging="True" DataSourceID="FilterObjectDataSource">
        
        <PagerSettings Mode="NumericFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></PagerSettings>
        <PagerStyle CssClass="pager"></PagerStyle>
        
        <Columns>
            <asp:BoundField DataField="username" HeaderText="Username" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
            <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton OnClientClick="return window.confirm('Delete this user?');" ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                        Text="Delete" CssClass="btn-delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
    <asp:ObjectDataSource ID="FilterObjectDataSource" runat="server" EnablePaging="True" OldValuesParameterFormatString="original_{0}" SelectMethod="FindAllWithFilter" TypeName="BVSoftware.Bvc5.Core.Membership.UserAccount" SelectCountMethod="GetRowCount">
        <SelectParameters>
            <asp:ControlParameter ControlID="FilterField" Name="filter" PropertyName="Text" Type="String" />
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="CriteriaObjectDataSource" runat="server" EnablePaging="True" OldValuesParameterFormatString="original_{0}"
        SelectCountMethod="GetRowCount" SelectMethod="FindByCriteria" TypeName="BVSoftware.Bvc5.Core.Membership.UserAccount">
        <SelectParameters>
            <asp:SessionParameter Name="criteria" SessionField="PeopleCriteria" Type="Object" />            
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
