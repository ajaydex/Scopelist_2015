<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_RSS_Feed_Viewer_editor" %>


<asp:Panel id="pnlEditor" runat="server" DefaultButton="btnSave">
    <div style="margin-bottom:30px;height:50px;width:650px;background-image: url('../../BVModules/ContentBlocks/Rss Feed Viewer/Images/AdminBg.png');">
        <div style="padding:13px 10px 0px 60px;color:#fff;">
            Feed Url: 
            <asp:TextBox ID="FeedField" runat="server" Columns="80"></asp:TextBox>
        </div>
    </div>
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="formlabel wide">Show Feed Title?</td>
            <td class="forminput"><asp:Checkbox runat="server" ID="chkShowTitle" /></td>
        </tr>
        <tr>
            <td class="formlabel wide">Show Feed Description?</td>
            <td class="forminput"><asp:Checkbox runat="server" ID="chkShowDescription" /></td>
        </tr>
        <tr>
            <td class="formlabel wide">Maximum Items to Display</td>
            <td class="forminput"><asp:TextBox runat="server" ID="MaxItemsField" Columns="6" Text="5"></asp:TextBox></td>
        </tr>
    </table>
    <br />
    <br />
    <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
    &nbsp;
    <asp:ImageButton ID="btnSave" runat="Server" ImageUrl="~/BVAdmin/Images/buttons/SaveChanges.png" />
    <hr />
</asp:Panel>
<asp:HiddenField ID="EditBvinField" runat="server" />

