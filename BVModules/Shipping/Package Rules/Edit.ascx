<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Edit.ascx.cs" Inherits="BVModules_Shipping_Package_Rules_Edit" %>
<%@ Register TagPrefix="anthem" Assembly="Anthem" Namespace="Anthem" %>
<%@ Register TagPrefix="ss" Assembly="StructuredSolutions.ShippingProviders" Namespace="StructuredSolutions.Bvc5.Shipping.Providers.Controls" %>
<%@ Register TagPrefix="uc" TagName="PackagingRules" Src="PackagingRules.ascx" %>
<%@ Register TagPrefix="uc" TagName="ShippingCostRules" Src="ShippingCostRules.ascx" %>

<%@ Import Namespace="ASPNET=System.Web.UI.WebControls" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>
<%@ Import Namespace="StructuredSolutions.Bvc5.Shipping" %>
<%@ Import Namespace="StructuredSolutions.Bvc5.Shipping.Providers" %>
<%@ Import Namespace="StructuredSolutions.Bvc5.Shipping.Providers.Settings" %>

<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.2.2/build/container/assets/container.css"/>
<script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/yahoo/yahoo-min.js"></script> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/dom/dom-min.js"></script>
<script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/event/event-min.js"></script>
<script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/animation/animation-min.js"></script>  
<script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/dragdrop/dragdrop-min.js"></script> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/container/container-min.js"></script>
<script type="text/javascript" src="<%= Page.ResolveUrl("~/BVAdmin/scripts/srrp-editor.js") %>"></script>

<script type="text/javascript">
function Anthem_Error(result) {
    alert(result.error);
}
</script>

