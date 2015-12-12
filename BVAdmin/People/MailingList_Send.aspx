<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="MailingList_Send.aspx.vb" Inherits="BVAdmin_People_MailingList_Send" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Send Email to Mailing List</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />

    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel wide">Choose a mailing list:</td>
            <td class="formfield"><asp:Label ID="lblList" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td class="formlabel">Choose an email template:</td>
            <td class="formfield">
                <asp:DropDownList runat="server" ID="EmailTemplateField"></asp:DropDownList> 
                <asp:ImageButton ID="btnPreview" runat="Server" ImageUrl="~/BVAdmin/Images/BUttons/Preview-small.png" /> 
                &nbsp &nbsp;
                <a href="/BVAdmin/Content/EmailTemplates_Edit.aspx">Create your own email template &raquo;</a>
            </td>
        </tr>
    </table>
    <br />
    <div class="controlarea1">
        <pre><asp:Label id="PreviewSubjectField" runat="server"/></pre>
        <hr />
        <pre><asp:Label id="PreviewBodyField" runat="server" /></pre>
    </div>

    <hr />
    <asp:ImageButton ID="btnCancel" runat="Server" ImageUrl="~/BVAdmin/Images/BUttons/Cancel.png" />&nbsp;
    <asp:ImageButton ID="btnSend" runat="Server" ImageUrl="~/BVAdmin/Images/BUttons/send-large.png" />

    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>

