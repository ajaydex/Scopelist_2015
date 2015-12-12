<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Default.aspx.vb" Inherits="BVAdmin_Catalog_Discounts" Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Offers</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />    
   
	<h2>Create New</h2>

	<asp:DropDownList ID="OfferTypeDropDownList" runat="server"></asp:DropDownList>

	<asp:ImageButton ID="NewOfferImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
          
    <h2>Current Offers</h2>
    
	<asp:GridView ID="OffersGridView" runat="server" AutoGenerateColumns="False" GridLines="none" cellpadding="0" width="100%">
		<EmptyDataTemplate>
			There are no offers to display</EmptyDataTemplate>
		<RowStyle CssClass="row" />
		<HeaderStyle CssClass="rowheader" />
		<AlternatingRowStyle CssClass="alternaterow" />
		<Columns>
			<asp:TemplateField HeaderText="Status">
				<ItemTemplate>
					<asp:Image ID="StatusImage" runat="server"></asp:Image>
				</ItemTemplate>
			</asp:TemplateField>
			<asp:BoundField DataField="Name" HeaderText="Name" />
			<asp:BoundField HeaderText="Type" DataField="OfferType" />
			<asp:BoundField DataField="StartDate" DataFormatString="{0:d}" HeaderText="Start Date"
				HtmlEncode="False" />
			<asp:BoundField DataField="EndDate" DataFormatString="{0:d}" HeaderText="End Date"
				HtmlEncode="False" />
			<asp:TemplateField ShowHeader="False">
				<ItemTemplate>
					<asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="false" CommandName="Edit"
						AlternateText="Edit" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" />
				</ItemTemplate>
			</asp:TemplateField>
			<asp:TemplateField ShowHeader="False">
				<ItemTemplate>
					<asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="false" CommandName="Delete"
						AlternateText="Delete" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" />
				</ItemTemplate>
			</asp:TemplateField>
			<asp:TemplateField>
				<ItemTemplate>
					<asp:ImageButton ID="EnableImageButton" runat="server" CausesValidation="false" CommandName="Enable"
						AlternateText="Enable" ImageUrl="~/BVAdmin/Images/Buttons/Enable.png" />
					<asp:ImageButton ID="DisableImageButton" runat="server" CausesValidation="false"
						CommandName="Disable" AlternateText="Disable" ImageUrl="~/BVAdmin/Images/Buttons/Disable.png" />
				</ItemTemplate>
			</asp:TemplateField>
			<asp:TemplateField>
				<ItemTemplate>
					<div>
						<asp:ImageButton ID="MoveUpImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Up.png"
							AlternateText="Move Up" CommandName="MoveUp" /></div>
					<div>
						<asp:ImageButton ID="MoveDownImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Down.png"
							AlternateText="Move Down" CommandName="MoveDown" /></div>
				</ItemTemplate>
			</asp:TemplateField>
		</Columns>
	</asp:GridView>
                
    <uc1:MessageBox ID="MessageBox2" runat="server" />    
</asp:Content>
