<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Search.aspx.vb" Inherits="BVAdmin_Configuration_Search" Title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ContentPlaceHolderID="headcontent" runat="server">
    <script type="text/javascript">
        function toggleSearchFields() {
            var txtSelector = "#SearchFieldsAndWeights input[type=text]";
            var chkSelector = "#<%= SearchMetaTitleCheckBox.ClientID %>, #<%= SearchProductChoiceCombinationsCheckBox.ClientID %>";

            if ($("#<%= EnableAdvancedSearchCheckBox.ClientID %>").is(":checked")) {
                $(txtSelector).removeAttr("readonly");
                $(txtSelector).css("background-color", "#fff");
                $(chkSelector).removeAttr("disabled");
            }
            else {
                $(txtSelector).attr("readonly", true);
                $(txtSelector).css("background-color", "#f2f2f2");
                $(chkSelector).attr("disabled", "disabled");
            }
        }

        $(document).ready(function () {
            toggleSearchFields();
            $("#<%= EnableAdvancedSearchCheckBox.ClientID %>").change(toggleSearchFields);
        });
    </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>
        Search Settings
    </h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />    
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
            <tr>
                <td class="formlabel">
                    Results Per Page
                </td>
                <td class="formfield">
                    <asp:TextBox ID="ResultsPerPageTextBox" runat="server"></asp:TextBox>
                    <bvc5:BVRegularExpressionValidator ID="RowsPerPageRegularExpressionValidator" runat="server" ErrorMessage="Max Results Must Be Numeric." Text="*" ControlToValidate="ResultsPerPageTextBox" Display="Dynamic" ValidationExpression="\d*"></bvc5:BVRegularExpressionValidator>
                    <bvc5:BVRequiredFieldValidator ID="RowsPerPageRequiredFieldValidator" runat="server" ErrorMessage="Max Results Required." Display="Dynamic" ControlToValidate="ResultsPerPageTextBox" Text="*"></bvc5:BVRequiredFieldValidator>
                    <bvc5:BVRangeValidator ID="RangeValidator1" runat="server" ControlToValidate="ResultsPerPageTextBox"
                        Display="Dynamic" ErrorMessage="Results per page must be greater than 0"
                        MinimumValue="0" MaximumValue="9999999" Type="Integer">*</bvc5:BVRangeValidator>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Items Per Row
                </td>
                <td class="formfield">
                    <asp:TextBox ID="ItemsPerRowTextBox" runat="server"></asp:TextBox>
                    <bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator1" runat="server" ErrorMessage="Items Per Row Must Be Numeric." Text="*" ControlToValidate="ItemsPerRowTextBox" Display="Dynamic" ValidationExpression="\d*"></bvc5:BVRegularExpressionValidator>
                    <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator1" runat="server" ErrorMessage="Items Per Row Required." Display="Dynamic" ControlToValidate="ItemsPerRowTextBox" Text="*"></bvc5:BVRequiredFieldValidator>
                    <bvc5:BVRangeValidator ID="BVRangeValidator1" runat="server" ControlToValidate="ItemsPerRowTextBox"
                        Display="Dynamic" ErrorMessage="Items per row must be greater than 0"
                        MinimumValue="0" MaximumValue="9999" Type="Integer">*</bvc5:BVRangeValidator>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Disable Blank Search Terms</td>
                <td class="formfield">
                    <asp:CheckBox ID="DisableBlankSearchTermsCheckBox" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Display Sku</td>
                <td class="formfield">
                    <asp:CheckBox ID="DisplaySkuCheckBox" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Display Images</td>
                <td class="formfield">
                    <asp:CheckBox ID="DisplayImagesCheckBox" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Display Prices</td>
                <td class="formfield">
                    <asp:CheckBox ID="DisplayPricesCheckBox" runat="server" />
                </td>
            </tr>            
            <tr>
                <td class="formlabel">
                    Show Sort Options:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkShowSort" runat="server" /></td>
            </tr>
             <tr>
                <td class="formlabel">
                    Show Category:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkShowCategory" runat="server" /></td>
            </tr>
             <tr>
                <td class="formlabel">
                    Show Manufacturer:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkShowManufacturer" runat="server" /></td>
            </tr>
             <tr>
                <td class="formlabel">
                    Show Vendor:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkShowVendor" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Show Price Range:</td>
                <td class="formfield">
                    <asp:CheckBox ID="chkShowPrice" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Searchable Property 1</td>
                <td class="formfield">
                    <asp:DropDownList ID="Property1Field" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Searchable Property 2</td>
                <td class="formfield">
                    <asp:DropDownList ID="Property2Field" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Searchable Property 3</td>
                <td class="formfield">
                    <asp:DropDownList ID="Property3Field" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Searchable Property 4</td>
                <td class="formfield">
                    <asp:DropDownList ID="Property4Field" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Searchable Property 5</td>
                <td class="formfield">
                    <asp:DropDownList ID="Property5Field" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Searchable Property 6</td>
                <td class="formfield">
                    <asp:DropDownList ID="Property6Field" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Searchable Property 7</td>
                <td class="formfield">
                    <asp:DropDownList ID="Property7Field" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Searchable Property 8</td>
                <td class="formfield">
                    <asp:DropDownList ID="Property8Field" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Searchable Property 9</td>
                <td class="formfield">
                    <asp:DropDownList ID="Property9Field" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Searchable Property 10</td>
                <td class="formfield">
                    <asp:DropDownList ID="Property10Field" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Redirect to Product Page When Only 1 Result</td>
                <td class="formfield">
                    <asp:CheckBox ID="SearchRedirectToProductPage" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                   Enable Advanced Search</td>
                <td class="formfield">
                    <asp:CheckBox ID="EnableAdvancedSearchCheckBox" runat="server" /><br />
                    <asp:Label ID="SqlServerFullTextSearchStatus" CssClass="errormessage" runat="server" />
                </td>
            </tr>
            
        </table>
        <br />
        <br />    

        <h2>Keyword Search Fields</h2>
        
        <table cellpadding="0" cellspacing="0" id="SearchFieldsAndWeights" class="linedTable">
            <tr>
                <th colspan="2">Search Field</th>
                <th>Weight (1 - 100)</th>
            </tr>
            <tr>
                <td class="formlabel">
                    Sku</td>
                <td class="formfield">
                    <asp:CheckBox ID="SearchSkuCheckBox" runat="server" /></td>
                <td>
                    <asp:TextBox ID="SearchSkuWeightTextBox" MaxLength="3" Columns="1" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvSkuWeight" ControlToValidate="SearchSkuWeightTextBox" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" />
                    <asp:RangeValidator ID="rvSkuWeight" ControlToValidate="SearchSkuWeightTextBox" Type="Integer" MinimumValue="1" MaximumValue="100" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Product Name</td>
                <td class="formfield">
                    <asp:CheckBox ID="SearchProductNameCheckBox" runat="server" /></td>
                <td>
                    <asp:TextBox ID="txtProductNameWeight" MaxLength="3" Columns="1" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvProductNameWeight" ControlToValidate="txtProductNameWeight" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" />
                    <asp:RangeValidator ID="rvProductNameWeight" ControlToValidate="txtProductNameWeight" Type="Integer" MinimumValue="1" MaximumValue="100" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Product Type Name</td>
                <td>
                    <asp:CheckBox ID="SearchProductTypeNameCheckbox" runat="server" /></td>
                <td>
                    <asp:TextBox ID="SearchProductTypeNameWeightTextBox" MaxLength="3" Columns="1" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvProductTypeNameWeight" ControlToValidate="SearchProductTypeNameWeightTextBox" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" />
                    <asp:RangeValidator ID="rvProductTypeNameWeight" ControlToValidate="SearchProductTypeNameWeightTextBox" Type="Integer" MinimumValue="1" MaximumValue="100" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Short Description</td>
                <td class="formfield">
                    <asp:CheckBox ID="SearchShortDescriptionCheckBox" runat="server" /></td>
                <td>
                    <asp:TextBox ID="SearchShortDescriptionWeightTextBox" MaxLength="3" Columns="1" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvShortDescriptionWeight" ControlToValidate="SearchShortDescriptionWeightTextBox" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" />
                    <asp:RangeValidator ID="rvShortDescriptionWeight" ControlToValidate="SearchShortDescriptionWeightTextBox" Type="Integer" MinimumValue="1" MaximumValue="100" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Long Description</td>
                <td class="formfield">
                    <asp:CheckBox ID="SearchLongDescriptionCheckBox" runat="server" /></td>
                <td>
                    <asp:TextBox ID="SearchLongDescriptionWeightTextBox" MaxLength="3" Columns="1" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvLongDescriptionWeight" ControlToValidate="SearchLongDescriptionWeightTextBox" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" />
                    <asp:RangeValidator ID="rvLongDescriptionWeight" ControlToValidate="SearchLongDescriptionWeightTextBox" Type="Integer" MinimumValue="1" MaximumValue="100" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Meta Title</td>
                <td>
                    <asp:CheckBox ID="SearchMetaTitleCheckBox" runat="server" /></td>
                <td>
                    <asp:TextBox ID="SearchMetaTitleWeightTextBox" MaxLength="3" Columns="1" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvMetaTitleWeight" ControlToValidate="SearchMetaTitleWeightTextBox" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" />
                    <asp:RangeValidator ID="rvMetaTitleWeight" ControlToValidate="SearchMetaTitleWeightTextBox" Type="Integer" MinimumValue="1" MaximumValue="100" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" /></td>
        </tr>
            <tr>
                <td class="formlabel">
                    Meta Description</td>
                <td class="formfield">
                    <asp:CheckBox ID="SearchMetaDescriptionCheckBox" runat="server" /></td>
                <td>
                    <asp:TextBox ID="SearchMetaDescriptionWeightTextBox" MaxLength="3" Columns="1" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvMetaDescriptionWeight" ControlToValidate="SearchMetaDescriptionWeightTextBox" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" />
                    <asp:RangeValidator ID="rvMetaDescriptionWeight" ControlToValidate="SearchMetaDescriptionWeightTextBox" Type="Integer" MinimumValue="1" MaximumValue="100" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Meta Keywords</td>
                <td class="formfield">
                    <asp:CheckBox ID="SearchMetaKeywordsCheckBox" runat="server" /></td>
                <td>
                    <asp:TextBox ID="SearchMetaKeywordsWeightTextBox" MaxLength="3" Columns="1" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvMetaKeywordsWeight" ControlToValidate="SearchMetaKeywordsWeightTextBox" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" />
                    <asp:RangeValidator ID="rvMetaKeywordsWeight" ControlToValidate="SearchMetaKeywordsWeightTextBox" Type="Integer" MinimumValue="1" MaximumValue="100" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Keywords</td>
                <td class="formfield">
                    <asp:CheckBox ID="SearchKeywordsCheckBox" runat="server" /></td>
                <td>
                    <asp:TextBox ID="SearchKeywordsWeightTextBox" MaxLength="3" Columns="1" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvKeywordsWeight" ControlToValidate="SearchKeywordsWeightTextBox" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" />
                    <asp:RangeValidator ID="rvKeywordsWeight" ControlToValidate="SearchKeywordsWeightTextBox" Type="Integer" MinimumValue="1" MaximumValue="100" Text="enter a whole number between 1 and 100" Display="Dynamic" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Search all choice<br />combinations (variants)</td>
                <td style="vertical-align:top">
                    <asp:CheckBox ID="SearchProductChoiceCombinationsCheckBox" runat="server" /></td>
                <td></td>
            </tr>
        </table>
        <br />
        <br />

        <asp:ImageButton ID="btnCancel" runat="server" CausesValidation="false" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" AlternateText="Cancel" />
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" AlternateText="Save Changes" />
    </asp:Panel>
</asp:Content>
