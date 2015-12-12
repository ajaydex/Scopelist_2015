<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="AdminPanel.ascx.vb" Inherits="BVModules_Controls_AdminPanel" %>
<asp:Panel EnableViewState="false" ID="pnlMain" runat="server" Visible="false" Width="100%">
    <div id="adminpanel">
        <table border="0" cellspacing="0" cellpadding="3" width="100%">
            <tr>
                <td id="adminleft">
                    <strong>
                        <asp:Literal EnableViewState="false" ID="lblStoreState" runat="server" Text="Store is :"></asp:Literal></strong>
                    (<asp:LinkButton EnableViewState="false" ID="btnToggleStore" runat="server">Toggle Store</asp:LinkButton>)
                </td>
                <td id="admincenter">
                    <asp:Literal ID="editLinks" runat="server" Visible="false"></asp:Literal>
                </td>
                <td id="adminright">
                    <asp:HyperLink EnableViewState="false" ID="lnkLogout" runat="server" NavigateUrl="~/Logout.aspx">Logout</asp:HyperLink>
                    |
                    <asp:HyperLink EnableViewState="false" ID="lnkGoToAdmin" runat="server">Go To Admin</asp:HyperLink></td>
            </tr>
        </table>
    </div>

    
    <style type="text/css">
        /*CONTENT COLUMN EDIT LINKS*/
	    /*used for the content column edit links when logged in*/	
	    a.customButton {
		    background: #BC1122 url(/BVAdmin/Images/edit-icon.png) no-repeat center center;
		    color: #fff;
		    text-decoration: none;
		    padding: 5px 10px;
		    -webkit-border-radius: 0 0 5px 5px;
		    -moz-border-radius: 0 0 5px 5px;
		    border-radius: 0 0 5px 5px;
		    vertical-align: middle;
		    display: inline-block;
		    position: absolute; 
		    top: 0;
		    right: 10px;
		    opacity: .8;
		    font-weight: bold;
		    text-indent: -999px;
		    width: 15px;
		    overflow: hidden;
	    }
	    a.customButton:hover {
		    opacity: 1;
	    }
	    /*has to be positioned so the content column edit link is in the correct location*/
	    .postContentColumn,
	    .preContentColumn {
		    position: relative;	
	    }
    </style>


</asp:Panel>