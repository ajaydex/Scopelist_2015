<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="GiftWrap.aspx.vb" Inherits="BVAdmin_Configuration_GiftWrap" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<h1>Gift Wrap Settings</h1>        
        <uc1:MessageBox ID="MessageBox1" runat="server" />
        <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
            <tr>
                <td class="formlabel wide">Gift Wrap for All Products:</td>
                <td class="formfield"><asp:CheckBox ID="chkGiftWrapAll" runat="server" /> Yes</td>
            </tr>
            <tr>
                <td class="formlabel wide">Global Gift Wrap Charge:</td>
                <td class="formfield"><asp:TextBox ID="txtGiftWrapCharge" runat="server"></asp:TextBox></td>
            </tr> 
        </table>   
        
        <br />
                                 
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton></td>
            
        </asp:Panel>
</asp:Content>

