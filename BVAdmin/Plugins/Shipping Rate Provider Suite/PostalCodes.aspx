<%@ Page Language="C#" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="true" CodeFile="PostalCodes.aspx.cs" Inherits="BVAdmin_Plugins_Shipping_Rate_Provider_Suite_PostalCodes" Title="Postal Code Support" %>
<%@ Register TagPrefix="anthem" Assembly="Anthem" Namespace="Anthem" %>
<%@ Import Namespace="StructuredSolutions.Bvc5.Shipping.PostalCodes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Shipping Rate Provider Suite</h1>
    
    <p>The Shipping Rate Provider Suite uses postal codes to calculate delivery distance. The delivery distance can be used to calculate appropriate shipping methods and costs. Postal code data is rquired for this functionality to work.</p>
    
    <h2>Installed Postal Code Data</h2>
    <asp:ObjectDataSource ID="PostalCodeSummaryDataSource" runat="server" 
        DeleteMethod="DeleteByCountry"
        SelectMethod="GetCounts" 
        TypeName="StructuredSolutions.Bvc5.Shipping.PostalCodes.PostalCode">
        <DeleteParameters>
            <asp:Parameter Name="countryBvin" Type="String" />
        </DeleteParameters>
    </asp:ObjectDataSource>

    <anthem:GridView ID="PostalCodeSummary" runat="server" 
        AutoGenerateColumns="False" 
        CellPadding="0"
        DataSourceID="PostalCodeSummaryDataSource" 
        ForeColor="#333333" 
        GridLines="None"
        DataKeyNames="CountryBvin" 
        EmptyDataText="No postal codes have been defined."
        OnRowCreated="PostalCodeSummary_RowCreated"
        Width="100%"
        BorderColor="#CCCCCC">

        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="Country">
                <ItemTemplate>
                    <asp:Literal ID="CountryName" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Count" HeaderText="Count" />
            <asp:TemplateField>
                <ItemTemplate>
                    <anthem:Button ID="DeletePostalCodes" runat="server" CausesValidation="false" CommandName="Delete" PreCallBackFunction="function(){return confirm('This may take several minutes. Are you sure you want to delete these postal codes?');}" Text="Delete" TextDuringCallBack="Working..." EnabledDuringCallback="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </anthem:GridView>

    <hr />

    <h2>Load Postal Code Data</h2>

    <div class="controlarea1">
        <h3>Included US ZIP Code Library</h3>
        <p>Simply click the button below to automatically load over 42,000 US ZIP codes.</p>
        <anthem:Button ID="InstallZipCodes" runat="server" CausesValidation="false" Text="Load US ZIP Codes" OnClick="InstallZipCodes_Click" />
    </div>

    <div class="controlarea1">
        <h3>Load Custom Postal Code Data</h3>
        <p>Shipping Rate Provider Suite with any custom postal code data that you've created or purchased.</p>
        
        <ul style="margin:0 1.5em 1.5em;">
            <li>The postal code data must be in CSV format.</li>
            <li>If you upload a compressed file (zip), then the first file in the archive must be in CSV format.</li>
            <li>Do not surround text values in the CSV data with quotes.</li>
        </ul>

        <div style="background:#fff;padding:15px;">
            <table class="linedTable" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="formlabel wide">
                        Country:
                    </td>
                    <td class="formfield">
                        <asp:DropDownList ID="Countries" runat="server" DataSourceID="CountriesDataSource"
                            DataTextField="DisplayName" DataValueField="bvin" OnDataBound="Countries_DataBound">
                        </asp:DropDownList><asp:ObjectDataSource ID="CountriesDataSource" runat="server"
                            SelectMethod="FindAll" TypeName="BVSoftware.Bvc5.Core.Content.Country" />
                    </td>
                </tr>
                <tr>
                    <td class="formlabel wide">
                        Postal Code File:
                    </td>
                    <td class="formfield">
                        <asp:FileUpload ID="PostalCodeFile" runat="server" />
                        <asp:RequiredFieldValidator ID="PostalCodeFileRequired" runat="server" 
                            ControlToValidate="PostalCodeFile"
                            Display="Dynamic" 
                            ErrorMessage="The Postal Code File is required."
                            SetFocusOnError="true" 
                            Text="Required.">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <div class="controlarea1">
                        Note: To calculate the Field Index Numbers of your custom CSV file, start at 1. For example the Latitude field index in the sample CSV file below is 1, the ZipCode field index is 2, City is 3, etc.<br />
                                <img src="ZipFile.jpg" alt="CSV file example" vspace="5" />
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="formlabel wide">
                        Postal Code Field Index:
                    </td>
                    <td class="formfield">
                        <asp:TextBox ID="CodeIndex" runat="server" size="10" />
                        <asp:RequiredFieldValidator ID="CodeIndexRequired" runat="server" 
                            ControlToValidate="CodeIndex"
                            Display="Dynamic" 
                            ErrorMessage="The Postal Code Field Index is required." 
                            SetFocusOnError="true"
                            Text="Required.">
                        </asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="CodeIndexRangeValidator" runat="server" 
                            ControlToValidate="CodeIndex"
                            Display="Dynamic" 
                            Type="Integer" 
                            MinimumValue="1" 
                            MaximumValue="999" 
                            ErrorMessage="The Postal Code Field Index must be a number between 1 and 999." 
                            SetFocusOnError="true" 
                            Text="Must be a number between 1 and 999.">
                        </asp:RangeValidator>
                    </td>
                </tr>

                <tr>
                    <td class="formlabel wide">
                        Latitude Field Index:
                    </td>
                    <td class="formfield">
                        <asp:TextBox ID="LatitudeIndex" runat="server" size="10" />
                        <asp:RequiredFieldValidator ID="LatitudeIndexRequired" runat="server" 
                            ControlToValidate="LatitudeIndex"
                            Display="Dynamic" 
                            ErrorMessage="The Latitude Field Index is required." 
                            SetFocusOnError="true" 
                            Text="Required.">
                        </asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="LatitudeIndexRangeValidator" runat="server" 
                            ControlToValidate="LatitudeIndex"
                            Display="Dynamic" 
                            Type="Integer" 
                            MinimumValue="1" 
                            MaximumValue="999" 
                            ErrorMessage="The Latitude Field Index must be a number between 1 and 999."
                            SetFocusOnError="true" 
                            Text="Must be a number between 1 and 999.">
                        </asp:RangeValidator>
                    </td>
                </tr>
                <tr>
                    <td class="formlabel wide">
                        Longitude Field Index:
                    </td>
                    <td class="formfield">
                        <asp:TextBox ID="LongitudeIndex" runat="server" size="10" />
                        <asp:RequiredFieldValidator ID="LongitudeIndexRequired" runat="server" 
                            ControlToValidate="LongitudeIndex"
                            Display="Dynamic" 
                            ErrorMessage="The Longitude Field Index is required."
                            SetFocusOnError="true" 
                            Text="Required.">
                        </asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="LongitudeIndexRangeValidator" runat="server" 
                            ControlToValidate="LongitudeIndex"
                            Display="Dynamic" 
                            Type="Integer" 
                            MinimumValue="1" 
                            MaximumValue="999" 
                            ErrorMessage="The Longitude Field Index must be a number between 1 and 999."
                            SetFocusOnError="true" 
                            Text="Must be a number between 1 and 999.">
                        </asp:RangeValidator>
                    </td>
                </tr>
                <tr>
                    <td class="formlabel wide">
                        City Field Index: [optional]
                    </td>
                    <td class="formfield">
                        <asp:TextBox ID="CityIndex" runat="server" size="10" />
                        <asp:RangeValidator ID="CityIndexRangeValidator" runat="server" 
                            ControlToValidate="CityIndex"
                            Display="Dynamic" 
                            Type="Integer" 
                            MinimumValue="1" 
                            MaximumValue="999" 
                            ErrorMessage="If you use the City Field Index, it must be a number between 1 and 999."
                            SetFocusOnError="true" 
                            Text="If you use this field, it must be a number between 1 and 999.">
                        </asp:RangeValidator>
                    </td>
                </tr>
                <tr>
                    <td class="formlabel wide">
                        Region Field Index: [optional]
                    </td>
                    <td class="formfield">
                        <asp:TextBox ID="RegionIndex" runat="server" size="10" />
                        <asp:RangeValidator ID="RegionIndexRangeValidator" runat="server" 
                            ControlToValidate="RegionIndex"
                            Display="Dynamic" 
                            Type="Integer" 
                            MinimumValue="1" 
                            MaximumValue="999" 
                            ErrorMessage="If you use the Region Field Index, it must be a number between 1 and 999."
                            SetFocusOnError="true" 
                            Text="If you use this field, it must be a number between 1 and 999.">
                        </asp:RangeValidator>
                    </td>
                </tr>
            </table>

            <br />
            <anthem:Button ID="LoadPostalCodes" runat="server" 
                CausesValidation="true" 
                ToolTip="Load Postal Codes" 
                OnClick="LoadPostalCodes_Click"
                Text="Load Postal Codes"
                TextDuringCallBack="Working...">
            </anthem:Button>

        </div>
    </div>
</asp:Content>

