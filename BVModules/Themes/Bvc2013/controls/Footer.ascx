<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Footer.ascx.vb" Inherits="BVModules_Themes_Bvc2013_Footer" %>
<%@ Register Src="~/BVModules/Controls/PoweredBy.ascx" TagName="PoweredBy" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/CustomPagesDisplay.ascx" TagName="CustomPagesDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>

<div id="footer">
	<div class="container clearfix">
        <div class="col1">
            <uc:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="Footer Column 1" />
        </div>
        
        <div class="col1">
            <uc:ContentColumnControl ID="ContentColumnControl2" runat="server" ColumnName="Footer Column 2" />
        </div>
        
        <div class="col1">
            <uc:ContentColumnControl ID="ContentColumnControl3" runat="server" ColumnName="Footer Column 3" />
        </div>
        
        <div class="col1">
            <uc:ContentColumnControl ID="ContentColumnControl4" runat="server" ColumnName="Footer Column 4" />
            <uc:CustomPagesDisplay ID="CustomPagesDisplay1" runat="server"></uc:CustomPagesDisplay>
        </div>
        
        <div class="col1">
        	<strong>Need Help?</strong><br />
            Call 1-800-777-1234
            <br />
            Mon-Fri 8:00AM-6:00PM
        </div>
        <div class="col1 last">
        	
        </div>
  	</div>
</div>

<div class="poweredby">
	<div class="container clearfix">
        <div class="col2">
            &copy; 2013 bikeshop. All rights reserved. <span class="pipe">|</span> <a href="#header">Top</a>
        </div>
        
        <div class="col2">
            &nbsp;
        </div>
        
        <div class="col2 last text-right">
            <uc:PoweredBy ID="PoweredBy1" runat="server" />
        </div>
	</div>
</div>