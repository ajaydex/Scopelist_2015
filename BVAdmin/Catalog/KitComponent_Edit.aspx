<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="KitComponent_Edit.aspx.vb" Inherits="BVAdmin_Catalog_KitComponent_Edit" title="Edit Kit Part Group" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<h1>Edit Kit Component</h1>
<table border="0" cellspacing="0" cellpadding="0" width="500">
<tr>
    <td class="formlabel">Display Name:</td>
    <td class="formfield"><asp:TextBox runat="server" ID="DisplaynameField" Width="300"></asp:TextBox></td>
</tr>
<tr>
    <td class="formlabel">Type:</td>
    <td class="formfield"><asp:DropDownList ID="ComponentTypeField" runat="server">
    <asp:ListItem Value="0" Text="Included - Hidden"></asp:ListItem>
    <asp:ListItem Value="1" Text="Included - Shown"></asp:ListItem>
    <asp:ListItem Value="2" Text="Radio Button Selection"></asp:ListItem>
    <asp:ListItem Value="3" Text="Drop Down List Selection"></asp:ListItem>
    <asp:ListItem Value="4" Text="Check Box (Multi) Selection"></asp:ListItem>
    </asp:DropDownList></td>
</tr>
<tr>
    <td class="formlabel">Small Image:</td>
    <td class="formfield">                            
            <asp:TextBox ID="ImageFileSmallField" runat="server" Columns="25" CssClass="FormInput"
                Width="220px"></asp:TextBox>
            <a href="javascript:popUpWindow('?returnScript=SetSmallImage&WebMode=1');">
                <asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="imgSelect1" /></a>    
    </td>
</tr>
<tr>
    <td class="formlabel">Large Image:</td>
    <td class="formfield">
            <asp:TextBox ID="ImageFileMediumField" runat="server" Columns="25" CssClass="FormInput"
                Width="220px"></asp:TextBox>
            <a href="javascript:popUpWindow('?returnScript=SetMediumImage&WebMode=1');">
                <asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="Image1" /></a>
    </td>
</tr>
<tr>
    <td class="formlabel"><asp:ImageButton ID="btnCancel" runat="server" AlternateText="Cancel" CausesValidation="false" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
    <td class="formfield"><asp:ImageButton ID="btnSave" runat="server" AlternateText="Save Changes" CausesValidation="true" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
</tr>
</table>
</asp:Content>

