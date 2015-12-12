<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_Feeds_Commission_Junction_Edit" %>

<tr>
    <td class="formlabel">CID</td>
    <td class="formfield">
        <asp:TextBox ID="txtCID" Width="250" runat="server" />
    </td>
</tr>
<tr>
    <td class="formlabel">SUBID</td>
    <td class="formfield">
        <asp:TextBox ID="txtSUBID" Width="250" runat="server" />
    </td>
</tr>
<tr>
    <td class="formlabel">AID</td>
    <td class="formfield">
        <asp:TextBox ID="txtAID" Width="250" runat="server" />
    </td>
</tr>
<tr>
    <td class="formlabel">Promotional Text</td>
    <td class="formfield">
        <asp:TextBox ID="txtPromotionalText" TextMode="MultiLine" Rows="3" Width="250" MaxLength="300" runat="server" />
    </td>
</tr>