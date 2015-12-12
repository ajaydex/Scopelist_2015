<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="MyAccount_Orders_Details.aspx.vb" Inherits="MyAccount_Orders_Details" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc1" %>
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc3" %>
<%@ Register Src="BVModules/Controls/ViewOrder.ascx" TagName="ViewOrder" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <h2>
        <span>Order History Details</span></h2>
    <uc3:MessageBox ID="MessageBox1" runat="server" />
    <uc2:ViewOrder ID="ViewOrder1" runat="server" />
    <asp:Panel ID="DownloadsPanel" runat="server" Visible="false">
        <h2>
            Downloads</h2>
        <asp:GridView ID="FilesGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin">
            <Columns>
                <asp:BoundField DataField="ShortDescription" HeaderText="File Name" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="DownloadImageButton" runat="server" AlternateText="Download"
                            CommandName="Download" ImageUrl="~/BVModules/Themes/Print Book/images/Buttons/Download.png" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
    </asp:Panel>
    <asp:ImageButton CssClass="float-r" ID="BackButton" runat="server" ImageUrl="~/BVModules/Themes/OpticAuthority/Images/Previous.png"
        AlternateText="Order History"></asp:ImageButton>
</asp:Content>
