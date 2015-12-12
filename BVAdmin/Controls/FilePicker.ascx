<%@ Control Language="VB" AutoEventWireup="false" CodeFile="FilePicker.ascx.vb" Inherits="BVAdmin_Controls_FilePicker" %>
<%@ Register Src="TimespanPicker.ascx" TagName="TimespanPicker" TagPrefix="uc1" %>
<%@ Reference Control="~/BVAdmin/Controls/MessageBox.ascx" %>

<table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
    <tr>
        <td class="formlabel wide">Upload a new file to the site:</td>
        <td class="formfield">
        	<asp:FileUpload ID="NewFileUpload" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel wide">Use a file that has already been uploaded:</td>
        <td class="formfield">
			<asp:DropDownList ID="FilesDropDownList" runat="server" AppendDataBoundItems="True">
            	<asp:ListItem>File Above</asp:ListItem>
            </asp:DropDownList>
            
            <asp:TextBox ID="FileSelectedTextBox" runat="server" Visible="False"></asp:TextBox>
            <bvc5:BVCustomValidator ID="FileHasBeenSelectedCustomValidator" runat="server" ErrorMessage="You must upload a file or select a file that has already been uploaded." CssClass="errormessage" ForeColor=" ">*</bvc5:BVCustomValidator>
            <bvc5:BVCustomValidator ID="FileIsUniqueToProductCustomValidator" runat="server" ErrorMessage="Physical file must be unique to product." CssClass="errormessage" ForeColor=" ">*</bvc5:BVCustomValidator>
            <a id="browseButton" runat="server" href="javascript:popUpWindow('?returnScript=SetSmallImage&WebMode=1');">
            <asp:Image runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Browse.png" ID="imgSelect1" /></a><asp:HiddenField
                ID="FileIdHiddenField" runat="server" />
		</td>
    </tr>
    <tr id="ShortDescriptionRow" runat="server">
        <td class="formlabel wide">Short description:</td>
        <td class="formfield">
			<asp:TextBox ID="ShortDescriptionTextBox" runat="server" columns="50"></asp:TextBox>
            <bvc5:BVCustomValidator ID="DescriptionIsUniqueToProductCustomValidator" runat="server" ErrorMessage="Short description must be unique for files with the same name." ControlToValidate="ShortDescriptionTextBox" CssClass="errormessage" ForeColor=" ">*</bvc5:BVCustomValidator>
		</td>
    </tr>
	
    <tr id="AvailableMinutesRow" runat="server">
    	<td class="formlabel wide">Available for (leave blank for unlimited):</td>
        <td class="formfield">
			<uc1:TimespanPicker ID="AvailableForTimespanPicker" runat="server" />
		</td>
    </tr>
	
    <tr id="NumberDownloadsRow" runat="server">
        <td class="formlabel wide">Number of times file can be downloaded:</td>
        <td class="formfield">
			<asp:TextBox ID="NumberOfDownloadsTextBox" runat="server" Width="32px"></asp:TextBox>
            (leave blank for unlimited)<bvc5:BVRegularExpressionValidator ID="RegularExpressionValidator1"
                runat="server" ControlToValidate="NumberOfDownloadsTextBox" ErrorMessage="Number of times file can be downloaded must be numeric"
                ValidationExpression="\d{1,6}" CssClass="errormessage" ForeColor=" ">*</bvc5:BVRegularExpressionValidator>
		</td>
    </tr>
</table>
