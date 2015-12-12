<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_CategoryTemplates_Scopelist_Category_and_Product_Grid___4_Col_Edit" %>
<table>
    <tr>
        <td class="formlabel">
            Items Per Page
        </td>
        <td class="formfield">
            <asp:TextBox ID="ItemsPerPageTextBox" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ItemsPerPageTextBox"
                ErrorMessage="Items Per Page Must Be Entered." ForeColor=" " CssClass="errormessage">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="ItemsPerPageTextBox"
                ErrorMessage="Items Per Page Must Be a Numeric Value between 1 and 99" ValidationExpression="\d{1,2}"
                ForeColor=" " CssClass="errormessage">*</asp:RegularExpressionValidator>
        </td>
        <td class="formfield">
            <asp:DropDownList ID="PagersDropDownList" runat="server">
                <asp:ListItem Text="Top" Value="0"></asp:ListItem>
                <asp:ListItem Text="Bottom" Value="1"></asp:ListItem>
                <asp:ListItem Text="Both" Value="2"></asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
</table>
<span>
    <asp:ImageButton ID="SaveImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
    <asp:ImageButton ID="CancelImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
</span>