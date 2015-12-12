<%@ Control Language="VB" AutoEventWireup="false" CodeFile="UserFilter.ascx.vb" Inherits="BVAdmin_Controls_UserFilter" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Panel ID="Panel1" runat="server" DefaultButton="btnGo" class="controlarea1">
    <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td class="formlabel">
                <label title="First Name">First Name</label>
            </td>                   
            <td>
                <asp:TextBox ID="FirstNameTextBox" runat="server"></asp:TextBox>            
            </td>
            <td class="formlabel">
                <label title="Last Name">Last Name</label>
            </td>
            <td>
                <asp:TextBox ID="LastNameTextBox" runat="server"></asp:TextBox>           
            </td>
            
            <td>                
            </td>
        </tr>
        <tr>
           <td class="formlabel">
                <label title="User Name">User Name</label>
           </td>            
           <td>
                <asp:TextBox ID="UserNameTextBox" runat="server"></asp:TextBox>            
           </td>
           <td class="formlabel">
                <label title="E-mail">E-mail</label>
           </td>
           <td>
                <asp:TextBox ID="EmailTextBox" runat="server"></asp:TextBox>           
           </td>
           <td>
                <asp:ImageButton ID="btnGo" runat="server" AlternateText="Filter Results" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" />
           </td>
        </tr>
    </table>   
</asp:Panel>