<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" 
CodeFile="ProductReviews.aspx.vb" Inherits="BVAdmin_Configuration_ProductReviews" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
  
    <h1>Product Reviews</h1>
    <uc1:MessageBox ID="msg" runat="server" />
    <table cellspacing="0" cellpadding="0" border="0" class="linedTable">
        <tr>
            <td class="formlabel"  >Allow Product Reviews?</td>
            <td  ><asp:checkbox id="chkProductReviewAllow" Runat="server"></asp:checkbox> Yes</td>
        </tr>
        <tr>
            <td class="formlabel"  >Show Product Reviews on Site?</td>
            <td  ><asp:checkbox id="chkProductReviewShow" Runat="server"></asp:checkbox> Yes</td>
        </tr>
        <tr>
            <td class="formlabel"  >Moderate Product Reviews?</td>
            <td  ><asp:checkbox id="chkProductReviewModerate" Runat="server"></asp:checkbox> Yes</td>
        </tr>
        <tr>
            <td class="formlabel"  >Allow Product Rating?</td>
            <td  ><asp:checkbox id="chkProductReviewShowRating" Runat="server"></asp:checkbox> Yes</td>
        </tr>
        <tr>
            <td class="formlabel"  >
                Allow Karma Scores?</td>
            <td  ><asp:checkbox id="chkProductReviewShowKarma" Runat="server"></asp:checkbox> Yes</td>
        </tr>
        <tr>
            <td class="formlabel"  >Show how many reviews at first?</td>
            <td  ><asp:textbox id="ProductReviewCountField" runat="server" CssClass="FormInput" Columns="3">3</asp:textbox></td>
        </tr>
        <tr>
            <td class="FormLabel" valign="top" align="right">Send email notification</td>
            <td>
                <asp:CheckBox ID="chkSendProductReviewNotificationEmail" runat="server" /> Yes
            </td>
        </tr>
        <tr>
            <td class="FormLabel" valign="top" align="right">Email Template</td>
            <td>
                <asp:HyperLink Text="edit" NavigateUrl="~/BVAdmin/Content/EmailTemplates_Edit.aspx?id=fc2bf4e9-65cf-4d3e-8d64-c039f8de29ee" runat="server" />
            </td>
        </tr>
 	</table>
    	
    <br />
    <br />
    <asp:imagebutton id="btnCancel" Runat="server" CausesValidation="False" ImageUrl="../images/buttons/Cancel.png"></asp:imagebutton>
    <asp:imagebutton id="btnSave" Runat="server" ImageUrl="../images/buttons/OK.png"></asp:imagebutton>
  
</asp:Content>

