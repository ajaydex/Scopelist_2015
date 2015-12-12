<%@ Control Language="VB" AutoEventWireup="false" CodeFile="KitComponentViewer.ascx.vb" Inherits="BVAdmin_Controls_KitComponentViewer" %>
<asp:GridView Width="100%" CellSpacing="0" cellpadding="0" GridLines="None" AlternatingRowStyle-CssClass="alternaterow" RowStyle-CssClass="row" DataKeyNames="bvin" ShowHeader="false" ID="GridView1" runat="server" AutoGenerateColumns="False">
    <Columns>
        <asp:TemplateField>
        <ItemTemplate>
            <asp:Literal ID="DescriptionLiteral" runat="server"></asp:Literal>
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemStyle Width="60" />
            <ItemTemplate>
                <asp:ImageButton CommandName="Edit" ID="btnEdit" runat="server" AlternateText="Edit" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" />   
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemStyle Width="60" />
            <ItemTemplate>
                <asp:ImageButton CommandName="Delete" ID="btnDelete" runat="server" AlternateText="Delete" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" OnClientClick="return window.confirm('Delete this part?');" />   
            </ItemTemplate>
        </asp:TemplateField>        
        <asp:TemplateField>
            <ItemStyle Width="20" />
            <ItemTemplate>
                <asp:ImageButton CommandName="Update" ID="btnUp" runat="server" AlternateText="Move Up" ImageUrl="~/BVAdmin/Images/Buttons/Up.png" />   
            </ItemTemplate>
            </asp:TemplateField>
        <asp:TemplateField>
            <ItemStyle Width="20" />
            <ItemTemplate>
                <asp:ImageButton CommandName="Cancel" ID="btnDown" runat="server" AlternateText="Move Down" ImageUrl="~/BVAdmin/Images/Buttons/Down.png" />   
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:HiddenField ID="ComponentIdField" runat="server" />
