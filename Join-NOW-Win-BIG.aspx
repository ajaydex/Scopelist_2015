<%@ Page Title="Join NOW Win BIG" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Join-NOW-Win-BIG.aspx.vb" Inherits="Join_NOW_Win_BIG" %>

<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="uc1" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" runat="Server">
    <style type="text/css">
        p
        {
            padding-bottom: 0px;
        }
        
        .block html .col1
        {
            width: 100%;
            float: left;
            margin-bottom: 30px;
        }
        
        h4
        {
            width: 100%;
            float: left;
            background: #383832;
            position: relative;
            height: 1px;
            margin: 15px 0px 25px;
        }
        
        h4 span
        {
            color: #383832;
            font-size: 20px;
            font-weight: bold;
            text-transform: uppercase;
            position: absolute;
            left: 15px;
            top: -9px;
            padding: 0px 10px;
            background: #fff;
        }
        
        h5
        {
            font-size: 24px;
            color: #515044;
            margin-bottom: 10px;
            font-family: "Cabin Condensed Bold";
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div class="joinbanner" runat="server" id="dvBanner">
        <div class="joinbanner_join_now">
            <asp:TextBox runat="server" ID="txtFirstName" class="join_now_input" placeholder="First Name" />
            <asp:TextBox runat="server" ID="txtLastName" class="join_now_input" placeholder="Last Name" />
            <asp:TextBox runat="server" ID="txtEmailId" class="join_now_input" placeholder="Enter your Email id" />
            <asp:Button Text="Submit" runat="server" class="join_submit_btn" ID="btnSubmit" />
        </div>
    </div>
    <uc1:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="Join Now Win Big" />
</asp:Content>
