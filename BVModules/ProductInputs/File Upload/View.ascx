<%@ Control Language="VB" AutoEventWireup="false" CodeFile="View.ascx.vb" Inherits="BVModules_ProductInputs_File_Upload_View" %>

<tr class="fileupload labelrow">
    <td class="choicelabel" colspan="3">
		<asp:Label ID="InputLabel" runat="server" Text="Label"></asp:Label>
		<bvc5:BVRequiredFieldValidator ID="InputRequiredFieldValidator" runat="server" ControlToValidate="InputFileUpload"
ErrorMessage="Field Required" ForeColor=" " display="dynamic" CssClass="errormessage">*</bvc5:BVRequiredFieldValidator>
	</td>
</tr>
<tr class="fileupload inputrow">
    <td class="choicefield" colspan="3"><asp:FileUpload ID="InputFileUpload" runat="server" Rows="1"></asp:FileUpload>
    </td>
</tr>
<asp:Placeholder ID="PreviousFile" Visible="false" runat="server">
<tr class="fileupload uploadedlabelrow">
    <td class="choicelabel" colspan="3">
		<b>Uploaded File: </b>
	</td>
</tr>
<tr class="fileupload uploadedimagerow">
    <td class="choicefield" colspan="3">
        <div class="uploadedFileType">
            <asp:Image ID="imgPreviousFile" runat="server" />
            <asp:Label ID="overlayText" Visible="false" runat="server"></asp:Label>
        </div>
    </td>
</tr>
</asp:Placeholder>


