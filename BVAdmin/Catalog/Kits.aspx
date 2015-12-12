<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Kits.aspx.vb" Inherits="BVAdmin_Catalog_Kits" Title="BV Commerce Admin" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<%@ Register Src="../Controls/SimpleKitFilter.ascx" TagName="SimpleKitFilter"
    TagPrefix="uc1" %>
<asp:Content ID="maincontentplace" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Kits</h1>
        <asp:Panel ID="pnlFilter" runat="server">
         <table border="0" cellspacing="0" cellpadding="0" width="100%">
                <tr>
                    <td align="left" valign="middle" ><h2>
                        <asp:Label ID="lblResults" runat="server">No Results</asp:Label></h2></td>
                        <td style="width:500px;">&nbsp;</td>
                    <td align="right" valign="middle" >
                        <asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New Kit" ImageUrl="~/BVAdmin/Images/Buttons/New.png" /></td>
                </tr></table>
            <uc1:SimpleKitFilter ID="SimpleKitFilter" runat="server" />            
            </asp:Panel>
        &nbsp; &nbsp;    
    <anthem:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin"
        BorderColor="#CCCCCC" CellPadding="0" GridLines="None" Width="100%" AllowPaging="True" DataSourceID="ObjectDataSource1" PageSize="10" AddCallBacks="true">
        
        <pagersettings Mode="NextPreviousFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></pagersettings>
        <pagerstyle CssClass="pager"></pagerstyle>
        
        <Columns>
            <asp:BoundField DataField="sku" HeaderText="SKU" />
            <asp:BoundField DataField="ProductName" HeaderText="Name" />
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
        <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" />        
    </anthem:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="True" OldValuesParameterFormatString="original_{0}"
        SelectCountMethod="GetRowCount" SelectMethod="FindByCriteria" TypeName="BVSoftware.Bvc5.Core.Catalog.Product">
        <SelectParameters>
            <asp:SessionParameter Name="criteria" SessionField="KitCriteria" Type="Object" />            
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <!--<PagerTemplate>
            <div>
                <asp:LinkButton ID="FirstLinkButton" runat="server" CommandName="FirstPage">First</asp:LinkButton>
                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="PageLink1">1</asp:LinkButton>
                <asp:LinkButton ID="LinkButton2" runat="server" CommandName="PageLink2">2</asp:LinkButton>
                <asp:LinkButton ID="LinkButton3" runat="server" CommandName="PageLink3">3</asp:LinkButton>
                <asp:LinkButton ID="LinkButton4" runat="server" CommandName="PageLink4">4</asp:LinkButton>                
                <asp:LinkButton ID="LastLinkButton" runat="server" CommandName="LastPage">Last</asp:LinkButton>
            </div>
        </PagerTemplate>-->
</asp:Content>
