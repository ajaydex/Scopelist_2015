<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Default.aspx.vb" Inherits="BVAdmin_Catalog_Default" Title="BV Commerce Admin" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../Controls/SimpleProductFilter.ascx" TagName="SimpleProductFilter" TagPrefix="uc1" %>
<%@ Register src="../Controls/MessageBox.ascx" tagname="MessageBox" tagprefix="uc2" %>

<asp:Content ID="maincontentplace" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Products</h1>
    <uc2:MessageBox ID="MessageBox1" runat="server" EnableViewState="false" />
    <asp:Panel ID="pnlFilter" runat="server">
        <table border="0" cellspacing="0" cellpadding="0" width="100%">
            <tr>
                <td align="left" valign="middle" ><h2>
                    <anthem:Label ID="lblResults" AutoUpdateAfterCallBack="true" runat="server">No Results</anthem:Label></h2></td>
                    <td style="width:500px;">&nbsp;</td>
                <td align="right" valign="middle" >
                    <asp:HyperLink ID="btnNew" runat="server" NavigateUrl="Products_Edit.aspx" ToolTip="Add New Product" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
                    <asp:HyperLink ID="lnkImportExport" runat="server" NavigateUrl="~/BVAdmin/ImportExport.aspx?id=0506D3B1-E9BE-4095-878F-CF50B13E88E2" ToolTip="Import/Export" ImageUrl="~/BVAdmin/Images/Buttons/ImportExport.png" CssClass="iframe" />
                </td>
            </tr>
        </table>
        <uc1:SimpleProductFilter ID="SimpleProductFilter" runat="server" />            
    </asp:Panel>
    
    <anthem:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" CellPadding="0" GridLines="None" Width="100%" AllowPaging="True" DataSourceID="ObjectDataSource1" PageSize="10" AddCallBacks="true">
       	<pagersettings Mode="NextPreviousFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></pagersettings>
        <pagerstyle CssClass="pager"></pagerstyle>
        <Columns>
            <asp:BoundField DataField="sku" HeaderText="SKU" />
            <asp:BoundField DataField="ProductName" HeaderText="Name" />
            <asp:BoundField DataField="SitePrice" HeaderText="Price" DataFormatString="{0:c}" />
            <asp:TemplateField HeaderText="Active">                
                <ItemTemplate>
                    <asp:CheckBox ID="chkActive" runat="server" Enabled="false" />                
                </ItemTemplate>
            </asp:TemplateField>            
            <asp:TemplateField>
                <ItemTemplate>
                   <anthem:ImageButton runat="server" CommandName="Edit" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" EnableCallback="false"></anthem:ImageButton> 
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton OnClientClick="return window.confirm('Delete this product?');" ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png"
                        AlternateText="Delete"></asp:ImageButton>                
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <anthem:ImageButton ID="CloneImageButton" runat="server" CausesValidation="False" CommandName="Clone"
                        AlternateText="Clone" ImageUrl="~/BVAdmin/Images/Buttons/CloneProduct.png" EnableCallback="false"></anthem:ImageButton>
            </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
        <SelectedRowStyle CssClass="rowselected" />
        <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" />        
    </anthem:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="True" OldValuesParameterFormatString="original_{0}"
        SelectCountMethod="GetRowCount" SelectMethod="FindByCriteria" TypeName="BVSoftware.Bvc5.Core.Catalog.Product">
        <SelectParameters>
            <asp:SessionParameter Name="criteria" SessionField="ProductCriteria" Type="Object" />            
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>