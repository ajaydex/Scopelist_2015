<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="BVAdmin_Plugins_Default" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">    
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="viewNoPlugins" runat="server">
            <h1>No plug-ins available.</h1>
        </asp:View>
        <asp:View ID="viewChooseDefault" runat="server">
            <h1>Please select a default plug-in</h1>
            <table>
                <tr>
                    <td><asp:DropDownList ID="DefaultPluginDropDownList" runat="server">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td><asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="~/BVAdmin/images/buttons/SaveChanges.png">
                        </asp:ImageButton></td>
                </tr>
            </table>        
        </asp:View>
        
    </asp:MultiView>
</asp:Content>

