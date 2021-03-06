<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Users_Edit_Address.aspx.vb" Inherits="BVAdmin_People_users_edit_address"
    Title="Untitled Page" %>

<%@ Register Src="../Controls/AddressEditor.ascx" TagName="AddressEditor" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>
        Edit User Address</h1>
    <asp:Panel Style="margin: 10px 10px 20px 10px;" ID="pnlMain" runat="server" DefaultButton="btnSave">
        <div style="margin: 0px 0px 10px 38px;">
            <uc1:AddressEditor ID="AddressEditor1" runat="server" />
        </div>
        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png"
            CausesValidation="False"></asp:ImageButton>&nbsp;<asp:ImageButton ID="btnSave" runat="server"
                ImageUrl="../images/buttons/SaveChanges.png" CausesValidation="False"></asp:ImageButton>
    </asp:Panel>
    <asp:HiddenField ID="UserIDField" runat="server" />
</asp:Content>
