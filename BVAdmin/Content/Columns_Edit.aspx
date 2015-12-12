<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Columns_Edit.aspx.vb" Inherits="BVAdmin_Content_Columns_Edit" Title="Untitled Page" %>

<%@ Register Src="../Controls/ContentColumnEditor.ascx" TagName="ContentColumnEditor" TagPrefix="uc2" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Edit Column </h1>
    <uc1:MessageBox ID="msg" runat="server" EnableViewState="false" />
    
    <uc2:ContentColumnEditor ID="ContentColumnEditor" runat="server" />
    
    <asp:ImageButton ID="btnOk" runat="server" AlternateText="Back to Column List" ImageUrl="~/BVAdmin/Images/Buttons/OK.png" />
    
    <hr />
    <h2>Advanced Options</h2>
    <asp:Panel ID="pnlAdvanced" runat="server" DefaultButton="btnClone">      
    	<table>
        	<tr>
            	<td class="formlabel">Copy To:</td>
                <td>
                	<asp:DropDownList ID="CopyToList" runat="server" Width="350px"></asp:DropDownList>
                    &nbsp;
                	<asp:ImageButton ID="btnCopyBlocks" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" />
                </td>
            </tr>
            <tr>
            	<td class="formlabel">
                	Clone As:
                </td>
                <td>
                	<asp:TextBox ID="CloneNameField" runat="server" Columns="20" Width="345px"></asp:TextBox>
                    &nbsp;
                    <asp:ImageButton ID="btnClone" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    
</asp:Content>
