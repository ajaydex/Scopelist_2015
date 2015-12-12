<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Service.master" AutoEventWireup="false" CodeFile="AffiliateSignup.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_AffiliateSignup" title="Affiliate Signup" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/StoreAddressEditor.ascx" TagName="StoreAddressEditor" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <h2><asp:Label ID="TitleLabel" runat="server">Affiliate Signup</asp:Label></h2>
    
    <uc:MessageBox ID="MessageBox1" runat="server" />

    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />

    <asp:MultiView ID="AffiliateMultiView" runat="server" ActiveViewIndex="0">
        <asp:View ID="IntroView" runat="server">
            <div id="affiliateIntro" runat="server"></div>
            <br />
            <p><asp:LinkButton ID="SignUpLinkButton" runat="server" CssClass="button medium">Sign Up Now</asp:LinkButton></p>
        </asp:View>
        <asp:View ID="FormView" runat="server">
            <fieldset id="affiliateform">
                <table id="AffiliateFormTable" runat="server">
                    <tr>
                        <td>
                            <uc:StoreAddressEditor ID="StoreAddressEditor1" runat="server" TabOrderOffSet="300" />
                        </td>
                    </tr>
                    <tr>
                        <td>


                            <table id="QuestionTable" runat="server">
                                <tr>
                                    <td class="formlabel">
                                        <asp:Label ID="DisplayNameLabel" runat="server" Text="Email Address:" AssociatedControlID="DisplayNameField"></asp:Label></td>
	                                <td class="formfield">
                                        <asp:TextBox ID="DisplayNameField" runat="server" Columns="40" CssClass="forminput"
                                            TabIndex="320"></asp:TextBox>
                                        <bvc5:BVRequiredFieldValidator ID="valEmail" runat="server" ErrorMessage="Email Address is Required"  ControlToValidate="DisplayNameField" ForeColor=" " CssClass="errormessage"></bvc5:BVRequiredFieldValidator>
	                                </td>
                                </tr>
                                <tr>
                                    <td class="formlabel">
                                        <asp:Label ID="WebSiteURLLabel" runat="server" Text="Your Site's URL:" AssociatedControlID="WebSiteURLField"></asp:Label></td>
	                                <td class="formfield">
                                        <asp:TextBox ID="WebSiteURLField" runat="server" Columns="40" CssClass="forminput"  TabIndex="321">http://</asp:TextBox>
                                        <bvc5:BVRequiredFieldValidator ID="valWebSite" runat="server" ErrorMessage="Web Site URL is Required"  ControlToValidate="WebSiteURLField" ForeColor=" " CssClass="errormessage"></bvc5:BVRequiredFieldValidator>
	                                </td>
                                </tr>
                                <tr>
                                    <td class="formlabel">
                                        <asp:Label ID="TaxIDLabel" runat="server" Text="Tax ID Number:" AssociatedControlID="TaxIDField"></asp:Label>
                                    </td>
	                                <td class="formfield">
                                        <asp:TextBox ID="TaxIDField" runat="server" Columns="20" CssClass="forminput" TabIndex="322"></asp:TextBox>
                                        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Tax Id Required." ControlToValidate="TaxIDField" ForeColor=" " CssClass="errormessage"></bvc5:BVRequiredFieldValidator>    
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formlabel">
                                        <asp:Label ID="DriversLicenseNumberLabel" runat="server" Text="Driver's License Number:"  AssociatedControlID="DriversLicenseNumberField"></asp:Label></td>
	                                <td class="formfield">
                                        <asp:TextBox ID="DriversLicenseNumberField" runat="server" Columns="20" CssClass="forminput" TabIndex="323"></asp:TextBox>
                                        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Drivers License Number Required." ControlToValidate="DriversLicenseNumberField" ForeColor=" " CssClass="errormessage"></bvc5:BVRequiredFieldValidator>    
                                    </td>
                                </tr>
                            </table>


                        </td>
                    </tr>
                </table>


                <div class="buttonrow BVSmallText">
                    <asp:CheckBox ID="chkAgree" runat="server" Text="I agree to the " TabIndex="324"></asp:CheckBox>
                    <a onclick="javascript:window.open('AffiliateTerms.aspx','Policy','width=400, height=500, menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no')" href="javascript:void(0);">Affiliate Terms and Conditions</a>
                </div>


                <div class="buttonrow">
                    <asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" AlternateText="Cancel" TabIndex="325"></asp:ImageButton>
                    <asp:ImageButton ID="btnSave" runat="server" AlternateText="Save" TabIndex="326"></asp:ImageButton>
                </div>

            </fieldset>
        </asp:View>

        <asp:View ID="ThanksView" runat="server">
            <asp:Label ID="lblAffiliateLink" runat="server" Text="Label"></asp:Label>
            <div id="affiliateThanks" runat="server"></div>
        </asp:View>   
             
    </asp:MultiView>
</asp:Content>
