<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminPopup.master" AutoEventWireup="false"
    CodeFile="FileDownloadBrowser.aspx.vb" Inherits="BVAdmin_Catalog_FileDownloadBrowser"
    Title="File Downloads" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BvcAdminPopupConent" runat="Server">
    <asp:GridView ID="FileGridView" runat="server" AutoGenerateColumns="False" GridLines="none" BorderWidth="0px">
        <Columns>
            <asp:BoundField DataField="CombinedDisplay" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <a runat="server" id="lnkChoose">
                        <asp:Image runat="Server" ID="imgChooseThis" ImageUrl="~/BVAdmin/Images/Buttons/Select.png" /></a>                    
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
</asp:Content>
