<%@ Page MasterPageFile="~/BVAdmin/BVAdmin.Master" Language="vb" AutoEventWireup="false"
    Inherits="Products_ProductTypes" CodeFile="ProductTypes.aspx.vb" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Product Types</h1>
    
    <uc1:MessageBox ID="msg" runat="server" />
    
    <asp:ImageButton ID="btnNew" runat="server" CausesValidation="False" ImageUrl="~/BVAdmin/images/buttons/New.png"></asp:ImageButton>
    <br />
    <br />
    
    <asp:DataGrid ID="dgList" cellpadding="0" BorderWidth="0px" CellSpacing="0"
        AutoGenerateColumns="False" DataKeyField="bvin" runat="server" GridLines="none">
        <Columns>
            <asp:BoundColumn DataField="ProductTypeName" HeaderText="Product Type"></asp:BoundColumn>
            <asp:TemplateColumn>
                <ItemTemplate>
                    <asp:ImageButton runat="server" ID="EditButton" ImageUrl="~/BVAdmin/images/buttons/Edit.png"
                        AlternateText="Edit" CommandName="Edit"></asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"></ItemStyle>
                <ItemTemplate>
                    <asp:ImageButton ID="DeleteImageButton" runat="server" CommandName="Delete" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    
        <HeaderStyle CssClass="rowheader"/>
        <ItemStyle CssClass="row" />
    </asp:DataGrid>
              
</asp:Content>
