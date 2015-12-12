<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"  CodeFile="Closed.aspx.vb" Inherits="closed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BvcPopupContentPlaceholder" Runat="Server">
    <script type="text/javascript">
        var refreshTimeInSeconds = 15;
        setTimeout("location.reload(true)", refreshTimeInSeconds * 1000);
    </script>

    <div id="closedcontent">       
        <asp:Label ID="lblDescription" Text="Our store is currently closed while we perform updates. We appreciate your patience." runat="server" />        
    </div>
</asp:Content>