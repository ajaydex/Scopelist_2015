<%@ Page Title="" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="GetProductInfo.aspx.vb" Inherits="GetProductInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <asp:Label runat="server" ID="ltlJson" CssClass="quantity" />
    <br />
    <br />
    <table>
        <tr>
            <td>
                Enter SKU of Product:
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtSKU" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Button Text="Check Inventory" runat="server" ID="btnSubmit" />
                <asp:Button Text="Clear Form" runat="server" ID="btnClearForm" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="EndOfForm" runat="Server">
</asp:Content>
