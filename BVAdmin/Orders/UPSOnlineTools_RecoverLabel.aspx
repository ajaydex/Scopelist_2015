<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="UPSOnlineTools_RecoverLabel.aspx.vb" Inherits="BVAdmin_Orders_UPSOnlineTools_RecoverLabel"
    Title="UPS Online Tools" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">    
    <h1>UPS<sup>&reg;</sup> Online Tools - Recover A Label</h1>
    <uc1:MessageBox ID="MessageBox" runat="Server" />
    <table cellspacing="0" cellpadding="0" width="600" border="0">
        <tr>
            <td class="formlabel">Tracking Number</td>
            <td class="formfield">
                <asp:TextBox ID="TextBox1" runat="server" Columns="40">1Z</asp:TextBox> <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Search.png">
                </asp:ImageButton>
           	</td>
        </tr>
   	</table>
    <br />
    <br />
    <asp:HyperLink ID="lnkView" Visible="False" runat="server" ImageUrl="~/BVAdmin/images/buttons/ViewPrintlabel.png" Target="_blank">View/Print Label</asp:HyperLink><br />
    <br />
    <br />
           
   
</asp:Content>
