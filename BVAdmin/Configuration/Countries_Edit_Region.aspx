<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Countries_Edit_Region.aspx.vb" Inherits="BVAdmin_Configuration_Countries_Edit_Region" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
 <h1>
        Edit Region</h1>
    <div style="float: left; width: 350px;">
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSaveChanges">
        <table border="0" cellspacing="0" cellpadding="0">             
            <tr>
                <td class="formlabel">
                    Name:</td>
                <td class="formfield">
                    <asp:TextBox ID="NameField" runat="server" Columns="30" MaxLength="100" TabIndex="2001"
                        Width="180px"></asp:TextBox><bvc5:BVRequiredFieldValidator ID="val1" runat="server" ErrorMessage="Please enter a Name" ControlToValidate="NameField">*</bvc5:BVRequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Abbreviation:</td>
                <td class="formfield">
                    <asp:TextBox ID="AbbreviationField" runat="server" Columns="5" MaxLength="50" TabIndex="2002"
                        Width="50px"></asp:TextBox>
                 </td>
            </tr>          
            <tr>
                <td class="formlabel">
                    <asp:ImageButton ID="btnCancel" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Cancel.png"
                        CausesValidation="False"></asp:ImageButton></td><td class="formfield"><asp:ImageButton ID="btnSaveChanges"
                            TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton></td>
            </tr>
        </table>
    </asp:Panel>
    <asp:HiddenField ID="BvinField" runat="server" />
    <asp:HiddenField ID="CountryIDField" runat="server" />
    </div>
    <div style="float: left; width: 350px;">
        <h2>
            Counties</h2>
        <div style="text-align: right; margin-top: 3px; margin-bottom: 3px;"><asp:Panel ID="pnlCounty" DefaultButton="btnNew" runat="server">
            <asp:TextBox ID="NewCountyField" runat="server" Columns="15" Width="175px"></asp:TextBox>&nbsp;
            <asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New County" ImageUrl="~/BVAdmin/Images/Buttons/New.png" /></asp:Panel></div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin"
            BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton OnClientClick="return window.confirm('Delete this county?');" ID="LinkButton1"
                            runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="row" />
            <HeaderStyle CssClass="rowheader" />
            <AlternatingRowStyle CssClass="alternaterow" />
        </asp:GridView>
    </div>
</asp:Content>

