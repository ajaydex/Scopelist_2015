<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="MyAccount_Orders_Details.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_MyAccount_Orders_Details" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ViewOrder.ascx" TagName="ViewOrder" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
	<h2>Order Details</h2>
	<uc:MessageBox ID="MessageBox1" runat="server" />

	<uc:ViewOrder ID="ViewOrder1" runat="server" />
	
    <asp:Panel ID="DownloadsPanel" runat="server" Visible="false">
        <h2>File Downloads</h2>
        <asp:GridView ID="FilesGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin">
            <Columns>
                <asp:BoundField DataField="ShortDescription" HeaderText="File Name" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="DownloadImageButton" runat="server" AlternateText="Download" CommandName="Download" ImageUrl="~/BVModules/Themes/Print Book/images/Buttons/Download.png" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
    </asp:Panel>
	
	<asp:imagebutton id="BackButton" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/OrderHistory.png" AlternateText="Order History"></asp:imagebutton>

</asp:Content>
