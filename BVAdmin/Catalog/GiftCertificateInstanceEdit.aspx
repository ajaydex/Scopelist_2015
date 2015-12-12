<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="GiftCertificateInstanceEdit.aspx.vb" Inherits="BVAdmin_Catalog_GiftCertificateInstanceEdit" title="Edit Gift Certificate" %>

<%@ Register Src="../Controls/DateModifierField.ascx" TagName="DateModifierField"
    TagPrefix="uc1" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<h1>Gift Certificate</h1>
<div><uc2:MessageBox ID="MessageBox1" runat="server" EnableViewState="false" /></div>
<table>
    <tr>
        <td>Issued Date:</td>
        <td>
            <uc1:DateModifierField ID="IssueDateModifierField" runat="server" />
        </td>
    </tr>
</table>    
<div><asp:ImageButton ID="SaveChangesImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /><asp:ImageButton
           ID="CancelImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></div>
<div><uc2:MessageBox ID="MessageBox2" runat="server" EnableViewState="false" /></div>
</asp:Content>

