<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_Feeds_Google_Sitemap_Edit" %>

<tr>
    <td class="formlabel">Additional URLs filename</td>
    <td class="formfield">
        <asp:Label ID="lblAdditionalUrlsPath" runat="server" /><asp:TextBox ID="txtAdditionalUrlsFilename" Width="250" runat="server" />
    </td>
</tr>
<tr>
    <td class="formlabel">Default Priority</td>
    <td class="formfield">
        <asp:DropDownList ID="ddlDefaultPriority" runat="server">
            <asp:ListItem>1.0</asp:ListItem>
            <asp:ListItem>0.9</asp:ListItem>
            <asp:ListItem>0.8</asp:ListItem>
            <asp:ListItem>0.7</asp:ListItem>
            <asp:ListItem>0.6</asp:ListItem>
            <asp:ListItem>0.5</asp:ListItem>
            <asp:ListItem>0.4</asp:ListItem>
            <asp:ListItem>0.3</asp:ListItem>
            <asp:ListItem>0.2</asp:ListItem>
            <asp:ListItem>0.1</asp:ListItem>
        </asp:DropDownList>
    </td>
</tr>
<tr>
    <td class="formlabel">Default Change Frequency</td>
    <td class="formfield">
        <asp:DropDownList ID="ddlDefaultChangeFrequency" runat="server">
            <asp:ListItem>always</asp:ListItem>
            <asp:ListItem>hourly</asp:ListItem>
            <asp:ListItem>daily</asp:ListItem>
            <asp:ListItem>weekly</asp:ListItem>
            <asp:ListItem>monthly</asp:ListItem>
            <asp:ListItem>yearly</asp:ListItem>
            <asp:ListItem>never</asp:ListItem>
        </asp:DropDownList>
    </td>
</tr>
<tr>
    <td class="formlabel">Include Product Images</td>
    <td class="formfield">
        <asp:CheckBox ID="chkIncludeProductImages" runat="server" />
    </td>
</tr>
<tr>
    <td class="formlabel">Ping Search Engines</td>
    <td class="formfield">
        <asp:CheckBox ID="chkPingSearchEngines" runat="server" />
    </td>
</tr>