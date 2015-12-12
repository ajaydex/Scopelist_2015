<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Default.aspx.vb" Inherits="BVAdmin_Content_Default" Title="Untitled Page" %>

<%@ Register Src="../Controls/ContentColumnEditor.ascx" TagName="ContentColumnEditor" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Home Page</h1>
	<div class="f-row">
		<div class="twelve columns">
			<uc1:ContentColumnEditor ID="ContentColumnEditor1" runat="server" ColumnId="1" />
            <hr />
		</div>
        
		<div class="twelve columns">
			<uc1:ContentColumnEditor ID="ContentColumnEditor2" runat="server" ColumnId="2" />
            <hr />
		</div>
        
		<div class="twelve columns">
			<uc1:ContentColumnEditor ID="ContentColumnEditor3" runat="server" ColumnId="3" /> 
		</div>
	</div>
</asp:Content>
