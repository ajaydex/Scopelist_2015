<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Affiliates.aspx.vb" Inherits="BVAdmin_People_Affiliates" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<h1>
    Affiliates</h1>
    
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
                        <asp:HyperLink ID="btnNew" runat="server" NavigateUrl="Affiliates_edit.aspx" ToolTip="Add New Affiliate" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
                        <asp:HyperLink ID="lnkImportExport" runat="server" NavigateUrl="~/BVAdmin/ImportExport.aspx?id=C68A863E-D23D-4181-A480-41761B4E90FB" ToolTip="Import/Export" ImageUrl="~/BVAdmin/Images/Buttons/ImportExport.png" CssClass="iframe" />
                    </td>
                </tr>
            </table>
        &nbsp;
    <asp:LinkButton ID="DisabledLinkButton" runat="server" style="float: right;">Display Only Disabled</asp:LinkButton>
    <div style="clear: both;"></div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin"
        BorderColor="#CCCCCC" CellPadding="0" GridLines="None" Width="100%" AllowPaging="True" DataSourceID="ObjectDataSource1">
        
        <pagersettings Mode="NextPreviousFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></pagersettings>
        <pagerstyle CssClass="pager"></pagerstyle>
        
        <Columns>
            <asp:BoundField DataField="DisplayName" HeaderText="Affiliate Name" />
            <asp:BoundField DataField="referralID" HeaderText="Referral ID" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton id="EnableLinkButton" runat="server" CommandName="EnableDisable">Enable</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton OnClientClick="return window.confirm('Delete this affiliate?');" ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                        Text="Delete" CssClass="btn-delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
        <PagerSettings Position="TopAndBottom" />
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="True" SelectCountMethod="GetRowCount" OldValuesParameterFormatString="original_{0}" SelectMethod="FindAllWithFilter" TypeName="BVSoftware.Bvc5.Core.Contacts.Affiliate">
        <SelectParameters>
            <asp:ControlParameter ControlID="FilterField" Name="filter" PropertyName="Text" Type="String" />
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" EnablePaging="True" SelectCountMethod="GetRowCount" OldValuesParameterFormatString="original_{0}" SelectMethod="FindAllWithFilter" TypeName="BVSoftware.Bvc5.Core.Contacts.Affiliate">
        <SelectParameters>
            <asp:SessionParameter Name="filter" SessionField="DisplayOnlyDisabled" Type="String" />
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>    
    </asp:ObjectDataSource>
</asp:Content>

