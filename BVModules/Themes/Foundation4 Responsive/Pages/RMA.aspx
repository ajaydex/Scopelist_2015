<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="RMA.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_RMA" Title="Return Form" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <h1>Product Returns</h1>
    <uc:MessageBox ID="MessageBox" runat="server" EnableViewState="false" />

    <asp:ValidationSummary ID="ValidationSummary1" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server"  DisplayMode="BulletList" ForeColor="White" ShowSummary="True" HeaderText='<a href="#" class="close">&times;</a>'></asp:ValidationSummary>

    <asp:MultiView ID="RMAMultiView" runat="server" ActiveViewIndex="0">
        <asp:View ID="RMAFormView" runat="server">

            <div class="returnitems">

                <asp:GridView ID="RMAGridView" CellSpacing="0" CellPadding="0" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="bvin" GridLines="none" ShowHeader="false" ShowFooter="false">

                    <Columns>
                        <asp:TemplateField HeaderText="Product To Return">
                            <ItemTemplate>
                                <hr />
                                <h3><%# Eval("ProductName") %> - <em><%#Eval("ProductSku")%></em></h3>
                                <div class="row">
                                    <div class="small-5 large-2 columns">
                                        <label>QTY to Return</label>
                                        <bvc5:BVRequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" Display="Dynamic" ControlToValidate="QuantityTextBox" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Must enter a quantity"></bvc5:BVRequiredFieldValidator><bvc5:BVRegularExpressionValidator ID="QuantityRegexValidator" runat="server" Display="Dynamic" ControlToValidate="QuantityTextBox" ValidationExpression="\d*" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Must be numeric"  ></bvc5:BVRegularExpressionValidator><bvc5:BVRangeValidator ID="QuantityRangeValidator" runat="server" Display="Dynamic" ControlToValidate="QuantityTextBox" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Quantity is invalid" Type="Integer" MinimumValue="1" MaximumValue="1" ></bvc5:BVRangeValidator>
                                        <asp:TextBox ID="QuantityTextBox" runat="server" Text="1" Columns="2"></asp:TextBox>
                                    </div>
                                    
                                    <div class="small-7 large-10 columns">
                                        <asp:Label ID="ReplacementRadioButtonLabel" runat="server" AssociatedControlID="ReplacementRadioButtonList">Replace Product</asp:Label>
                                        <asp:RadioButtonList ID="ReplacementRadioButtonList" runat="server" RepeatLayout="flow" RepeatDirection="Horizontal" CssClass="radiobuttonlist clearfix">
                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                            <asp:ListItem Selected="True" Value="0">No</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>  
                                <div class="row">
                                    <div class="large-6 columns">
                                        <asp:Label ID="ReasonDropDownLabel" runat="server" AssociatedControlID="ReasonDropDownList">Please specify a reason for your return.</asp:Label>
                                        <bvc5:BVRequiredFieldValidator ID="ReasonRequiredFieldValidator" runat="server" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Please select a reason for returning this item." ControlToValidate="ReasonDropDownList" InitialValue="-1" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                                        <asp:DropDownList ID="ReasonDropDownList" runat="server" CssClass="rmagrid">
                                            <asp:ListItem Value="-1" Selected="True">-- Select One --</asp:ListItem>
                                            <asp:ListItem Value="0">I changed my mind; didn't like</asp:ListItem>
                                            <asp:ListItem Value="1">I ordered the wrong item</asp:ListItem>
                                            <asp:ListItem Value="2">The item was damaged but NOT due to shipping</asp:ListItem>
                                            <asp:ListItem Value="3">The item was damaged during shipping</asp:ListItem>
                                            <asp:ListItem Value="4">I received the wrong item; incorrect item was shipped</asp:ListItem>
                                            <asp:ListItem Value="5">Other... Please describe in the comment box below</asp:ListItem>
                                        </asp:DropDownList>
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

                <div class="row">
                    <div class="large-6 columns">
                        <asp:Label ID="NameTextLabel" runat="server" AssociatedControlID="NameTextBox" Text="Name"></asp:Label>
                        <bvc5:BVRequiredFieldValidator ID="NameRequiredFieldValidator" ControlToValidate="NameTextBox" runat="server" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Name is required" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                        <asp:TextBox ID="NameTextBox" runat="server" placeholder="required"></asp:TextBox>
                    </div>
                    <div class="large-6 columns">
                        <asp:Label ID="EmailTextLabel" runat="server" AssociatedControlID="EmailTextBox" Text="Email Address"></asp:Label>
                        <bvc5:BVRequiredFieldValidator ID="EmailRequiredFieldValidator" runat="server" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> E-mail address is required" ControlToValidate="EmailTextBox" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                        <asp:TextBox ID="EmailTextBox" runat="server" placeholder="required"></asp:TextBox>
                    </div>
                </div>

                <div class="row">
                    <div class="large-6 columns end">
                        <asp:Label ID="PhoneNumberTextLabel" runat="server" AssociatedControlID="PhoneNumberTextBox" Text="Phone Number"></asp:Label> 
                        <bvc5:BVRequiredFieldValidator ID="PhoneRequiredFieldValidator" runat="server" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Phone number is required" ControlToValidate="PhoneNumberTextBox" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                        <asp:TextBox ID="PhoneNumberTextBox" runat="server" placeholder="required"></asp:TextBox>
                    </div>
                </div>

                <div class="row">
                    <div class="large-12 columns">
                        <asp:Label ID="CommentsTextLabel" runat="server" AssociatedControlID="CommentsTextBox" Text="Comments"></asp:Label>
                        <asp:TextBox ID="CommentsTextBox" runat="server" Rows="3" TextMode="MultiLine"></asp:TextBox>
                    </div>
                </div>
                    
                <div class="buttonrow">
                    <asp:ImageButton ID="SubmitReturnImageButton" runat="server" AlternateText="Submit Return Request" ImageUrl="~/BVModules/Themes/Bvc5/images/Buttons/Submit.png" />
                </div>

            </fieldset>
        </asp:View>

        <asp:View ID="ThankYouView" runat="server">
            <div id="rmaThankYou">
                <h2>Thank you for submitting your return request.</h2>
            </div>
            <asp:Panel ID="RMANumberPanel" runat="server" Width="100%">
                <asp:Label ID="RMANumberLabel" runat="server" Text=""></asp:Label>
            </asp:Panel>
        </asp:View>
    </asp:MultiView>
</asp:Content>