<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Export.ascx.vb" Inherits="BVModules_ImportExport_ProductExport_Export" %>
<%@ Register Src="~/BVAdmin/Controls/ProductFilter.ascx" TagName="ProductFilter" TagPrefix="uc" %>

<uc:ProductFilter ID="ucProductFilter" DisplaySharedChoicesSection="true" runat="server" />
<br />
<table cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td>
                <asp:CheckBox ID="IncludeChoiceCombinations" runat="server" /> Include Choice Combinations
            </td>
        </tr>
        <tr>
            <td>
                <asp:CheckBox ID="IncludeProductCategories" runat="server" /> Include Product Categories
            </td>
        </tr>
</table>
<br />