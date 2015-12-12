<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Product_Grid_editor" %>
<%@ Register Src="../../../BVAdmin/Controls/ProductPicker.ascx" TagName="ProductPicker" TagPrefix="uc1" %>

<div class="f-row">
    <div class="six columns">
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="formlabel">
                    Grid Columns
                </td>
                <td class="forminput">
                    <asp:TextBox ID="GridColumnsField" runat="server" Columns="40"></asp:TextBox>
                    <bvc5:BVRegularExpressionValidator ControlToValidate="GridColumnsField" runat="server" ID="valGridColumns" ForeColor=" " CssClass="errormessage" ValidationExpression="[1-9]" Display="dynamic" ErrorMessage="Please Enter a Numeric Value"></bvc5:BVRegularExpressionValidator>
                </td>
            </tr>
        </table>
        <br />

        <asp:Panel ID="pnlEditor" runat="server" DefaultButton="btnNew">
            <uc1:ProductPicker ID="ProductPicker1" runat="server" DisplayKits="true" />
            <br />
            <asp:ImageButton ID="btnNew" runat="Server" ImageUrl="~/BVAdmin/Images/buttons/new.png" />
            <asp:HiddenField ID="EditBvinField" runat="server" />
        </asp:Panel>
    </div>
    <div class="six columns">
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnOkay">
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

<table border="0" cellspacing="0" cellpadding="0">  
    <tr>
        <td class="formlabel">
            Pre-Html:
        </td>
        <td class="forminput">
            <asp:TextBox ID="PreHtmlField" runat="server" Columns="40"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel">
            Post-Html:
        </td>
        <td class="forminput">
            <asp:TextBox ID="PostHtmlField" runat="server" Columns="40"></asp:TextBox>
        </td>
    </tr>
</table>

<br />

<asp:ImageButton ID="btnOkay" runat="server" ImageUrl="~/bvadmin/images/buttons/Ok.png" />
&nbsp;
<asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" CausesValidation="False" />

<hr />  

