<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false"
    CodeFile="SiteTerms.aspx.vb" Inherits="BVAdmin_Content_SiteTerms" Title="Untitled Page"
    MaintainScrollPositionOnPostback="true" ValidateRequest="false" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Site Terms</h1>
    <anthem:Panel AutoUpdateAfterCallBack="true" runat="server">
        <uc1:MessageBox ID="MessageBox1" runat="server" />
    </anthem:Panel>    
    <div class="controlarea1">
        <table cellspacing="0" cellpadding="0">
            <tr>
                <td class="formlabel">
                    Term:  
                </td>
                <td class="formfield">
                    <asp:TextBox ID="SiteTermTextBox" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Value: 
                </td>
                <td>
                    <asp:TextBox ID="SiteTermValueTextBox" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table> 
        <br />
        <asp:ImageButton ID="NewImageButton" ImageUrl="~/BVAdmin/Images/Buttons/New.png" runat="server" />
    </div>
    
    <br />
 
    <div id="GridViewDiv">
        <asp:Panel ID="pnlDefaultButton" DefaultButton="btnDefault" runat="server">
            <anthem:GridView ID="TermsGridView" runat="server" AutoGenerateColumns="False" GridLines="none">
                <Columns>
                    <asp:BoundField DataField="SiteTerm" HeaderText="Term" ReadOnly="True" />
                    <asp:BoundField DataField="SiteTermValue" HeaderText="Value" />
                    <asp:CommandField ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/BVAdmin/Images/Buttons/CancelSmall.png"
                        DeleteImageUrl="~/BVAdmin/Images/Buttons/Delete.png" EditImageUrl="~/BVAdmin/Images/Buttons/Edit.png"
                        UpdateImageUrl="~/BVAdmin/Images/Buttons/Update-small.png" />
                    <asp:CommandField ShowDeleteButton="True" ButtonType="Image" DeleteImageUrl="~/BVAdmin/Images/Buttons/Delete.png" />
                </Columns>
                <RowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </anthem:GridView>
            <asp:Button ID="btnDefault" style="display:none" runat="server" />
        </asp:Panel>
    </div>
    <anthem:Panel ID="Panel1" AutoUpdateAfterCallBack="true" runat="server">
        <uc1:MessageBox ID="MessageBox2" runat="server" />
    </anthem:Panel>
</asp:Content>