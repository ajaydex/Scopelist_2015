<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Roles.aspx.vb" Inherits="BVAdmin_People_Roles" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>
        Groups</h1>
    <div style="text-align: right; margin-top: 3px; margin-bottom: 3px;">
        <asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New Group" ImageUrl="~/BVAdmin/Images/Buttons/New.png" /></div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin"
        BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%">
        <Columns>
            <asp:BoundField DataField="RoleName" HeaderText="Role Name" />
            <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton OnClientClick="return window.confirm('Delete this Group?');" ID="LinkButton1"
                        runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn-delete"></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle Width="100px" />
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
</asp:Content>
