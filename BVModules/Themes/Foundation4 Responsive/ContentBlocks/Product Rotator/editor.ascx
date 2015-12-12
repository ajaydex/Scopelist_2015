<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_Product_Rotator_editor" %>
<%@ Register Src="~/BVAdmin/Controls/ProductPicker.ascx" TagName="ProductPicker" TagPrefix="uc1" %>
<%@ Register TagPrefix="uc" TagName="HtmlEditor" Src="~/BVAdmin/Controls/HtmlEditor.ascx" %>

<div class="f-row">
    <div class="six columns">
        <asp:Panel ID="pnlEditor" runat="server" DefaultButton="btnNew">
            <uc1:ProductPicker ID="ProductPicker1" runat="server" DisplayKits="true" />
            <br />      
            <asp:ImageButton ID="btnNew" runat="Server" ImageUrl="~/BVAdmin/Images/buttons/New.png" />
            &nbsp;
            <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/CancelSmall.png" />
            <asp:HiddenField ID="EditBvinField" runat="server" />
        </asp:Panel>
    </div>
    <div class="six columns">
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
            <script type="text/javascript">
                $(document).ready(function () {
                    // select all desired input fields and attach tooltips to them
                    $(".formfield :text, .formfield :checkbox").tooltip({
                        position: {
                            my: "left center",
                            at: "right+10 center"
                        }
                    });

                    $('input[type=checkbox]').click(hideInvalidOptions);
                    hideInvalidOptions();
                });

                function hideInvalidOptions() {
                    // do not allow new badge of image is hidden
                    if (!$('#<%=chkDisplayImage.ClientID%>').is(':checked')) {
                    $('#<%=chkDisplayNewBadge.ClientID%>').attr('disabled', 'disabled');
                    $('#<%=chkDisplayNewBadge.ClientID%>').removeAttr('checked');
                } else {
                    $('#<%=chkDisplayNewBadge.ClientID%>').removeAttr('disabled');
                }

                // do not allow options relating to add to cart if add to cart button and selected checkboxes are both turned off
                if (!$('#<%=chkDisplayAddToCartButton.ClientID%>').is(':checked')) {
                    $('#<%=chkDisplayQuantity.ClientID%>, #<%=chkRemainOnPageAfterAddToCart.ClientID%>').attr('disabled', 'disabled');
                    $('#<%=chkDisplayQuantity.ClientID%>, #<%=chkRemainOnPageAfterAddToCart.ClientID%>').removeAttr('checked');
                } else {
                    $('#<%=chkDisplayQuantity.ClientID%>, #<%=chkRemainOnPageAfterAddToCart.ClientID%>').removeAttr('disabled');
                }
            }
        </script>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="3"
                GridLines="None" DataKeyNames="bvin" Width="400px">
                <Columns>
                    <asp:TemplateField HeaderText="Product Image">
                    <ItemTemplate>
                    <img src="../../<%#Eval("Setting4") %>" />
                    </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Setting3" HeaderText="Product Name" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="btnUp" runat="server" CommandName="Update" ImageUrl="~/BVAdmin/Images/buttons/up.png"
                                AlternateText="Move Up"></asp:ImageButton><br />
                            <asp:ImageButton ID="btnDown" runat="server" CommandName="Cancel" ImageUrl="~/BVAdmin/Images/buttons/down.png"
                                AlternateText="Move Down"></asp:ImageButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="30px" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Image" DeleteImageUrl="~/BVAdmin/images/Buttons/X.png"
                        ShowDeleteButton="True">
                        <ItemStyle HorizontalAlign="Center" Width="30px" />
                    </asp:CommandField>
                </Columns>
                <RowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
        </asp:Panel>
    </div>
</div>

<hr />

<asp:CheckBox ID="chkShowInOrder" CssClass="formlabel" Text="Rotate products in the order shown above" runat="server" />
<br />
<table border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="formlabel">Pre-Content Html:</td>
        <td class="forminput">
            <uc:HtmlEditor ID="ucPreContentHtml" EditorHeight="200" EditorWidth="500" EditorWrap="true" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Post-Content Html:</td>
        <td class="forminput">
            <uc:HtmlEditor ID="ucPostContentHtml" EditorHeight="200" EditorWidth="500" EditorWrap="true" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel" colspan="2">
            <strong>Product Display Settings:</strong>
        </td>
    </tr>
        <tr>
        <td class="formlabel">CSS Class Prefix</td>
        <td class="formfield">
            <asp:TextBox ID="txtCssClassPrefix" Columns="40" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Display Name</td>
        <td class="formfield">
            <asp:Checkbox ID="chkDisplayName" runat="server"></asp:Checkbox>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Display Image</td>
        <td class="formfield">
            <asp:Checkbox ID="chkDisplayImage" runat="server"></asp:Checkbox>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Display New Badge</td>
        <td class="formfield">
            <asp:Checkbox ID="chkDisplayNewBadge" runat="server"></asp:Checkbox>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Display Description</td>
        <td class="formfield">
            <asp:Checkbox ID="chkDisplayDescription" runat="server"></asp:Checkbox>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Display Price</td>
        <td class="formfield">
            <asp:Checkbox ID="chkDisplayPrice" runat="server"></asp:Checkbox>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Display Add to Cart Button</td>
        <td class="formfield">
            <asp:Checkbox ID="chkDisplayAddToCartButton" runat="server"></asp:Checkbox>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Display Quantity</td>
        <td class="formfield">
            <asp:Checkbox ID="chkDisplayQuantity" runat="server"></asp:Checkbox>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Remain on Page After Add To Cart</td>
        <td class="formfield">
            <asp:Checkbox ID="chkRemainOnPageAfterAddToCart" runat="server"></asp:Checkbox>
        </td>
    </tr>
</table>

<br />

<asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/bvadmin/images/buttons/Ok.png" />

<hr />

