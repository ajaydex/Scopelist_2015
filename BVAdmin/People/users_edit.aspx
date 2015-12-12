<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Users_Edit.aspx.vb" Inherits="BVAdmin_People_users_edit" Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/AddressEditor.ascx" TagName="AddressEditor" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Edit User</h1>
    <uc2:MessageBox ID="MessageBox1" runat="server" />
    <asp:Label ID="lblError" runat="server" CssClass="errormessage" EnableViewState="False"></asp:Label>
    
    <div class="f-row">
    	<div class="six columns">
        	<h2>Account Info</h2>
        	<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSaveChanges">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="formlabel">
                            Username:</td>
                        <td class="formfield">
                            <asp:TextBox ID="UsernameField" runat="server" Columns="30" MaxLength="100" TabIndex="2000"
                                Width="200px"></asp:TextBox><bvc5:BVRequiredFieldValidator ID="valRequiredUsername"
                                    runat="server" ErrorMessage="Please enter a Username" ControlToValidate="UsernameField">*</bvc5:BVRequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Email:</td>
                        <td class="formfield">
                            <asp:TextBox ID="EmailField" runat="server" Columns="30" MaxLength="100" TabIndex="2001"
                                Width="200px"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="val2Username" CssClass="errormessage" EnableClientScript="True"
                                runat="server" ControlToValidate="EmailField" Display="Dynamic" ErrorMessage="Please enter an email address"
                                Visible="True">*</bvc5:BVRequiredFieldValidator><bvc5:BVRegularExpressionValidator ID="valUsername"
                                    CssClass="errormessage" runat="server" ControlToValidate="EmailField" Display="Dynamic"
                                    ErrorMessage="Please enter a valid email address" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$">*</bvc5:BVRegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            First Name:</td>
                        <td class="formfield">
                            <asp:TextBox ID="FirstNameField" TabIndex="2002" runat="server" Columns="30" MaxLength="50"
                                Width="200px"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="valFirstName" CssClass="errormessage" EnableClientScript="True"
                                runat="server" ControlToValidate="FirstNameField" Display="Dynamic" ErrorMessage="Please enter a first name or nickname"
                                Visible="True">*</bvc5:BVRequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Last Name:</td>
                        <td class="formfield">
                            <asp:TextBox ID="LastNameField" TabIndex="2003" runat="server" Columns="30" MaxLength="50"
                                Width="200px"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" CssClass="errormessage"
                                EnableClientScript="True" runat="server" ControlToValidate="LastNameField" Display="Dynamic"
                                ErrorMessage="Please enter a last name" Visible="True">*</bvc5:BVRequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Tax Exempt:</td>
                        <td class="formfield">
                            <asp:CheckBox ID="chkTaxExempt" runat="server" TabIndex="2004"></asp:CheckBox></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Password Format:</td>
                        <td class="formfield">
                            <asp:DropDownList ID="PasswordFormatField" runat="server" TabIndex="2005">
                                <asp:ListItem Value="0">Clear Text (Not PCI Compliant)</asp:ListItem>
                                <asp:ListItem Value="2">Encrypted (Not PCI Compliant)</asp:ListItem>
                                <asp:ListItem Value="1">Hashed (Recommended)</asp:ListItem>                        
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Password:</td>
                        <td class="formfield">
                            <asp:TextBox ID="PasswordField" autocomplete="off" runat="server" Columns="30" Width="200px" TabIndex="2006"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="valPassword" runat="server" ControlToValidate="PasswordField"
                                ErrorMessage="A password is required" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>&nbsp;
                            <bvc5:BVRegularExpressionValidator ID="PasswordRegularExpressionValidator" runat="server"
                                ControlToValidate="PasswordField" Display="Dynamic" ErrorMessage="Password must be at least 6 characters long.">*</bvc5:BVRegularExpressionValidator>
                        </td>
                    </tr>
                    <tr id="trResetPassword" runat="server">
                        <td class="formlabel"></td>
                        <td class="formfield">
                            <asp:ImageButton ID="btnResetPassword" OnClientClick="return window.confirm('Reset this user\'s password?');" ImageUrl="../images/buttons/ResetPassword.png" runat="server" /><br />
                            <span class="smalltext">Generate new password &amp; email to user</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Password Hint:</td>
                        <td class="formfield">
                            <asp:TextBox ID="PasswordHintField" runat="server" Columns="30" Width="200px" TabIndex="2007"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Password Answer:</td>
                        <td class="formfield">
                            <asp:TextBox ID="PasswordAnswerField" runat="server" Columns="30" Width="200px" TabIndex="2008"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Account Locked:</td>
                        <td class="formfield">
                            <asp:CheckBox ID="LockedField" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Notes:</td>
                        <td class="formfield">
                            <asp:TextBox ID="CommentField" runat="server" Columns="30" Rows="3" TextMode="MultiLine"
                                Width="200px" TabIndex="2009"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Pricing Group</td>
                        <td class="formfield">
                            <asp:DropDownList ID="PricingGroupDropDownList" runat="server">
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Sales Person:</td>
                        <td class="formfield">
                            <asp:CheckBox ID="IsSalesPersonField" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="formlabel">Custom Question Answers:</td>
                        <td class="formfield">
                            <asp:TextBox ID="CustomQuestionAnswerTextBox" runat="server" Columns="30" Rows="3" TextMode="MultiLine" Width="200px" TabIndex="2011"></asp:TextBox>
                       	</td>
                    </tr>
                </table>
    		</asp:Panel>
        </div>
        
        <div class="six columns">
			<asp:Placeholder ID="phImpersonate" runat="server">
	            <div id="impersonate" class="controlarea1">
	                <asp:ImageButton ID="btnImpersonate" Text="Impersonate" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Impersonate.png" /><br />
                    <asp:label ID="lblImpersonate" runat="server" class="smalltext"></asp:Label>
	            </div>
	        </asp:Placeholder>
            <h2>Billing and Shipping Address</h2>
            <table style="margin: 10px 0 20px; width:100%;" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td valign="top">
                        <span class="lightlabel">Billing Address:</span><br />
                        &nbsp;<br />
                        <asp:Label runat="server" ID="BillingAddressField"></asp:Label><br />
                        <asp:ImageButton ID="btnBillingAddressEdit" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png"
                            AlternateText="Edit" /></td>
                    <td valign="top">
                        <span class="lightlabel">Shipping Address:</span><br />
                        &nbsp;<br />
                        <asp:Label runat="server" ID="ShippingAddressField"></asp:Label><br />
                        <asp:ImageButton ID="btnShippingAddressEdit" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png"
                            AlternateText="Edit" />
                    </td>
                </tr>
            </table>
            
            <hr />
            
            <asp:ImageButton ID="btnNewAddress" runat="server" ImageUrl="../images/buttons/New.png" AlternateText="Add New Address" class="right"></asp:ImageButton>
            <h2>Address Book</h2>
            <div style="height: 275px; overflow: auto; border: 1px solid #ccc; padding: 15px; margin-bottom:10px;">
                <asp:DataList ID="AddressList" runat="server" CellSpacing="5" RepeatDirection="Horizontal" RepeatColumns="1" DataKeyField="bvin">
                    <ItemTemplate>
                        <asp:Label CssClass="BVSmallText" runat="server" ID="AddressDisplay" Text='<%# DataBinder.Eval(Container, "DataItem.FirstName") %>'></asp:Label><br />
                        <asp:ImageButton CommandName="Edit" ID="EditButton" ImageUrl="../Images/Buttons/Edit.png" AlternateText="Edit" runat="server" />&nbsp;
                        <asp:ImageButton CommandName="Delete" ID="DeleteButton" ImageUrl="../Images/Buttons/X.png" AlternateText="Delete" runat="server" />
                        <asp:ImageButton CommandName="BillTo" ID="BillToImageButton" ImageUrl="../Images/Buttons/BillTo.png" AlternateText="Set As Default Billing Address" runat="server" OnClientClick="return window.confirm('Make this the default Billing Address?');" /> 
                        <asp:ImageButton CommandName="ShipTo" ID="ShipToImageButton" ImageUrl="../Images/Buttons/ShipTo.png" AlternateText="Set As Default Shipping Address" runat="server" OnClientClick="return window.confirm('Make this the default Shipping Address?');" />
                        <hr />
                    </ItemTemplate>
                </asp:DataList>
            </div>
            
			<h2>Loyalty Points</h2>
	        <table cellspacing="0" cellpadding="3" style="width: 100%">
	            <tbody>
	                <tr class="rowheader">
	                    <td>Points</td>
	                    <td>Currency</td>
	                    <td></td>
	                </tr>
	                <tr class="row">
	                    <td><asp:Label ID="lblLoyaltyPoints" runat="server" /></td>
	                    <td><asp:Label ID="lblLoyaltyPointsCurrency" runat="server" /></td>
	                    <td><asp:HyperLink ID="lnkLoyaltyPoints" ImageUrl="../images/buttons/Edit.png" Target="_blank" ToolTip="Edit Loyalty Points" onclick="window.open(this.href, 'popup', 'width=600, height=530, scrollbars=yes'); return false;" runat="server" /></td>
	                </tr>
	            </tbody>
	        </table>

        </div>
    </div>
    
    <hr />
    
    <h2>Groups</h2>
    <table cellpadding="0" border="0" cellspacing="0" style="width:100%;">
        <tr>
            <td style="width:45%;">Member of</td>
            <td style="width:10%;">&nbsp;</td>
            <td style="width:45%;">Groups</td>
        </tr>
        <tr>
            <td>
                <asp:ListBox ID="MemberList" runat="server" SelectionMode="Multiple" Rows="7" TabIndex="2700"></asp:ListBox>
            </td>
            <td align="center">
                <asp:ImageButton ID="AddButton" runat="server" ImageUrl="../images/buttons/left.png"></asp:ImageButton>
                <br />
                <br />
                <asp:ImageButton ID="RemoveButton" runat="server" ImageUrl="../images/buttons/right.png"></asp:ImageButton>
            </td>
            <td>
                <asp:ListBox ID="NonMemberList" runat="server" Rows="7" style="width:100%;" SelectionMode="Multiple" TabIndex="2701"></asp:ListBox>
            </td>
        </tr>
    </table>
    
    <hr />
    
    <asp:HyperLink ID="lnkNewOrder" Visible="false" runat="server" ImageUrl="../images/buttons/New.png" AlternateText="New Order" class="right"></asp:HyperLink>
    <h2>Order History</h2>
    <asp:Label ID="lblItems" runat="server">Orders Found</asp:Label><br>
    <div style="overflow:scroll; max-height:250px;">
        <asp:DataGrid ID="dgOrders" runat="server" Width="100%" AutoGenerateColumns="False" GridLines="None" CellPadding="0" DataKeyField="bvin">
            <AlternatingItemStyle CssClass="alternaterow"></AlternatingItemStyle>
            <HeaderStyle CssClass="rowheader"></HeaderStyle>
            <ItemStyle CssClass="row" />
            <Columns>
                <asp:BoundColumn DataField="OrderNumber" HeaderText="Order Number"></asp:BoundColumn>
                <asp:BoundColumn DataField="GrandTotal" HeaderText="Total" DataFormatString="{0:c}">
                </asp:BoundColumn>
                <asp:BoundColumn DataField="TimeOfOrder" HeaderText="Date"></asp:BoundColumn>
                <asp:TemplateColumn>
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    <ItemTemplate>
                        <asp:ImageButton ID="DetailsButton" runat="server" ImageUrl="../images/buttons/orderdetails.png"
                            CommandName="Edit" CausesValidation="false"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
    </div>
            
    <hr />
          
    <h2>Search History</h2>
    <div style="overflow:scroll; max-height:250px;">
        <asp:DataGrid ID="dgSearchHistory" runat="server" Width="100%" AutoGenerateColumns="false" GridLines="none" CellPadding="0" DataKeyField="bvin">
        	<AlternatingItemStyle CssClass="alternaterow"></AlternatingItemStyle>
            <HeaderStyle CssClass="rowheader"></HeaderStyle>
            <ItemStyle CssClass="row" />
            <Columns>
                <asp:BoundColumn DataField="QueryPhrase" HeaderText="Query Phrase"></asp:BoundColumn>
                <asp:BoundColumn DataField="LastUpdated" HeaderText="Date Searched"></asp:BoundColumn>
            </Columns>
        </asp:DataGrid>
    </div>
           
    <hr />
    
    <h2>User Wishlist</h2>
    <div style="overflow:scroll; max-height:250px;">
    <asp:DataList ID="DataList1" runat="server" CellPadding="0" GridLines="none" Width="100%" RepeatColumns="0" DataKeyField="bvin">
    	<AlternatingItemStyle CssClass="alternaterow"></AlternatingItemStyle>
        <HeaderStyle CssClass="rowheader"></HeaderStyle>
        <ItemStyle CssClass="row" />
        <ItemTemplate>
            <a href="../../BVAdmin/Catalog/Products_Edit.aspx?id=<%#Eval("bvin") %>">
                <img src="../../<%#Eval("ImageFileSmall") %>" border="none" />
                <br />
                <%#Eval("ProductName") %>
            </a>
        </ItemTemplate>
    </asp:DataList>
    </div> 
    
    <hr />   
    
    <br />
    <asp:ImageButton ID="btnCancel" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
    &nbsp;
    <asp:ImageButton ID="btnSaveChanges" TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
    
     
    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>
