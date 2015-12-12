<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Receipt.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_Receipt" %>
<%@ Register Src="~/BVModules/Controls/ViewOrder.ascx" TagName="ViewOrder" TagPrefix="uc" %>
<%@ Register src="~/BVModules/Controls/MessageBox.ascx" tagname="MessageBox" tagprefix="uc" %>
<%@ Register src="~/BVModules/Controls/AnalyticsTags.ascx" tagname="AnalyticsTags" tagprefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
    <div class="main">
		<div class="row">
			<div class="large-12 columns">

                <uc:MessageBox ID="MessageBox1" runat="server" />
                <h1>Thank You!</h1> 
    
                <asp:Label ID="lblOrderNumber" runat="server"></asp:Label>

                <asp:Panel ID="DownloadsPanel" runat="server" Visible="false">
                    <h2>File Downloads</h2>
                    <asp:GridView ID="FilesGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" GridLines="None" CssClass="dataTable">
                        <Columns>
                            <asp:BoundField DataField="ShortDescription" HeaderText="File Name" />
                            <asp:TemplateField ItemStyle-CssClass="text-right">
                                <ItemTemplate>
                                    <asp:ImageButton ID="DownloadImageButton" runat="server" AlternateText="Download" CommandName="Download" ImageUrl="~/BVModules/Themes/Print Book/images/Buttons/Download.png" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>

                <asp:HyperLink ID="lnkDownloadAgain" runat="Server" Visible="false" NavigateUrl="~/MyAccount_Orders.aspx" Text="You can download files at anytime from the My Account section of the store."></asp:HyperLink> 
    
                <uc:ViewOrder DisableReturns="true" ID="ViewOrder1" runat="server" DisableNotesAndPayment="true" DisableStatus="true" />
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ContentPlaceHolderID="EndOfForm" runat="server">
    <uc:AnalyticsTags ID="AnalyticsTags1" runat="server" />
</asp:Content>
