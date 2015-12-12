<%@ Page ValidateRequest="false" Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="StoreClosed.aspx.vb" Inherits="BVAdmin_Content_StoreClosed" title="Untitled Page" %>

<%@ Register Src="../Controls/HtmlEditor.ascx" TagName="HtmlEditor" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
	<h1>Store Closed Page Content</h1>
    <asp:Panel ID="pnlMain" runat="server" >
        
        <uc1:HtmlEditor ID="ContentField" runat="server" EditorHeight="300" />
        <br /><br />
        <asp:ImageButton ID="btnCancel" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False" />
        &nbsp;
        <asp:ImageButton ID="btnSaveChanges" TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png" />
    </asp:Panel>
</asp:Content>



