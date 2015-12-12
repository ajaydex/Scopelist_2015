<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminProduct.master" AutoEventWireup="false"
    CodeFile="ProductChoices.aspx.vb" Inherits="BVAdmin_Catalog_ProductChoices" Title="Product Choices" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <h1>Product Variations</h1>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
	<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSaveChanges">
		<table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
			<tr>
				<td colspan="2">
					<asp:ImageButton ID="btnCancel2" TabIndex="9006" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
					&nbsp;
					<asp:ImageButton ID="btnSave2" TabIndex="9005" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td>
					<asp:MultiView ID="ProductChoiceMultiView" runat="server" ActiveViewIndex="0">
						<asp:View ID="ProductChoiceListView" runat="server">
							<uc1:MessageBox ID="ChoicesMessageBox" runat="server" Visible="true" />
							<table border="0" cellspacing="0" cellpadding="0" style="width:500px;">
								<tr>
									<td>
										Add Shared Choice:
									</td>
									<td>
                                        <asp:DropDownList ID="SharedChoicesDropDownList" ValidationGroup="ValidateShared" runat="server"></asp:DropDownList>
                                        <asp:CustomValidator ID="SharedChoicesDropDownListRequiredvalidator" ErrorMessage="Please select a shared choice" ValidationGroup="ValidateShared" Display="Dynamic" runat="server"></asp:CustomValidator>
									</td>
									<td>
										<asp:ImageButton ID="AddSharedChoiceButton" runat="server" ValidationGroup="ValidateShared" AlternateText="Add New Product" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
									</td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr>
									<td style="height: 26px">
										Add New Choice:
									</td>
									<td>
										<asp:DropDownList ID="ChoiceTypes" runat="server"></asp:DropDownList>
									</td>
									<td>
										<asp:ImageButton ID="AddNewChoiceButton" runat="server" AlternateText="Add New Product" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
									</td>
								</tr>
							</table>
							<br /><br />
							<table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
								<tr>
									<td>
										<asp:GridView ID="ChoicesGridView" runat="server" AutoGenerateColumns="False" style="width:100%;" RowStyle-Height="40" GridLines="none">
											<Columns>
												<asp:BoundField HeaderText="Choice Name" DataField="Name" />
												<asp:TemplateField>
													<ItemTemplate>
														<asp:Panel ID="VariantsPanel" runat="server">
														</asp:Panel>
													</ItemTemplate>
												</asp:TemplateField>
												<asp:TemplateField HeaderText="Shared?">
													<EditItemTemplate>
														<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
													</EditItemTemplate>
													<ItemTemplate>
														<asp:Image ID="SharedImage" runat="server" ImageUrl="~/BVAdmin/Images/MessageIcons/OK.gif" />
													</ItemTemplate>
												</asp:TemplateField>                                                
												<asp:TemplateField ShowHeader="False">
													<ItemTemplate>
														<asp:ImageButton ID="EditImageButton" runat="server" CausesValidation="false" CommandName="Edit"
															ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" Text="Button" />
													</ItemTemplate>
												</asp:TemplateField>
												<asp:TemplateField ShowHeader="False">
													<ItemTemplate>
														<asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="false" CommandName="Delete"
															ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" Text="Button" />
													</ItemTemplate>
												</asp:TemplateField>
												<asp:TemplateField>
													<ItemTemplate>
														<asp:ImageButton ID="moveUpButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Up.png" CommandName="MoveItem" CommandArgument="Up" />
														<asp:ImageButton ID="moveDownButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Down.png" CommandName="MoveItem" CommandArgument="Down" />
													</ItemTemplate>
													<ItemStyle Width="20px" />
												</asp:TemplateField>
											</Columns>
											<RowStyle Height="40px" />
											<EmptyDataTemplate>
												There are no product choices to display.
											</EmptyDataTemplate>
											<RowStyle CssClass="row" />
											<HeaderStyle CssClass="rowheader" />
											<AlternatingRowStyle CssClass="alternaterow" />
										</asp:GridView>
									</td>
								</tr>
							</table>                            
						</asp:View>
						<asp:View ID="ProductChoiceCombinationsView" runat="server">
						
							<uc1:MessageBox ID="MessageBox1" runat="server" Visible="true" />
							
							<div>
								<asp:Button ID="SelectButton" runat="server" Text="Select All" UseSubmitBehavior="False" OnClientClick='return ToggleAllCheckBoxes("SelectedCheckBox", true)' />
								<asp:Button ID="DeselectButton" runat="server" OnClientClick='return ToggleAllCheckBoxes("SelectedCheckBox", false)' Text="Deselect All" />
							</div>
								
							<asp:GridView ID="ChoiceCombinationsGridView" runat="server" AutoGenerateColumns="False" AllowSorting="True" GridLines="none" style="width: 200px;" RowStyle-Height="40">
								<Columns>
									<asp:TemplateField HeaderText="Selected">
										<ItemTemplate>
											<asp:CheckBox ID="SelectedCheckBox" runat="server" />
										</ItemTemplate>
									</asp:TemplateField>                                  
								</Columns>
								<RowStyle CssClass="row" />
								<HeaderStyle CssClass="rowheader" />
								<AlternatingRowStyle CssClass="alternaterow" />
							</asp:GridView>
							
						</asp:View>
					</asp:MultiView>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
					<asp:ImageButton ID="btnCancelChanges" TabIndex="9006" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
					&nbsp;
					<asp:ImageButton ID="btnSaveChanges" TabIndex="9005" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
				</td>
			</tr>
		</table>
    </asp:Panel>
</asp:Content>
