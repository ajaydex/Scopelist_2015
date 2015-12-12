<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_Feeds__FeedTypeEditors_Product_Edit" %>

<tr>
    <td class="formlabel">Include Choice Combination products (variants)</td>
    <td class="formfield">
        <asp:CheckBox ID="chkIncludeChoiceCombinations" runat="server" />
    </td>
</tr>
<tr>
    <td class="formlabel">Include parent product of Choice Combinations</td>
    <td class="formfield">
        <asp:CheckBox ID="chkIncludeChoiceCombinationParents" runat="server" />

        <script type="text/javascript">
            $(document).ready(function() {
                function initChoiceCombinationCheckboxes() {
                    if (!$('#<%=chkIncludeChoiceCombinations.ClientID%>').is(':checked')) {
                        $('#<%=chkIncludeChoiceCombinationParents.ClientID%>').prop('checked', true);
                        $('#<%=chkIncludeChoiceCombinationParents.ClientID%>').prop('disabled', true);
                    }
                    else
                        $('#<%=chkIncludeChoiceCombinationParents.ClientID%>').prop('disabled', false);
                }
                initChoiceCombinationCheckboxes();

                $('#<%=chkIncludeChoiceCombinations.ClientID%>').change(function () {
                    initChoiceCombinationCheckboxes();
                });
            });
        </script>
    </td>
</tr>