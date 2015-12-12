<%@ Control Language="VB" AutoEventWireup="false" CodeFile="InventoryModifications.ascx.vb" Inherits="BVAdmin_Controls_InventoryModifications" %>
<%@ Register Src="EnumeratedValueModifierField.ascx" TagName="EnumeratedValueModifierField" TagPrefix="uc5" %>
<%@ Register Src="IntegerModifierField.ascx" TagName="IntegerModifierField" TagPrefix="uc3" %>

<asp:Panel ID="InventoryModificationsPanel" runat="server">
    <table>        
        <tr id="Tr9" runat="server">
            <td>
                <asp:CheckBox ID="QuantityAvailableCheckBox" runat="server" CssClass="modificationSelected" Text="Qty Available" OnClick="$(this).parent().siblings('.hide').slideToggle('fast')" />
                <div class="hide">
                    <uc3:IntegerModifierField ID="QuantityAvailableIntegerModifierField" runat="server" />
                </div>
            </td>
        </tr>
        <tr id="Tr10" runat="server">
            <td>
                <asp:CheckBox ID="QuantityOutOfStockPointCheckBox" runat="server" CssClass="modificationSelected" Text="Out-of-Stock Point" OnClick="$(this).parent().siblings('.hide').slideToggle('fast')" />
                <div class="hide">
                    <uc3:IntegerModifierField ID="QuantityOutOfStockPointIntegerModifierField" runat="server" />
                </div>
            </td>
        </tr>     
        <tr id="Tr12" runat="server">
            <td>
                <asp:CheckBox ID="QuantityReservedCheckBox" runat="server" CssClass="modificationSelected" Text="Qty Reserved" OnClick="$(this).parent().siblings('.hide').slideToggle('fast')" />
                <div class="hide">
                    <uc3:IntegerModifierField ID="QuantityReserveIntegerModifierField" runat="server" />
                </div>
            </td>
        </tr>     
        <%-- 
        <tr id="Tr14" runat="server">
            <td>
                <asp:CheckBox ID="StatusCheckBox" runat="server" CssClass="modificationSelected" Text="Status"/><br/>
                <uc5:EnumeratedValueModifierField ID="StatusEnumeratedValueModifierField" runat="server" />
            </td>
        </tr>--%>      
    </table>
</asp:Panel>    
    