<%@ Page ValidateRequest="false" Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="CustomPages_Edit.aspx.vb" Inherits="BVAdmin_Content_CustomPages_Edit" title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/HtmlEditor.ascx" TagName="HtmlEditor" TagPrefix="uc1" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Edit Page</h1>
    <uc2:MessageBox ID="MessageBox1" runat="server" />
    <asp:Label ID="lblError" runat="server" CssClass="errormessage"></asp:Label>
    <asp:Panel ID="pnlMain" runat="server" >
        <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
            <tr>
                <td class="formlabel">
                    Url:</td>
                <td class="formfield">
                    <asp:Literal ID="UrlLiteral" runat="server"></asp:Literal>
                    <div style="margin: 5px 0;">
                        <asp:HyperLink ID="lnkViewInStore" ImageUrl="~/BVAdmin/Images/Buttons/ViewInStore.png" Visible="false" runat="server" />
                    </div>
                    <br />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Page Name:</td>
                <td class="formfield">
                    <asp:TextBox ID="NameField" runat="server" TabIndex="2000" CssClass="wide"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="RequiredVal1" runat="server" ErrorMessage="Please enter a page name" ControlToValidate="NameField" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Name In Menu:</td>
                <td class="formfield">
                    <asp:TextBox ID="NameInMenuTextBox" TabIndex="2001" runat="server" CssClass="wide"></asp:TextBox>
                </td>
            </tr>      
            <tr>
                <td class="formlabel">
                    Content:</td>
                <td class="formfield">
                    <uc1:HtmlEditor ID="ContentField" runat="server" EditorHeight="300" EditorWidth="700" TabIndex="2003" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Custom Url:</td>
                <td class="formfield">
                    <asp:TextBox ID="CustomUrlTextBox" runat="server" TabIndex="2004" CssClass="wide"></asp:TextBox>
                </td>
            </tr>            
            <tr>
                <td class="formlabel">
                    Meta Description:</td>
                <td class="formfield">
                    <asp:TextBox ID="MetaDescriptionField" runat="server" MaxLength="255" Columns="30"
                        TabIndex="2005" Width="300px" Height="75px" Rows="4" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Meta Keywords:</td>
                <td class="formfield">
                    <asp:TextBox ID="MetaKeywordsField" runat="server" MaxLength="255" TabIndex="2006" CssClass="wide"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Meta Title:</td>
                <td class="formfield">
                    <asp:TextBox ID="MetaTitleField" runat="server" MaxLength="255" TabIndex="2007" CssClass="wide"></asp:TextBox></td>
            </tr>      
            
            <tr>
                <td class="formlabel" style="vertical-align:top">
                    Display Template:</td>
                <td class="formfield">
                    <anthem:Panel AutoUpdateAfterCallBack="true" runat="server">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td style="width:50px"><asp:Image ID="TemplatePreviewImage" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/NoCategoryPreview.png" TabIndex="2011" /></td>
                                <td class="formfield">
                                    <asp:DropDownList ID="TemplateList" runat="server" AutoPostBack="True" TabIndex="2010" style="vertical-align:top">
                                        <asp:ListItem Value="BV Grid">- No Templates Found -</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </anthem:Panel>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Show In Bottom Menu:</td>
                <td class="formfield">
                    <asp:CheckBox ID="ShowInBottomMenuCheckBox" Text="Yes" TabIndex="2002" runat="server" />
                </td>
            </tr>
            <tr><td colspan="2"><hr /></td></tr>
            <tr>
                <td class="formlabel">
                    Pre-Content Column</td>
                <td class="formfield">
                    <asp:DropDownList ID="PreContentColumnIdField" runat="server" TabIndex="2008">
                        <asp:ListItem> - None -</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Post-Content Column:</td>
                <td class="formfield">
                    <asp:DropDownList ID="PostContentColumnIdField" runat="server" TabIndex="2009">
                        <asp:ListItem> - None -</asp:ListItem>
                    </asp:DropDownList></td>
            </tr> 
        </table>
        <br />
        <br />
        <asp:ImageButton ID="btnCancel" TabIndex="2502" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False" />
        &nbsp;
        <asp:ImageButton ID="btnUpdate" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Update.png" />
        &nbsp;
        <asp:ImageButton ID="btnSaveChanges" TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png" />
           
    </asp:Panel>
    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>

