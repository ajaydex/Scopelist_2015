<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="PriceGroups.aspx.vb" Inherits="BVAdmin_People_PriceGroups" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Price Groups</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <asp:GridView ID="PricingGroupsGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" GridLines="none" cellpadding="0">
        <Columns>
            <asp:TemplateField HeaderText="Name">
                <ItemTemplate>
                    <asp:TextBox ID="NameTextBox" runat="server"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Pricing Type">
                <ItemTemplate>
                    <asp:DropDownList ID="PricingTypeDropDownList" runat="server">
                        <asp:ListItem Text="Percentage Off List Price" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Amount Off List Price" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Percentage Above Cost" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Amount Above Cost" Value="3"></asp:ListItem>
                        <asp:ListItem Text="Percentage Off Site Price" Value="4"></asp:ListItem>
                        <asp:ListItem Text="Amount Off Site Price" Value="5"></asp:ListItem>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText = "Adjustment Amount">
                <ItemTemplate>
                    <asp:TextBox ID="AdjustmentAmountTextBox" runat="server"></asp:TextBox>                
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="DeleteImageButton" runat="server" AlternateText="Delete" CommandName="Delete" ImageUrl="~/BVAdmin/Images/Buttons/delete.png" />
                </ItemTemplate>
            </asp:TemplateField>            
        </Columns>
        <EmptyDataTemplate>
            There are currently no pricing groups.
        </EmptyDataTemplate>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
    <br />
    <table>
        <tr>
            <td>
                <asp:ImageButton ID="AddNewImageButton" ImageUrl="~/BVAdmin/Images/Buttons/New.png" runat="server" AlternateText="Add" />   
            </td>
        </tr>
    </table>
    <br /> 
    <asp:ImageButton ID="SaveImageButton" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" runat="server" AlternateText="Save" />
    <asp:ImageButton ID="CancelImageButton" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" runat="server" AlternateText="Cancel" />

</asp:Content>

