<%@ Page EnableEventValidation="false" ValidateRequest="false" Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Columns_EditBlock.aspx.vb" Inherits="BVAdmin_Content_Columns_EditBlock" Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1><asp:Label ID="TitleLabel" runat="server" Text="Edit Content Block"></asp:Label></h1>
    <uc1:MessageBox ID="msg" runat="server" />
    <asp:PlaceHolder ID="phEditor" runat="server"></asp:PlaceHolder>
   
    <h2>Advanced Options</h2>
    <table border="0" cellspacing="0" cellpadding="2">
        <tr>
            <td class="formlabel">
                Copy To:</td>
            <td class="formfield">
                <asp:DropDownList ID="CopyToList" runat="server" Width="350px">
                </asp:DropDownList>
                <asp:ImageButton ID="btnGoCopy" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" /></td>
        </tr>
        <tr>
            <td class="formlabel">
                Move To:</td>
            <td class="formfield">
                <asp:DropDownList ID="MoveToList" runat="server" Width="350px">
                </asp:DropDownList>
                <asp:ImageButton ID="btnGoMove" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" /></td>
        </tr>
    </table>   
    
    <asp:HiddenField ID="BlockIDField" runat="server" />
</asp:Content>
