<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="BVAdmin_Default" title="Dashboard" %>
<%@ Register Src="Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc1" %>
<%@ Register src="Controls/LatestVersionCheck.ascx" tagname="LatestVersionCheck" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <h1>Dashboard</h1>
	
	<uc2:MessageBox ID="MessageBox1" runat="server" EnableViewState="false" />
	
	<div class="f-row">
		<div class="three columns">
        	<div style="padding:4px; border:1px solid #ccc;">
                <uc1:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnID="101" /><br />       
            </div>
		</div>
		
		<div class="six columns">
        	<div style="padding:4px; border:1px solid #ccc;">
                <uc1:ContentColumnControl ID="ContentColumnControl2" runat="server" ColumnID="102" /><br />     
            </div>
		</div>
	
        <div class="three columns">
        	<div style="padding:4px; border:1px solid #ccc;">
                <uc3:LatestVersionCheck ID="LatestVersionCheck1" runat="server" />
                <uc1:ContentColumnControl ID="ContentColumnControl3" runat="server" ColumnID="103" /><br />   
            </div>
		</div>
    </div>
</asp:Content>