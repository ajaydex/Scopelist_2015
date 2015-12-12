<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Fraud.aspx.vb" Inherits="BVAdmin_Configuration_Fraud" title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Fraud Screening</h1>
    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
        <tr>
            <td style="width:48%;"><strong>Emails</strong></td>
            <td style="4%;">&nbsp;</td>
            <td style="width:48%;"><strong>IP Addresses</strong></td>
        </tr>
        <tr>
        	<td>
            	<asp:Panel ID="pnlEmail" runat="server" DefaultButton="btnNewEmail">
                	<asp:TextBox ID="EmailField" runat="server" Columns="16"></asp:TextBox>&nbsp;
                	<asp:ImageButton ID="btnNewEmail" runat="server" ImageUrl="../images/buttons/new.png"></asp:ImageButton>
               	</asp:Panel>
            </td>
            <td>&nbsp;</td>
            <td>
            	<asp:Panel ID="Panel1" runat="server" DefaultButton="btnNewIP">
                	<asp:TextBox ID="IPField" runat="server" Columns="16"></asp:TextBox>&nbsp;
                	<asp:ImageButton ID="btnNewIP" runat="server" ImageUrl="../images/buttons/new.png"></asp:ImageButton>
               	</asp:Panel>
            </td>
        </tr>
        <tr>
        	<td>
                <asp:ListBox ID="lstEmail" runat="server" Rows="16" Width="140px" SelectionMode="Multiple"></asp:ListBox>
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:ListBox ID="lstIP" runat="server" Rows="16" Width="140px" SelectionMode="Multiple"></asp:ListBox>
           	</td>
       	</tr>
        <tr>
        	<td>
                <asp:ImageButton ID="btnDeleteEmail" runat="server" ImageUrl="../images/buttons/delete.png"></asp:ImageButton>
           	</td>
            <td>&nbsp;</td>
            <td>
                <asp:ImageButton ID="btnDeleteIP" runat="server" ImageUrl="../images/buttons/delete.png"></asp:ImageButton>
           	</td>
        </tr>
   	</table>
    
    <br />
    
    
    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
    	<tr>
            <td style="width:48%;"><strong>Domain Names</strong></td>
            <td style="4%;">&nbsp;</td>
            <td style="width:48%;"><strong>Phone Numbers</strong></td>
       	</tr>
        <tr>
        	<td>
            	<asp:Panel ID="Panel2" runat="server" DefaultButton="btnNewDomain">
                	<asp:TextBox ID="DomainField" runat="server" Columns="16"></asp:TextBox>&nbsp;
                	<asp:ImageButton ID="btnNewDomain" runat="server" ImageUrl="../images/buttons/new.png"></asp:ImageButton>
               	</asp:Panel>
           	</td>
            <td>&nbsp;</td>
            <td>
            	<asp:Panel ID="Panel3" runat="server" DefaultButton="btnNewPhoneNumber">
                	<asp:TextBox ID="PhoneNumberField" runat="server" Columns="16"></asp:TextBox>&nbsp;
                	<asp:ImageButton ID="btnNewPhoneNumber" runat="server" ImageUrl="../images/buttons/new.png"></asp:ImageButton>
               	</asp:Panel>
          	</td>
        </tr>
        <tr>
        	<td>
                <asp:ListBox ID="lstDomain" runat="server" Rows="16" Width="140px" SelectionMode="Multiple"></asp:ListBox>
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:ListBox ID="lstPhoneNumber" runat="server" Rows="16" Width="140px" SelectionMode="Multiple"></asp:ListBox>
           	</td>
        </tr>
        <tr>
        	<td>
                <asp:ImageButton ID="btnDeleteDomain" runat="server" ImageUrl="../images/buttons/delete.png"></asp:ImageButton>
           	</td>
           	<td>&nbsp;</td>
            <td>
                <asp:ImageButton ID="btnDeletePhoneNumber" runat="server" ImageUrl="../images/buttons/delete.png"></asp:ImageButton>
           	</td>
        </tr>
   	</table>
    
    <br />
    
    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
    	<tr>
            <td style="width:48%;"><strong>Credit Card Numbers</strong></td>
            <td style="4%;">&nbsp;</td>
            <td style="width:48%;">&nbsp;</td>
        </tr>
        <tr>
        	<td>
            	<asp:Panel ID="Panel4" runat="server" DefaultButton="btnNewCCNumber">
                	<asp:TextBox ID="CreditCardField" runat="server" Columns="16"></asp:TextBox>&nbsp;
                	<asp:ImageButton ID="btnNewCCNumber" runat="server" ImageUrl="../images/buttons/new.png"></asp:ImageButton>
               	</asp:Panel>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
        	<td>
                <asp:ListBox ID="lstCreditCard" runat="server" Rows="16" Width="140px" SelectionMode="Multiple"></asp:ListBox>
           	</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
        	<td>
                <asp:ImageButton ID="btnDeleteCCNumber" runat="server" ImageUrl="../images/buttons/delete.png"></asp:ImageButton>
           	</td>
            <td>&nbsp;</td>
           	<td>&nbsp;</td>
        </tr>
   	</table
           
 
></asp:Content>