<div id="panel">
    <h1>Edit Shipping Method - <%= Provider.Name %></h1>

    <div id="subhead" class="subhead">
        <ss:HelpImage id="Help" runat="server"
            AlternateText=""
            HelpText="&lt;p&gt;Package Rules will apply the Packaging Rules to split the
                order into (or a single package) into multiple packages. The shipping
                cost for each package is then calculated and added to the total.&lt;/p&gt;
                &lt;h2&gt;Details&lt;/h2&gt;
                &lt;p&gt;BVC divides each order into multiple packages: one for each
                item that ships separately, one for each drop shipment, and one for all
                the remaining items. Each Packaging Rule is then be applied to split the
                packages into smaller ones.&lt;/p&gt;
                &lt;p&gt;After all the packages are determined, this Package Rules will 
                use the Shipping Cost Rules you create to calculate the cost of shipping
                each package. The total shipping cost for all packages will be displayed
                to the customer.&lt;/p&gt;"
            HelpTitle="Package Rules"
            ImageAlign="right" 
            ImageUrl="~/BVAdmin/Images/MessageIcons/Question.png"
            ToolTip="Click on this symbol to turn on the context sensitive help">
        </ss:HelpImage>
        <anthem:ValidationSummary ID="ValidationSummary1" runat="server" 
            AutoUpdateAfterCallBack="true" 
            DisplayMode="SingleParagraph" 
            EnableClientScript="false">
        </anthem:ValidationSummary>
    </div>

    <div>
        <asp:ImageButton ID="CancelButton1" runat="server"
            CausesValidation="false" 
            ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png"
            OnClick="CancelButton_Click"
            ToolTip="Stop editing this shipping method">
        </asp:ImageButton>
        <anthem:ImageButton ID="UpdateButton1" runat="server"
            CausesValidation="true" 
            ImageUrl="~/BVAdmin/Images/Buttons/Update.png"
            OnClick="UpdateButton_Click" 
            TextDuringCallback="Working..."
            ToolTip="Save the settings and continue editing this shipping method">
        </anthem:ImageButton>
        <asp:ImageButton ID="SaveButton1" runat="server" 
            CausesValidation="true"
            ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png"
            OnClick="SaveButton_Click"
            ToolTip="Save the settings and stop editing this shipping method">
        </asp:ImageButton>
    </div>

    <br />

    <div class="section">
        <h2 class="settings">
            Basic Settings
        </h2>
        <table border="0" cellpadding="0" cellspacing="0" class="linedTable">
            <tr>
                <td class="formlabel">
                    <ss:HelpLabel ID="NameLabel" runat="server" 
                        AssociatedControlID="NameField" 
                        Text="Shipping Method Name:" 
                        ToolTip="&lt;p&gt;Enter a name to identify this shipping method.&lt;/p&gt; 
                            &lt;p&gt;This name is used as the shipping cost name during checkout.
                            For example,&lt;/p&gt;
                            &lt;blockquote&gt;$1.23 - My Name&lt;/blockquote&gt;">
                    </ss:HelpLabel>
                </td>
                <td class="formfield">
                    <asp:TextBox ID="NameField" runat="server" EnableViewState="false" Width="260px" />
                    <anthem:RequiredFieldValidator ID="NameRequired" runat="server" 
                        AutoUpdateAfterCallBack="true"
                        ControlToValidate="NameField"
                        Display="Dynamic"
                        EnableClientScript="false"
                        ErrorMessage="The shipping method name is required." 
                        SetFocusOnError="true"
                        Text="<div>Required</div>">
                    </anthem:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    <ss:HelpLabel ID="ShippingProviderLabel" runat="server"
                        AssociatedControlID="ShippingProviderField"
                        Text="Suggested Service:"
                        ToolTip="&lt;p&gt;Select the carrier that will be assigned to suggested
                            packages without a carrier. Only carriers that support tracking are listed.
                            You can select a different carrier when you ship the package.&lt;/p&gt;
                            &lt;p&gt;If a Shipping Cost Rule assigns a specific carrier, this
                            value is ignored. For example, if the Shipping Cost Rule uses
                            USPS Parcel Post to calculate the cost of shipping a package, then
                            USPS Parcel Post will be assigned to the suggested package regardless
                            of this setting.&lt;/p&gt;">
                    </ss:HelpLabel>
                    <ss:HelpLabel ID="ShippingProviderServiceCodeLabel" runat="server"
                        AssociatedControlID="ShippingProviderServiceCodeField"
                        Text="Default Service Name"
                        ToolTip="&lt;p&gt;Select the service that will be assigned to suggested
                            package without a carrier. You can select a different
                            service when you ship the package.&lt;/p&gt;"
                        Visible="false">
                    </ss:HelpLabel>
                </td>
                <td class="formfield">
                    <anthem:DropDownList ID="ShippingProviderField" runat="server" 
                        AutoCallBack="true" 
                        OnSelectedIndexChanged="ShippingProviderField_SelectedIndexChanged">
                    </anthem:DropDownList>
                    <anthem:DropDownList ID="ShippingProviderServiceCodeField" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    <ss:HelpLabel ID="MethodAdjustmentAmountLabel" runat="server" 
                        AssociatedControlID="MethodAdjustmentAmountField" 
                        Text="Adjust Final Cost By:"
                        ToolTip="&lt;p&gt;Enter the amount and type of adjustment to
                            apply to the total cost.&lt;/p&gt;">
                    </ss:HelpLabel>
                </td>
                <td class="formfield">                
                    <anthem:TextBox ID="MethodAdjustmentAmountField" runat="server"
                        EnableViewState="false"
                        CssClass="numeric" />
                    <anthem:DropDownList ID="MethodAdjustmentTypeField" runat="server"> 
                        <Items>
                            <asp:ListItem>Amount</asp:ListItem>
                            <asp:ListItem Value="Percentage">Percent</asp:ListItem>
                        </Items>
                    </anthem:DropDownList>           
                    <anthem:RequiredFieldValidator ID="MethodAdjustmentAmountRequired" runat="server" 
                        AutoUpdateAfterCallBack="true"
                        ControlToValidate="MethodAdjustmentAmountField"
                        Display="Dynamic"
                        EnableClientScript="false"
                        ErrorMessage="The adjustment amount is required."
                        SetFocusOnError="True"
                        Text="<div>Required</div>">
                    </anthem:RequiredFieldValidator>
                    <anthem:CustomValidator ID="MethodAdjustmentAmountNumericValidator" runat="server" 
                        AutoUpdateAfterCallBack="true"
                        ControlToValidate="MethodAdjustmentAmountField" 
                        Display="Dynamic" 
                        EnableClientScript="false"
                        ErrorMessage="The adjustment value must be a number." 
                        OnServerValidate="MethodAdjustmentAmountNumericValidate_ServerValidate"
                        SetFocusOnError="True" 
                        Text="<div>Must be a number</div>">
                    </anthem:CustomValidator>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    <ss:HelpLabel ID="ShipMethodVisibleLabel" runat="server" 
                        AssociatedControlID="ShipMethodVisibleField" 
                        Text="Visible in Checkout:" 
                        ToolTip="&lt;p&gt;Check this option if this shipping method should
                            be visible to the customer during checkout.&lt;/p&gt;">
                    </ss:HelpLabel>
                </td>
                <td class="formfield">
                    <asp:CheckBox ID="ShipMethodVisibleField" runat="server"
                        EnableViewState="false"
                        Checked="True">
                    </asp:CheckBox>
                </td>
            </tr>
        </table>
    </div>

    <br />
    <br />
    
    <uc:PackagingRules ID="PackagingRules" runat="server" />

    <br />
    <br />

    <uc:ShippingCostRules ID="ShippingCostRules" runat="server" />

    <div id="tip1">
        <div class="hd"></div>
        <div class="bd"></div>
        <div class="ft">Drag title bar to move</div>
    </div>

    <br />
    <br />

</div>

<script type="text/javascript" src='<%= Page.ResolveUrl("~/BVAdmin/scripts/srrp-editor.js") %>'></script>
