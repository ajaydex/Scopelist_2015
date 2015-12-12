<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Edit.ascx.cs" Inherits="BVModules_Shipping_Wrapper_Edit" %>
<%@ Register TagPrefix="anthem" Assembly="Anthem" Namespace="Anthem" %>
<%@ Register TagPrefix="ss" Assembly="StructuredSolutions.ShippingProviders" Namespace="StructuredSolutions.Bvc5.Shipping.Providers.Controls" %>

<%@ Import Namespace="ASPNET=System.Web.UI.WebControls" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>
<%@ Import Namespace="StructuredSolutions.Bvc5.Shipping.Providers" %>

<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.2.2/build/container/assets/container.css"/>
<script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/yahoo/yahoo-min.js"></script> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/dom/dom-min.js"></script>
<script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/event/event-min.js"></script>
<script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/animation/animation-min.js"></script>  
<script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/dragdrop/dragdrop-min.js"></script> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/container/container-min.js"></script>
<script type="text/javascript" src="<%= Page.ResolveUrl("~/BVAdmin/scripts/srrp-editor.js") %>"></script>

<div id="panel">
    <h1>Wrapped Shipping Method - <%= Provider.Name %></h1>

    <div id="subhead" class="subhead">
        <ss:HelpImage id="Help" runat="server"
            AlternateText=""
            HelpText="&lt;p&gt;The Wrapper provider is used to hide shipping 
                methods from the customer until a shipping cost rule make it visible.&lt;/p&gt; 
                &lt;p&gt;To use this provider, wrap any one of the providers
                and set Visible off. Then in your Order Rules or Package Rules, select 
                &quot;Use Cost From&quot; this method.&lt;/p&gt;"
            HelpTitle="Wrapper"
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

    <div class="section">
        <h2 class="settings">
            Basic Settings
        </h2>
        <table border="0" cellpadding="0" cellspacing="0" class="linedTable">
            <tr>
                <td class="formlabel">
                    <ss:HelpLabel ID="BaseProviderLabel" runat="server" 
                        AssociatedControlID="BaseProviderField" 
                        Text="Wrapped Provider:" 
                        ToolTip="&lt;p&gt;Select the shipping rate provider to wrap.&lt;/p&gt;">
                    </ss:HelpLabel>
                </td>
                <td class="formfield">
                    <asp:DropDownList ID="BaseProviderField" runat="server" 
                        AutoPostBack="true" 
                        CausesValidation="true"
                        OnSelectedIndexChanged="BaseProviderField_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    <ss:HelpLabel ID="ShipMethodVisibleLabel" runat="server" 
                        AssociatedControlID="ShipMethodVisibleField" 
                        Text="Visible in Checkout:" 
                        ToolTip="&lt;p&gt;Check this option if this shipping method
                            should be visible to the customer during checkout.&lt;/p&gt;">
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

    <div class="section">
        <div style="float:right;">
            <asp:LinkButton ID="Unwrap" runat="server" ToolTip="Unwrap this shipping method" OnClick="Unwrap_Click" Text="Unwrap" />
        </div>
        <h2 class="settings">
            Wrapped Provider Settings
        </h2>
        <div style="padding:20px;border:1px solid #ccc;">
            <asp:PlaceHolder ID="BaseProviderModuleHolder" runat="server" />
        </div>
    </div>
    
    <div id="tip1">
        <div class="hd"></div>
        <div class="bd"></div>
        <div class="ft">Drag title bar to move</div>
    </div>

    <br />
    <br />

</div>

<script type="text/javascript" src='<%= Page.ResolveUrl("~/BVAdmin/scripts/srrp-editor.js") %>'></script>
