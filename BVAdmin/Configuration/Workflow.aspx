<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Workflow.aspx.vb" Inherits="BVAdmin_Configuration_Workflow" Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1 id="workflow">Workflows</h1>
    <uc1:MessageBox ID="msg" runat="server" />
    
    <div class="f-row">
		<div class="three columns">
        	<asp:Panel DefaultButton="btnNew" runat="server" ID="pnlMain">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="formlabel">Name:</td>
                        <td class="formfield">
                            <asp:TextBox ID="NewNameField" Width="150" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="formlabel">Type:</td>
                        <td class="formfield">
                            <asp:DropDownList ID="WorkflowTypeField" runat="server">
                                <asp:ListItem Value="2" Text="Order"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Product"></asp:ListItem>
                                <asp:ListItem Value="3" Text="Shipping"></asp:ListItem>
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td class="formlabel">&nbsp;</td>
                        <td class="formfield">
                            <asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New Workflow" ImageUrl="~/BVAdmin/Images/Buttons/New.png" /></td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        
        <div class="nine columns">
        	<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin"
                BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Workflow Name" />
                    <asp:TemplateField HeaderText="Type">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("WorkflowType") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="TypeField" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CheckBoxField DataField="SystemWorkflow" HeaderText="System Workflow" />
                    <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton OnClientClick="return window.confirm('Delete this workflow?');" ID="LinkButton1"
                                runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn-delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
        </div>
   	</div>
 
</asp:Content>
