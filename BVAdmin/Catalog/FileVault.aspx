<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="FileVault.aspx.vb" Inherits="BVAdmin_Catalog_FileVault" title="File Vault" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/FilePicker.ascx" TagName="FilePicker" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
	<h1>File Vault</h1>
    <uc2:MessageBox ID="MessageBox1" runat="server" />
    
    <p><asp:LinkButton ID="ImportLinkButton" runat="server" CausesValidation="False">Import Files Already In "Files" Folder</asp:LinkButton></p>
    
    <asp:GridView ID="FileGridView" runat="server" AutoGenerateColumns="False" BorderColor="#CCCCCC"
        CellPadding="0" DataKeyNames="FileId" GridLines="None" Width="100%" DataSourceID="ObjectDataSource1" AllowPaging="True">
        
        <pagersettings Mode="NextPreviousFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></pagersettings>
        <pagerstyle CssClass="pager"></pagerstyle>
        
        <Columns>
            <asp:BoundField HeaderText="Name" DataField="FileName"/>
            <asp:BoundField HeaderText="Description" DataField="ShortDescription"/>
            <asp:BoundField HeaderText="Product Count" DataField="ProductCount" />            
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="EditImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" CommandName="Edit" CausesValidation="false" />
                </ItemTemplate>
                <ItemStyle Width="40px" />
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="DeleteImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" CommandName="Delete" CausesValidation="false" />
                </ItemTemplate>
                <ItemStyle Width="40px" />
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
        <PagerSettings Position="TopAndBottom" />
    </asp:GridView>
    
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllFilesInVault" TypeName="BVSoftware.Bvc5.Core.Catalog.ProductFile" EnablePaging="True" SelectCountMethod="GetRowCount">
        <SelectParameters>
            <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <div style="margin-top: 20px;" class="controlarea1"> 
        <uc1:FilePicker ID="FilePicker" runat="server" />
        <br />
        <asp:ImageButton ID="AddNewImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/AddFile.png" />        
    </div>
</asp:Content>