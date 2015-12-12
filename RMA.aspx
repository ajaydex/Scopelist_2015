<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="RMA.aspx.vb" Inherits="RMA" Title="Return Form" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <uc2:ManualBreadCrumbTrail ID="ManualBreadCrumbTrail1" runat="server" />
    <h1>
        Product Returns</h1>
    <uc1:MessageBox ID="MessageBox" runat="server" EnableViewState="false" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
    <asp:MultiView ID="RMAMultiView" runat="server" ActiveViewIndex="0">
        <asp:View ID="RMAFormView" runat="server">
            <div class="returnitems">
                <asp:GridView ID="RMAGridView" CellSpacing="1" runat="server" AutoGenerateColumns="False"
                    RowStyle-CssClass="row" AlternatingRowStyle-CssClass="altrow"
                    GridLines="none">
                    <HeaderStyle CssClass="rowheader" />
                    <Columns>
                        <asp:TemplateField HeaderText="Qty" ItemStyle-CssClass="qtycolumn">
                            <ItemTemplate>
                                <asp:HiddenField ID="bvin" runat="server" />
                                <div class="qtyfield">
                                    <asp:TextBox ID="QuantityTextBox" runat="server" Text="1" Columns="2"></asp:TextBox>
                                    <bvc5:BVRequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" ErrorMessage="Must enter a quantity"
                                        Text="*" ControlToValidate="QuantityTextBox" Display="Dynamic" ForeColor=" " CssClass="errormessage"></bvc5:BVRequiredFieldValidator>
                                    <bvc5:BVRegularExpressionValidator ID="QuantityRegexValidator" runat="server" ControlToValidate="QuantityTextBox"
                                        ValidationExpression="\d*" ErrorMessage="Must be numeric" Display="Dynamic" ForeColor=" " CssClass="errormessage"></bvc5:BVRegularExpressionValidator>
                                    <bvc5:BVRangeValidator ID="QuantityRangeValidator" runat="server" ErrorMessage="RangeValidator"
                                        Type="Integer" MinimumValue="1" MaximumValue="1" ControlToValidate="QuantityTextBox"
                                        Text="*" Display="Dynamic" ForeColor=" " CssClass="errormessage"></bvc5:BVRangeValidator>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product To Return">
                            <ItemTemplate>
                                <div class="returnitem">
                                    <div class="BVSmallText">
                                        <asp:Literal ID ="litProductSku" runat="server"></asp:Literal>
                                    </div>
                                    <strong>
                                        <asp:Literal ID ="litProductName" runat="server"></asp:Literal>
                                    </strong>
                                    <div class="returncontrols">
                                        <table cellspacing="1" cellpadding="0" border="0">
                                            <tr>
                                                <td class="formlabel">
                                                    <asp:Label ID="ReasonDropDownLabel" CssClass="required" runat="server" AssociatedControlID="ReasonDropDownList">Reason:</asp:Label>
                                                </td>
                                                <td class="formfield">
                                                    <asp:DropDownList ID="ReasonDropDownList" runat="server" CssClass="rmagrid">
                                                        <asp:ListItem Value="-1" Selected="True">-- Select One --</asp:ListItem>
                                                        <asp:ListItem Value="0">I changed my mind; didn't like</asp:ListItem>
                                                        <asp:ListItem Value="1">I ordered the wrong item</asp:ListItem>
                                                        <asp:ListItem Value="2">The item was damaged but NOT due to shipping</asp:ListItem>
                                                        <asp:ListItem Value="3">The item was damaged during shipping</asp:ListItem>
                                                        <asp:ListItem Value="4">I received the wrong item; incorrect item was shipped</asp:ListItem>
                                                        <asp:ListItem Value="5">Other... Please describe in the comment box below</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <bvc5:BVRequiredFieldValidator ID="ReasonRequiredFieldValidator" runat="server" ErrorMessage="Oops!  You must select a reason for returning this item."
                                                        Text="*" ControlToValidate="ReasonDropDownList" InitialValue="-1" Display="Dynamic" ForeColor=" " CssClass="errormessage"></bvc5:BVRequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="formlabel">
                                                    <asp:Label ID="ReplacementRadioButtonLabel" CssClass="required" runat="server" AssociatedControlID="ReplacementRadioButtonList">Replace Product:</asp:Label>
                                                </td>
                                                <td class="formfield">
                                                    <asp:RadioButtonList ID="ReplacementRadioButtonList" RepeatLayout="flow" runat="server"
                                                        RepeatDirection="Horizontal">
                                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        <asp:ListItem Selected="True" Value="0">No</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <%--<h2>Add additional item</h2>
            <table style="margin-top: 30px;">        
                <tr>
                    <td>Product Name:</td>        
                    <td>
                        <asp:TextBox ID="ProductNameTextBox" runat="server"></asp:TextBox>
                        <bvc5:BVRequiredFieldValidator ID="ProductNameRequiredFieldValidator" runat="server" ErrorMessage="Product name is required" ControlToValidate="ProductNameTextBox" ValidationGroup="AddNewItem" Text="*"></bvc5:BVRequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Product Description:</td>        
                    <td>
                        <asp:TextBox ID="ProductDescriptionTextBox" runat="server"></asp:TextBox>
                        <bvc5:BVRequiredFieldValidator ID="ProductDescriptionRequiredFieldValidator" runat="server" ErrorMessage="Product description is required" ControlToValidate="ProductDescriptionTextBox" ValidationGroup="AddNewItem" Text="*"></bvc5:BVRequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><asp:ImageButton ID="AddProductImageButton" runat="server" AlternateText="Add" CausesValidation="true" ValidationGroup="AddNewItem"/></td>
                </tr>
            </table>--%>
            <fieldset class="rmaform">
                <legend>Return Form</legend>
                <table cellspacing="1">
                    <tr>
                        <td class="formlabel">
                            <asp:Label ID="NameTextLabel" CssClass="required" runat="server" AssociatedControlID="NameTextBox"
                                Text="Name:"></asp:Label></td>
                        <td class="formfield">
                            <asp:TextBox ID="NameTextBox" CssClass="forminput required" runat="server"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox"
                                ErrorMessage="Name is required" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            <asp:Label ID="EmailTextLabel" CssClass="required" runat="server" AssociatedControlID="EmailTextBox"
                                Text="Email Address:"></asp:Label></td>
                        <td class="formfield">
                            <asp:TextBox ID="EmailTextBox" CssClass="forminput required" runat="server"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="EmailRequiredFieldValidator" runat="server" ErrorMessage="E-mail address is required"
                                ControlToValidate="EmailTextBox" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            <asp:Label ID="PhoneNumberTextLabel" CssClass="required" runat="server" AssociatedControlID="PhoneNumberTextBox"
                                Text="Phone Number:"></asp:Label></td>
                        <td class="formfield">
                            <asp:TextBox ID="PhoneNumberTextBox" CssClass="forminput required" runat="server"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="PhoneRequiredFieldValidator" runat="server" ErrorMessage="Phone number is required"
                                ControlToValidate="PhoneNumberTextBox" ForeColor=" " CssClass="errormessage">*</bvc5:BVRequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td class="formlabel aligntop">
                            <asp:Label ID="CommentsTextLabel" runat="server" AssociatedControlID="CommentsTextBox"
                                Text="Comments:"></asp:Label></td>
                        <td class="formfield">
                            <asp:TextBox ID="CommentsTextBox" CssClass="formtextarea" runat="server" Rows="3"
                                TextMode="MultiLine"></asp:TextBox></td>
                    </tr>
                </table>
                <div class="buttonrow">
                    <asp:ImageButton ID="SubmitReturnImageButton" runat="server" AlternateText="Submit Return Request"
                        ImageUrl="~/BVModules/Themes/Bvc5/images/Buttons/Submit.png" /></div>
            </fieldset>
        </asp:View>
        <asp:View ID="ThankYouView" runat="server">
            <div id="rmaThankYou">
                <h2>
                    Thank you for submitting your return request.</h2>
            </div>
            <asp:Panel ID="RMANumberPanel" runat="server" Width="100%">
                <asp:Label ID="RMANumberLabel" runat="server" Text=""></asp:Label>
            </asp:Panel>
        </asp:View>
    </asp:MultiView>
</asp:Content>