<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_Shipping_By_Order_Total_Mixed_edit" %>
<h1>
    Edit Shipping Method - By Order Total</h1>
<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
    <table border="0" cellspacing="0" cellpadding="5">
        <tr>
            <td class="formfield" colspan="2">
                Name:
                <asp:TextBox ID="NameField" runat="server" Width="300"></asp:TextBox></td>
        </tr>
       <%-- <tr>
            <td class="formfield" colspan="2">
                Is Express: <asp:CheckBox ID="chkIsExpress" runat="server" />
            </td>
        </tr>--%>
        <tr>
            <td class="formfield" colspan="2">
                <asp:GridView ID="GridView1" CellPadding="3" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="bvin" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="Level" DataFormatString="{0:c}" HeaderText="When subtotal is at least" />
                        <asp:BoundField DataField="FixedAmount" DataFormatString="{0:c}" HeaderText="Charge this Amount" />
                        <asp:TemplateField HeaderText="and this Percentage">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("percentage", "{0}%")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                    <RowStyle CssClass="row" />
                    <HeaderStyle CssClass="rowheader" />
                    <AlternatingRowStyle CssClass="alternaterow" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td class="formfield" colspan="2">
                <asp:Panel ID="pnlNew" runat="server" DefaultButton="btnNew">
                    Order Total:
                    <asp:TextBox ID="NewLevelField" runat="server" Columns="7"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="OrderTotalBVRequiredFieldValidator" ValidationGroup="NewLevel" ControlToValidate="NewLevelField" Text="*" ErrorMessage="Order Total is required." runat="server"></bvc5:BVRequiredFieldValidator>
                    <bvc5:BVRangeValidator ID="OrderTotalBVRangeValidator" ValidationGroup="NewLevel" ControlToValidate="NewLevelField" Type="Currency" MinimumValue="0" MaximumValue="999999" Text="*" ErrorMessage="Order total must be between 0 and 999999" runat="server"></bvc5:BVRangeValidator>
                    &nbsp;&nbsp;Charge this amount:
                    <asp:TextBox ID="NewAmountField" runat="server" Columns="7"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator1" ValidationGroup="NewLevel" ControlToValidate="NewAmountField" Text="*" ErrorMessage="Amount is required." runat="server"></bvc5:BVRequiredFieldValidator>                    
                    <bvc5:BVRangeValidator ID="AmountBVRangeValidator" ValidationGroup="NewLevel" ControlToValidate="NewAmountField" Type="Currency" MinimumValue="0" MaximumValue="999999" Text="*" ErrorMessage="Amount must be between 0 and 999999" runat="server"></bvc5:BVRangeValidator>
                    and this percent <asp:TextBox ID="NewPercentageField" Text="0" runat="server" Columns="5"></asp:TextBox>%
                    <asp:ImageButton ID="btnNew" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/New.png" ValidationGroup="NewLevel" />
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td class="formlabel" colspan="2">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
            <td class="formfield">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
        </tr>
    </table>
</asp:Panel>
