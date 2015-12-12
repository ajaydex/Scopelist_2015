<%@ Page MasterPageFile="~/BVAdmin/BVAdminProduct.Master" Language="vb" AutoEventWireup="false" Inherits="products_edit_categories" CodeFile="Products_Edit_Categories.aspx.vb" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/CategoryTreeView.ascx" TagName="CategoryTreeView" TagPrefix="uc" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <h1>Categories - <asp:Label ID="lblProductName" runat="server" /></h1>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<uc2:MessageBox ID="msg" runat="server" />
	<uc2:MessageBox ID="WebPageMessage1" runat="server" />              
	
	<uc:CategoryTreeView ID="ucCategoryTreeView" runat="server" />
	
	<br /><br />
	<asp:ImageButton ID="CancelButton" runat="server" ImageUrl="../images/buttons/Cancel.png"></asp:ImageButton>
	<asp:ImageButton ID="SaveButton" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>

</asp:Content>
