<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminPopup.master" AutoEventWireup="false" CodeFile="ImportExport.aspx.vb" Inherits="BVAdmin_ImportExport" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ContentPlaceHolderID="BvcAdminPopupConent" runat="server">
    <h1><asp:Label ID="lblTitle" runat="server" /></h1>
    
    <asp:Panel ID="pnlImport" DefaultButton="btnImport" runat="server">
        <h2><asp:Label ID="lblImportTitle" runat="server" /></h2>
        <uc:MessageBox ID="ucImportMessageBox" runat="server" />
        <asp:PlaceHolder ID="ImportControllerPlaceHolder" runat="server"></asp:PlaceHolder>
        <asp:FileUpload ID="fuImport" runat="server" /><br />
        <br />
        <asp:ImageButton ID="btnImport" ImageUrl="~/BVAdmin/Images/Buttons/ImportLarge.png" OnClientClick="this.disabled = true;__doPostBack(this.name,'');" runat="server" />
        <hr />
    </asp:Panel>

    <asp:Panel ID="pnlExport" DefaultButton="btnExport" runat="server">
        <h2><asp:Label ID="lblExportTitle" runat="server" /></h2>
        <uc:MessageBox ID="ucExportMessageBox" runat="server" />
        <asp:PlaceHolder ID="ExportControllerPlaceHolder" runat="server"></asp:PlaceHolder>
        <div class="clearfix">
            <asp:ImageButton ID="btnExport" CssClass="exportButton" ImageUrl="~/BVAdmin/Images/Buttons/ExportLarge.png" OnClientClick="$('#ExportMsg').fadeIn(600).delay(2000).fadeOut(600)" runat="server" />
            <span id="ExportMsg" style="display:none">Exporting...please wait</span>
        </div>
        <br />
        <br />
    </asp:Panel>

</asp:Content>