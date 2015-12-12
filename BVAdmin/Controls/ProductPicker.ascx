<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ProductPicker.ascx.vb" Inherits="BVAdmin_Controls_ProductPicker" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<div id="productpicker">
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnGo">
        <div class="controlarea1">
            <div style="padding:5px;">
                <h6>Product Filter</h6>
                
                <asp:TextBox ID="FilterField" runat="server" Width="210px" ></asp:TextBox>
                
                <asp:DropDownList ID="ManufacturerFilter" runat="server" Width="280px" AutoPostBack="True">
                    <asp:ListItem Text="- Any Manufacturer -"></asp:ListItem>
                </asp:DropDownList>
                
                <asp:DropDownList ID="VendorFilter" runat="server" Width="280px" AutoPostBack="True">
                    <asp:ListItem Text="- Any Vendor -"></asp:ListItem>
                </asp:DropDownList>
                
                <asp:DropDownList ID="CategoryFilter" runat="server" Width="280px" AutoPostBack="True">
                    <asp:ListItem Text="- Any Category -"></asp:ListItem>
                </asp:DropDownList>
                
                <asp:ImageButton ID="btnGo" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" CausesValidation="False" /><br />
            </div>
       </div>    
    </asp:Panel> 
   
    <div style="height: 30px;">
       <div style="float: right;">
            Items per page:
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True">
                <asp:ListItem>5</asp:ListItem>
                <asp:ListItem Selected="True" Value="10"></asp:ListItem>
                <asp:ListItem>25</asp:ListItem>
                <asp:ListItem>50</asp:ListItem>
            </asp:DropDownList>
       </div>     
    </div>
    
    <anthem:GridView CellPadding="2" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" Width="100%" GridLines="none" AllowPaging="True" DataSourceID="ObjectDataSource1" >
        
        <pagersettings Mode="NextPreviousFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></pagersettings>
        <pagerstyle CssClass="pager"></pagerstyle>
        
        <Columns>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox ID="chkSelectAll" CssClass="selectAll" runat="server" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelected" runat="server" />
                    <asp:Literal ID="radioButtonLiteral" runat="server"></asp:Literal>                
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="sku" HeaderText="SKU" />
            <asp:BoundField DataField="ProductName" HeaderText="Name" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label Id="PriceLabel" runat="server" Text="" EnableViewState="false"></asp:Label>    
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label Id="InventoryLabel" runat="server" Text="" EnableViewState="false"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
        <PagerSettings Position="TopAndBottom" />
    </anthem:GridView> 
       
	<asp:HiddenField ID="ExcludeCategoryBvinField" runat="server" /> 
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="FindByCriteria" TypeName="BVSoftware.Bvc5.Core.Catalog.Product" EnablePaging="True" SelectCountMethod="GetRowCount">
        <SelectParameters>
            <asp:Parameter Name="criteria" Type="Object" />
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</div>