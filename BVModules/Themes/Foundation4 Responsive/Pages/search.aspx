<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Search.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_search" Title="Search" %>
<%@ Register Src="~/BVModules/Controls/Pager.ascx" TagName="Pager" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Themes/Foundation4 Responsive/Controls/SearchCriteria.ascx" TagName="SearchCriteria" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/SingleProductDisplay.ascx" TagName="SingleProductDisplay" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Themes/Foundation4 Responsive/Controls/ProductGridDisplay.ascx" TagName="ProductGridDisplay" TagPrefix="uc" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">

    <div class="main">
		<div class="row">
			<div class="large-12 columns">
                <h1>Store Search</h1>
                <uc:MessageBox ID="MessageBox1" runat="server" />

                <div class="row">
                    <div class="large-4 columns">
                        <fieldset id="SearchForm" class="highlight">
                            <uc:SearchCriteria ID="SearchCriteria1" runat="server" />
                        </fieldset>
                    </div>
                    <div class="large-8 columns">
                        <div class="gridheader">
                            <uc:Pager ID="Pager1" runat="server" />
                        </div>

                        <hr />

                        <uc:ProductGridDisplay ID="ProductGridDisplay" runat="server" />

                        <hr />

                        <div class="gridfooter">
                            <uc:Pager ID="Pager2" runat="server" /> 
                        </div> 

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
                