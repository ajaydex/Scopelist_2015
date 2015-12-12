<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Taxes.aspx.vb" Inherits="BVAdmin_Configuration_Taxes" Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    

    <a href="http://bit.ly/1vGgZKN" target="_blank"><img src="/bvadmin/images/avatax.jpg" alt="Avalara" /></a>
    
    <h1>Taxes</h1>
	<asp:Panel Visible="false" runat="server" ID="msgBox">
        <uc1:MessageBox ID="msg" runat="server" />
        <br />
	</asp:Panel>
    
    <div class="controlarea1">
        <table border="0" cellspacing="0" cellpadding="0">
            <%--
            <tr>
                <td class="formlabel" align="left">
                    Charge Tax On Gift Wrapping
                </td>
                <td class="formfield" align="left">
                    <asp:CheckBox ID="chkChargeTaxOnGiftWrap" runat="server" />
                </td>
            </tr>
            --%>
            <tr>
                <td class="formfield">
                    <asp:CheckBox ID="chkChargeTaxOnNonShipping" runat="server" /> Charge Tax On Non-Shipping Items
                </td>
            </tr>
        </table>
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
	</div>
    
   
    <hr />
    
    <div><asp:ImageButton ID="btnAddTax" runat="server" ImageUrl="../../bvadmin/images/buttons/New.png"></asp:ImageButton></div>
 
    <br />
    
    <asp:DataGrid ID="dgTaxes" DataKeyField="bvin" CellPadding="0" BorderWidth="0px" CellSpacing="0" runat="server" AutoGenerateColumns="False" Width="100%" ShowHeader="False" AllowPaging="True" GridLines="none">
        
        <AlternatingItemStyle CssClass="alternaterow"></AlternatingItemStyle>
        <ItemStyle CssClass="row"></ItemStyle>
        <HeaderStyle CssClass="rowheader"></HeaderStyle>
        
        <Columns>
            <asp:TemplateColumn>
                <ItemTemplate>
                    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                        <tr>
                            <td>
                                Country:</td>
                            <td>
                                <asp:Label ID="CountryInfo" Text="" runat="server" /></td>
                        </tr>
                        <tr>
                            <td>
                                State/Region:</td>
                            <td>
                                <asp:Label ID="RegionInfo" Text="" runat="server" /></td>
                        </tr>
                        <tr>
                        <td>
                            County:</td>
                        <td>
                            <asp:Label ID="CountyInfo" Text="All" runat="server" /></td>
                        </tr>
                        <tr>
                            <td>
                                Postal/Zip Code:</td>
                            <td>
                                <asp:Label ID="PostalCodeInfo" Text="All" runat="server" /></td>
                        </tr>
                        <tr>
                            <td>
                                Applies to Type:</td>
                            <td>
                                <asp:Label ID="TaxTypeInfo" Text="All Taxable Items" runat="server" /></td>
                        </tr>
                        <tr>
                            <td>
                                Applies To Shipping:</td>
                            <td>
                                <asp:Label ID="AppliesToShippingLabel" Text="0.0" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Tax Rate:</td>
                            <td>
                                <asp:Label ID="RateInfo" Text="0.0" runat="server" />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:TemplateColumn>
            
            <asp:TemplateColumn>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"></ItemStyle>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Databinder.Eval(Container, "DataItem.Bvin", "Taxes_Edit.aspx?id={0}") %>'>
                        <asp:Image ImageUrl="../../bvadmin/images/buttons/edit.png" AlternateText="Edit"
                            runat="server" ID="EditButton"></asp:Image>
                    </asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateColumn>
            
            <asp:TemplateColumn>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"></ItemStyle>
                <ItemTemplate>
                    <asp:ImageButton ID="DeleteButton" runat="server" ImageUrl="../../bvadmin/images/buttons/Delete.png"
                        CommandName="Delete" Message="Are you sure you want to delete this tax?"></asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
        <PagerStyle HorizontalAlign="left" Position="Bottom" Mode="NumericPages"></PagerStyle>
        <pagerstyle CssClass="pager"></pagerstyle>
    </asp:DataGrid>
           
</asp:Content>
