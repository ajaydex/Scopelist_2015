<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Design.aspx.vb" Inherits="BVAdmin_Configuration_Design" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
	<h1>Site Display Settings</h1>        
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
       <asp:CheckBox ID="MessageBoxErrorTestModeCheckBox" runat="server" /> Put Message Boxes In Error Test Mode (adds fake errors to all message boxes)
       <br /><br />
       <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
   	</asp:Panel>
</asp:Content>

