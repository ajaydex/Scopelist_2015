<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="GiftCertificates.aspx.vb" Inherits="BVAdmin_Catalog_GiftCertificates" title="Gift Certificates" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Gift Certificates</h1>
    <div><asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New Gift Certificate" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
        </div>
    <div>
        <uc1:MessageBox ID="MessageBox1" runat="server" EnableViewState="false" />
        <h2>Gift Certificate Products</h2>
        <asp:GridView ID="GiftCertificatesGridView" runat="server" AutoGenerateColumns="False" GridLines="None" cellpadding="0">
            <Columns>
                <asp:BoundField DataField="ProductName" HeaderText="Name" />
                <asp:BoundField DataField="Sku" HeaderText="Sku" />
                <asp:TemplateField HeaderText="Active">             
                    <ItemTemplate>
                        <asp:CheckBox ID="chkActive" runat="server" Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="EditImageButton" CommandName="Edit" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="DeleteImageButton" CommandName="Delete" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="row" />
            <HeaderStyle CssClass="rowheader" />
            <AlternatingRowStyle CssClass="alternaterow" />
        </asp:GridView>
        <h2>Issued Gift Certificates</h2>
        <asp:GridView ID="IssuedGiftCertificatesGridView" runat="server" AutoGenerateColumns="False" GridLines="None" CellPadding="0" DataKeyNames="bvin" DataSourceID="ObjectDataSource1" AllowPaging="True">
    
    	    <pagersettings Mode="NextPreviousFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></pagersettings>
            <pagerstyle CssClass="pager"></pagerstyle>
    
            <RowStyle CssClass="row" />
            <HeaderStyle CssClass="rowheader" />
            <AlternatingRowStyle CssClass="alternaterow" />
            <Columns>
                <asp:BoundField DataField="CertificateCode" HeaderText="Certificate Code" />            
                <asp:HyperLinkField DataNavigateUrlFields="OrderBvin" DataNavigateUrlFormatString="~/BVAdmin/Orders/ViewOrder.aspx?id={0}"
                        DataTextField="OrderNumber" HeaderText="Order Number">                    
                </asp:HyperLinkField>            
                <asp:BoundField DataField="DateIssued" DataFormatString="{0:d}" HeaderText="Date Issued"
                    HtmlEncode="False" />
                <asp:BoundField DataField="OriginalAmount" DataFormatString="{0:c}" HtmlEncode="False" HeaderText="Issued Amount" />
                <asp:BoundField DataField="CurrentAmount" DataFormatString="{0:c}" HtmlEncode="False" HeaderText="Current Amount" />
                <asp:BoundField DataField="IsValid" HeaderText="Valid" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="EditImageButton" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" CommandName="Edit" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>                        
            </Columns>
            <PagerSettings Position="TopAndBottom" />
        </asp:GridView>
        <uc1:MessageBox ID="MessageBox2" runat="server" EnableViewState="false" />
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="True" OldValuesParameterFormatString="original_{0}"
            SelectCountMethod="GetRowCount" SelectMethod="FindAll" TypeName="BVSoftware.Bvc5.Core.Catalog.GiftCertificate">
            <SelectParameters>            
                <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>

