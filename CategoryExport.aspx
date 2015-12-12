<%@ Page Title="" Language="VB" AutoEventWireup="false" CodeFile="CategoryExport.aspx.vb"
    Inherits="CategoryExport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:TreeView ID="CategoryTree" ExpandDepth="0" ShowCheckBoxes="All" ShowLines="true"
        runat="server" />
    <script type="text/javascript">
        $(document).ready(function () {
            var selector = "[id$='<%= CategoryTree.ClientID%>'] span";
            $(selector).css("cursor", "default");
            $(selector).click(function () {
                var chk = $(this).prev();
                chk.prop("checked", !chk.is(":checked"));
            });
        });
    </script>
    <asp:Button ID="btnExport" runat="server" Text="Export Selected Category" UseSubmitBehavior="true" />
    <br />
    <asp:HyperLink ID="lnkCategoryDump" runat="server" NavigateUrl="~/CategoriesDump.xml"
        Text="Category Dump"></asp:HyperLink>
    </form>
</body>
</html>
