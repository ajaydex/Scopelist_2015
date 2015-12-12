<%@ Control Language="VB" AutoEventWireup="false" CodeFile="GiftCertificates.ascx.vb" Inherits="BVModules_Controls_GiftCertificates" %>
<h2 id="title" runat="server" visible="false">Gift Certificates</h2><asp:Literal ID="litMessages" runat="server" EnableViewState="false" />
<table border="0" cellspacing="0" cellpadding="3" class="giftcertificates">
    <tr>
        <td valign="top">
            <asp:TextBox ID="GiftCertificateTextBox" runat="server"></asp:TextBox>
            <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="GiftCertificateTextBox"
                ErrorMessage="You must enter a gift certificate id." ValidationGroup="GiftCertificates" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator></td>                
    </tr>        
    <tr>
        <td valign="top">
            <asp:ImageButton ID="AddGiftCertificateImageButton" AlternateText="Add Gift Certificate" runat="server" ValidationGroup="GiftCertificates" ImageUrl="~/BVModules/Themes/Bvc5/images/Buttons/AddGiftCertificate.png" />
        </td>
    </tr>
    <tr>
        <td valign="top">
            <asp:GridView ID="GiftCertificatesGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin">
                <Columns>
                    <asp:BoundField DataField="CertificateCode" HeaderText="Gift Cetificate Id" />
                    <asp:BoundField DataField="CurrentAmount" HeaderText="Amount" DataFormatString="{0:c}" HtmlEncode="false" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="RemoveImageButton" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/Buttons/Delete.png" CommandName="Delete" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </td>
    </tr>
</table>