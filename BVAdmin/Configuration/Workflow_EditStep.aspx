<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Workflow_EditStep.aspx.vb" Inherits="BVAdmin_Configuration_Workflow_EditStep" title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
 <h1>
        <asp:Label ID="TitleLabel" runat="server" Text="Edit Workflow Step"></asp:Label></h1>
    <uc1:MessageBox ID="msg" runat="server" />
    <div style="text-align: center; margin: auto;">
        <asp:PlaceHolder ID="phEditor" runat="server"></asp:PlaceHolder>        
    </div>
    <asp:HiddenField ID="BlockIDField" runat="server" />
</asp:Content>

