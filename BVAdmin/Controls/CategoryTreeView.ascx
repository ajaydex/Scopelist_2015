<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CategoryTreeView.ascx.vb" Inherits="BVAdmin_Controls_CategoryTreeView" %>

<asp:TreeView ID="CategoryTree" ExpandDepth="0" ShowCheckBoxes="All" ShowLines="true" runat="server" />

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