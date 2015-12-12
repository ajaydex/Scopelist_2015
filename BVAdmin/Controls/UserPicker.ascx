<%@ Control Language="VB" AutoEventWireup="false" CodeFile="UserPicker.ascx.vb" Inherits="BVAdmin_Controls_UserPicker" %>
<%@ Reference Control="~/BVAdmin/Controls/MessageBox.ascx" %>

<asp:Panel ID="wrapper" runat="server" DefaultButton="btnValidateUser">
    <span>Username:</span>
    <br />
    <asp:TextBox ID="UserNameField" runat="server" Columns="30" TabIndex="3000"></asp:TextBox>
    <asp:ImageButton ID="btnValidateUser" runat="server" CausesValidation="false" AlternateText="Validate User" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" TabIndex="3010" />
    
    <br />
    <br />
    <asp:ImageButton ID="btnBrowseUsers" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Browse.png" AlternateText="Browse for User Account" CausesValidation="false" />
    <asp:ImageButton ID="btnNewUser" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/New.png" AlternateText="Add New User Account" CausesValidation="false" />
    
    
    <asp:Panel CssClass="controlarea2" ID="pnlUserBrowser" runat="server" Visible="false" DefaultButton="btnGoUserSearch">
        <span>User Browser Filter:</span>
        <br />
        <asp:TextBox ID="FilterField" runat="server" Columns="30"></asp:TextBox>
        <asp:ImageButton ID="btnGoUserSearch" runat="server" AlternateText="Filter Results" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" CausesValidation="false" />
        
        <div style="width:100%; height:200px; margin-top:10px; overflow:auto;">
            <asp:GridView ShowHeader="false" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" cellpadding="0" GridLines="None" style="width:100%;">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="lblUsername" runat="server" Text='<%# Bind("Username") %>'>'></asp:Label><br />
                            <span class="smalltext">
                                <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("Email") %>'>'></asp:Label><br />
                                <asp:Label ID="lblFirstName" runat="server" Text='<%# Bind("FirstName") %>'>'></asp:Label>
                                <asp:Label ID="lblLastName" runat="server" Text='<%# Bind("LastName") %>'>'></asp:Label>
                            </span>
                    	</ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="SelectUserButton" runat="server" CausesValidation="false" CommandName="Edit"
                                ImageUrl="~/BVAdmin/Images/Buttons/Go.png" AlternateText="Select User"></asp:ImageButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
        </div>
        
        <asp:ImageButton ID="btnBrowserUserCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Close.png" AlternateText="Close Browser" />
    </asp:Panel>
    <asp:Panel CssClass="controlarea2" ID="pnlNewUser" runat="server" Visible="false">
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="formlabel">
                    Username:</td>
                <td class="formfield">
                    <asp:TextBox ID="NewUserNameField" runat="server" Columns="15"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Email:</td>
                <td class="formfield">
                    <asp:TextBox ID="NewUserEmailField" runat="server" Columns="15"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    First Name:</td>
                <td class="formfield">
                    <asp:TextBox ID="NewUserFirstNameField" runat="server" Columns="15"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Last Name:</td>
                <td class="formfield">
                    <asp:TextBox ID="NewUserLastNameField" runat="server" Columns="15"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    <asp:ImageButton ID="btnNewUserCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
                <td class="formfield">
                    <asp:ImageButton ID="btnNewUserSave" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Ok.png" /></td>
            </tr>
        </table>
    </asp:Panel>
</asp:Panel>
