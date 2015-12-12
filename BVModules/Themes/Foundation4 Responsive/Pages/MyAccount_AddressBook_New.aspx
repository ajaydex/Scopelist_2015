<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" Language="vb" AutoEventWireup="false" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_myaccount_AddressBook_New" CodeFile="MyAccount_AddressBook_New.aspx.vb" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="~/BVModules/Controls/StoreAddressEditor.ascx" TagName="AddressControl" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ContentPlaceHolderID="MainContentHolder" runat="server">
    <h1>Add New Address</h1>
    <uc:MessageBox ID="msg" runat="server" />
    <fieldset>
        <uc:AddressControl id="AddressControl1" runat="server"></uc:AddressControl>
        <asp:ImageButton ID="SaveButton" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/SaveChanges.png"  TabIndex="1200"></asp:ImageButton>
    </fieldset>

    <asp:ImageButton ID="CancelButton" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Cancel.png" CausesValidation="False" TabIndex="1300"></asp:ImageButton> 

    <asp:HiddenField ID="hfUserBvin" runat="server" />
</asp:Content>
