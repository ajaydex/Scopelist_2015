<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="ProductSharedChoices.aspx.vb" Inherits="BVAdmin_Catalog_ProductSharedChoices" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Shared Choices</h1>
    
    <asp:DropDownList ID="SharedChoiceTypes" runat="server"></asp:DropDownList>
    <asp:ImageButton ID="NewSharedChoiceImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
    <br /><br />
    
    <asp:GridView ID="SharedChoicesAndInputsGridView" runat="server" AutoGenerateColumns="False" GridLines="none" CellPadding="0">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="Type" HeaderText="Type" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="EditImageButton" runat="server" OnClientClick="return window.confirm('Editing this shared choice will affect ALL products that are \nassociated with this shared choice. Are you sure you want to continue?');"
                        ImageUrl="../Images/Buttons/Edit.png" CommandName="Edit" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="DeleteImageButton" runat="server" OnClientClick="return window.confirm('Deleting this shared choice will affect ALL products that are \nassociated with this shared choice and will result in loss of inventory for \nthose products. Are you sure you want to continue?');"
                        ImageUrl="../Images/Buttons/Delete.png" CommandName="Delete" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
</asp:Content>