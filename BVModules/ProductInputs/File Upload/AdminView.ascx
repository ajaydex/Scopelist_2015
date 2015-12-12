<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AdminView.ascx.vb" Inherits="BVModules_ProductInputs_File_Upload_AdminView" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<table>
    <tr>
        <td><asp:Label ID="InputLabel" runat="server" Text="Label"></asp:Label></td>
        <td class="choicefield"><asp:FileUpload ID="InputFileUpload" runat="server" Rows="1"></asp:FileUpload></td>
        <td class="choiceerror"><bvc5:BVRequiredFieldValidator ID="InputRequiredFieldValidator" ControlToValidate="InputFileUpload" Enabled="false" ErrorMessage="Field Required" runat="server">*</bvc5:BVRequiredFieldValidator></td>
    </tr>
</table>