<%@ Control Language="VB" AutoEventWireup="false" Inherits="BVAdmin_Controls_ProductReviewEditor"
    CodeFile="ProductReviewEditor.ascx.vb" %>
<table border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="formlabel">
			Product:</td>
		<td class="formfield">
			<asp:Label ID="lblProductName" runat="server" CssClass="BVSmallText">Product Name</asp:Label></td>
	</tr>
	<tr>
		<td class="formlabel">
			User:</td>
		<td class="formfield">
			<asp:TextBox ID="txtUserName" runat="server">User name</asp:TextBox></td>
	</tr>
    <tr>
		<td class="formlabel">
			Email:</td>
		<td class="formfield">
			<asp:TextBox ID="txtEmail" runat="server">Email</asp:TextBox></td>
	</tr>
	<tr>
		<td class="formlabel">
			Review Date:</td>
		<td class="formfield">
			<asp:Label ID="lblReviewDate" runat="server" CssClass="BVSmallText">01/01/2004</asp:Label></td>
	</tr>
	<tr>
		<td class="formlabel">
			Rating:</td>
		<td class="formfield">
			<asp:DropDownList ID="lstRating" runat="server">
				<asp:ListItem Value="5">5 Stars</asp:ListItem>
				<asp:ListItem Value="4">4 Stars</asp:ListItem>
				<asp:ListItem Value="3">3 Stars</asp:ListItem>
				<asp:ListItem Value="2">2 Stars</asp:ListItem>
				<asp:ListItem Value="1">1 Stars</asp:ListItem>
			</asp:DropDownList></td>
	</tr>
	<tr>
		<td class="formlabel">
			Karma Score:</td>
		<td class="formfield">
			<asp:TextBox ID="KarmaField" runat="server" CssClass="FormInput" Columns="5">0</asp:TextBox></td>
	</tr>
	<tr>
		<td class="formlabel">
			Approved:</td>
		<td class="formfield">
			<asp:CheckBox ID="chkApproved" runat="server"></asp:CheckBox></td>
	</tr>
	<tr>
		<td class="formlabel">
			Review:</td>
		<td class="formfield">
			<asp:TextBox ID="DescriptionField" runat="server" CssClass="FormInput" Columns="60"
				MaxLength="6000" Rows="6" TextMode="MultiLine"></asp:TextBox></td>
	</tr>
</table>
    
<br /><br />
<asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/cancel.png" AlternateText="Cancel" CausesValidation="False"></asp:ImageButton>
&nbsp;
<asp:ImageButton ID="btnOK" runat="server" ImageUrl="../images/buttons/savechanges.png" AlternateText="Save"></asp:ImageButton>
  
