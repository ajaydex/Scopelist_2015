<%@ Page MasterPageFile="~/BVAdmin/BVAdmin.Master" Language="vb" AutoEventWireup="false" Inherits="Kit_Edit_Categories" CodeFile="Kit_Edit_Categories.aspx.vb" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Categories - <asp:Label ID="lblProductName" runat="server" /></h1>
    <uc2:MessageBox ID="msg" runat="server" />
    <uc2:MessageBox ID="WebPageMessage1" runat="server" />              
               
    <asp:CheckBoxList ID="chkCategories" runat="server"></asp:CheckBoxList>

    <br />
    <br />
    
    <asp:ImageButton ID="CancelButton" runat="server" ImageUrl="../images/buttons/Cancel.png"></asp:ImageButton>
    &nbsp;
    <asp:ImageButton ID="SaveButton" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
</asp:Content>
