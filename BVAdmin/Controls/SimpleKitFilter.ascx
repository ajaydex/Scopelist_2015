<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SimpleKitFilter.ascx.vb" Inherits="BVAdmin_Controls_SimpleKitFilter" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<asp:Panel ID="Panel1" runat="server" DefaultButton="btnGo" class="controlarea1">
    <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td>
            	Filter: 
                <br />
                <asp:TextBox ID="FilterField" runat="server">
                </asp:TextBox> <asp:ImageButton ID="btnGo" runat="server" AlternateText="Filter Results" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" />
            </td>
            <td>                
                <anthem:DropDownList ID="ProductTypeFilter" runat="server" AutoCallBack="True" Width="230px"></anthem:DropDownList>
                <br />
                <anthem:DropDownList ID="CategoryFilter" runat="server" AutoCallBack="True" Width="230px"></anthem:DropDownList>
                <br />
                <anthem:DropDownList ID="ManufacturerFilter" runat="server" AutoCallBack="True" Width="230px"></anthem:DropDownList>
            </td>                   
            <td>
                <anthem:DropDownList ID="VendorFilter" runat="server" AutoCallBack="True" Width="230px"></anthem:DropDownList>
                <br />
                <anthem:DropDownList ID="StatusFilter" runat="server" AutoCallBack="True" Width="230px"></anthem:DropDownList>
                <br />
                <anthem:DropDownList ID="InventoryStatusFilter" runat="server" AutoCallBack="True" Width="230px"></anthem:DropDownList>
           	</td>                    
        </tr>
    </table>
</asp:Panel>