<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminProduct.master" AutoEventWireup="false"
    CodeFile="FileDownloads.aspx.vb" Inherits="BVAdmin_Catalog_FileDownloads" Title="File Downloads" %>

<%@ Register Src="../Controls/FilePicker.ascx" TagName="FilePicker" TagPrefix="uc2" %>

<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core" TagPrefix="cc1" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <h1>File Downloads</h1>
    
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">            
	<uc1:MessageBox ID="MessageBox1" runat="server" />   
    <uc2:FilePicker ID="FilePicker1" runat="server" />
	
	<br />
	
    <asp:ImageButton ID="AddFileButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/AddFile.png" />
	
	<br />
	<br />
	<br />
	
    <asp:GridView ID="FileGrid" runat="server" AutoGenerateColumns="False" GridLines="none" Borderwidth="0px" style="width:100%;" RowStyle-Height="40">
        <Columns>
            <asp:BoundField DataField="ShortDescription" />
            <asp:ButtonField ButtonType="Image" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png"
                Text="Button" CommandName="Delete" />
            <asp:ButtonField ButtonType="Image" ImageUrl="~/BVAdmin/Images/Buttons/Download.png"
                Text="Button" CommandName="Download"  />
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
</asp:Content>
