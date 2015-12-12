<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Footer.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Footer" %>

<%@ Register Src="~/BVModules/Controls/CustomPagesDisplay.ascx" TagName="CustomPagesDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/WaitingMessage.ascx" TagName="WaitingMessage" TagPrefix="uc" %>

<div class="prefooter">
    <div class="row">
        <div class="large-2 columns">
            <div class="clearfix">
                <uc:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="PreFooter Column 1" />
            </div>
        </div>
        <div class="large-2 columns">
            <div class="clearfix">
            	<h6>Learn</h6>
            	<uc:CustomPagesDisplay ID="CustomPagesDisplay1" runat="server"></uc:CustomPagesDisplay>
                <uc:ContentColumnControl ID="ContentColumnControl2" runat="server" ColumnName="PreFooter Column 2" />
            </div>
        </div>
        <div class="large-2 columns">
            <div class="clearfix">
                <uc:ContentColumnControl ID="ContentColumnControl3" runat="server" ColumnName="PreFooter Column 3" />
            </div>
        </div>
        <div class="large-2 columns">
            <div class="clearfix">
            	
                <uc:ContentColumnControl ID="ContentColumnControl4" runat="server" ColumnName="PreFooter Column 4" />
            </div>
        </div>
        <div class="large-4 columns">
            <div class="clearfix">
            	<hr />
                <uc:ContentColumnControl ID="ContentColumnControl5" runat="server" ColumnName="PreFooter Column 5-6" />
            </div>
        </div>
    </div>
</div>

<div class="footer">
    <div class="row">
	    <div class="large-8 columns">
    	    <uc:ContentColumnControl ID="ContentColumnControl6" runat="server" ColumnName="Footer Column 1" />
        </div>
        <div class="large-4 columns">
    	    <uc:ContentColumnControl ID="ContentColumnControl7" runat="server" ColumnName="Footer Column 2" />
        </div>
    </div>
</div>

<div id="to-top" class="scroll-button" style="display: block;">
    <a class="scroll-button" title="Back to Top" href="javascript:void(0)"></a>
</div>

<uc:WaitingMessage ID="WaitingMessage1" runat="server" />
