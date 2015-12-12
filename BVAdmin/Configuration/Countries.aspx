<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false"
    CodeFile="Countries.aspx.vb" Inherits="BVAdmin_Configuration_Countries" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <h1>Countries</h1>   
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">        
        
        <table border="0" cellspacing="0" cellpadding="0">        
            <tr>
                <td><asp:CheckBox ID="PostalCodeValidationCheckBox" runat="server" /></td>
                <td>&nbsp;Enable Postal Code Validation</td>
            </tr> 
        </table>
        
        <br />
        
        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
         
    </asp:Panel>
    
    <br />
    <br />

    <div class="f-row">
    
        <div class="six columns">
            <h2>Active Countries</h2>
            
            <asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New User" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
            <br /><br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%">
                <Columns>
                    <asp:BoundField DataField="DisplayName" HeaderText="Name" />
                    <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton OnClientClick="return window.confirm('Delete this country?');" ID="LinkButton1"
                                runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn-delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:ButtonField CommandName="Cancel" Text="Disable" />
                </Columns>
                <RowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
        </div>
        <div class="six columns">
            <h2>Disabled Countries</h2>
            <asp:ImageButton ID="ImageButton1" runat="server" AlternateText="Add New User" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
            <br /><br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%">
                <Columns>
                    <asp:BoundField DataField="DisplayName" HeaderText="Name" />
                    <asp:CommandField ShowEditButton="True" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton OnClientClick="return window.confirm('Delete this country?');" ID="LinkButton1"
                                runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:ButtonField CommandName="Cancel" Text="Activate" />
                </Columns>
                <RowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
        </div>
   	</div>
</asp:Content>
