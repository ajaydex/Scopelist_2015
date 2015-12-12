<%@ Page MasterPageFile="~/BVAdmin/BVAdminProduct.master" ValidateRequest="False"
    Language="vb" AutoEventWireup="false" Inherits="products_products_edit_images"
    CodeFile="Products_Edit_Images.aspx.vb" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <h1>Additional Images</h1>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:MessageBox ID="msg" runat="server" />
	
    <asp:Panel ID="pnlMain" runat="server" Visible="True">
	
		<asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New Image" ImageUrl="~/BVAdmin/images/Buttons/New.png" />
		
		<br />
		<br />
		
		<asp:Panel ID="pnlEditor" runat="server" DefaultButton="btnSave" Visible="false" CssClass="controlarea1">
			<table border="0" cellspacing="0" cellpadding="0" style="width:738px;">
				<tr>
					<td colspan="2">
						<asp:Image ID="imgPreview" runat="server" ImageUrl="~/BVAdmin/images/NoPreview.gif" style="max-width:738px;max-height:500px;" />
						<br />
						<br />
						<a href="javascript:popUpWindow('../ImageBrowser.aspx?startdir=images/products&amp;returnScript=SetEditorImage&WebMode=1');">
							<asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="imgSelect1" />
						</a>
					</td>
				</tr>
				<tr>
					<td class="formlabel">
						File Name:
					</td>
					<td>
						<asp:TextBox ID="FileNameField" runat="server"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td class="formlabel">
						Caption:
					</td>
					<td class="formfield">
						<asp:TextBox ID="CaptionField" runat="server" TextMode="MultiLine"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td class="formlabel">
						Alternate Text:
					</td>
					<td class="formfield">
						<asp:TextBox ID="AlternateTextField" runat="server" TextMode="MultiLine"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td class="formlabel" colspan="2">
						<asp:ImageButton ID="btnCancel" runat="server" AlternateText="Cancel" CausesValidation="False"
							ImageUrl="~/BVAdmin/images/Buttons/Cancel.png" />&nbsp;
						<asp:ImageButton ID="btnSave" runat="server" AlternateText="Save Changes" ImageUrl="~/BVAdmin/images/Buttons/SaveChanges.png" />
						<asp:ImageButton ID="btnUpdate" runat="server" AlternateText="Update Changes" ImageUrl="~/BVAdmin/images/Buttons/Update.png" Visible="false" />
					</td>
				</tr>
			</table>
		</asp:Panel>
		
		
		
		<asp:GridView ID="GridView1" ShowHeader="true" runat="server" AutoGenerateColumns="False" CellSpacing="0" CellPadding="0" DataKeyNames="Bvin" GridLines="none">			
			<Columns>			
				<asp:TemplateField HeaderText="Image">
					<ItemStyle Width="120px" />
					<ItemTemplate>
						<asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("FileName", "~/{0}") %>' AlternateText='<%# Eval("AlternateText")%>' ToolTip='<%# Eval("AlternateText")%>' />
					</ItemTemplate>
				</asp:TemplateField>

                <asp:TemplateField HeaderText="Filename/Caption">
                    <ItemTemplate>
                        <asp:Label ID="lblFilename" runat="server" /><br />
                        <asp:Literal ID="litCaption" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
				
                <asp:ButtonField CommandName="Edit" ButtonType="Image" ImageUrl="~/BVAdmin/images/Buttons/Edit.png"  CausesValidation="false" />

                <asp:ButtonField CommandName="Delete" ButtonType="Image" ImageUrl="~/BVAdmin/images/Buttons/Delete.png" CausesValidation="false" />
				
				<asp:TemplateField>
					<ItemStyle Width="25px" />
					<ItemTemplate>
						<anthem:ImageButton ID="btnUp" runat="Server" CausesValidation="false" CommandName="Up" ImageUrl="~/BVAdmin/Images/Buttons/Up.png" AlternateText="Move Up" EnableCallBack="false" />
					</ItemTemplate>
				</asp:TemplateField>
				
				<asp:TemplateField>
					<ItemStyle Width="25px" />
					<ItemTemplate>                                
						<anthem:ImageButton ID="btnDown" runat="Server" CausesValidation="false" CommandName="Down" ImageUrl="~/BVAdmin/Images/Buttons/Down.png" AlternateText="Move Down" EnableCallBack="false" />
					</ItemTemplate>
				</asp:TemplateField>
				
			</Columns>
			
			<RowStyle CssClass="row" />
			<HeaderStyle CssClass="rowheader" />
			<AlternatingRowStyle CssClass="alternaterow" />			
		</asp:GridView>
		
		<asp:HiddenField ID="EditBvin" runat="server" />
               
    </asp:Panel>
    <asp:HiddenField ID="ProductIdField" runat="server" />
</asp:Content>
