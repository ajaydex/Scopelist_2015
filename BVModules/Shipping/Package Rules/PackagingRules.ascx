<%@ Control Language="C#" CodeFile="PackagingRules.ascx.cs" Inherits="BVModules_Shipping_Package_Rules_PackagingRules" %>
<%@ Register TagPrefix="anthem" Assembly="Anthem" Namespace="Anthem" %>
<%@ Register TagPrefix="ss" Assembly="StructuredSolutions.ShippingProviders" Namespace="StructuredSolutions.Bvc5.Shipping.Providers.Controls" %>
<%@ Register TagPrefix="uc" TagName="PackageMatchEditor" Src="PackageMatchEditor.ascx" %>

<%@ Import Namespace="ASPNET=System.Web.UI.WebControls" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>
<%@ Import Namespace="StructuredSolutions.Bvc5.Shipping.Providers" %>
    
<div class="section">
    <div style="float:right;">
        <asp:LinkButton ID="Export" runat="server" ToolTip="Export the packaging rules to a file" OnClick="Export_Click" Text="Export" /> |
        <a href="#" onclick="javascript:showImportPackagingDialog(); return false;" title="Import the packaging rules from a file">Import</a>
    </div>
    <h2 class="settings">
        Packaging Rules
    </h1>
    <p>
        Prior to calculating the shipping costs, 
        the order will be split into separate packages: one package for each
        drop shipper, one package for each item that ships separately, 
        and one package for all of the remaining items.
        For more accurate shipping costs, you can divide the default packages 
        before the shipping cost rules are applied.
    </p>
    
    <asp:ObjectDataSource ID="PackagingRulesDataSource" runat="server"
        TypeName="StructuredSolutions.Bvc5.Shipping.Providers.Packaging.PackageRulePackagingRulesDataSource"
        OnDeleting="PackagingRulesDataSource_Deleting"
        OnSelecting="PackagingRulesDataSource_Selecting"
        OnUpdating="PackagingRulesDataSource_Updating"
        DeleteMethod="Delete"
        SelectMethod="Select"
        UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="settings" Type="Object" />
        </DeleteParameters>
        <SelectParameters>
            <asp:Parameter Name="settings" Type="Object" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="settings" Type="Object" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    
    <anthem:GridView ID="PackagingRules" runat="server"
        AddCallBacks="true"
        AllowPaging="True"
        AutoGenerateColumns="false"
        CellPadding="0"
        CellSpacing="0"
        CssClass="rules"
        EnableCallBack="true"
        DataKeyNames="Id"
        DataSourceID="PackagingRulesDataSource"
        ForeColor="#333333"
        GridLines="None"
        OnRowCommand="PackagingRules_RowCommand"
        OnRowCreated="PackagingRules_RowCreated" 
        ShowHeader="false"
        Width="100%">
        <Columns>
            <asp:TemplateField HeaderStyle-HorizontalAlign="left">
            	<ItemStyle HorizontalAlign="Left" Width="90%" />
                
                <ItemTemplate>
                    <div style="padding: 20px;">
                    	<div style="margin-bottom: 15px;">
                        	<asp:ImageButton ID="PackagingRuleInsertRow" runat="server" 
                                CommandName="New" 
                                CommandArgument='<%# Eval("Id") %>' 
                                ImageUrl="~/BVAdmin/Images/Buttons/New.png" 
                                ToolTip="Insert a new packaging rule after this rule" />
                            <asp:ImageButton ID="PackagingRuleEditRow" runat="server" 
                                CommandName="Edit" 
                                CommandArgument='<%# Eval("Id") %>'
                                ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" 
                                ToolTip="Edit this packaging rule" />
                            <anthem:ImageButton ID="PackagingRuleDeleteRow" runat="server" 
                                CommandName="Delete" 
                                ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" 
                                PreCallBackFunction="function(){return confirm('Are you sure you want to delete this rule?');}"
                                ToolTip="Delete this packaging rule" />
                    	</div>
                        <ol style="list-style: none; margin: 0; padding: 0;">
                            <li style="list-style: none; margin: 0; padding: 0;" value="<%# (PackagingRules.PageIndex * PackagingRules.PageSize) + ((GridViewRow)Container).RowIndex + 1%>">
                                <%# Eval("Name") %>
                            </li>
                        </ol>
                    </div>
                </ItemTemplate>
                
                <EditItemTemplate>
                	<div style="padding: 20px;">
                    <asp:ImageButton ID="PackagingRuleCancelEdit" runat="server" 
                        CausesValidation="false"
                        CommandName="Cancel" 
                        ImageUrl="~/BVAdmin/Images/Buttons/CancelSmall.png"
                        ToolTip="Quit editing this packaging rule without saving changes">
                    </asp:ImageButton>

                    <br />
                    <br />
                    
                    <asp:ValidationSummary ID="PackagingGroupValidationSummary" runat="server" 
                        AutoUpdateAfterCallBack="true" 
                        DisplayMode="SingleParagraph" 
                        EnableClientScript="false"
                        ValidationGroup="RuleGroup">
                    </asp:ValidationSummary>
                    
                    <table class="formtable subform">
                        <tr>
                            <td class="formlabel">
                                <ss:HelpLabel ID="NameLabel" runat="server" 
                                    AssociatedControlID="NameField"
                                    Text="Name:"
                                    ToolTip="&lt;p&gt;Enter the name of this packaging.&lt;/p&gt;">
                                </ss:HelpLabel>
                            </td>
                            <td class="formfield" colspan="5">
                                <asp:TextBox ID="NameField" runat="server" Width="260px" Text='<%# Bind("Name") %>' />
                                <asp:RequiredFieldValidator ID="NameFieldRequired" runat="server"
                                    ControlToValidate="NameField" 
                                    Display="Dynamic" 
                                    EnableClientScript="false"
                                    ErrorMessage="The packaging name is required." 
                                    Text="<div>Required</div>"
                                    ValidationGroup="RuleGroup">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                <ss:HelpLabel ID="TareWeightLabel" runat="server" 
                                    AssociatedControlID="TareWeightField"
                                    Text="Packaging:"
                                    ToolTip="&lt;p&gt;Enter the tare weight for each package. This value will
                                        override the default packaging weight in Basic Settings.&lt;/p&gt;">
                                </ss:HelpLabel>
                            </td>
                            <td class="formfield" colspan="5">
                                <asp:TextBox ID="TareWeightField" runat="server" CssClass="numeric" Text='<%# Bind("TareWeight") %>'/>
                                <%= WebAppSettings.SiteShippingWeightType %>
                                <asp:RequiredFieldValidator ID="TareWeightFieldRequired" runat="server"
                                    ControlToValidate="TareWeightField" 
                                    Display="Dynamic" 
                                    EnableClientScript="false"
                                    ErrorMessage="The packaging weight is required (can be 0)."
                                    Text="<div>Required</div>"
                                    ValidationGroup="RuleGroup">
                                </asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="TareWeightFieldNumeric" runat="server" 
                                    ControlToValidate="TareWeightField" 
                                    Display="Dynamic" 
                                    EnableClientScript="false"
                                    ErrorMessage="The packaging weight must be a number between 0 and 999." 
                                    MinimumValue="0" 
                                    MaximumValue="999" 
                                    Text="<div>Number between 0 and 999 required</div>" 
                                    Type="Double"
                                    ValidationGroup="RuleGroup">
                                </asp:RangeValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="7">
                                <h2>Create packages that satisfy all of the following conditions</h2>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="7">
                                <uc:PackageMatchEditor ID="PackageMatchEditor" runat="server" DataSource='<%# Eval("Limits") %>' Prompt="Criteria:" RuleId='<%# Eval("ID") %>' />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="7">
                                <h2>Optional box dimensions</h2>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel" colspan="7">Dimensions:</td>
                        </tr>
                        <tr>
                            <td class="formfield" colspan="7">
                                <asp:TextBox ID="HeightField" runat="server" CssClass="numeric" Text='<%# Bind("BoxHeight") %>' size="4" />
                                <%= WebAppSettings.SiteShippingLengthType %>
                                <ss:HelpLabel ID="HeightLabel" runat="server" 
                                    AssociatedControlID="HeightField"
                                    Text="High"
                                    ToolTip="&lt;p&gt;Enter the box height.&lt;/p&gt;
                                        &lt;p&gt;Use 0 if you do not want to assign
                                        box dimensions or restrict the items in this package
                                        to a particular size.&lt;/p&gt;">
                                </ss:HelpLabel> &times;
                                
                                <asp:TextBox ID="WidthField" runat="server" CssClass="numeric" Text='<%# Bind("BoxWidth") %>' size="4" />
                                <%= WebAppSettings.SiteShippingLengthType %>
                                <ss:HelpLabel ID="WidthLabel" runat="server" 
                                    AssociatedControlID="WidthField"
                                    Text="Wide"
                                    ToolTip="&lt;p&gt;Enter the box width.&lt;/p&gt;
                                        &lt;p&gt;Use 0 if you do not want to assign
                                        box dimensions or restrict the items in this package
                                        to a particular size.&lt;/p&gt;">
                                </ss:HelpLabel> &times;
                                
                                <asp:TextBox ID="LengthField" runat="server" CssClass="numeric" Text='<%# Bind("BoxLength") %>' size="4" />
                                <%= WebAppSettings.SiteShippingLengthType %>
                                <ss:HelpLabel ID="LengthLabel" runat="server" 
                                    AssociatedControlID="LengthField"
                                    Text="Long"
                                    ToolTip="&lt;p&gt;Enter the box length.&lt;/p&gt;
                                        &lt;p&gt;Use 0 if you do not want to assign
                                        box dimensions or restrict the items in this package
                                        to a particular size.&lt;/p&gt;">
                                </ss:HelpLabel>
                                
                                <asp:RequiredFieldValidator ID="HeightFieldRequired" runat="server"
                                    ControlToValidate="HeightField" 
                                    Display="Dynamic" 
                                    EnableClientScript="false"
                                    ErrorMessage="The box dimensions are required. Use 0 if you do not want to assign box dimensions or restrict the items in this package to a particular size."
                                    Text="<div>All dimensions are required</div>"
                                    ValidationGroup="RuleGroup">
                                </asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="HeightFieldNumeric" runat="server" 
                                    ControlToValidate="HeightField" 
                                    Display="Dynamic" 
                                    EnableClientScript="false"
                                    ErrorMessage="The box dimensions must be 0 or greater. Use 0 if you do not want to assign box dimensions or restrict the items in this package to a particular size." 
                                    MinimumValue="0" 
                                    MaximumValue="9999" 
                                    Text="<div>All dimensions must be a number equal to or greater than 0</div>" 
                                    Type="Double"
                                    ValidationGroup="RuleGroup">
                                </asp:RangeValidator>
                                <asp:RequiredFieldValidator ID="WidthFieldRequired" runat="server"
                                    ControlToValidate="WidthField" 
                                    Display="Dynamic" 
                                    EnableClientScript="false"
                                    ErrorMessage="The box dimensions are required. Use 0 if you do not want to assign box dimensions or restrict the items in this package to a particular size."
                                    Text="<div>All dimensions are required</div>"
                                    ValidationGroup="RuleGroup">
                                </asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="WidthFieldNumeric" runat="server" 
                                    ControlToValidate="WidthField" 
                                    Display="Dynamic" 
                                    EnableClientScript="false"
                                    ErrorMessage="The box dimensions must be 0 or greater. Use 0 if you do not want to assign box dimensions or restrict the items in this package to a particular size." 
                                    MinimumValue="0" 
                                    MaximumValue="9999" 
                                    Text="<div>All dimensions must be a number equal to or greater than 0</div>" 
                                    Type="Double"
                                    ValidationGroup="RuleGroup">
                                </asp:RangeValidator>
                                <asp:RequiredFieldValidator ID="LengthFieldRequired" runat="server"
                                    ControlToValidate="LengthField" 
                                    Display="Dynamic" 
                                    EnableClientScript="false"
                                    ErrorMessage="The box dimensions are required. Use 0 if you do not want to assign box dimensions or restrict the items in this package to a particular size."
                                    Text="<div>All dimensions are required</div>"
                                    ValidationGroup="RuleGroup">
                                </asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="LengthFieldNumeric" runat="server" 
                                    ControlToValidate="LengthField" 
                                    Display="Dynamic" 
                                    EnableClientScript="false"
                                    ErrorMessage="The box dimensions must be 0 or greater. Use 0 if you do not want to assign box dimensions or restrict the items in this package to a particular size." 
                                    MinimumValue="0" 
                                    MaximumValue="9999" 
                                    Text="<div>All dimensions must be a number equal to or greater than 0</div>" 
                                    Type="Double"
                                    ValidationGroup="RuleGroup">
                                </asp:RangeValidator>
                            </td>
                        </tr>
                    </table>
                    
                    <asp:GridView id="SamplePackages" runat="server"
                        AllowPaging="true"
                        AutoGenerateColumns="false"
                        Caption="Showing 5 of xxx" 
                        CellPadding="4"
                        CellSpacing="0"
                        CssClass="samples"
                        EmptyDataText="No orders found."
                        ForeColor="#333333"
                        GridLines="None"
                        PageSize="5"
                        ShowHeader="true"
                        Visible="false"
                        Width="95%"
                        OnPageIndexChanging="SamplePackages_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="OrderDisplay" HeaderText="Order" HtmlEncode="false" />
                            <asp:BoundField DataField="MatchValues" HeaderText="Matching Value(s)" />
                            <asp:BoundField DataField="LimitValues" HeaderText="Limit(s)" />
                            <asp:BoundField DataField="Weight" HeaderText="Weight" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="Volume" HeaderText="Volume" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="FillFactor" HeaderText="%/Box" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="Items" HeaderText="Items" HtmlEncode="false" />
                        </Columns>
                        <PagerSettings Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous" />
                        <PagerStyle backcolor="#5D7B9D" forecolor="White" font-bold="True" horizontalalign="Left" CssClass="pager" />
                        <RowStyle backcolor="#F7F6F3" forecolor="#000000" verticalalign="Top" />
                        <AlternatingRowStyle backcolor="White" forecolor="#333333" />
                        <HeaderStyle backcolor="#5D7B9D" forecolor="White" font-bold="True" horizontalalign="Left" />
                    </asp:GridView>
                    
                    <br />
                    <br />
                    
                    <asp:ImageButton ID="PackagingRuleUpdateRule" runat="server" 
                        CommandName="Update" 
                        CommandArgument='<%# Eval("Id") %>'
                        ImageUrl="~/BVAdmin/Images/Buttons/Update.png" 
                        ToolTip="Save the changes you have made to this packaging rule"
                        ValidationGroup="RuleGroup">
                    </asp:ImageButton>
                    <anthem:ImageButton ID="ViewPackagingRule" runat="server" 
                        CommandName="View" 
                        ImageUrl="~/BVAdmin/Images/Buttons/View.png" 
                        TextDuringCallBack="Working..."
                        ToolTip="Display a sample of how old order items would be packaged by this rule"
                        ValidationGroup="RuleGroup">
                    </anthem:ImageButton>
                    
                </EditItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                <EditItemTemplate />
                <ItemTemplate>
                    <div><asp:ImageButton ID="PackagingRuleMoveUp" runat="server" 
                            ImageUrl="~/BVAdmin/Images/Buttons/Up.png" 
                            CommandArgument='<%# Eval("Id") %>' 
                            CommandName="MoveUp" 
                            ToolTip="Move this packaging rule up in order" /></div>
                    <div><asp:ImageButton ID="PackagingRuleMoveDown" runat="server" 
                            ImageUrl="~/BVAdmin/Images/Buttons/Down.png" 
                            CommandArgument='<%# Eval("Id") %>' 
                            CommandName="MoveDown" 
                            ToolTip="Move this packaging rule down in order" /></div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        
        <HeaderStyle CssClass="rowheader" />
        <RowStyle CssClass="row" />
        <AlternatingRowStyle CssClass="alternaterow" />
        <EditRowStyle CssClass="editrow" BackColor="#FFFFCC" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        
        <PagerSettings Position="Bottom" Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous" />
        <PagerStyle CssClass="pager" />
        
        <EmptyDataTemplate>
        	<div class="messagebox">
            	<ul>
                	<li>No custom packaging is defined.</li>
                </ul>
            </div>
            <asp:ImageButton ID="NewPackagingRule" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/New.png" CommandName="New" CommandArgument="" />
        </EmptyDataTemplate>
    </anthem:GridView>
</div>



<div id="importpackaging" style="visibility:hidden">
    <div class="hd">Import Packaging Rules</div>
    <div class="bd" style="padding:1em">
        <p>Select the packaging rules file then click Import</p>
        <asp:FileUpload ID="ImportPackagingUpload" runat="server" />
        <asp:CustomValidator ID="ImportPackagingUploadRequired" runat="server" Display="Dynamic" ClientValidationFunction="validateImportPackagingUpload" EnableClientScript="true" Text="<br />Please select a rules file<br />" ValidationGroup="ImportPackaging" OnServerValidate="ImportPackagingUploadRequired_ServerValidate" />
        <div style="text-align:right;margin-top:1em">
            <asp:Button ID="Import" runat="server" OnClick="Import_Click" Text="Import" CausesValidation="true" ValidationGroup="ImportPackaging" />
            <input onclick="javascript: importpackagingdialog.hide();" type="button" value="Cancel" />
        </div>
    </div>
</div>
