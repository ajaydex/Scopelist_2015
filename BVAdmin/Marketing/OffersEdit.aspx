<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="OffersEdit.aspx.vb" Inherits="BVAdmin_Marketing_OffersEdit" title="Untitled Page" %>
<%@ PreviousPageType VirtualPath="~/BVAdmin/Marketing/Default.aspx" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core" TagPrefix="cc1" %>
<%@ Register Src="../Controls/DatePicker.ascx" TagName="DatePicker" TagPrefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

	<h1>Offers Edit</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />   
	
	<h2>General Information</h2>
                    
    <table cellspacing="0" cellpadding="0" border="0" class="linedTable">
        <tr>
            <td class="formlabel">
                Name
            </td>
            <td class="formfield" colspan="2">
                <asp:TextBox ID="OfferNameTextBox" runat="server" columns="60"></asp:TextBox>
                <bvc5:BVRegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="OfferNameTextBox" ErrorMessage="Name must be between 1 and 50 characters" ValidationExpression=".{1,50}" Display="Dynamic">*</bvc5:BVRegularExpressionValidator>
                <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="OfferNameTextBox" ErrorMessage="Offer Name Is Required." display="Dynamic">*</bvc5:BVRequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Start Date
            </td>
            <td class="formfield" colspan="2">
                <uc2:DatePicker ID="StartDatePicker" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                End Date
            </td>
            <td class="formfield" colspan="2">
                <div style="float:left;margin-right:10px;"><uc2:DatePicker ID="EndDatePicker" runat="server" /></div>
                <bvc5:BVCustomValidator ID="CustomValidator1" runat="server" ErrorMessage="End date must be greater than start date.">*</bvc5:BVCustomValidator>
            </td>
        </tr>
        
    </table>

    <div class="controlarea1">
        <asp:PlaceHolder ID="EditPlaceHolder" runat="server"></asp:PlaceHolder>
   	</div> 

    <br />
    <br />

    <h2>Offer Use</h2>
    <asp:CheckBox ID="RequiresCouponCodeCheckBox" runat="server" /> Requires promotional code
    
    <table cellspacing="0" cellpadding="0" border="0">
        <%-- 
        <tr>
            <td>
                Generate unique promotional codes</td>
            <td>
                <asp:CheckBox ID="UniquePromotionalCodesCheckBox" runat="server" /></td>
        </tr>
        --%>
        <tr>
            <td class="formlabel">
                Promotion Code
           	</td>
            <td>
                <asp:TextBox ID="PromotionCodeTextBox" runat="server" Width="213px"></asp:TextBox>
          	</td>
        </tr>
    </table>
    
   	<table cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td class="formlabel">
                Use type
           	</td>
            <td>
                <div style="padding-bottom:5px;padding-top:10px;"><asp:RadioButton ID="UnlimitedRadioButton" runat="server" Checked="True" GroupName="UseType" Text="Unlimited" /></div>
                <div style="padding-bottom:5px;"><asp:RadioButton ID="PerCustomerRadioButton" runat="server" GroupName="UseType" Text="Per customer" />
                	<asp:TextBox ID="UsePerPersonTextBox" runat="server" Width="77px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text="time(s)"></asp:Label>
                    <bvc5:BVCustomValidator ID="PerCustomerCustomValidator" runat="server" ControlToValidate="UsePerPersonTextBox" ErrorMessage="Number of times per customer must be set and has to be greater than 0.">*</bvc5:BVCustomValidator>
                </div>
                <div style="padding-bottom:5px;">
                	<asp:RadioButton ID="PerStoreRadioButton" runat="server" GroupName="UseType" Text="Per store" />
                    <asp:TextBox ID="UsePerStoreTextBox" runat="server" Width="73px"></asp:TextBox>
                    <asp:Label ID="Label2" runat="server" Text="time(s)"></asp:Label>
                    <bvc5:BVCustomValidator ID="PerStoreCustomValidator" runat="server" ControlToValidate="UsePerStoreTextBox" ErrorMessage="Number of times per store must be set and has to be greater than 0.">*</bvc5:BVCustomValidator>
         		</div>
            </td>
        </tr>  
 	</table>
    
    
    <h2>Restrictions</h2>
    <asp:CheckBox ID="PromotionCodeCantBeCombinedCheckBox" runat="server" /> Promotion may NOT be combined with other promotional codes
    

    <hr />
			
    <asp:ImageButton ID="CancelImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" CausesValidation="False" />
    &nbsp;
    <asp:ImageButton ID="SaveImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
    
    
    <uc1:MessageBox ID="MessageBox2" runat="server" />    
</asp:Content>

