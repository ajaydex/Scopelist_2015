<%@ Page ValidateRequest="false" Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="PrintTemplates_Edit.aspx.vb" Inherits="BVAdmin_Content_PrintTemplates_Edit" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/HtmlEditor.ascx" TagName="HtmlEditor" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Print Template</h1>
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
                        ErrorMessage="A Template Name is Required">*</bvc5:BVRequiredFieldValidator>
              	</td>
            </tr>                       
        </table>
    </asp:Panel>
    
    
    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">        
        <tr>
            <td align="left" valign="top">
            	
            	
                Body:<br />
                <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                	<tr>
                    	<td>
                        	<asp:TextBox ID="BodyField" runat="server" Rows="10" TextMode="multiline" Wrap="false" />
                        </td>
                        <td>
                       		<input type="button" id="btnHTMLBody" value="<" onclick="MoveEmailVars()" runat="server" />
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                
                Repeating Section:<br />
                <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                	<tr>
                    	<td>
                        	<asp:TextBox ID="RepeatingSectionField" runat="server" Rows="10" TextMode="MultiLine" Wrap="false" />
                        </td>
                        <td>
                       		<input type="button" id="btnHTMLRepeating" value="<" onclick="MoveEmailVars2()" runat="server" />
                        </td>
                    </tr>
                </table>
                <br />
                <br />
            </td>
            <td align="right" valign="top" style="width:200px;">
                Available Tags:<br />
                <asp:ListBox ID="Tags" style="font-size:11px;" runat="server" Width="220" Height="400px" SelectionMode="single"></asp:ListBox>
          	</td>
        </tr>
   	</table>
    
    <asp:ImageButton ID="btnCancel" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False" />
    &nbsp;
    <asp:ImageButton ID="btnSaveChanges" TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png" /></asp:ImageButton>
     
    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>


