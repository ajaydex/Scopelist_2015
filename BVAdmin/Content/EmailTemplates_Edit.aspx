<%@ Page ValidateRequest="false" Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master"
    AutoEventWireup="false" CodeFile="EmailTemplates_Edit.aspx.vb" Inherits="BVAdmin_Content_EmailTemplates_Edit"
    Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/HtmlEditor.ascx" TagName="HtmlEditor" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Email Template</h1>
    <uc2:MessageBox ID="MessageBox1" runat="server" />
    <asp:Label ID="lblError" runat="server" CssClass="errormessage"></asp:Label>
    
    <asp:Panel ID="pnlMain" runat="server">
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="formlabel">
                    Template Name:
                </td>
                <td class="formfield">
                    <asp:TextBox ID="DisplayNameField" runat="server" Columns="50" Width="400px"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DisplayNameField"
                        ErrorMessage="A Template Name is Required">*</bvc5:BVRequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="formlabel">
                    From:
                </td>
                <td class="formfield">
                    <asp:TextBox ID="FromField" runat="server" Columns="50" Width="400px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Subject:
                </td>
                <td class="formfield">
                    <asp:TextBox ID="SubjectField" runat="server" Columns="50" Width="400px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    
                </td>
                <td class="formfield">
                    <asp:CheckBox ID="SendInPlaintTextField" runat="server" /> Send in Plain Text Only
                </td>
            </tr>
        </table>
    </asp:Panel>
    
    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
        <tr>
            <td valign="top">
                HTML Body:<br />
                <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                	<tr>
                    	<td>
                        	<asp:TextBox ID="BodyField" runat="server" Rows="10" TextMode="multiline" Wrap="false"></asp:TextBox>
                        </td>
                        <td style="width:80px;">
                             <a href="#" class="btn-edit" onclick="MoveEmailVars()" id="btnHTMLBody" runat="server">&laquo; Insert</a>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                
                HTML Repeating Section:<br />
                <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                	<tr>
                    	<td>
                        	<asp:TextBox ID="RepeatingSectionField" runat="server" Rows="10" TextMode="MultiLine" Wrap="false"></asp:TextBox>
                        </td>
                        <td style="width:80px;">
                             <a href="#" class="btn-edit" onclick="MoveEmailVars2()" id="btnHTMLRepeating" runat="server">&laquo; Insert</a>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                
                Plain Text Body:<br />
                <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                	<tr>
                    	<td>
                        	<asp:TextBox ID="BodyPlainTextField" runat="server" Rows="10" TextMode="MultiLine"></asp:TextBox>
                        </td>
                        <td style="width:80px;">
                             <a href="#" class="btn-edit" onclick="MoveEmailVars3()" id="btnTextBody"  runat="server">&laquo; Insert</a>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                
                Plain Text Repeating Section:<br />
                <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                	<tr>
                    	<td>
                        	<asp:TextBox ID="RepeatingSectionPlainTextField" runat="server" Rows="10" TextMode="MultiLine"></asp:TextBox>
                        </td>
                        <td style="width:80px;">
                             <a href="#" class="btn-edit" onclick="MoveEmailVars4()" id="btnTextRepeating"  runat="server">&laquo; Insert</a>
                        </td>
                    </tr>
                </table>
                
            </td>
            <td align="right" valign="top" style="width:200px;">
                Available Tags:<br />
                <asp:ListBox ID="Tags" style="font-size:11px;" runat="server" Width="220" Height="820" SelectionMode="single"></asp:ListBox>
          	</td>
        </tr>
    </table>
    <br />
    <asp:ImageButton ID="btnCancel" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False" />
    &nbsp;
    <asp:ImageButton ID="btnSaveChanges" TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png" />
        
    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>
