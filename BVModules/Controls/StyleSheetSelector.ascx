<%@ Control Language="vb" AutoEventWireup="false" Inherits="BVModules_Controls_StyleSheetSelector" CodeFile="StyleSheetSelector.ascx.vb" %>

<%--<asp:datagrid id="StyleGrid" AutoGenerateColumns="False" ShowHeader="False" CellPadding="3" runat="server">
	<AlternatingItemStyle CssClass="AlternateItem"></AlternatingItemStyle>
	<ItemStyle CssClass="Item"></ItemStyle>
	<HeaderStyle CssClass="Header"></HeaderStyle>
	<Columns>
		<asp:TemplateColumn>
			<ItemTemplate>
				<asp:ImageButton ID="SelectButton" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Select.png" CommandName="Update"
					CausesValidation="false"></asp:ImageButton>
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:BoundColumn DataField="StyleName"></asp:BoundColumn>
		<asp:HyperLinkColumn Visible="False" Text="Preview" Target="_blank" DataNavigateUrlField="FileName" DataNavigateUrlFormatString="../default.aspx?css={0}"></asp:HyperLinkColumn>
		<asp:BoundColumn Visible="False" DataField="FileName"></asp:BoundColumn>
	</Columns>
</asp:datagrid>
--%>

<h1>Themes</h1>
        <table border="0" cellspacing="0" cellpadding="3">
        <tr>
            <td class="formlabel">Current Theme:</td>
            <td class="formfield">
                <asp:DropDownList ID="ThemeField" runat="server" AutoPostBack="True">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="formlabel">
                Preview:</td>
            <td class="formfield">
                <asp:Image ID="PreviewImage" runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel">
                <asp:ImageButton ID="btnCancel" runat="server" ToolTip="Cancel" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Cancel.png"
                CausesValidation="False"></asp:ImageButton></td>
            <td class="formfield"><asp:ImageButton ID="btnSave" CausesValidation="true" ToolTip="Save Changes"
                runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/SaveChanges.png"></asp:ImageButton></td>
            </tr>
        </table>