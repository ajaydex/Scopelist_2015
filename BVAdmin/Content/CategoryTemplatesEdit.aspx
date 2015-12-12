<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="CategoryTemplatesEdit.aspx.vb" Inherits="BVAdmin_Content_PrintTemplates" title="Untitled Page" %>

<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core" TagPrefix="cc1" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Category Templates Edit</h1>    
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <asp:Panel ID="CategoryEditorPanel" runat="server"></asp:Panel>                
</asp:Content>


