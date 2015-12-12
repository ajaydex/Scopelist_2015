<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="OrderStatusCodes.aspx.vb" Inherits="BVAdmin_Configuration_OrderStatusCodes" title="Order Status Codes" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<h1>Order Status Codes</h1>
<uc1:MessageBox ID="msg" runat="server" /><br />
Status Name: <asp:TextBox ID="NewStatusNameField" Width="300" runat="server"></asp:TextBox> <asp:ImageButton ID="btnNet" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/New.png" AlternateText="Add New Status Code" /><br />
&nbsp;<br />
      <asp:GridView ID="GridView1" runat="server" ShowHeader="true" AutoGenerateColumns="False" DataKeyNames="bvin"
        BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%">
        <Columns>
            <asp:BoundField DataField="StatusName" HeaderText="Status Name" />
            <asp:CheckBoxField DataField="SystemCode" HeaderText="System Status?" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="btnUp" runat="server" CommandName="Update" ImageUrl="~/BVAdmin/images/buttons/Up.png"
                        AlternateText="Move Up"></asp:ImageButton><br />
                    <asp:ImageButton ID="btnDown" runat="server" CommandName="Cancel" ImageUrl="~/BVAdmin/images/buttons/Down.png"
                        AlternateText="Move Down"></asp:ImageButton>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
            </asp:TemplateField>
            <asp:CommandField ButtonType="Image" DeleteImageUrl="~/BVAdmin/Images/Buttons/X.png"
                ShowDeleteButton="True">
                <ItemStyle HorizontalAlign="Center" Width="80px" />
            </asp:CommandField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="row" />
    </asp:GridView>
&nbsp;<br />
<asp:ImageButton ID="btnOk" runat="server" AlternateText="ok" ImageUrl="~/BVAdmin/Images/Buttons/Ok.png" />
</asp:Content>


