<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb"
    Inherits="BVModules_ProductChoices_DropDownList_ProductChoiceEdit" EnableViewState="true" %>
<asp:MultiView ID="ProductChoiceMultiView" runat="server" ActiveViewIndex="0">
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
                    Items</td>
                <td class="formfield">
                    <asp:ImageButton ID="newChoiceOptionButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/New.png" /></td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:GridView ID="ChoicesGridView" runat="server" AutoGenerateColumns="False" BorderColor="#CCCCCC" CellPadding="3" GridLines="None">
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
                    Display Name</td>
                <td class="formfield" style="height: 26px; width: 276px;">
                    <asp:TextBox ID="ChoiceOptionDisplayNameTextBox" runat="server" Width="215px"></asp:TextBox></td>
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
                    <asp:CheckBox ID="ChoiceOptionDefaultItemCheckBox" runat="server" /></td>
            </tr>        
            <tr>
                <td>
                </td>
                <td style="width: 276px">
                    &nbsp;<asp:ImageButton ID="ChoiceOptionCancelButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
                    <asp:ImageButton ID="ChoiceOptionContinueButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Continue.png" /></td>
            </tr>
        </table>
    </asp:View>
</asp:MultiView>
