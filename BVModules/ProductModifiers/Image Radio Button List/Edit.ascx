<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb"
    Inherits="BVModules_ProductModifiers_ImageRadioButtonList_ProductModifierEdit" EnableViewState="true" %>

<asp:MultiView ID="ProductModifierMultiView" runat="server" ActiveViewIndex="0">
    <asp:View ID="View1" runat="server">        
        <table>
            <tr>
                <td class="formlabel">
                    Name</td>
                <td class="formfield">
                    <asp:TextBox ID="NameTextBox" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Display Name</td>
                <td class="formfield">
                    <asp:TextBox ID="DisplayNameTextBox" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Is Required</td>
                <td class="formfield">                
                    <asp:CheckBox ID="RequiredCheckBox" runat="server" />                    
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Items</td>
                <td class="formfield">
                    <asp:ImageButton ID="newModifierOptionButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/New.png" /></td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:GridView ID="ModifiersGridView" runat="server" AutoGenerateColumns="False" BorderColor="#CCCCCC" CellPadding="3" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="Bvin" HeaderText="bvin" ReadOnly="True" Visible="False" />
                            <asp:BoundField HeaderText="Name" DataField="DisplayText" />                            
                            <asp:CheckBoxField HeaderText="Default" DataField="IsDefault" />
                            <asp:ButtonField ButtonType="Image" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png"
                                Text="Button" CommandName="Edit" />
                            <asp:ButtonField ButtonType="Image" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png"
                                Text="Button" CommandName="Delete" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:ImageButton ID="moveUpButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Up.png" CommandName="MoveItem" CommandArgument="Up"/>
                                    <asp:ImageButton ID="moveDownButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Down.png" CommandName="MoveItem" CommandArgument="Down" />
                                </ItemTemplate>
                                <ItemStyle Width="20px" />
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            No items to display.
                        </EmptyDataTemplate>
                        <RowStyle CssClass="row" />
                        <HeaderStyle CssClass="rowheader" />
                        <AlternatingRowStyle CssClass="alternaterow" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td style="height: 26px">
                </td>
                <td style="height: 26px">
                    &nbsp;<asp:ImageButton ID="CancelButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
                    <asp:ImageButton ID="ContinueChangesButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Continue.png" /></td>
            </tr>
        </table>
    </asp:View>        
    <asp:View ID="View2" runat="server">
        <table>
            <tr>
                <td class="formlabel" style="height: 26px">
                    Name</td>
                <td class="formfield" style="height: 26px; width: 276px;">
                    <asp:TextBox ID="ModifierOptionNameTextBox" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="formlabel" style="height: 26px">
                    Image Url</td>
                <td class="formfield" style="height: 26px; width: 276px;">
                         <asp:TextBox ID="ImageField" runat="server" Columns="20" CssClass="FormInput"></asp:TextBox>
                    <a href="javascript:popUpWindow('?returnScript=SetImage&WebMode=1');">
                        <asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="imgSelect1" /></a>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Null Item?</td>
                <td class="formfield" style="width: 276px">
                    <asp:CheckBox ID="NullItemCheckBox" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Set As Default Item?</td>
                <td class="formfield" style="width: 276px">
                    <asp:CheckBox ID="ModifierOptionDefaultItemCheckBox" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Price Adjustment</td>
                <td class="formfield" style="width: 276px">
                    <asp:TextBox ID="ModifierOptionPriceAdjustmentTextBox" runat="server"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="ModifierOptionPriceAdjustmentRequiredFieldValidator" runat="server" ErrorMessage="Price adjustment is required." Text="*" ControlToValidate="ModifierOptionPriceAdjustmentTextBox"></bvc5:BVRequiredFieldValidator>
                    <bvc5:BVCustomValidator ID="ModifierOptionPriceAdjustmentCustomValidator" runat="server" ErrorMessage="Price adjustment must be a valid monetary value." Text="*" OnServerValidate="MonetaryValidate" ControlToValidate="ModifierOptionPriceAdjustmentTextBox"></bvc5:BVCustomValidator>    
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Weight Adjustment</td>
                <td class="formfield" style="width: 276px">
                    <asp:TextBox ID="ModifierOptionWeightAdjustmentTextBox" runat="server"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="ModifierOptionWeightRequiredFieldValidator" runat="server" ErrorMessage="Price adjustment is required." Text="*" ControlToValidate="ModifierOptionWeightAdjustmentTextBox"></bvc5:BVRequiredFieldValidator>
                    <bvc5:BVCustomValidator ID="ModifierOptionWeightBVCustomValidator" runat="server" ErrorMessage="Weight adjustment must be a valid numeric value." Text="*" OnServerValidate="MonetaryValidate" ControlToValidate="ModifierOptionWeightAdjustmentTextBox"></bvc5:BVCustomValidator>                        
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Shipping Adjustment</td>
                <td class="formfield" style="width: 276px">
                    <asp:TextBox ID="ModifierOptionShippingAdjustmentTextBox" runat="server"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="ModifierOptionShippingBVRequiredFieldValidator" runat="server" ErrorMessage="Price adjustment is required." Text="*" ControlToValidate="ModifierOptionShippingAdjustmentTextBox"></bvc5:BVRequiredFieldValidator>
                    <bvc5:BVCustomValidator ID="ModifierOptionShippingBVCustomValidator" runat="server" ErrorMessage="Shipping adjustment must be a valid monetary value." Text="*" OnServerValidate="MonetaryValidate" ControlToValidate="ModifierOptionShippingAdjustmentTextBox"></bvc5:BVCustomValidator>    
                </td>
            </tr>        
            <tr>
                <td>
                </td>
                <td style="width: 276px">
                    &nbsp;<asp:ImageButton ID="ModifierOptionCancelButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
                    <asp:ImageButton ID="ModifierOptionContinueButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Continue.png" /></td>
            </tr>
        </table>
    </asp:View>
</asp:MultiView>
