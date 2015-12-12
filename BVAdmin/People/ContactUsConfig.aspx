<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="ContactUsConfig.aspx.vb" Inherits="BVAdmin_People_ContactUsConfig"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Contact Us Config</h1>
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="formlabel">
                Enable Contact Form
                
            </td>
            <td class="formfield">
            	<asp:CheckBox ID="chkContactForm" runat="server" />
            </td>
       	</td>
  	</table>
	
    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
	&nbsp;
    <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
    
    <br />
    <br />
    <h2>Questions</h2>
    <asp:ImageButton ID="NewImageButton" AlternateText="New" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
    <br />
    <br />
    <asp:GridView ID="QuestionsGridView" runat="server" AutoGenerateColumns="False" GridLines="none" CellPadding="5" DataKeyNames="bvin">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="Type" HeaderText="Type" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton AlternateText="Edit" CommandName="Edit" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png">
                    </asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton AlternateText="Delete" CommandName="Delete" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png">
                    </asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="moveUpButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Up.png" CommandName="MoveItem" CommandArgument="Up"/>
                    <asp:ImageButton ID="moveDownButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Down.png" CommandName="MoveItem" CommandArgument="Down" />
                </ItemTemplate>
                <ItemStyle Width="20px" />
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
</asp:Content>
