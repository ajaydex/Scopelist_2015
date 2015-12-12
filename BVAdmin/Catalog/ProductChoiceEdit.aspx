<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="ProductChoiceEdit.aspx.vb" Inherits="BVAdmin_Catalog_ProductChoiceEdit" title="Edit Product Choice" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<%@ Register Src="~/BVAdmin/Controls/SharedChoiceProductList.ascx" TagName="SharedChoiceProductList" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Edit Product Variations</h1>
    
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    
    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td valign="top">
                <asp:Panel ID="EditPanel" runat="server" />
            </td>
            <td valign="top">
                <uc1:SharedChoiceProductList ID="SharedChoiceProductList" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>