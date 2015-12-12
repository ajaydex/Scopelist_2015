<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Images.aspx.vb" Inherits="BVAdmin_Configuration_Images" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
	<h1>Images</h1>        
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel wide">Small Size:</td>
            <td class="formfield">
                <asp:TextBox ID="ImagesSmallWidthField" runat="server" Columns="5"></asp:TextBox>
                wide by
                <asp:TextBox ID="ImagesSmallHeightField" runat="server" Columns="5"></asp:TextBox>
                tall</td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Medium Size:</td>
            <td class="formfield">
                <asp:TextBox ID="ImagesMediumWidthField" runat="server" Columns="5"></asp:TextBox>
                wide by
                <asp:TextBox ID="ImagesMediumHeightField" runat="server" Columns="5"></asp:TextBox>
                tall</td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Image Browser Default Directory:
            </td>
            <td class="formfield">
                <asp:TextBox ID="ImageBrowser" Columns="50" Width="300px" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Force Images Sizes:
            </td>
            <td class="formfield">
                <asp:CheckBox ID="chkForceImageSizes" runat="Server" /> Yes
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Hide Images in Cart:
            </td>
            <td class="formfield">
                <asp:CheckBox ID="chkHideCartImages" runat="server" /> Yes
            </td>
        </tr>
  	</table>
  	<br />
    
    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
    &nbsp;
    <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
    </asp:Panel>
</asp:Content>

