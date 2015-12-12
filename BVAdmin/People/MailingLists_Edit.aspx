<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="MailingLists_Edit.aspx.vb" Inherits="BVAdmin_People_MailingLists_Edit" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Edit Mailing List</h1>

    <uc1:MessageBox ID="MessageBox1" runat="server" />

    <div class="f-row">
    	<div class="twelve columns">
            <asp:Label ID="lblError" runat="server" CssClass="errormessage"></asp:Label><asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSaveChanges">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="formlabel">
                            Name:</td>
                        <td class="formfield">
                            <asp:TextBox ID="NameField" runat="server" Columns="30" MaxLength="100" TabIndex="2000"
                                Width="200px"></asp:TextBox><bvc5:BVRequiredFieldValidator ID="valName" runat="server"
                                    ErrorMessage="Please enter a Name" ControlToValidate="NameField">*</bvc5:BVRequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Is Private:</td>
                        <td class="formfield">
                            <asp:CheckBox ID="IsPrivateField" runat="server" />
                        </td>
                    </tr>
                </table>

                <br />
                <asp:ImageButton ID="btnCancel" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>&nbsp;
                <asp:ImageButton ID="btnSaveChanges" TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
            </asp:Panel>
            <hr />
        </div>  
    </div>

    <div class="f-row">
        <div class="six columns">
            <h2>Import New Members</h2>
            <strong>Format:</strong> <em>email address, last name, first name</em>
            <br />
            <span class="smalltext">&bull; First and Last names are optional. <span style="color: red;">One member per row.</span></span>
            <bvc5:BVCustomValidator ID="CustomValidator1" runat="server" ControlToValidate="ImportField" ErrorMessage="All E-mail Addresses Must Be Valid." ValidationGroup="Import"></bvc5:BVCustomValidator>&nbsp;
            <asp:TextBox ID="ImportField" runat="server" Rows="10" TextMode="MultiLine" Wrap="False" style="margin-bottom:5px;"></asp:TextBox>
                
            <asp:ImageButton ID="btnImport" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Import.png" ValidationGroup="Import" />&nbsp;
        </div>
        <div class="six columns">
            <h2>Members</h2>
            <div style="text-align:right; margin:3px 0px 10px 0px;">
                <span style="float:left;"><asp:ImageButton ID="btnExport" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Export.png" CausesValidation="False" />&nbsp;</span>
                <span style="float:left;"><asp:CheckBox ID="chkOnlyEmail" runat="server" Text="Email Addresses Only" /></span>
                
                <asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New Mailing List" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
            </div>
              
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BorderColor="#CCCCCC" cellpadding="0" DataKeyNames="bvin" GridLines="None" Width="100%">
                <Columns>
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" />
                    <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return window.confirm('Delete this member?');" Text="Delete" CssClass="btn-delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
        </div>
    </div>

    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>

